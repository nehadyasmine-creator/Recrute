import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

interface Offre {
  id: number;
  titre: string;
  description: string;
  lieu: string;
  typeContrat: string;
  salaire: number | null;
  teletravail: boolean;
  statut?: string | null;
  datePublication?: string | null;
  recruteur?: {
    utilisateur?: {
      id?: number | null;
      prenom?: string | null;
      nom?: string | null;
    };
  };
}

@Component({
  selector: 'app-mes-offres-recruteur',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './mes-offres-recruteur.html',
  styleUrl: './mes-offres-recruteur.scss',
})
export class MesOffresRecruteur implements OnInit {
  private apiService = inject(ApiService);
  private authService = inject(AuthService);

  offres: Offre[] = [];
  loading = true;
  errorMessage = '';
  recruiterId: number | null = null;
  recruiterName = '';

  ngOnInit(): void {
    const userId = this.authService.getUserId();
    const role = this.authService.getUserRole();

    if (!userId) {
      this.errorMessage = 'Vous devez être connecté pour voir vos offres.';
      this.loading = false;
      return;
    }

    if (role && role !== 'recruteur') {
      this.errorMessage = 'Cette page est réservée aux recruteurs.';
      this.loading = false;
      return;
    }

    this.apiService.getRecruteurByUtilisateurId(userId).subscribe({
      next: (recruteur) => {
        this.recruiterId = recruteur?.id ?? null;
        this.recruiterName = [recruteur?.utilisateur?.prenom, recruteur?.utilisateur?.nom].filter(Boolean).join(' ');

        if (!this.recruiterId) {
          this.errorMessage = 'Profil recruteur introuvable.';
          this.loading = false;
          return;
        }

        this.loadOffers(this.recruiterId);
      },
      error: () => {
        this.errorMessage = 'Impossible de récupérer votre profil recruteur.';
        this.loading = false;
      },
    });
  }

  private loadOffers(recruiterId: number): void {
    this.apiService.getOffresByRecruteur(recruiterId).subscribe({
      next: (offres) => {
        this.offres = offres || [];
        this.loading = false;
      },
      error: () => {
        this.errorMessage = 'Impossible de charger vos offres pour le moment.';
        this.loading = false;
      },
    });
  }

  goToDetail(offerId: number): string[] {
    return ['/detail-offre', offerId.toString()];
  }

  goToEdit(offerId: number): string[] {
    return ['/ajouter-offre', offerId.toString()];
  }

  deleteOffer(offerId: number, event?: Event): void {
    event?.stopPropagation();

    const confirmed = window.confirm('Supprimer cette offre ? Cette action est irréversible.');
    if (!confirmed) {
      return;
    }

    this.apiService.deleteOffre(offerId).subscribe({
      next: () => {
        this.offres = this.offres.filter((offre) => offre.id !== offerId);
      },
      error: () => {
        this.errorMessage = 'Impossible de supprimer cette offre pour le moment.';
      },
    });
  }

  truncate(value: string | null | undefined, maxLength: number): string {
    const text = value?.trim() || '';
    if (text.length <= maxLength) {
      return text;
    }

    return `${text.slice(0, maxLength)}...`;
  }

  displayOrFallback(value: unknown, fallback = 'Non renseigné'): string {
    if (value === null || value === undefined) return fallback;
    const str = String(value).trim();
    return str ? str : fallback;
  }

  formatDate(value?: string | null): string {
    if (!value) return 'Non renseignée';
    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return value;

    return new Intl.DateTimeFormat('fr-FR', {
      day: '2-digit',
      month: 'long',
      year: 'numeric',
    }).format(date);
  }
}
