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
import { DetailEntreprise } from './detail-entreprise/detail-entreprise';
import { AjouterOffre } from './ajouter-offre/ajouter-offre';
import { MesOffresRecruteur } from './mes-offres-recruteur/mes-offres-recruteur';
import { AccueilEmployeur } from './accueil-employeur/accueil-employeur';
import { InfosCandidat } from './infos-candidat/infos-candidat';
import { Messagerie } from './messagerie';
import { Postuler } from './postuler/postuler';
import { DetailCandidature } from './detail-candidature/detail-candidature';

export const routes: Routes = [
    { path: '', component: Home },
    { path: 'faq', component: Faq },
    { path: 'contactez-nous', component: Contact},
    { path: 'inscription-candidat', component: InscriptionCandidat},
    { path: 'inscription-employeur', component: InscriptionEmployeur},
    { path: 'modifier-profil-candidat', component: ModifierProfilCandidat},
    { path: 'modifier-profil-employeur', component: ModifierProfilEmployeur},
    { path: 'liste-offres', component: ListeOffres},
    { path: 'accueil-employeur', component: AccueilEmployeur},
    { path: 'ajouter-offre', component: AjouterOffre},
    { path: 'ajouter-offre/:id', component: AjouterOffre},
    { path: 'mes-offres', component: MesOffresRecruteur},
    { path: 'messagerie', component: Messagerie},
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
    { path: 'infos-candidat/:id', component: InfosCandidat },
    { path: 'detail-candidature/:id', component: DetailCandidature },

    //à laisser en tout dernier, sert à rediriger vers la page d'accueil si on essaie d'aller sur une page qui n'existe pas
    { path: '**', redirectTo: '' },
];
