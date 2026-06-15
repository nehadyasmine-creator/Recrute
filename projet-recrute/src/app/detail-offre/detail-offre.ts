import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { forkJoin, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { LinkifyPipe } from '../shared/pipes/linkify.pipe';
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
  experienceRequise?: number | null;
  dateDebut?: string | null;
  datePublication?: string | null;
  duree?: string | null;
  statut?: string | null;
  recruteur?: {
    poste?: string | null;
    utilisateur?: {
      id?: number | null;
      nom?: string | null;
      prenom?: string | null;
      email?: string | null;
    };
    entreprise?: {
      id?: number | null;
      nom?: string | null;
      secteur?: string | null;
      siegeSocial?: string | null;
      siteWeb?: string | null;
      taille?: string | null;
      siren?: string | null;
    };
  };
}

interface CompetenceOffreView {
  nom: string;
  obligatoire: boolean;
}

interface CandidatureView {
  id: number;
  candidatId: number;
  candidatNom: string;
  candidatEmail: string;
  statut: string;
  dateCandidature?: string | null;
  cv?: string | null;
  aiScore?: number;
}

@Component({
  selector: 'app-detail-offre',
  imports: [CommonModule, RouterLink, LinkifyPipe],
  templateUrl: './detail-offre.html',
  styleUrl: './detail-offre.scss',
})
export class DetailOffre implements OnInit {
  private apiService = inject(ApiService);
  private authService = inject(AuthService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  offre: Offre | null = null;
  competencesRequises: CompetenceOffreView[] = [];
  loading = true;
  errorMessage = '';
  savedOfferIds: Set<number> = new Set();
  
  receivedApplications: CandidatureView[] = [];
  loadingApplications = false;
  applicationsError = '';
  
  analyzingIA = false;
  hasAnalyzedIA = false;
  aiAnalysisError = '';

  private candidateId: number | null = null;

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const id = Number(idParam);

    if (!id || Number.isNaN(id)) {
      this.errorMessage = 'Offre introuvable.';
      this.loading = false;
      return;
    }

    this.loadOffre(id);
    this.loadSavedOffers();
  }

  private loadOffre(id: number): void {
    this.loading = true;
    this.apiService.getOffreById(id).subscribe({
      next: (offre) => {
        this.offre = offre;
        this.loadReceivedApplications(id);
        this.loading = false;
        this.loadCompetences(id);
      },
      error: () => {
        this.errorMessage = 'Impossible de charger cette offre pour le moment.';
        this.loading = false;
      },
    });
  }

  private loadCompetences(offerId: number): void {
    this.apiService.getCompetencesByOffre(offerId).subscribe({
      next: (competencesOffres) => {
        this.competencesRequises = (competencesOffres || []).map((item: any) => ({
          nom: item?.competence?.nom || 'Compétence non précisée',
          obligatoire: !!item?.obligatoire,
        }));
      },
      error: () => {
        this.competencesRequises = [];
      },
    });
  }

