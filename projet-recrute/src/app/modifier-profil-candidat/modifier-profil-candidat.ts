import { CommonModule } from '@angular/common';
import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { forkJoin, switchMap } from 'rxjs';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-modifier-profil-candidat',
  imports: [CommonModule, FormsModule],
  templateUrl: './modifier-profil-candidat.html',
  styleUrl: './modifier-profil-candidat.scss',
})
export class ModifierProfilCandidat implements OnInit, OnDestroy {
  ongletActif = 'infos';

  isLoading = false;
  infoMessage = '';
  errorMessage = '';

  userId: number | null = null;
  candidatId: number | null = null;

  currentUtilisateur: any = null;
  currentCandidat: any = null;

  utilisateurForm = {
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
  };

  candidatForm = {
    typeContrat: '',
    ville: '',
    disponibilite: '',
  };

  readonly typeContrats = ['CDI', 'CDD', 'Stage', 'Alternance', 'Freelance', 'Interim'];
  readonly niveaux = ['debutant', 'intermediaire', 'avance', 'expert'];
  readonly categoriesCompetence = ['technique', 'soft_skill', 'langue', 'autre'];

  experiences: any[] = [];
  newExperience = {
    poste: '',
    entrepriseNom: '',
    dateDebut: '',
    dateFin: '',
    description: '',
  };
  editingExperienceId: number | null = null;
  editingExperience = {
    poste: '',
    entrepriseNom: '',
    dateDebut: '',
    dateFin: '',
    description: '',
  };

  competencesCatalog: any[] = [];
  competencesCandidat: any[] = [];
  newCompetence = {
    category: 'technique',
    nom: '',
    niveau: 'debutant',
  };
  editingCompetenceKey: string | null = null;
  editingCompetence = {
    idCompetence: null as number | null,
    category: 'technique',
    nom: '',
    niveau: 'debutant',
  };

  selectedFile: File | null = null;
  cvPreviewUrl: SafeResourceUrl | null = null;
  private cvBlobUrl: string | null = null;

  selectedPdpFile: File | null = null;
  pdpPreviewUrl: string | null = null;
  private pdpBlobUrl: string | null = null;

  passwordForm = {
    ancienMotDePasse: '',
    nouveauMotDePasse: '',
    confirmationNouveauMotDePasse: '',
  };

  private authService = inject(AuthService);
  private apiService = inject(ApiService);
  private router = inject(Router);
  private sanitizer = inject(DomSanitizer);

  ngOnInit(): void {
    this.loadAll();
  }

  ngOnDestroy(): void {
    this.clearCvPreviewUrl();
    this.clearPdpPreviewUrl();
  }

  changerOnglet(nomOnglet: string): void {
    this.ongletActif = nomOnglet;
    this.clearMessages();
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/']);
  }

  private clearMessages(): void {
    this.infoMessage = '';
    this.errorMessage = '';
  }

  private setError(message: string): void {
    this.infoMessage = '';
    this.errorMessage = message;
  }

  private setInfo(message: string): void {
    this.errorMessage = '';
    this.infoMessage = message;
  }

  private ensureSession(): boolean {
    const id = this.authService.getUserId();
    if (!id) {
      this.setError('Session expirée, veuillez vous reconnecter.');
      return false;
    }
    this.userId = id;
    return true;
  }

  loadAll(): void {
    if (!this.ensureSession() || this.userId === null) {
      return;
    }

    this.isLoading = true;
    this.clearMessages();

    forkJoin({
      utilisateur: this.apiService.getUtilisateurById(this.userId),
      candidat: this.apiService.getCandidatByUtilisateurId(this.userId),
      competencesCatalog: this.apiService.getCompetences(),
    }).subscribe({
      next: ({ utilisateur, candidat, competencesCatalog }) => {
        this.currentUtilisateur = utilisateur;
        this.currentCandidat = candidat;
        this.candidatId = candidat?.id ?? null;
        this.competencesCatalog = competencesCatalog || [];

        this.utilisateurForm = {
          nom: utilisateur?.nom ?? '',
          prenom: utilisateur?.prenom ?? '',
          email: utilisateur?.email ?? '',
          telephone: utilisateur?.telephone ?? '',
        };

        this.candidatForm = {
          typeContrat: candidat?.typeContrat ?? '',
          ville: candidat?.ville ?? '',
          disponibilite: candidat?.disponibilite ?? '',
        };

        this.loadExperiences();
        this.loadCompetencesCandidat();
        this.loadCvPreview();
        this.loadPdpPreview();
        this.isLoading = false;
      },
      error: () => {
        this.isLoading = false;
        this.setError('Impossible de charger votre profil candidat.');
      },
    });
  }

