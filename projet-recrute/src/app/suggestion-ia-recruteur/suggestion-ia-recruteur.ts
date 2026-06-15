import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

@Component({
  selector: 'app-suggestion-ia-recruteur',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './suggestion-ia-recruteur.html',
  styleUrl: './suggestion-ia-recruteur.scss',
})
export class SuggestionIaRecruteur implements OnInit {
  private authService = inject(AuthService);
  private apiService = inject(ApiService);
  private router = inject(Router);

  recruteurId: number | null = null;
  offres: any[] = [];
  selectedOffer: any = null;
  
  loading = true;
  loadingSuggestions = false;
  hasAnalyzed = false;
  errorMessage = '';
  infoMessage = '';

  suggestions: any[] = [];

  ngOnInit(): void {
    this.initializePage();
  }

  private initializePage(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.router.navigate(['/']);
      return;
    }

    // 1. Récupération du profil recruteur
    this.apiService.getRecruteurByUtilisateurId(userId).subscribe({
      next: (recruteur) => {
        this.recruteurId = recruteur?.id ?? null;
        if (this.recruteurId) {
          this.loadOffresRecruteur();
        } else {
          this.loading = false;
          this.errorMessage = 'Profil recruteur introuvable.';
        }
      },
      error: () => {
        this.loading = false;
        this.errorMessage = 'Impossible de charger votre profil recruteur.';
      },
    });
  }

  private loadOffresRecruteur(): void {
    // 2. Récupération des offres de ce recruteur
    this.apiService.getOffresByRecruteur(this.recruteurId!).subscribe({
      next: (offres) => {
        this.offres = offres || [];
        this.loading = false;

        // S'il a déjà des offres, on pré-sélectionne la première et on lance l'IA
        if (this.offres.length > 0) {
          this.selectedOffer = this.offres[0];
          this.loadIASuggestions();
        }
      },
      error: () => {
        this.loading = false;
        this.errorMessage = 'Erreur lors de la récupération de vos offres.';
      }
    });
  }

  onOfferSelected(event: Event): void {
    const selectElement = event.target as HTMLSelectElement;
    const offerId = Number(selectElement.value);
    this.selectedOffer = this.offres.find(o => o.id === offerId) || null;
    
    // Si une nouvelle offre est sélectionnée, on relance automatiquement l'analyse
    if (this.selectedOffer) {
       this.loadIASuggestions();
    }
  }

  loadIASuggestions(): void {
    if (!this.selectedOffer) return;
    
    this.loadingSuggestions = true;
    this.errorMessage = ''; 
    this.infoMessage = 'Analyse de l\'offre par l\'IA en cours...';
    
    // Format attendu par la nouvelle route FastAPI "OfferRequest" (Pydantic)
    const offerPayload = {
      titre: this.selectedOffer.titre || '',
      description: this.selectedOffer.description || ''
    };

    // 3. Appel à la route FastAPI POST /api/match-offer
    this.apiService.getIASuggestionsFromOffer(offerPayload).subscribe({
      next: (data: any) => {
        console.log("Réponse de l'IA (Candidats) :", data); 
        this.suggestions = Array.isArray(data) ? data : (data.suggestions || []); 
        this.loadingSuggestions = false;
        this.hasAnalyzed = true;
        this.infoMessage = 'Recommandations IA générées avec succès !';
      },
      error: (err) => {
        console.error("Erreur de l'API IA :", err); 
        this.loadingSuggestions = false;
        this.hasAnalyzed = true;
        this.infoMessage = '';
        this.errorMessage = "Impossible d'obtenir des recommandations pour cette offre.";
      }
    });
  }
}