  private loadSavedOffers(): void {
    const userId = this.authService.getUserId();
    if (!userId) return;

    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        this.candidateId = candidat?.id ?? null;
        if (!this.candidateId) return;

        this.apiService.getCandidaturesByCandidat(this.candidateId).subscribe({
          next: (candidatures) => {
            const savedCands = candidatures.filter((c: any) => c.statut === 'enregistree');
            this.savedOfferIds = new Set(savedCands.map((c: any) => c.offre?.id || c.idOffre));
          },
        });
      },
    });
  }

  goToCandidatureDetail(candidatureId: number): void {
    this.router.navigate(['/detail-candidature', candidatureId]);
  }

  private loadReceivedApplications(offerId: number): void {
    this.receivedApplications = [];
    this.applicationsError = '';

    if (!this.canEditOffer()) {
      return;
    }

    this.loadingApplications = true;

    this.apiService.getCandidaturesByOffre(offerId).subscribe({
      next: (candidatures) => {
        const filtered = (candidatures || []).filter((c: any) => c?.statut !== 'enregistree');

        this.receivedApplications = filtered
          .map((c: any): CandidatureView => {
            const prenom = (c?.candidat?.utilisateur?.prenom || '').trim();
            const nom = (c?.candidat?.utilisateur?.nom || '').trim();
            const fullName = `${prenom} ${nom}`.trim();

            return {
              id: c?.id,
              candidatId: c?.candidat?.id, 
              candidatNom: fullName || 'Candidat inconnu',
              candidatEmail: c?.candidat?.utilisateur?.email || 'Email non renseigné',
              statut: this.candidatureStatusLabel(c?.statut),
              dateCandidature: c?.dateCandidature || null,
              cv: c?.candidat?.cv || null,
            };
          })
          .sort((a, b) => {
            const dateA = a.dateCandidature ? new Date(a.dateCandidature).getTime() : 0;
            const dateB = b.dateCandidature ? new Date(b.dateCandidature).getTime() : 0;
            return dateB - dateA;
          });

        this.loadingApplications = false;
      },
      error: () => {
        this.loadingApplications = false;
        this.applicationsError = 'Impossible de charger les candidatures reçues pour cette offre.';
      },
    });
  }

  analyzeApplicationsWithIA(): void {
    if (!this.offre || this.receivedApplications.length === 0) return;

    const candsWithCv = this.receivedApplications.filter(c => c.candidatId && c.cv);
    if (candsWithCv.length === 0) {
      this.aiAnalysisError = "Aucun candidat n'a fourni de CV.";
      return;
    }

    this.analyzingIA = true;
    this.aiAnalysisError = '';

    const downloadObservables = candsWithCv.map(cand =>
      this.apiService.downloadCv(cand.candidatId).pipe(
        map((blob: Blob) => {
          const fileName = `cv_${cand.id}.pdf`;
          return new File([blob], fileName, { type: 'application/pdf' });
        }),
        catchError(() => of(null)) 
      )
    );

    forkJoin(downloadObservables).subscribe({
      next: (filesOrNull) => {
        const validFiles = filesOrNull.filter(f => f !== null) as File[];

        if (validFiles.length === 0) {
          this.analyzingIA = false;
          this.aiAnalysisError = "Impossible de récupérer les fichiers PDF des CVs.";
          return;
        }

        this.apiService.compareMultipleCvs(
          this.offre!.titre,
          this.offre!.description,
          validFiles
        ).subscribe({
          next: (results) => {
            results.forEach((res: any) => {
              const match = res.nomFichier.match(/cv_(\d+)\.pdf/);
              if (match) {
                const candId = Number(match[1]);
                const targetCand = this.receivedApplications.find(c => c.id === candId);
                if (targetCand) {
                  targetCand.aiScore = res.score;
                }
              }
            });

            this.receivedApplications.sort((a, b) => {
              const scoreA = a.aiScore !== undefined ? a.aiScore : -1;
              const scoreB = b.aiScore !== undefined ? b.aiScore : -1;
              return scoreB - scoreA;
            });

            this.analyzingIA = false;
            this.hasAnalyzedIA = true;
          },
          error: (err) => {
            console.error("Erreur API IA :", err);
            this.analyzingIA = false;
            this.aiAnalysisError = "Erreur lors de l'analyse des CVs par l'IA.";
          }
        });
      },
      error: () => {
        this.analyzingIA = false;
        this.aiAnalysisError = "Erreur globale lors du téléchargement des CVs.";
      }
    });
  }

  private candidatureStatusLabel(status?: string | null): string {
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
        return this.displayOrFallback(status, 'Non renseigné');
    }
  }

  isOfferSaved(): boolean {
    if (!this.offre) return false;
    return this.savedOfferIds.has(this.offre.id);
  }

  toggleSaveOffer(event?: Event): void {
    event?.stopPropagation();

    if (!this.offre) return;

    const userId = this.authService.getUserId();
    if (!userId) {
      this.errorMessage = 'Vous devez être connecté pour enregistrer une offre.';
      return;
    }

    if (!this.candidateId) {
      this.apiService.getCandidatByUtilisateurId(userId).subscribe({
        next: (candidat) => {
          this.candidateId = candidat?.id ?? null;
          if (!this.candidateId) {
            this.errorMessage = 'Impossible de retrouver votre profil candidat.';
            return;
          }
          this.saveOrRemoveCurrentOffer();
        },
        error: () => {
          this.errorMessage = 'Impossible de retrouver votre profil candidat.';
        },
      });
      return;
    }

    this.saveOrRemoveCurrentOffer();
  }

  private saveOrRemoveCurrentOffer(): void {
    if (!this.offre || !this.candidateId) return;

    if (this.isOfferSaved()) {
      this.removeSavedOffer(this.offre.id);
    } else {
      this.saveOffer(this.offre.id, this.candidateId);
    }
  }

  private saveOffer(offerId: number, candidateId: number): void {
    const candidature = {
      offre: { id: offerId },
      candidat: { id: candidateId },
      statut: 'enregistree',
      dateCandidature: new Date().toISOString().split('T')[0],
    };

    this.apiService.createCandidature(candidature).subscribe({
      next: () => {
        this.savedOfferIds.add(offerId);
      },
      error: () => {
        this.errorMessage = "Erreur lors de l'enregistrement de l'offre.";
      },
    });
  }

  private removeSavedOffer(offerId: number): void {
    if (!this.candidateId) return;

    this.apiService.getCandidaturesByCandidat(this.candidateId).subscribe({
      next: (candidatures) => {
        const savedCand = candidatures.find(
          (c: any) => c.statut === 'enregistree' && (c.offre?.id === offerId || c.idOffre === offerId)
        );
        if (!savedCand) return;

        this.apiService.deleteCandidature(savedCand.id).subscribe({
          next: () => {
            this.savedOfferIds.delete(offerId);
          },
          error: () => {
            this.errorMessage = "Erreur lors de la suppression de l'enregistrement.";
          },
        });
      },
    });
  }

  goBackToList(): void {
    this.router.navigate(['/liste-offres']);
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

  yesNo(value?: boolean | null): string {
    return value ? 'Oui' : 'Non';
  }

  displayOrFallback(value: unknown, fallback = 'Non renseigné'): string {
    if (value === null || value === undefined) return fallback;

    const str = String(value).trim();
    return str ? str : fallback;
  }

  recruteurNomComplet(): string {
    const prenom = this.offre?.recruteur?.utilisateur?.prenom?.trim() || '';
    const nom = this.offre?.recruteur?.utilisateur?.nom?.trim() || '';
    const fullName = `${prenom} ${nom}`.trim();
    return fullName || 'Non renseigné';
  }

  canEditOffer(): boolean {
    if (this.authService.getUserRole() !== 'recruteur') {
      return false;
    }

    const userId = this.authService.getUserId();
    const offerOwnerUserId = this.offre?.recruteur?.utilisateur?.id;
    return !!userId && !!offerOwnerUserId && userId === offerOwnerUserId;
  }

  entrepriseLink(): string[] | null {
    const entrepriseId = this.offre?.recruteur?.entreprise?.id;
    return entrepriseId ? ['/detail-entreprise', String(entrepriseId)] : null;
  }
}