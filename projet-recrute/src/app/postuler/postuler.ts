import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';

interface OffreResume {
  id: number;
  titre?: string | null;
  lieu?: string | null;
  typeContrat?: string | null;
  description?: string | null;
  recruteur?: {
    entreprise?: {
      id?: number | null;
      nom?: string | null;
    };
  };
}

@Component({
  selector: 'app-postuler',
  imports: [CommonModule, FormsModule],
  templateUrl: './postuler.html',
  styleUrl: './postuler.scss',
})
export class Postuler implements OnInit {
  private apiService = inject(ApiService);
  private authService = inject(AuthService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  loading = true;
  submitting = false;
  infoMessage = '';
  errorMessage = '';

  offerId: number | null = null;
  userId: number | null = null;
  candidateId: number | null = null;

  offre: OffreResume | null = null;
  lettreMotivation = '';
  hasAlreadyApplied = false;
  showFullDescription = false;

  ngOnInit(): void {
    this.loadPage();
  }

  private loadPage(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const offerId = Number(idParam);

    if (!offerId || Number.isNaN(offerId)) {
      this.errorMessage = 'Offre introuvable.';
      this.loading = false;
      return;
    }

    this.offerId = offerId;
    this.userId = this.authService.getUserId();

    if (!this.userId) {
      this.errorMessage = 'Vous devez être connecté pour postuler.';
      this.loading = false;
      return;
    }

    this.apiService.getOffreById(offerId).subscribe({
      next: (offre) => {
        this.offre = offre;
        this.loadCandidateContext();
      },
      error: () => {
        this.errorMessage = 'Impossible de charger cette offre pour le moment.';
        this.loading = false;
      },
    });
  }

  private loadCandidateContext(): void {
    if (!this.userId) {
      this.loading = false;
      return;
    }

    this.apiService.getCandidatByUtilisateurId(this.userId).subscribe({
      next: (candidat) => {
        this.candidateId = candidat?.id ?? null;

        if (!this.candidateId) {
          this.errorMessage = 'Impossible de retrouver votre profil candidat.';
          this.loading = false;
          return;
        }

        this.checkExistingApplication();
      },
      error: () => {
        this.errorMessage = 'Impossible de retrouver votre profil candidat.';
        this.loading = false;
      },
    });
  }

  private checkExistingApplication(): void {
    if (!this.candidateId || !this.offerId) {
      this.loading = false;
      return;
    }

    this.apiService.getCandidaturesByCandidat(this.candidateId).subscribe({
      next: (candidatures) => {
        this.hasAlreadyApplied = (candidatures || []).some((candidature: any) => Number(candidature?.offre?.id ?? candidature?.idOffre) === this.offerId);
        if (this.hasAlreadyApplied) {
          this.infoMessage = 'Vous avez déjà une candidature pour cette offre.';
        }
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  submitApplication(): void {
    if (!this.offerId || !this.candidateId) {
      this.errorMessage = 'Impossible de soumettre votre candidature.';
      return;
    }

    const motivation = this.lettreMotivation.trim();
    if (!motivation) {
      this.errorMessage = 'La lettre de motivation est obligatoire.';
      return;
    }

    if (this.hasAlreadyApplied) {
      this.errorMessage = 'Vous avez déjà postulé à cette offre.';
      return;
    }

    this.submitting = true;
    this.errorMessage = '';
    this.infoMessage = '';

    const candidature = {
      offre: { id: this.offerId },
      candidat: { id: this.candidateId },
      lettreMotivation: motivation,
      dateCandidature: new Date().toISOString().split('T')[0],
      statut: 'envoyee',
    };

    this.apiService.createCandidature(candidature).subscribe({
      next: () => {
        this.submitting = false;
        this.infoMessage = 'Votre candidature a été envoyée avec succès.';
        this.hasAlreadyApplied = true;
        this.router.navigate(['/detail-offre', this.offerId]);
      },
      error: () => {
        this.submitting = false;
        this.errorMessage = 'Erreur lors de l’envoi de la candidature.';
      },
    });
  }

  backToOffer(): void {
    if (this.offerId) {
      this.router.navigate(['/detail-offre', this.offerId]);
      return;
    }

    this.router.navigate(['/liste-offres']);
  }

  offerTitle(): string {
    return this.offre?.titre?.trim() || 'Offre';
  }

  companyName(): string {
    return this.offre?.recruteur?.entreprise?.nom?.trim() || 'Entreprise non renseignée';
  }

  offerMeta(): string {
    const city = this.offre?.lieu?.trim();
    const contract = this.offre?.typeContrat?.trim();
    return [city, contract].filter(Boolean).join(' · ') || 'Informations non renseignées';
  }

  getOfferDescription(): string {
    return this.offre?.description?.trim() || 'Aucune description renseignée.';
  }

  getOfferDescriptionPreview(): string {
    const description = this.getOfferDescription();
    const limit = 260;
    if (description.length <= limit) {
      return description;
    }

    return `${description.slice(0, limit).trimEnd()}...`;
  }

  hasLongDescription(): boolean {
    return this.getOfferDescription().length > 260;
  }

  toggleDescription(): void {
    this.showFullDescription = !this.showFullDescription;
  }
}
