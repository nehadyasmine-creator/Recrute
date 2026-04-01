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

  private authService = inject(AuthService);
   private router = inject(Router);

  logout() {
    this.authService.logout(); 
    this.router.navigate(['/']); 
  }
  changerOnglet(nomOnglet: string) {
    this.ongletActif = nomOnglet;
  }
}
