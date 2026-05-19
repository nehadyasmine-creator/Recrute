import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

@Component({
  selector: 'app-contact',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './contact.html',
  styleUrl: './contact.scss',
})
export class Contact implements OnInit {
  private authService = inject(AuthService);
  private apiService = inject(ApiService);

  isLoading = false;
  isUserLoading = true;
  successMessage = '';
  errorMessage = '';

  contactForm = {
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
    roleUtilisateur: '',
    objet: '',
    message: '',
  };

  ngOnInit(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.isUserLoading = false;
      return;
    }

    this.apiService.getUtilisateurById(userId).subscribe({
      next: (utilisateur) => {
        this.contactForm.nom = utilisateur?.nom || '';
        this.contactForm.prenom = utilisateur?.prenom || '';
        this.contactForm.email = utilisateur?.email || '';
        this.contactForm.telephone = utilisateur?.telephone || '';
        this.contactForm.roleUtilisateur = utilisateur?.role || '';
        this.isUserLoading = false;
      },
      error: () => {
        this.isUserLoading = false;
      }
    });
  }

  submit(): void {
    this.successMessage = '';
    this.errorMessage = '';

    if (!this.contactForm.nom.trim() || !this.contactForm.prenom.trim() || !this.contactForm.email.trim() || !this.contactForm.objet.trim() || !this.contactForm.message.trim()) {
      this.errorMessage = 'Veuillez remplir les champs obligatoires.';
      return;
    }

    this.isLoading = true;

    this.apiService.sendContactMessage(this.contactForm).subscribe({
      next: () => {
        this.successMessage = 'Votre message a bien été envoyé aux administrateurs.';
        this.isLoading = false;
        this.contactForm.objet = '';
        this.contactForm.message = '';
      },
      error: () => {
        this.errorMessage = 'Impossible d\'envoyer votre message pour le moment.';
        this.isLoading = false;
      }
    });
  }

}
