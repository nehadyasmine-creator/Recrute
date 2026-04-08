import { Component, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-inscription-employeur',
  imports: [FormsModule, RouterLink],
  templateUrl: './inscription-employeur.html',
  styleUrl: './inscription-employeur.scss',
})
export class InscriptionEmployeur {
  private authService = inject(AuthService);
  private router = inject(Router);

  employeurData = {
    entreprise: '',
    siren: '',
    nom: '',
    prenom: '',
    email: '',
    motdepasse: '',
    confirmPassword: '',
    telephone: '',
    adresse: '',
    role: 'recruteur'
  };

  errorMessage: string = '';

  onRegister() {
    // Vérification des mots de passe
    if (this.employeurData.motdepasse !== this.employeurData.confirmPassword) {
      this.errorMessage = "Les mots de passe ne correspondent pas.";
      return;
    }

    // Formatage des données pour l'API
    const finalData = {
      entreprise: this.employeurData.entreprise,
      siren: this.employeurData.siren,
      nom: this.employeurData.nom,
      prenom: this.employeurData.prenom,
      email: this.employeurData.email,
      telephone: '+33' + this.employeurData.telephone.substring(1),
      motDePasse: this.employeurData.motdepasse,
      adresse: this.employeurData.adresse,
      role: 'recruteur'
    };

    // Appel du service
    this.authService.register(finalData).subscribe({
      next: (res) => {
        console.log('Inscription réussie !', res);  
        this.router.navigate(['/']); 
      },
      error: (err) => {
        console.error('Détails de l\'erreur :', err);
        this.errorMessage = "Erreur lors de l'inscription.";
      }
    });
  }
}