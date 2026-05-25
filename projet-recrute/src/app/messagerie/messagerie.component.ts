import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { forkJoin, map, of, switchMap } from 'rxjs';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';

type MessagerieConversation = {
  candidature: any;
  messages: any[];
  unreadCount: number;
  lastActivity: string | null;
  title: string;
  subtitle: string;
};

@Component({
  selector: 'app-messagerie',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './messagerie.html',
  styleUrl: './messagerie.scss',
})
export class Messagerie implements OnInit {
  private route = inject(ActivatedRoute);
  private authService = inject(AuthService);
  private apiService = inject(ApiService);

  isLoading = false;
  infoMessage = '';
  errorMessage = '';

  userId: number | null = null;
  userRole: string | null = null;
  recruiterId: number | null = null;
  candidateId: number | null = null;

  discussions: MessagerieConversation[] = [];
  selectedDiscussion: MessagerieConversation | null = null;
  composerMessage = '';
  totalUnreadCount = 0;

  ngOnInit(): void {
    const candidatureParam = this.route.snapshot.queryParamMap.get('candidatureId');
    const selectedCandidatureId = candidatureParam ? Number(candidatureParam) : undefined;
    this.loadDashboard(selectedCandidatureId && Number.isFinite(selectedCandidatureId) ? selectedCandidatureId : undefined);
  }

  private clearMessages(): void {
    this.infoMessage = '';
    this.errorMessage = '';
  }

  private setError(message: string): void {
    this.infoMessage = '';
    this.errorMessage = message;
  }

  private setInfo(message: string): void {
    this.errorMessage = '';
    this.infoMessage = message;
  }

  private ensureSession(): boolean {
    const id = this.authService.getUserId();
    if (!id) {
      this.setError('Session expirée, veuillez vous reconnecter.');
      return false;
    }

    this.userId = id;
    this.userRole = this.normalizeRole(this.authService.getUserRole());
    return true;
  }

  loadDashboard(selectedCandidatureId?: number): void {
    if (!this.ensureSession() || this.userId === null) {
      return;
    }

    this.isLoading = true;
    this.clearMessages();

    const role = this.userRole;

    if (role === 'recruteur') {
      this.loadRecruiterDashboard(selectedCandidatureId);
      return;
    }

    if (role === 'candidat') {
      this.loadCandidateDashboard(selectedCandidatureId);
      return;
    }

    this.isLoading = false;
    this.setError('Votre rôle utilisateur ne permet pas d’accéder à la messagerie.');
  }

  selectDiscussion(discussion: MessagerieConversation): void {
    this.selectedDiscussion = discussion;
    this.composerMessage = '';
  }

  sendMessage(): void {
    if (!this.selectedDiscussion || !this.composerMessage.trim()) {
      return;
    }

    if (this.userRole !== 'recruteur' && this.userRole !== 'candidat') {
      this.setError('Impossible d’identifier le destinataire.');
      return;
    }

    const candidatureId = this.selectedDiscussion.candidature?.id;
    if (!candidatureId) {
      this.setError('Conversation invalide, veuillez recharger la page.');
      return;
    }

    const payload: any = {
      candidature: { id: candidatureId },
      expediteurRole: this.userRole,
      message: this.composerMessage.trim(),
      sendAt: new Date().toISOString().slice(0, 19),
      lu: false,
    };

    if (this.userRole === 'recruteur') {
      if (!this.recruiterId) {
        this.setError('Recruteur introuvable, veuillez recharger la page.');
        return;
      }

      payload.recruteur = { id: this.recruiterId };
      const candidateId = this.selectedDiscussion.candidature?.candidat?.id;
      if (candidateId) {
        payload.candidat = { id: candidateId };
      }
    } else {
      if (!this.candidateId) {
        this.setError('Candidat introuvable, veuillez recharger la page.');
        return;
      }

      payload.candidat = { id: this.candidateId };
      const recruiterId = this.selectedDiscussion.candidature?.offre?.recruteur?.id;
      if (recruiterId) {
        payload.recruteur = { id: recruiterId };
      }
    }

    this.apiService.sendMessage(payload).subscribe({
      next: () => {
        this.composerMessage = '';
        this.setInfo('Message envoyé.');
        this.loadDashboard(candidatureId);
      },
      error: () => {
        this.setError('Impossible d’envoyer le message pour le moment.');
      },
    });
  }

