import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';

@Component({
  selector: 'app-candidature-enregistre',
  imports: [CommonModule, RouterLink],
  templateUrl: './candidature-enregistre.html',
  styleUrl: './candidature-enregistre.scss',
})
export class CandidatureEnregistre implements OnInit {
  savedOffers: any[] = [];
  isLoading = true;
  errorMessage = '';
  private candidateId: number | null = null;
  
  private authService = inject(AuthService);
  private apiService = inject(ApiService);
  private router = inject(Router);

  ngOnInit(): void {
    this.loadSavedOffers();
  }

  loadSavedOffers(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.isLoading = false;
      this.errorMessage = 'Utilisateur non connecté';
      return;
    }

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        this.candidateId = candidat?.id ?? null;
        if (!this.candidateId) {
          this.isLoading = false;
          this.errorMessage = 'Profil candidat introuvable';
          return;
        }

        this.apiService.getCandidaturesByCandidat(this.candidateId).subscribe({
          next: (candidatures) => {
            const savedCandidatures = candidatures.filter(c => c.statut === 'enregistree');
            const offerIds = savedCandidatures.map(c => c.offre?.id || c.idOffre);

            if (offerIds.length === 0) {
              this.savedOffers = [];
              this.isLoading = false;
              return;
            }

            this.apiService.getOffres().subscribe({
              next: (allOffres) => {
                this.savedOffers = allOffres.filter(o => offerIds.includes(o.id));
                this.isLoading = false;
              },
              error: () => {
                this.isLoading = false;
                this.errorMessage = 'Erreur lors du chargement des offres';
              }
            });
          },
          error: () => {
            this.isLoading = false;
            this.errorMessage = 'Erreur lors du chargement des candidatures';
          }
        });
      },
      error: () => {
        this.isLoading = false;
        this.errorMessage = 'Profil candidat introuvable';
      }
    });
  }

  goToDetail(offerId: number): void {
    this.router.navigate(['/detail-offre', offerId]);
  }

  removeSavedOffer(offerId: number, event?: Event): void {
    event?.stopPropagation();

    const removeFromCandidate = (candidateId: number) => {
      this.apiService.getCandidaturesByCandidat(candidateId).subscribe({
      next: (candidatures) => {
        const savedCand = candidatures.find(
          c => c.statut === 'enregistree' && (c.offre?.id === offerId || c.idOffre === offerId)
        );
        if (savedCand) {
          this.apiService.deleteCandidature(savedCand.id).subscribe({
            next: () => {
              this.savedOffers = this.savedOffers.filter(o => o.id !== offerId);
            },
            error: () => {
              this.errorMessage = 'Erreur lors de la suppression de l\'offre';
            }
          });
        }
      }
    });
    };

    if (this.candidateId) {
      removeFromCandidate(this.candidateId);
      return;
    }

    const userId = this.authService.getUserId();
    if (!userId) return;

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        const candidateId = candidat?.id;
        if (!candidateId) return;
        this.candidateId = candidateId;
        removeFromCandidate(candidateId);
      }
    });
  }

}
