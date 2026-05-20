import { Routes } from '@angular/router';
import { Home } from './home/home';
import { Faq } from './faq/faq';
import { Contact } from './contact/contact';
import { InscriptionCandidat } from './inscription-candidat/inscription-candidat';
import { InscriptionEmployeur } from './inscription-employeur/inscription-employeur';
import { ModifierProfilCandidat } from './modifier-profil-candidat/modifier-profil-candidat';
import { ListeOffres } from './liste-offres/liste-offres';
import { QuiSommesNous } from './qui-sommes-nous/qui-sommes-nous';
import { ListeCandidatsComponent } from './liste-candidats/liste-candidats.component';
import { ModifierProfilEmployeur } from './modifier-profil-employeur/modifier-profil-employeur';
import { CandidatureEnregistre } from './candidature-enregistre/candidature-enregistre';
import { OffresPostulees } from './offres-postulees/offres-postulees';
import { Admin } from './admin/admin';
import { SuggestionIaCandidat } from './suggestion-ia-candidat/suggestion-ia-candidat';
import { MdpOublie } from './mdp-oublie/mdp-oublie';
import { DetailOffre } from './detail-offre/detail-offre';
import { Postuler } from './postuler/postuler';
import { DetailEntreprise } from './detail-entreprise/detail-entreprise';

export const routes: Routes = [
    { path: '', component: Home },
    { path: 'faq', component: Faq },
    { path: 'contactez-nous', component: Contact},
    { path: 'inscription-candidat', component: InscriptionCandidat},
    { path: 'inscription-employeur', component: InscriptionEmployeur},
    { path: 'modifier-profil-candidat', component: ModifierProfilCandidat},
    { path: 'modifier-profil-employeur', component: ModifierProfilEmployeur},
    { path: 'liste-offres', component: ListeOffres},
    { path: 'detail-offre/:id', component: DetailOffre},
    { path: 'detail-entreprise/:id', component: DetailEntreprise},
    { path: 'postuler/:id', component: Postuler},
    { path: 'candidatures-enregistrees', component: CandidatureEnregistre},
    { path: 'offres-postulees', component: OffresPostulees},
    { path: 'suggestion-ia-candidat', component: SuggestionIaCandidat},
    { path: 'mdp-oublie', component: MdpOublie},
    { path: 'admin', component: Admin},
    { path: 'qui-sommes-nous', component: QuiSommesNous},
    { path: 'liste-candidats', component: ListeCandidatsComponent},


    //à laisser en tout dernier, sert à rediriger vers la page d'accueil si on essaie d'aller sur une page qui n'existe pas
    { path: '**', redirectTo: '' },
];
