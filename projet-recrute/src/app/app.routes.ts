import { Routes } from '@angular/router';
import { Home } from './home/home';
import { Faq } from './faq/faq';
import { Contact } from './contact/contact';
import { InscriptionCandidat } from './inscription-candidat/inscription-candidat';
import { InscriptionEmployeur } from './inscription-employeur/inscription-employeur';
import { ModifierProfilCandidat } from './modifier-profil-candidat/modifier-profil-candidat';
import { ListeOffres } from './liste-offres/liste-offres';
import { QuiSommesNous } from './qui-sommes-nous/qui-sommes-nous';
import { ModifierProfilEmployeur } from './modifier-profil-employeur/modifier-profil-employeur';
import { CandidatureEnregistre } from './candidature-enregistre/candidature-enregistre';
import { OffresPostulees } from './offres-postulees/offres-postulees';
import { Admin } from './admin/admin';

export const routes: Routes = [
    { path: '', component: Home },
    { path: 'faq', component: Faq },
    { path: 'contactez-nous', component: Contact},
    { path: 'inscription-candidat', component: InscriptionCandidat},
    { path: 'inscription-employeur', component: InscriptionEmployeur},
    { path: 'modifier-profil-candidat', component: ModifierProfilCandidat},
    { path: 'modifier-profil-employeur', component: ModifierProfilEmployeur},
    { path: 'liste-offres', component: ListeOffres},
    { path: 'candidatures-enregistrees', component: CandidatureEnregistre},
    { path: 'offres-postulees', component: OffresPostulees},
    { path: 'admin', component: Admin},
    { path: 'qui-sommes-nous', component: QuiSommesNous},


    //à laisser en tout dernier, sert à rediriger vers la page d'accueil si on essaie d'aller sur une page qui n'existe pas
    { path: '**', redirectTo: '' },
];
