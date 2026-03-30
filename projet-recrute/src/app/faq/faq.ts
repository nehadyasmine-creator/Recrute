import { Component } from '@angular/core';

@Component({
  selector: 'app-faq',
  imports: [],
  templateUrl: './faq.html',
  styleUrl: './faq.scss',
})
export class Faq {
  // Stocke l'index de la question ouverte (-1 = tout est fermé)
  openedIndex: number = -1;

  faqs = [
    { q: "Comment s'inscrire en tant qu'ingénieur ?", r: "Cliquez sur 'Je suis un candidat' sur l'accueil et remplissez le formulaire." },
    { q: "Quels sont les frais pour les employeurs ?", r: "L'inscription est gratuite, vous ne payez qu'à la publication d'une offre." },
    { q: "Comment modifier mon CV ?", r: "Rendez-vous dans votre profil, section 'Mon CV' pour uploader un nouveau fichier." },
    { q: "Dois-je créer un compte pour visualiser les offres disponibles ?", r: "Non. Il est cependant nécessaire d'avoir un compte candidat pour postuler à une offre." },
    { q: "Comment modifier mon CV ?", r: "Rendez-vous dans votre profil, section 'Mon CV' pour uploader un nouveau fichier." }
  ];

  toggle(index: number) {
    this.openedIndex = this.openedIndex === index ? -1 : index;
  }
}