  getUtilisateurInitiales(): string {
    const nom = (this.utilisateurForm.nom || '').trim();
    const prenom = (this.utilisateurForm.prenom || '').trim();
    if (prenom && nom) {
      return `${prenom.charAt(0)}${nom.charAt(0)}`.toUpperCase();
    }
    if (prenom) {
      return prenom.charAt(0).toUpperCase();
    }
    if (nom) {
      return nom.charAt(0).toUpperCase();
    }
    return 'U';
  }

  saveInfos(): void {
    if (!this.userId || !this.candidatId || !this.currentUtilisateur || !this.currentCandidat) {
      this.setError('Profil incomplet, veuillez recharger la page.');
      return;
    }

    this.clearMessages();

    const updatedUtilisateur = {
      ...this.currentUtilisateur,
      nom: this.utilisateurForm.nom,
      prenom: this.utilisateurForm.prenom,
      email: this.utilisateurForm.email,
      telephone: this.utilisateurForm.telephone,
    };

    const updatedCandidat = {
      ...this.currentCandidat,
      typeContrat: this.candidatForm.typeContrat || null,
      ville: this.candidatForm.ville || null,
      disponibilite: this.candidatForm.disponibilite || null,
    };

    this.apiService
      .updateUtilisateur(this.userId, updatedUtilisateur)
      .pipe(switchMap(() => this.apiService.updateCandidat(this.candidatId as number, updatedCandidat)))
      .subscribe({
        next: () => {
          this.currentUtilisateur = updatedUtilisateur;
          this.currentCandidat = updatedCandidat;
          this.setInfo('Informations mises à jour avec succès.');
        },
        error: () => this.setError('Erreur lors de la mise à jour des informations.'),
      });
  }

  loadExperiences(): void {
    if (!this.candidatId) {
      return;
    }

    this.apiService.getExperiencesByCandidat(this.candidatId).subscribe({
      next: (data) => {
        this.experiences = data || [];
      },
      error: () => this.setError('Impossible de charger les expériences.'),
    });
  }

  addExperience(): void {
    if (!this.candidatId) {
      return;
    }
    if (!this.newExperience.poste.trim()) {
      this.setError('Le poste est obligatoire pour ajouter une expérience.');
      return;
    }

    const payload = {
      candidat: { id: this.candidatId },
      poste: this.newExperience.poste,
      entrepriseNom: this.newExperience.entrepriseNom || null,
      dateDebut: this.newExperience.dateDebut || null,
      dateFin: this.newExperience.dateFin || null,
      description: this.newExperience.description || null,
    };

    this.apiService.createExperience(payload).subscribe({
      next: () => {
        this.newExperience = {
          poste: '',
          entrepriseNom: '',
          dateDebut: '',
          dateFin: '',
          description: '',
        };
        this.loadExperiences();
      },
      error: () => this.setError("Erreur lors de l'ajout de l'expérience."),
    });
  }

  startEditExperience(exp: any): void {
    this.editingExperienceId = exp.id;
    this.editingExperience = {
      poste: exp.poste ?? '',
      entrepriseNom: exp.entrepriseNom ?? '',
      dateDebut: exp.dateDebut ?? '',
      dateFin: exp.dateFin ?? '',
      description: exp.description ?? '',
    };
  }

  cancelEditExperience(): void {
    this.editingExperienceId = null;
  }

  saveExperience(exp: any): void {
    if (!this.candidatId || !this.editingExperienceId) {
      return;
    }

    const payload = {
      ...exp,
      candidat: { id: this.candidatId },
      poste: this.editingExperience.poste,
      entrepriseNom: this.editingExperience.entrepriseNom || null,
      dateDebut: this.editingExperience.dateDebut || null,
      dateFin: this.editingExperience.dateFin || null,
      description: this.editingExperience.description || null,
    };

    this.apiService.updateExperience(this.editingExperienceId, payload).subscribe({
      next: () => {
        this.editingExperienceId = null;
        this.loadExperiences();
      },
      error: () => this.setError("Erreur lors de la modification de l'expérience."),
    });
  }

