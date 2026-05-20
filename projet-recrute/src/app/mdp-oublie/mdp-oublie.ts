import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';

@Component({
  selector: 'app-mdp-oublie',
  standalone: true,
  imports: [FormsModule, RouterLink],
  templateUrl: './mdp-oublie.html',
  styleUrl: './mdp-oublie.scss',
})
export class MdpOublie {
  step: 'identify' | 'verify' | 'password' | 'done' = 'identify';
  loading = false;
  errorMessage = '';
  successMessage = '';

  identityForm = {
    email: '',
    role: 'candidat',
  };

  verificationForm = {
    nom: '',
    prenom: '',
    telephone: '',
    poste: '',
  };

  passwordForm = {
    nouveauMotDePasse: '',
    confirmationNouveauMotDePasse: '',
  };

  constructor(private apiService: ApiService) {}

  private extractErrorMessage(err: any, fallback: string): string {
    const error = err?.error;

    if (typeof error === 'string') {
      return error;
    }

    if (error && typeof error === 'object') {
      return error.message || error.detail || error.error || fallback;
    }

    return err?.message || fallback;
  }

  private extractSuccessMessage(value: any, fallback: string): string {
    if (typeof value === 'string') {
      return value;
    }

    if (value && typeof value === 'object') {
      return value.message || value.detail || fallback;
    }

    return fallback;
  }

  startVerification(): void {
    if (!this.identityForm.email || !this.identityForm.role) {
      this.errorMessage = 'Veuillez saisir votre mail et sélectionner votre type de compte.';
      return;
    }

    this.loading = true;
    this.errorMessage = '';

    this.apiService.initForgotPassword(this.identityForm).subscribe({
      next: () => {
        this.step = 'verify';
        this.loading = false;
      },
      error: (err) => {
        this.loading = false;
        this.errorMessage = this.extractErrorMessage(err, 'Mail ou type de compte incorrect.');
      },
    });
  }

  verifyIdentity(): void {
    this.loading = true;
    this.errorMessage = '';

    this.apiService.verifyForgotPassword({ ...this.identityForm, ...this.verificationForm }).subscribe({
      next: () => {
        this.step = 'password';
        this.loading = false;
      },
      error: (err) => {
        this.loading = false;
        this.errorMessage = this.extractErrorMessage(err, 'Les informations saisies ne correspondent pas au compte.');
      },
    });
  }

  resetPassword(): void {
    if (!this.passwordForm.nouveauMotDePasse || !this.passwordForm.confirmationNouveauMotDePasse) {
      this.errorMessage = 'Veuillez remplir les deux champs de mot de passe.';
      return;
    }

    if (this.passwordForm.nouveauMotDePasse !== this.passwordForm.confirmationNouveauMotDePasse) {
      this.errorMessage = 'Les deux mots de passe ne correspondent pas.';
      return;
    }

    this.loading = true;
    this.errorMessage = '';

    this.apiService.resetForgotPassword({
      ...this.identityForm,
      ...this.verificationForm,
      ...this.passwordForm,
    }).subscribe({
      next: (response) => {
        this.loading = false;
        this.successMessage = this.extractSuccessMessage(response, 'Mot de passe réinitialisé avec succès.');
        this.step = 'done';
      },
      error: (err) => {
        this.loading = false;
        this.errorMessage = this.extractErrorMessage(err, 'Impossible de réinitialiser le mot de passe.');
      },
    });
  }

  get verificationFields(): string[] {
    const baseFields = ['nom', 'prenom', 'telephone'];

    if (this.identityForm.role === 'recruteur') {
      return [...baseFields, 'poste'];
    }

    return baseFields;
  }

  fieldLabel(field: string): string {
    const labels: Record<string, string> = {
      nom: 'Nom',
      prenom: 'Prénom',
      telephone: 'Téléphone',
      poste: 'Poste',
    };

    return labels[field] || field;
  }

  fieldPlaceholder(field: string): string {
    const placeholders: Record<string, string> = {
      nom: 'Votre nom',
      prenom: 'Votre prénom',
      telephone: '06 12 34 56 78',
      poste: 'Votre poste',
    };

    return placeholders[field] || '';
  }

}
