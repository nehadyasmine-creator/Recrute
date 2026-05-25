import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';
import { forkJoin, of, switchMap } from 'rxjs';

@Component({
  selector: 'app-infos-candidat',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './infos-candidat.html',
  styleUrl: './infos-candidat.scss',
})
export class InfosCandidat implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private apiService = inject(ApiService);
  private authService = inject(AuthService);

  candidat: any = null;
  experiences: any[] = [];
  competences: any[] = [];
  candidatures: any[] = [];
  recruiterOffers: any[] = [];
  loading = true;
  error = '';
  cvLoading = false;
  actionLoading = false;
  recruiterId: number | null = null;
  messagingCandidatureId: number | null = null;
  messagingOfferId: number | null = null;
  selectedOfferId: number | null = null;
  private userRole: string | null = null;

  ngOnInit(): void {
    this.userRole = this.normalizeRole(this.authService.getUserRole());
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.loadCandidat(id);
  }

  private loadCandidat(id: number): void {
    this.loading = true;
    this.error = '';

    forkJoin({
      candidat: this.apiService.getCandidatById(id),
      experiences: this.apiService.getExperiencesByCandidat(id),
      competences: this.apiService.getCompetencesByCandidat(id),
    }).subscribe({
      next: (candidat) => {
        this.candidat = candidat.candidat;
        this.experiences = candidat.experiences || [];
        this.competences = (candidat.competences || []).map((c: any) => c.competence);

        if (this.isRecruiterConnected()) {
          this.loadRecruiterMessagingContext(id);
          return;
        }

        this.loading = false;
      },
      error: () => {
        this.error = 'Impossible de charger le profil.';
        this.loading = false;
      }
    });
  }

  private loadRecruiterMessagingContext(candidatId: number): void {
    const connectedUserId = this.authService.getUserId();
    if (!connectedUserId) {
      this.loading = false;
      return;
    }

    this.apiService.getRecruteurByUtilisateurId(connectedUserId).pipe(
      switchMap((recruteur) => {
        this.recruiterId = recruteur?.id ?? null;
        if (!this.recruiterId) {
          return of({ candidatures: [] as any[], offres: [] as any[] });
        }

        return forkJoin({
          candidatures: this.apiService.getCandidaturesByCandidat(candidatId),
          offres: this.apiService.getOffresByRecruteur(this.recruiterId),
        });
      })
    ).subscribe({
      next: ({ candidatures, offres }) => {
        this.candidatures = candidatures || [];
        this.recruiterOffers = offres || [];
        const offerIds = new Set((offres || []).map((offre: any) => Number(offre?.id)));
        const candidateDiscussion = this.candidatures.find((candidature: any) => offerIds.has(Number(candidature?.offre?.id ?? candidature?.idOffre)));
        this.messagingCandidatureId = candidateDiscussion?.id ?? null;
        this.selectedOfferId = this.messagingCandidatureId ? null : this.selectedOfferId;
        this.messagingOfferId = this.selectedOfferId;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  isRecruiterConnected(): boolean {
    return this.userRole === 'recruteur';
  }

  hasCv(): boolean {
    return !!this.candidat?.cv;
  }

  openCv(): void {
    if (!this.candidat?.id || !this.hasCv()) {
      return;
    }

    this.cvLoading = true;
    this.apiService.downloadCv(this.candidat.id).subscribe({
      next: (blob) => {
        this.cvLoading = false;
        const url = window.URL.createObjectURL(blob);
        window.open(url, '_blank', 'noopener');
        window.setTimeout(() => window.URL.revokeObjectURL(url), 3000);
      },
      error: () => {
        this.cvLoading = false;
        this.error = 'Impossible d’ouvrir le CV pour le moment.';
      },
    });
  }

  startMessaging(): void {
    if (this.messagingCandidatureId) {
      this.router.navigate(['/messagerie'], {
        queryParams: {
          candidatureId: this.messagingCandidatureId,
        },
      });
      return;
    }

    if (!this.recruiterId || !this.messagingOfferId || !this.candidat?.id) {
      return;
    }

    this.actionLoading = true;
    this.error = '';

    this.apiService.createCandidature({
      candidat: { id: this.candidat.id },
      offre: { id: this.messagingOfferId },
    }).subscribe({
      next: (createdCandidature) => {
        const candidatureId = createdCandidature?.id;
        if (!candidatureId) {
          this.actionLoading = false;
          this.error = 'La candidature a été créée, mais son identifiant est introuvable.';
          return;
        }

        this.actionLoading = false;
        this.router.navigate(['/messagerie'], {
          queryParams: {
            candidatureId,
          },
        });
      },
      error: () => {
        this.actionLoading = false;
        this.error = 'Impossible de créer la candidature vide pour le moment.';
      },
    });
  }

  getMessageActionLabel(): string {
    return this.messagingCandidatureId ? 'Démarrer une messagerie' : 'Créer la candidature et démarrer la messagerie';
  }

  getMessageHelperText(): string {
    if (this.messagingCandidatureId) {
      return 'Une candidature existe déjà avec ce candidat. Vous pouvez ouvrir la discussion directement.';
    }

    if (this.recruiterOffers.length > 0) {
      return 'Aucune candidature liée à vos offres. Choisissez l’offre à utiliser pour créer une candidature vide avant d’ouvrir la discussion.';
    }

    return 'Aucune offre n’est disponible sur votre compte pour créer une candidature vide.';
  }

  canStartMessaging(): boolean {
    if (this.messagingCandidatureId) {
      return true;
    }

    return !!this.recruiterId && !!this.selectedOfferId && !!this.candidat?.id;
  }

  getSelectedOfferId(): number | null {
    return this.selectedOfferId ? Number(this.selectedOfferId) : null;
  }

  onSelectedOfferChange(value: string | number | null): void {
    const parsed = value === null || value === '' ? null : Number(value);
    this.selectedOfferId = parsed && Number.isFinite(parsed) ? parsed : null;
    this.messagingOfferId = this.selectedOfferId;
  }

  hasSelectableOffers(): boolean {
    return this.recruiterOffers.length > 0;
  }

  getInitiales(): string {
    const p = this.candidat?.utilisateur?.prenom?.[0] ?? '';
    const n = this.candidat?.utilisateur?.nom?.[0] ?? '';
    return (p + n).toUpperCase() || '?';
  }

  private normalizeRole(role?: string | null): string | null {
    const normalized = (role || '').trim().toLowerCase();
    return normalized || null;
  }
}