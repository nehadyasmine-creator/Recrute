import { Routes } from '@angular/router';
import { Home } from './home/home';
import { Faq } from './faq/faq';
import { Contact } from './contact/contact';
import { InscriptionCandidat } from './inscription-candidat/inscription-candidat';
import { InscriptionEmployeur } from './inscription-employeur/inscription-employeur';

export const routes: Routes = [
    { path: '', component: Home },
    { path: 'faq', component: Faq },
    { path: 'contactez-nous', component: Contact},
    { path: 'inscription-candidat', component: InscriptionCandidat},
    { path: 'inscription-employeur', component: InscriptionEmployeur},


    //à laisser en tout dernier, sert à rediriger vers la page d'accueil si on essaie d'aller sur une page qui n'existe pas
    { path: '**', redirectTo: '' },
];