  deleteExperience(id: number): void {
    this.apiService.deleteExperience(id).subscribe({
      next: () => {
        this.loadExperiences();
      },
      error: () => this.setError("Erreur lors de la suppression de l'expérience."),
    });
  }

  loadCompetencesCandidat(): void {
    if (!this.candidatId) {
      return;
    }

    this.apiService.getCompetencesByCandidat(this.candidatId).subscribe({
      next: (data) => {
        this.competencesCandidat = data || [];
      },
      error: () => this.setError('Impossible de charger les compétences.'),
    });
  }

  addCompetence(): void {
    if (!this.candidatId || !this.newCompetence.nom.trim()) {
      this.setError('Choisissez une catégorie et saisissez la compétence.');
      return;
    }

    this.apiService
      .createCompetence({
        category: this.newCompetence.category,
        nom: this.newCompetence.nom.trim(),
      })
      .pipe(
        switchMap((competence) =>
          this.apiService.addCompetenceCandidat({
            id: {
              idCandidat: this.candidatId,
              idCompetence: competence.id,
            },
            candidat: { id: this.candidatId },
            competence: { id: competence.id },
            niveau: this.newCompetence.niveau,
          })
        )
      )
      .subscribe({
      next: () => {
        this.newCompetence = {
          category: 'technique',
          nom: '',
          niveau: 'debutant',
        };
        this.loadCompetencesCandidat();
      },
      error: () => this.setError("Erreur lors de l'ajout de la compétence."),
    });
  }

  startEditCompetence(comp: any): void {
    const key = `${comp.id?.idCandidat}-${comp.id?.idCompetence}`;
    this.editingCompetenceKey = key;
    this.editingCompetence = {
      idCompetence: comp.id?.idCompetence ?? null,
      category: comp.competence?.category ?? 'technique',
      nom: comp.competence?.nom ?? '',
      niveau: comp.niveau ?? 'debutant',
    };
  }

  cancelEditCompetence(): void {
    this.editingCompetenceKey = null;
  }

  saveCompetence(comp: any): void {
    if (!this.candidatId || !this.editingCompetence.idCompetence || !this.editingCompetence.nom.trim()) {
      return;
    }

    this.apiService
      .updateCompetence(this.editingCompetence.idCompetence, {
        id: this.editingCompetence.idCompetence,
        category: this.editingCompetence.category,
        nom: this.editingCompetence.nom.trim(),
      })
      .pipe(
        switchMap((updatedCompetence) =>
          this.apiService.deleteCompetenceCandidat(this.candidatId as number, comp.id?.idCompetence)
            .pipe(
              switchMap(() =>
          this.apiService.addCompetenceCandidat({
            id: {
              idCandidat: this.candidatId,
              idCompetence: updatedCompetence.id,
            },
            candidat: { id: this.candidatId },
            competence: { id: updatedCompetence.id },
            niveau: this.editingCompetence.niveau,
          })
              )
            )
        )
      )
      .subscribe({
        next: () => {
          this.editingCompetenceKey = null;
          this.loadCompetencesCandidat();
        },
        error: () => this.setError('Erreur lors de la modification de la compétence.'),
      });
  }

  deleteCompetence(comp: any): void {
    if (!this.candidatId || !comp?.id?.idCompetence) {
      return;
    }

    this.apiService.deleteCompetenceCandidat(this.candidatId, comp.id.idCompetence).subscribe({
      next: () => {
        this.loadCompetencesCandidat();
      },
      error: () => this.setError('Erreur lors de la suppression de la compétence.'),
    });
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    if (file) {
      this.selectedFile = file;
    }
  }

  uploadCV(): void {
    if (!this.candidatId) {
      this.setError('Profil candidat introuvable.');
      return;
    }
    if (!this.selectedFile) {
      this.setError('Veuillez sélectionner un fichier PDF.');
      return;
    }

    this.apiService.uploadCv(this.candidatId, this.selectedFile).subscribe({
      next: () => {
        this.selectedFile = null;
        this.setInfo('CV mis à jour avec succès.');
        this.refreshCandidat();
        this.loadCvPreview();
      },
      error: () => this.setError("Erreur lors de l'envoi du fichier CV."),
    });
  }

