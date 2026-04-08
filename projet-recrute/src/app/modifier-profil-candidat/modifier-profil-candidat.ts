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
<<<<<<< Updated upstream

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
=======
  selectedFile: File | null = null;
cvUrl: string | null = null; // Pour afficher le lien du CV existant

onFileSelected(event: any) {
  this.selectedFile = event.target.files[0];
}

uploadCV() {
  if (!this.selectedFile) return;

  const formData = new FormData();
  formData.append('cv', this.selectedFile); // 'cv' doit correspondre au nom attendu par le back

  this.authService.updateCV(formData).subscribe({
    next: (res) => {
      alert('CV mis à jour avec succès !');
      this.cvUrl = res.cvPath; // Le back doit renvoyer le nouveau chemin
    },
    error: (err) => console.error('Erreur upload', err)
>>>>>>> Stashed changes
  });
}
}
