import { Component, inject } from '@angular/core';
import { AuthService } from '../service/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-modifier-profil-candidat',
  imports: [],
  templateUrl: './modifier-profil-candidat.html',
  styleUrl: './modifier-profil-candidat.scss',
})
export class ModifierProfilCandidat {
  ongletActif: string = 'infos'; 
  selectedFile: File | null = null;

  private authService = inject(AuthService);
  private router = inject(Router);

   onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      this.selectedFile = file;
      console.log("Fichier sélectionné :", file.name);
    }
  }
  logout() {
    this.authService.logout(); 
    this.router.navigate(['/']); 
  }
  changerOnglet(nomOnglet: string) {
    this.ongletActif = nomOnglet;
  }

  uploadCV() {
  const userId = this.authService.getUserId();

  if (!userId) {
    alert("Session expirée, veuillez vous reconnecter.");
    return;
  }

  if (!this.selectedFile) {
    alert("Veuillez sélectionner un fichier.");
    return;
  }

  const formData = new FormData();
  // On utilise 'file' car c'est ce que le Java attend
  formData.append('file', this.selectedFile); 

  this.authService.uploadCV(userId, formData).subscribe({
    next: (res) => {
      console.log('Succès:', res);
      alert('CV mis à jour avec succès !');
    },
    error: (err) => {
      console.error('Erreur upload:', err);
      alert("Erreur lors de l'envoi du fichier.");
    }
  });
}
}
