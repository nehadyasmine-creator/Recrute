import { CommonModule } from '@angular/common';
import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { FormatTaillePipe } from '../shared/pipes/format-taille.pipe';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { forkJoin, of, switchMap } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-modifier-profil-employeur',
  imports: [CommonModule, FormsModule, FormatTaillePipe],
  templateUrl: './modifier-profil-employeur.html',
  styleUrl: './modifier-profil-employeur.scss',
})
export class ModifierProfilEmployeur implements OnInit, OnDestroy {
  ongletActif = 'infos';

  isLoading = false;
  infoMessage = '';
  errorMessage = '';

  userId: number | null = null;
  recruteurId: number | null = null;
  entrepriseId: number | null = null;

  currentUtilisateur: any = null;
  currentRecruteur: any = null;
  currentEntreprise: any = null;

  utilisateurForm = {
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
  };

  recruteurForm = {
    poste: '',
  };

  entrepriseForm = {
    nom: '',
    secteur: '',
    siegeSocial: '',
    siren: '',
    siteWeb: '',
    taille: '',
  }

  readonly taillesEntreprises = ['startup','pme','eti','grand_groupe'];

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
  private route = inject(ActivatedRoute);
  private sanitizer = inject(DomSanitizer);

  ngOnInit(): void {
    const ongletParam = this.route.snapshot.queryParamMap.get('onglet');
    if (ongletParam === 'entreprise' || ongletParam === 'infos') {
      this.ongletActif = ongletParam;
    }

    this.loadAll();
  }

  ngOnDestroy(): void {
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
      recruteur: this.apiService.getRecruteurByUtilisateurId(this.userId),
    })
      .pipe(
        switchMap(({ utilisateur, recruteur }) => {
          this.currentUtilisateur = utilisateur;
          this.currentRecruteur = recruteur;
          this.recruteurId = recruteur?.id ?? null;
          this.entrepriseId = recruteur?.entreprise?.id ?? null;

          if (this.entrepriseId) {
            return forkJoin({
              utilisateur: of(utilisateur),
              recruteur: of(recruteur),
              entreprise: this.apiService.getEntrepriseById(this.entrepriseId),
            });
          }

          return of({
            utilisateur,
            recruteur,
            entreprise: recruteur?.entreprise ?? null,
          });
        })
      )
      .subscribe({
      next: ({ utilisateur, recruteur, entreprise }) => {
        this.currentUtilisateur = utilisateur;
        this.currentRecruteur = recruteur;
        this.currentEntreprise = entreprise ?? recruteur?.entreprise ?? null;
        this.recruteurId = recruteur?.id ?? null;
        this.entrepriseId = this.currentEntreprise?.id ?? null;

        this.utilisateurForm = {
          nom: utilisateur?.nom ?? '',
          prenom: utilisateur?.prenom ?? '',
          email: utilisateur?.email ?? '',
          telephone: utilisateur?.telephone ?? '',
        };

        this.recruteurForm = {
          poste: recruteur?.poste ?? '',
        };

        this.entrepriseForm = {
          nom: this.currentEntreprise?.nom ?? '',
          secteur: this.currentEntreprise?.secteur ?? '',
          siegeSocial: this.currentEntreprise?.siegeSocial ?? '',
          siren: this.currentEntreprise?.siren ?? '',
          siteWeb: this.currentEntreprise?.siteWeb ?? '',
          taille: this.currentEntreprise?.taille ?? '',
        };

        this.loadPdpPreview();
        this.isLoading = false;
      },
      error: () => {
        this.isLoading = false;
        this.setError('Impossible de charger votre profil employeur.');
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
    if (!this.userId || !this.recruteurId || !this.currentUtilisateur || !this.currentRecruteur) {
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

    const updatedRecruteur = {
      ...this.currentRecruteur,
      poste: this.recruteurForm.poste || null,
    };

    this.apiService
      .updateUtilisateur(this.userId, updatedUtilisateur)
      .pipe(switchMap(() => this.apiService.updateRecruteur(this.recruteurId as number, updatedRecruteur)))
      .subscribe({
        next: () => {
          this.currentUtilisateur = updatedUtilisateur;
          this.currentRecruteur = updatedRecruteur;
          this.setInfo('Informations mises à jour avec succès.');
        },
        error: () => this.setError('Erreur lors de la mise à jour des informations.'),
      });
  }

  saveEntreprise(): void {
    if (!this.entrepriseId || !this.currentEntreprise) {
      this.setError('Profil incomplet, veuillez recharger la page.');
      return;
    }

    this.clearMessages();

    const updatedEntreprise = {
      ...this.currentEntreprise,
      nom: this.entrepriseForm.nom,
      secteur: this.entrepriseForm.secteur,
      siegeSocial: this.entrepriseForm.siegeSocial,
      siren: this.entrepriseForm.siren,
      siteWeb: this.entrepriseForm.siteWeb,
      taille: this.entrepriseForm.taille,
    };

    this.apiService
      .updateEntreprise(this.entrepriseId, updatedEntreprise)
      .subscribe({
        next: () => {
          this.currentEntreprise = updatedEntreprise;
          this.setInfo('Informations mises à jour avec succès.');
        },
        error: () => this.setError('Erreur lors de la mise à jour des informations.'),
      });
    };

  private refreshRecruteur(): void {
    if (!this.recruteurId) {
      return;
    }

    this.apiService.getRecruteurById(this.recruteurId).subscribe({
      next: (recruteur) => {
        this.currentRecruteur = recruteur;
        this.recruteurForm = {
          poste: recruteur?.poste ?? '',
        };
      },
      error: () => this.setError('Impossible de rafraîchir le profil recruteur.'),
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

