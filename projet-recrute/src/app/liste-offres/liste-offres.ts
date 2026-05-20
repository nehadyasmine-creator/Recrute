import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

interface Offre {
  id: number;
  titre: string;
  description: string;
  lieu: string;
  typeContrat: string;
  salaire: number;
  teletravail: boolean;
}

@Component({
  selector: 'app-liste-offres',
  imports: [CommonModule, RouterLink],
  templateUrl: './liste-offres.html',
  styleUrl: './liste-offres.scss',
})
export class ListeOffres implements OnInit {
  private apiService = inject(ApiService);
  private authService = inject(AuthService);
  private router = inject(Router);

  offres: Offre[] = [];
  loading = true;
  error = '';
  savedOfferIds: Set<number> = new Set();
  private candidateId: number | null = null;

  ngOnInit(): void {
    this.loadOffres();
    this.loadSavedOffers();
  }

  private loadOffres(): void {
    this.apiService.getOffresOuvertes().subscribe({
      next: (offres) => {
        this.offres = offres;
        this.loading = false;
      },
      error: () => {
        this.error = 'Impossible de charger les offres pour le moment.';
        this.loading = false;
      }
    });
  }

  private loadSavedOffers(): void {
    const userId = this.authService.getUserId();
    if (!userId) return;

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        this.candidateId = candidat?.id ?? null;
        if (!this.candidateId) {
          return;
        }

        this.apiService.getCandidaturesByCandidat(this.candidateId).subscribe({
          next: (candidatures) => {
            const savedCands = candidatures.filter(c => c.statut === 'enregistree');
            this.savedOfferIds = new Set(savedCands.map(c => c.offre?.id || c.idOffre));
          }
        });
      }
    });
  }

  isOfferSaved(offerId: number): boolean {
    return this.savedOfferIds.has(offerId);
  }

  goToDetail(offerId: number): void {
    this.router.navigate(['/detail-offre', offerId]);
  }

  toggleSaveOffer(offer: any, event?: Event): void {
    event?.stopPropagation();

    const userId = this.authService.getUserId();
    if (!userId) {
      this.error = 'Vous devez être connecté pour enregistrer une offre';
      return;
    }

    if (!this.candidateId) {
      this.apiService.getCandidatByUtilisateurId(userId).subscribe({
        next: (candidat) => {
          this.candidateId = candidat?.id ?? null;
          if (!this.candidateId) {
            this.error = 'Impossible de retrouver votre profil candidat';
            return;
          }

          this.saveOrRemoveOffer(offer);
        },
        error: () => {
          this.error = 'Impossible de retrouver votre profil candidat';
        }
      });
      return;
    }

    this.saveOrRemoveOffer(offer);
  }

  private saveOrRemoveOffer(offer: any): void {
    if (!this.candidateId) {
      this.error = 'Impossible de retrouver votre profil candidat';
      return;
    }

    if (this.isOfferSaved(offer.id)) {
      // Supprimer de favoris
      this.removeSavedOffer(offer.id);
    } else {
      // Ajouter à favoris
      this.saveOffer(offer, this.candidateId);
    }
  }

  private saveOffer(offer: any, candidateId: number): void {
    const candidature = {
      offre: { id: offer.id },
      candidat: { id: candidateId },
      statut: 'enregistree',
      dateCandidature: new Date().toISOString().split('T')[0]
    };

    this.apiService.createCandidature(candidature).subscribe({
      next: () => {
        this.savedOfferIds.add(offer.id);
      },
      error: () => {
        this.error = 'Erreur lors de l\'enregistrement de l\'offre';
      }
    });
  }

  private removeSavedOffer(offerId: number): void {
    const userId = this.authService.getUserId();
    if (!userId) return;

    const fetchAndRemove = (candidateId: number) => {
      this.apiService.getCandidaturesByCandidat(candidateId).subscribe({
        next: (candidatures) => {
          const savedCand = candidatures.find(
            c => c.statut === 'enregistree' && (c.offre?.id === offerId || c.idOffre === offerId)
          );
          if (savedCand) {
            this.apiService.deleteCandidature(savedCand.id).subscribe({
              next: () => {
                this.savedOfferIds.delete(offerId);
              },
              error: () => {
                this.error = 'Erreur lors de la suppression de l\'enregistrement';
              }
            });
          }
        }
      });
    };

    if (this.candidateId) {
      fetchAndRemove(this.candidateId);
      return;
    }

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        const candidateId = candidat?.id;
        if (!candidateId) return;
        this.candidateId = candidateId;
        fetchAndRemove(candidateId);
      },
      error: () => {
        this.error = 'Impossible de retrouver votre profil candidat';
      }
    });
  }
}