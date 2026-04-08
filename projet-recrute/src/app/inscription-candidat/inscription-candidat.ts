import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-inscription-candidat',
  imports: [FormsModule],
  templateUrl: './inscription-candidat.html',
  styleUrl: './inscription-candidat.scss',
})
export class InscriptionCandidat {
  private authService = inject(AuthService);
  private router = inject(Router);

  candidatData = {
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
    motdepasse: '',
    confirmPassword: '',
    role: 'Candidat'
  };

  errorMessage: string = '';

  onRegister() {
    if (this.candidatData.motdepasse !== this.candidatData.confirmPassword) {
      this.errorMessage = "Les mots de passe ne correspondent pas.";
      return;
    }

    const finalData = {
    nom: this.candidatData.nom,
    prenom: this.candidatData.prenom,
    email: this.candidatData.email,
    telephone: '+33'+this.candidatData.telephone.substring(1),
    motDePasse: this.candidatData.motdepasse,
    role: 'candidat' 
  };

    this.authService.register(finalData).subscribe({
      next: (res) => {
        console.log('Inscription réussie !', res);  
        this.router.navigate(['/']); 
      },
      error: (err) => {
        console.error('Détails de l\'erreur :', err); // Ajoute cette ligne
        this.errorMessage = "Erreur lors de l'inscription.";
      }
    });
  }
}