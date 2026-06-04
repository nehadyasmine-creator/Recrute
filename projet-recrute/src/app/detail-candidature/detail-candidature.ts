import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

interface CandidatureDetail {
  id: number;
  statut: string;
  dateCandidature: string;
  lettreMotivation?: string | null;
  offre?: {
    id: number;
    titre: string;
    lieu: string;
    typeContrat: string;
  } | null;
  candidat?: {
    id: number;
    cv?: string | null;
    utilisateur?: {
      nom: string;
      prenom: string;
      email: string;
    } | null;
  } | null;
}

@Component({
  selector: 'app-detail-candidature',
  imports: [CommonModule, RouterLink],
  templateUrl: './detail-candidature.html',
  styleUrl: './detail-candidature.scss'
})
export class DetailCandidature implements OnInit, OnDestroy {
  private apiService = inject(ApiService);
  private authService = inject(AuthService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private sanitizer = inject(DomSanitizer);

  candidature: CandidatureDetail | null = null;
  loading = true;
  errorMessage = '';
  actionLoading = false;
  cvPreviewUrl: SafeResourceUrl | null = null;
  private cvBlobUrl: string | null = null;

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const id = Number(idParam);

    if (!id || Number.isNaN(id)) {
      this.errorMessage = 'Candidature introuvable.';
      this.loading = false;
      return;
    }

    this.loadCandidature(id);
  }

  private loadCandidature(id: number): void {
    this.loading = true;
    this.apiService.getCandidatureById(id).subscribe({
      next: (data) => {
        this.candidature = data;
        this.loading = false;
        this.loadCvPreview();
        
        // Sécurité : s'assurer que seul le recruteur peut voir cela (optionnel selon vos règles)
        if (this.authService.getUserRole() !== 'recruteur') {
          this.errorMessage = "Accès restreint aux recruteurs.";
          this.candidature = null;
          this.clearCvPreviewUrl();
        }
      },
      error: () => {
        this.errorMessage = 'Impossible de charger les détails de la candidature.';
        this.loading = false;
      }
    });
  }

  ngOnDestroy(): void {
    this.clearCvPreviewUrl();
  }

  updateStatut(nouveauStatut: string): void {
    if (!this.candidature || this.actionLoading) return;
    this.actionLoading = true;

    // On prépare l'objet partiel à envoyer au backend
    const candidatureModifiee = {
      ...this.candidature,
      statut: nouveauStatut
    };

    this.apiService.updateCandidatureStatut(this.candidature.id, candidatureModifiee).subscribe({
      next: () => {
        if (this.candidature) {
          this.candidature.statut = nouveauStatut;
        }
        this.actionLoading = false;
      },
      error: () => {
        this.errorMessage = "Échec de la mise à jour du statut.";
        this.actionLoading = false;
      }
    });
  }

  contacterCandidat(): void {
    if (!this.candidature?.candidat?.utilisateur?.email) return;
    const email = this.candidature.candidat.utilisateur.email;
    const sujet = encodeURIComponent(`Votre candidature pour le poste de : ${this.candidature.offre?.titre || ''}`);
    window.location.href = `mailto:${email}?subject=${sujet}`;
  }

  formatDate(value?: string | null): string {
    if (!value) return 'Non renseignée';
    const date = new Date(value);
    return Number.isNaN(date.getTime()) ? value : new Intl.DateTimeFormat('fr-FR', { day: '2-digit', month: 'long', year: 'numeric' }).format(date);
  }

  getStatutClass(status?: string): string {
    switch (status) {
      case 'acceptee': return 'status-accepted';
      case 'refusee': return 'status-rejected';
      case 'en_attente': return 'status-pending';
      default: return 'status-default';
    }
  }

  getStatutLabel(status?: string): string {
    switch (status) {
      case 'envoyee': return 'Reçue / Nouvelle';
      case 'en_attente': return 'En cours d\'examen';
      case 'refusee': return 'Refusée';
      case 'acceptee': return 'Acceptée';
      default: return status || 'Inconnu';
    }
  }

  private loadCvPreview(): void {
    const candidatId = this.candidature?.candidat?.id;
    if (!candidatId || !this.candidature?.candidat?.cv) {
      this.clearCvPreviewUrl();
      return;
    }

    this.apiService.downloadCv(candidatId).subscribe({
      next: (blob) => {
        this.clearCvPreviewUrl();
        this.cvBlobUrl = window.URL.createObjectURL(blob);
        this.cvPreviewUrl = this.sanitizer.bypassSecurityTrustResourceUrl(this.cvBlobUrl);
      },
      error: () => {
        this.clearCvPreviewUrl();
      },
    });
  }

  private clearCvPreviewUrl(): void {
    this.cvPreviewUrl = null;
    if (this.cvBlobUrl) {
      window.URL.revokeObjectURL(this.cvBlobUrl);
      this.cvBlobUrl = null;
    }
  }
}