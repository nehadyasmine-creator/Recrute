import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { forkJoin } from 'rxjs';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

@Component({
  selector: 'app-admin',
  imports: [CommonModule, RouterLink],
  templateUrl: './admin.html',
  styleUrl: './admin.scss',
})
export class Admin implements OnInit {
  isLoading = true;
  accessDenied = false;

  stats = [
    { label: 'Offres', value: 0, icon: 'bi-briefcase', hint: 'Offres publiées et archivées' },
    { label: 'Candidats', value: 0, icon: 'bi-people', hint: 'Profils candidats actifs' },
    { label: 'Recruteurs', value: 0, icon: 'bi-buildings', hint: 'Comptes entreprises' },
    { label: 'Candidatures', value: 0, icon: 'bi-send-check', hint: 'Toutes les candidatures reçues' },
    { label: 'Remontées', value: 0, icon: 'bi-chat-left-text', hint: 'Messages envoyés aux admins' },
    { label: 'Offres ouvertes', value: 0, icon: 'bi-lightning-charge', hint: 'Offres encore accessibles' },
  ];

  candidatureBreakdown: Array<{ label: string; count: number; percent: number; tone: string }> = [];
  topOffers: Array<{ title: string; count: number; status: string }> = [];
  recentMessages: any[] = [];
  highlights: string[] = [];

  constructor(
    private apiService: ApiService,
    private authService: AuthService,
    private router: Router,
  ) {}

  ngOnInit(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.accessDenied = true;
      this.isLoading = false;
      return;
    }

    this.apiService.getUtilisateurById(userId).subscribe({
      next: (utilisateur) => {
        const role = (utilisateur?.role || '').toString().trim().toLowerCase();
        if (role !== 'admin') {
          this.accessDenied = true;
          this.isLoading = false;
          this.router.navigate(['/']);
          return;
        }

        this.loadDashboard();
      },
      error: () => {
        this.accessDenied = true;
        this.isLoading = false;
      },
    });
  }

  private loadDashboard(): void {
    forkJoin({
      offres: this.apiService.getOffres(),
      candidats: this.apiService.getCandidats(),
      recruteurs: this.apiService.getRecruteurs(),
      candidatures: this.apiService.getCandidatures(),
      contacts: this.apiService.getContactMessages(),
      utilisateurs: this.apiService.getUtilisateurs(),
    }).subscribe({
      next: ({ offres, candidats, recruteurs, candidatures, contacts, utilisateurs }) => {
        const openOffers = offres.filter((offre) => this.normalizeStatus(offre?.statut) === 'ouverte').length;
        const openMessages = contacts.filter((message) => this.normalizeStatus(message?.statut) !== 'traite').length;

        this.stats = [
          { label: 'Offres', value: offres.length, icon: 'bi-briefcase', hint: 'Offres publiées et archivées' },
          { label: 'Candidats', value: candidats.length, icon: 'bi-people', hint: 'Profils candidats actifs' },
          { label: 'Recruteurs', value: recruteurs.length, icon: 'bi-buildings', hint: 'Comptes entreprises' },
          { label: 'Candidatures', value: candidatures.length, icon: 'bi-send-check', hint: 'Toutes les candidatures reçues' },
          { label: 'Remontées', value: contacts.length, icon: 'bi-chat-left-text', hint: `${openMessages} en attente de traitement` },
          { label: 'Offres ouvertes', value: openOffers, icon: 'bi-lightning-charge', hint: 'Offres encore accessibles' },
        ];

        const statusGroups = [
          { label: 'Envoyées', key: 'envoyee', tone: 'blue' },
          { label: 'En attente', key: 'en_attente', tone: 'amber' },
          { label: 'Refusées', key: 'refusee', tone: 'rose' },
          { label: 'Acceptées', key: 'acceptee', tone: 'emerald' },
          { label: 'Enregistrées', key: 'enregistree', tone: 'slate' },
        ];

        this.candidatureBreakdown = statusGroups.map((item) => {
          const count = candidatures.filter((candidature) => this.normalizeStatus(candidature?.statut) === item.key).length;
          return {
            label: item.label,
            count,
            percent: candidatures.length ? Math.round((count / candidatures.length) * 100) : 0,
            tone: item.tone,
          };
        });

        const byOffer = offres.map((offre) => ({
          title: offre?.titre || 'Offre sans titre',
          count: candidatures.filter((candidature) => this.matchOffer(candidature, offre)).length,
          status: this.normalizeStatus(offre?.statut) === 'ouverte' ? 'Ouverte' : 'Fermée',
        }))
          .filter((offre) => offre.count > 0)
          .sort((a, b) => b.count - a.count)
          .slice(0, 5);

        this.topOffers = byOffer;
        this.recentMessages = [...contacts]
          .sort((a, b) => this.toDate(b?.dateCreation).getTime() - this.toDate(a?.dateCreation).getTime())
          .slice(0, 5);

        this.highlights = [
          `${utilisateurs.length} comptes actifs`,
          `${openMessages} message(s) à traiter`,
          `${this.candidatureBreakdown.find((item) => item.label === 'En attente')?.count || 0} candidature(s) en attente`,
        ];

        this.isLoading = false;
      },
      error: () => {
        this.isLoading = false;
      },
    });
  }

  private matchOffer(candidature: any, offre: any): boolean {
    if (!candidature || !offre) {
      return false;
    }

    const candidatureOffer = candidature?.offre;
    if (candidatureOffer?.idOffre && offre?.idOffre) {
      return candidatureOffer.idOffre === offre.idOffre;
    }

    return candidature?.idOffre === offre?.idOffre;
  }

  private normalizeStatus(value: any): string {
    return (value || '').toString().trim().toLowerCase();
  }

  private toDate(value: any): Date {
    const date = new Date(value);
    return Number.isNaN(date.getTime()) ? new Date(0) : date;
  }

  markAsRead(message: any): void {
    const id = message?.id ?? message?.idContactMessage;
    if (!id) {
      return;
    }

    this.apiService.markContactMessageAsRead(id).subscribe({
      next: () => this.loadDashboard(),
      error: () => {
        this.isLoading = false;
      },
    });
  }

  deleteMessage(message: any): void {
    const id = message?.id ?? message?.idContactMessage;
    if (!id) {
      return;
    }

    this.apiService.deleteContactMessage(id).subscribe({
      next: () => this.loadDashboard(),
      error: () => {
        this.isLoading = false;
      },
    });
  }

}