  getBackLink(): string {
    if (this.userRole === 'recruteur') {
      return '/modifier-profil-employeur';
    }

    if (this.userRole === 'candidat') {
      return '/modifier-profil-candidat';
    }

    return '/';
  }

  getComposerLabel(): string {
    if (this.userRole === 'recruteur') {
      return 'Répondre au candidat';
    }

    if (this.userRole === 'candidat') {
      return 'Répondre au recruteur';
    }

    return 'Nouveau message';
  }

  getDiscussionTitle(discussion: MessagerieConversation): string {
    const candidature = discussion.candidature;
    const candidate = candidature?.candidat?.utilisateur;
    const company = candidature?.offre?.recruteur?.entreprise?.nom;
    const offerTitle = candidature?.offre?.titre;

    if (this.userRole === 'recruteur') {
      const candidateName = this.formatName(candidate?.prenom, candidate?.nom, `Candidat #${candidature?.candidat?.id ?? ''}`);
      return candidateName;
    }

    if (company) {
      return company;
    }

    return offerTitle || 'Discussion';
  }

  getDiscussionSubtitle(discussion: MessagerieConversation): string {
    const candidature = discussion.candidature;
    const candidate = candidature?.candidat?.utilisateur;
    const offerTitle = candidature?.offre?.titre;
    const city = candidature?.candidat?.ville;

    if (this.userRole === 'recruteur') {
      return [offerTitle, city].filter(Boolean).join(' · ') || 'Conversation en cours';
    }

    return [offerTitle, this.formatName(candidate?.prenom, candidate?.nom)].filter(Boolean).join(' · ') || 'Conversation en cours';
  }

  getStatusLabel(statut?: string): string {
    const normalized = (statut || '').trim().toLowerCase();
    switch (normalized) {
      case 'envoyee':
        return 'Envoyée';
      case 'en_attente':
        return 'En attente';
      case 'refusee':
        return 'Refusée';
      case 'acceptee':
        return 'Acceptée';
      case 'enregistree':
        return 'Enregistrée';
      default:
        return 'Sans statut';
    }
  }

  getLatestLabel(discussion: MessagerieConversation): string {
    const latestMessage = discussion.messages[discussion.messages.length - 1];
    return latestMessage?.sendAt || discussion.candidature?.dateCandidature || '';
  }

  hasUnreadMessages(discussion: MessagerieConversation): boolean {
    return discussion.unreadCount > 0;
  }

  getOfferLink(discussion: MessagerieConversation): string | null {
    const offerId = discussion.candidature?.offre?.id;
    return offerId ? `/detail-offre/${offerId}` : null;
  }

  getCandidateLink(discussion: MessagerieConversation): string | null {
    const candidateId = discussion.candidature?.candidat?.id;
    return this.userRole === 'recruteur' && candidateId ? `/infos-candidat/${candidateId}` : null;
  }

  canMarkAsRead(message: any): boolean {
    if (message?.lu || !message?.expediteurRole) {
      return false;
    }

    if (this.userRole === 'recruteur') {
      return message.expediteurRole === 'candidat';
    }

    if (this.userRole === 'candidat') {
      return message.expediteurRole === 'recruteur';
    }

    return false;
  }

  markAsRead(message: any): void {
    if (!message?.id || !this.canMarkAsRead(message)) {
      return;
    }

    this.apiService.markMessageAsRead(Number(message.id)).subscribe({
      next: () => {
        this.setInfo('Message marqué comme lu.');
        const selectedId = Number(this.selectedDiscussion?.candidature?.id);
        this.loadDashboard(selectedId);
        window.dispatchEvent(new Event('profile-updated'));
      },
      error: () => {
        this.setError('Impossible de marquer ce message comme lu.');
      },
    });
  }