  downloadCv(): void {
    if (!this.candidatId || !this.currentCandidat?.cv) {
      this.setError('Aucun CV disponible.');
      return;
    }

    this.apiService.downloadCv(this.candidatId).subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = this.currentCandidat.cv;
        a.click();
        window.URL.revokeObjectURL(url);
      },
      error: () => this.setError('Impossible de télécharger le CV.'),
    });
  }

  private refreshCandidat(): void {
    if (!this.candidatId) {
      return;
    }

    this.apiService.getCandidatById(this.candidatId).subscribe({
      next: (candidat) => {
        this.currentCandidat = candidat;
        this.candidatForm = {
          typeContrat: candidat?.typeContrat ?? '',
          ville: candidat?.ville ?? '',
          disponibilite: candidat?.disponibilite ?? '',
        };
        if (candidat?.cv) {
          this.loadCvPreview();
        } else {
          this.clearCvPreviewUrl();
        }
      },
      error: () => this.setError('Impossible de rafraîchir le profil candidat.'),
    });
  }

  onPdpSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0] ?? null;
    if (!file) {
      return;
    }

    this.selectedPdpFile = file;
    this.clearPdpPreviewUrl();
    this.pdpBlobUrl = window.URL.createObjectURL(file);
    this.pdpPreviewUrl = this.pdpBlobUrl;
  }

  uploadPdp(): void {
    if (!this.userId) {
      this.setError('Utilisateur non identifié.');
      return;
    }

    if (!this.selectedPdpFile) {
      this.setError('Veuillez sélectionner une image.');
      return;
    }

    this.apiService.uploadPdp(this.userId, this.selectedPdpFile).subscribe({
      next: () => {
        this.selectedPdpFile = null;
        this.setInfo('Photo de profil mise à jour avec succès.');
        this.refreshUtilisateur();
      },
      error: () => this.setError("Erreur lors de l'envoi de la photo de profil."),
    });
  }

  private refreshUtilisateur(): void {
    if (!this.userId) {
      return;
    }

    this.apiService.getUtilisateurById(this.userId).subscribe({
      next: (utilisateur) => {
        this.currentUtilisateur = utilisateur;
        this.utilisateurForm = {
          nom: utilisateur?.nom ?? '',
          prenom: utilisateur?.prenom ?? '',
          email: utilisateur?.email ?? '',
          telephone: utilisateur?.telephone ?? '',
        };
        this.loadPdpPreview();
        window.dispatchEvent(new Event('profile-updated'));
      },
      error: () => this.setError('Impossible de rafraîchir le profil utilisateur.'),
    });
  }

  changePassword(): void {
    if (!this.userId) {
      this.setError('Utilisateur non identifié.');
      return;
    }

    if (!this.passwordForm.ancienMotDePasse || !this.passwordForm.nouveauMotDePasse || !this.passwordForm.confirmationNouveauMotDePasse) {
      this.setError('Tous les champs de mot de passe sont obligatoires.');
      return;
    }

    if (this.passwordForm.nouveauMotDePasse !== this.passwordForm.confirmationNouveauMotDePasse) {
      this.setError('La confirmation du nouveau mot de passe ne correspond pas.');
      return;
    }

    this.apiService.changePassword(this.userId, this.passwordForm).subscribe({
      next: () => {
        this.passwordForm = {
          ancienMotDePasse: '',
          nouveauMotDePasse: '',
          confirmationNouveauMotDePasse: '',
        };
        this.setInfo('Mot de passe modifié avec succès.');
      },
      error: (err) => this.setError(err?.error || 'Erreur lors du changement du mot de passe.'),
    });
  }

  private loadCvPreview(): void {
    if (!this.candidatId || !this.currentCandidat?.cv) {
      this.clearCvPreviewUrl();
      return;
    }

    this.apiService.downloadCv(this.candidatId).subscribe({
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

  private loadPdpPreview(): void {
    if (!this.userId || !this.currentUtilisateur?.pdp) {
      this.clearPdpPreviewUrl();
      return;
    }

    this.apiService.downloadPdp(this.userId).subscribe({
      next: (blob) => {
        this.clearPdpPreviewUrl();
        this.pdpBlobUrl = window.URL.createObjectURL(blob);
        this.pdpPreviewUrl = this.pdpBlobUrl;
      },
      error: () => {
        this.clearPdpPreviewUrl();
      },
    });
  }

  private clearPdpPreviewUrl(): void {
    this.pdpPreviewUrl = null;
    if (this.pdpBlobUrl) {
      window.URL.revokeObjectURL(this.pdpBlobUrl);
      this.pdpBlobUrl = null;
    }
  }
}
