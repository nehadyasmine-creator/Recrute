import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

interface CandidatureAvecOffre {
  id: number;
  statut: string;
  dateCandidature?: string;
  offre?: {
    id: number;
    titre?: string;
    description?: string;
    lieu?: string;
    typeContrat?: string;
    salaire?: number;
    teletravail?: boolean;
    statut?: string;
  };
  idOffre?: number;
}

@Component({
  selector: 'app-offres-postulees',
  imports: [CommonModule, RouterLink],
  templateUrl: './offres-postulees.html',
  styleUrl: './offres-postulees.scss',
})
export class OffresPostulees implements OnInit {
  private authService = inject(AuthService);
  private apiService = inject(ApiService);

  loading = true;
  errorMessage = '';
  candidatures: CandidatureAvecOffre[] = [];

  ngOnInit(): void {
    this.loadAppliedOffers();
  }

  loadAppliedOffers(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.errorMessage = 'Utilisateur non connecté';
      this.loading = false;
      return;
    }

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        const candidatId = candidat?.id;
        if (!candidatId) {
          this.errorMessage = 'Profil candidat introuvable';
          this.loading = false;
          return;
        }

        this.apiService.getCandidaturesByCandidat(candidatId).subscribe({
          next: (candidatures) => {
            this.candidatures = candidatures.filter(c => c.statut !== 'enregistree');
            this.loading = false;
          },
          error: () => {
            this.errorMessage = 'Impossible de charger vos candidatures';
            this.loading = false;
          }
        });
      },
      error: () => {
        this.errorMessage = 'Profil candidat introuvable';
        this.loading = false;
      }
    });
  }

  getStatusLabel(status: string): string {
    switch (status) {
      case 'envoyee':
        return 'Envoyée';
      case 'en_attente':
        return 'En attente';
      case 'refusee':
        return 'Refusée';
      case 'acceptee':
        return 'Acceptée';
      default:
        return status;
    }
  }

  getStatusClass(status: string): string {
    switch (status) {
      case 'envoyee':
        return 'status-info';
      case 'en_attente':
        return 'status-warning';
      case 'refusee':
        return 'status-danger';
      case 'acceptee':
        return 'status-success';
      default:
        return 'status-neutral';
    }
  }

  getOfferId(candidature: CandidatureAvecOffre): number | null {
    return candidature.offre?.id || candidature.idOffre || null;
  }

}