  private loadRecruiterDashboard(selectedCandidatureId?: number): void {
    if (!this.userId) {
      return;
    }

    this.apiService.getRecruteurByUtilisateurId(this.userId).pipe(
      switchMap((recruteur) => {
        this.recruiterId = recruteur?.id ?? null;
        if (!this.recruiterId) {
          return of({ candidatures: [] as any[], messages: [] as any[] });
        }

        return forkJoin({
          messages: this.apiService.getMessagesByRecruteur(this.recruiterId),
          offres: this.apiService.getOffresByRecruteur(this.recruiterId),
        }).pipe(
          switchMap(({ messages, offres }) => {
            const candidatureRequests = (offres || []).map((offre) =>
              this.apiService.getCandidaturesByOffre(offre.id).pipe(
                map((candidatures) => (candidatures || []).map((candidature) => ({
                  ...candidature,
                  offre,
                })))
              )
            );

            if (!candidatureRequests.length) {
              return of({ candidatures: [] as any[], messages });
            }

            return forkJoin(candidatureRequests).pipe(
              map((resolved) => ({
                candidatures: resolved.flat(),
                messages,
              }))
            );
          })
        );
      })
    ).subscribe({
      next: ({ candidatures, messages }) => {
        this.applyDiscussions(candidatures || [], messages || [], selectedCandidatureId);
      },
      error: () => {
        this.isLoading = false;
        this.setError('Impossible de charger vos discussions.');
      },
    });
  }

  private loadCandidateDashboard(selectedCandidatureId?: number): void {
    if (!this.userId) {
      return;
    }

    this.apiService.getCandidatByUtilisateurId(this.userId).pipe(
      switchMap((candidat) => {
        this.candidateId = candidat?.id ?? null;
        if (!this.candidateId) {
          return of({ candidatures: [] as any[], messages: [] as any[] });
        }

        return forkJoin({
          candidatures: this.apiService.getCandidaturesByCandidat(this.candidateId),
          messages: this.apiService.getMessagesByCandidat(this.candidateId),
        });
      })
    ).subscribe({
      next: ({ candidatures, messages }) => {
        const candidaturesAvecOffre = (candidatures || []).map((candidature) => ({
          ...candidature,
        }));
        this.applyDiscussions(candidaturesAvecOffre, messages || [], selectedCandidatureId);
      },
      error: () => {
        this.isLoading = false;
        this.setError('Impossible de charger vos discussions.');
      },
    });
  }

  private applyDiscussions(candidatures: any[], messages: any[], selectedCandidatureId?: number): void {
    const discussions = candidatures.map((candidature) => {
      const candidatureId = Number(candidature?.id);
      const discussionMessages = (messages || [])
        .filter((message) => Number(message?.candidature?.id ?? message?.candidature?.idCandidature ?? message?.candidatureId) === candidatureId)
        .sort((left, right) => this.toTimestamp(left?.sendAt) - this.toTimestamp(right?.sendAt));

      return {
        candidature,
        messages: discussionMessages,
        unreadCount: discussionMessages.filter((message) => !message?.lu).length,
        lastActivity: discussionMessages.length ? discussionMessages[discussionMessages.length - 1]?.sendAt : candidature?.dateCandidature ?? null,
        title: this.getDiscussionTitle({ candidature, messages: discussionMessages, unreadCount: 0, lastActivity: null, subtitle: '' } as MessagerieConversation),
        subtitle: this.getDiscussionSubtitle({ candidature, messages: discussionMessages, unreadCount: 0, lastActivity: null, title: '', subtitle: '' } as MessagerieConversation),
      };
    });

    discussions.sort((left, right) => this.toTimestamp(right.lastActivity) - this.toTimestamp(left.lastActivity));

    this.discussions = discussions;
    this.totalUnreadCount = (messages || []).filter((message) => !message?.lu).length;

    const selected = selectedCandidatureId
      ? this.discussions.find((discussion) => Number(discussion.candidature?.id) === Number(selectedCandidatureId))
      : null;

    this.selectedDiscussion = selected || this.discussions[0] || null;
    this.isLoading = false;
  }

  private normalizeRole(role?: string | null): string | null {
    const normalizedRole = (role || '').trim().toLowerCase();
    return normalizedRole || null;
  }

  isRecruiterMessage(message: any): boolean {
    return message?.expediteurRole === 'recruteur';
  }

  isCandidateMessage(message: any): boolean {
    return message?.expediteurRole === 'candidat';
  }

  private formatName(prenom?: string, nom?: string, fallback = 'Non renseigné'): string {
    const firstName = (prenom || '').trim();
    const lastName = (nom || '').trim();

    if (firstName && lastName) {
      return `${firstName} ${lastName}`;
    }

    if (firstName) {
      return firstName;
    }

    if (lastName) {
      return lastName;
    }

    return fallback;
  }

  private toTimestamp(value: string | null | undefined): number {
    if (!value) {
      return 0;
    }

    const timestamp = new Date(value).getTime();
    return Number.isNaN(timestamp) ? 0 : timestamp;
  }
}
