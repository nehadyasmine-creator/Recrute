import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

@Component({
  selector: 'app-suggestion-ia-candidat',
  imports: [CommonModule, RouterLink],
  templateUrl: './suggestion-ia-candidat.html',
  styleUrl: './suggestion-ia-candidat.scss',
})
export class SuggestionIaCandidat implements OnInit {
  private authService = inject(AuthService);
  private apiService = inject(ApiService);
  private router = inject(Router);

  candidatId: number | null = null;
  hasCv = false;
  loading = true;
  uploading = false;
  loadingSuggestions = false;
  errorMessage = '';
  infoMessage = '';

  selectedFile: File | null = null;
  suggestions: any[] = [];

  ngOnInit(): void {
    this.initializePage();
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    this.selectedFile = input.files?.[0] ?? null;
  }

  uploadCv(): void {
    if (!this.candidatId) {
      this.errorMessage = 'Profil candidat introuvable.';
      return;
    }

    if (!this.selectedFile) {
      this.errorMessage = 'Veuillez sélectionner un fichier CV PDF.';
      return;
    }

    this.uploading = true;
    this.errorMessage = '';
    this.infoMessage = 'Envoi et analyse du CV en cours...';
    this.loadingSuggestions = true;

    this.apiService.getIASuggestionsFromPdf(this.selectedFile).subscribe({
      next: (data: any) => {
        console.log("Réponse de l'IA :", data);
        this.uploading = false;
        this.loadingSuggestions = false;
        this.hasCv = true;
        this.infoMessage = 'CV analysé avec succès !';
        this.selectedFile = null;
        
        this.suggestions = Array.isArray(data) ? data : (data.suggestions || []); 
      },
      error: (err) => {
        console.error("Erreur de l'API IA :", err);
        this.uploading = false;
        this.loadingSuggestions = false;
        this.infoMessage = '';
        this.errorMessage = "Erreur lors de l'analyse du CV par l'IA.";
      },
    });
  }

  private initializePage(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.router.navigate(['/']);
      return;
    }

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        this.candidatId = candidat?.id ?? null;
        this.hasCv = !!candidat?.cv;
        this.loading = false;

        // Si le candidat a déjà un CV en base de données, on charge les suggestions
        if (this.hasCv) {
          this.loadIASuggestions();
        }
      },
      error: () => {
        this.loading = false;
        this.errorMessage = 'Impossible de charger votre profil candidat.';
      },
    });
  }

  private loadIASuggestions(): void {
    if (!this.candidatId) return;
    
    this.loadingSuggestions = true;
    this.errorMessage = ''; 
    this.infoMessage = 'Récupération de votre CV en cours...';
    
    // 1. On télécharge le CV existant depuis l'API
    this.apiService.downloadCv(this.candidatId).subscribe({
      next: (cvBlob: Blob) => {
        this.infoMessage = "CV récupéré, analyse par l'IA en cours...";

        // 2. On convertit le Blob reçu en un objet File
        const cvFile = new File([cvBlob], 'cv_candidat.pdf', { type: 'application/pdf' });

        // 3. On envoie le fichier à l'IA via le endpoint Python existant
        this.apiService.getIASuggestionsFromPdf(cvFile).subscribe({
          next: (data: any) => {
            console.log("Réponse de l'IA :", data); 
            this.suggestions = Array.isArray(data) ? data : (data.suggestions || []); 
            this.loadingSuggestions = false;
            this.infoMessage = 'Recommandations IA générées avec succès !';
          },
          error: (err) => {
            console.error("Erreur de l'API IA :", err); 
            this.loadingSuggestions = false;
            this.infoMessage = '';
            this.errorMessage = "Impossible de récupérer les recommandations IA.";
          }
        });
      },
      error: (err) => {
        console.error("Erreur lors de la récupération du CV :", err); 
        this.loadingSuggestions = false;
        this.infoMessage = '';
        this.errorMessage = "Impossible de récupérer votre CV enregistré.";
      }
    });
  }
}