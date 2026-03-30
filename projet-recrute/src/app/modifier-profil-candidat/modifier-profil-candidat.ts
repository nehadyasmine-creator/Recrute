import { Component } from '@angular/core';

@Component({
  selector: 'app-modifier-profil-candidat',
  imports: [],
  templateUrl: './modifier-profil-candidat.html',
  styleUrl: './modifier-profil-candidat.scss',
})
export class ModifierProfilCandidat {
  ongletActif: string = 'infos'; 

  
  changerOnglet(nomOnglet: string) {
    this.ongletActif = nomOnglet;
  }
}
