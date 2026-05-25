import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

const API = environment.apiUrl;

@Injectable({ providedIn: 'root' })
export class ApiService {
  private http = inject(HttpClient);

  // Récupérer un dossier de candidature spécifique
getCandidatureById(id: number): Observable<any> {
  return this.http.get<any>(`${API}/candidatures/${id}`);
}

// Mettre à jour l'état (le backend doit intercepter la modification)
updateCandidatureStatut(id: number, candidature: any): Observable<any> {
  return this.http.put<any>(`${API}/candidatures/${id}`, candidature);
}
  // Auth
  register(data: any): Observable<any> {
    return this.http.post(`${API}/auth/register`, data);
  }
  login(email: string, motDePasse: string): Observable<any> {
    return this.http.post(`${API}/auth/login`, { email, motDePasse });
  }

  // Mot de passe oublié
  initForgotPassword(data: any): Observable<any> {
    return this.http.post(`${API}/utilisateurs/mot-de-passe-oublie/init`, data);
  }
  verifyForgotPassword(data: any): Observable<any> {
    return this.http.post(`${API}/utilisateurs/mot-de-passe-oublie/verifier`, data);
  }
  resetForgotPassword(data: any): Observable<any> {
    return this.http.post(`${API}/utilisateurs/mot-de-passe-oublie/reinitialiser`, data);
  }

  // Candidats
  getCandidats(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidats`);
  }
  getCandidatById(id: number): Observable<any> {
    return this.http.get<any>(`${API}/candidats/${id}`);
  }
  getCandidatByUtilisateurId(idUtilisateur: number): Observable<any> {
    return this.http.get<any>(`${API}/candidats/utilisateur/${idUtilisateur}`);
  }
  createCandidat(data: any): Observable<any> {
    return this.http.post(`${API}/candidats`, data);
  }
  updateCandidat(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/candidats/${id}`, data);
  }
  deleteCandidat(id: number): Observable<any> {
    return this.http.delete(`${API}/candidats/${id}`);
  }
  uploadCv(id: number, file: File): Observable<any> {
    const formData = new FormData();
    formData.append('file', file);
    return this.http.post(`${API}/candidats/${id}/cv`, formData, { responseType: 'text' });
  }
  downloadCv(id: number): Observable<Blob> {
    return this.http.get(`${API}/candidats/${id}/cv`, { responseType: 'blob' });
  }

  // Utilisateurs
  getUtilisateurs(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/utilisateurs`);
  }
  getUtilisateurById(id: number): Observable<any> {
    return this.http.get<any>(`${API}/utilisateurs/${id}`);
  }
  updateUtilisateur(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/utilisateurs/${id}`, data);
  }
  changePassword(id: number, data: any): Observable<any> {
    return this.http.post(`${API}/utilisateurs/${id}/change-password`, data, { responseType: 'text' });
  }
  uploadPdp(id: number, file: File): Observable<string> {
    const formData = new FormData();
    formData.append('file', file);
    return this.http.post(`${API}/utilisateurs/${id}/pdp`, formData, { responseType: 'text' });
  }
  downloadPdp(id: number): Observable<Blob> {
    return this.http.get(`${API}/utilisateurs/${id}/pdp`, { responseType: 'blob' });
  }

  // Contact
  getContactMessages(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/contacts`);
  }
  markContactMessageAsRead(id: number): Observable<any> {
    return this.http.put(`${API}/contacts/${id}/statut`, {});
  }
  deleteContactMessage(id: number): Observable<any> {
    return this.http.delete(`${API}/contacts/${id}`);
  }
  sendContactMessage(data: any): Observable<any> {
    return this.http.post(`${API}/contacts`, data);
  }

  // Offres
  getOffres(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/offres`);
  }
  getOffresOuvertes(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/offres/ouvertes`);
  }
  getOffresByRecruteur(idRecruteur: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/offres/recruteur/${idRecruteur}`);
  }
  getOffreById(id: number): Observable<any> {
    return this.http.get<any>(`${API}/offres/${id}`);
  }
  createOffre(data: any): Observable<any> {
    return this.http.post(`${API}/offres`, data);
  }
  updateOffre(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/offres/${id}`, data);
  }
  deleteOffre(id: number): Observable<any> {
    return this.http.delete(`${API}/offres/${id}`);
  }

  // Recruteurs
  getRecruteurs(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/recruteurs`);
  }
  getRecruteurById(id: number): Observable<any> {
    return this.http.get<any>(`${API}/recruteurs/${id}`);
  }
  getRecruteurByUtilisateurId(idUtilisateur: number): Observable<any> {
    return this.http.get<any>(`${API}/recruteurs/utilisateur/${idUtilisateur}`);
  }
  createRecruteur(data: any): Observable<any> {
    return this.http.post(`${API}/recruteurs`, data);
  }
  updateRecruteur(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/recruteurs/${id}`, data);
  }

  // Entreprises
  getEntreprises(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/entreprises`);
  }
  getEntrepriseById(id: number): Observable<any> {
    return this.http.get<any>(`${API}/entreprises/${id}`);
  }
  createEntreprise(data: any): Observable<any> {
    return this.http.post(`${API}/entreprises`, data);
  }
  updateEntreprise(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/entreprises/${id}`, data);
  }

  // Competences
  getCompetences(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/competences`);
  }
  getCompetencesByOffre(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/competences-offres/offre/${id}`);
  }
  createCompetence(data: any): Observable<any> {
    return this.http.post(`${API}/competences`, data);
  }
  updateCompetence(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/competences/${id}`, data);
  }
  getCompetencesByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/competences-candidats/candidat/${id}`);
  }
  addCompetenceCandidat(data: any): Observable<any> {
    return this.http.post(`${API}/competences-candidats`, data);
  }
  deleteCompetenceCandidat(idCandidat: number, idCompetence: number): Observable<any> {
    return this.http.delete(`${API}/competences-candidats`, {
      body: {
        idCandidat,
        idCompetence,
      },
    });
  }
  createCompetenceOffre(data: any): Observable<any> {
    return this.http.post(`${API}/competences-offres`, data);
  }
  deleteCompetenceOffre(idOffre: number, idCompetence: number): Observable<any> {
    return this.http.delete(`${API}/competences-offres`, {
      body: {
        idOffre,
        idCompetence,
      },
    });
  }

  // Experiences
  getExperiencesByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/experiences/candidat/${id}`);
  }
  createExperience(data: any): Observable<any> {
    return this.http.post(`${API}/experiences`, data);
  }
  updateExperience(id: number, data: any): Observable<any> {
    return this.http.put(`${API}/experiences/${id}`, data);
  }
  deleteExperience(id: number): Observable<any> {
    return this.http.delete(`${API}/experiences/${id}`);
  }

  // Liens
  getLiensByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/liens/candidat/${id}`);
  }
  createLien(data: any): Observable<any> {
    return this.http.post(`${API}/liens`, data);
  }

  // Candidatures
  getCandidatures(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidatures`);
  }
  getCandidaturesByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidatures/candidat/${id}`);
  }
  getCandidaturesByOffre(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidatures/offre/${id}`);
  }
  createCandidature(data: any): Observable<any> {
    return this.http.post(`${API}/candidatures`, data);
  }
  deleteCandidature(id: number): Observable<any> {
    return this.http.delete(`${API}/candidatures/${id}`);
  }

  // Messagerie
  getMessagesByCandidature(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/messagerie/candidature/${id}`);
  }
  getMessagesByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/messagerie/candidat/${id}`);
  }
  getMessagesByRecruteur(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/messagerie/recruteur/${id}`);
  }
  sendMessage(data: any): Observable<any> {
    return this.http.post(`${API}/messagerie`, data);
  }
  markMessageAsRead(id: number): Observable<any> {
    return this.http.put(`${API}/messagerie/${id}/lu`, {});
  }

  public getIASuggestionsFromPdf(file: File) {
    const formData = new FormData();
    formData.append('file', file);
    
    return this.http.post<any>('http://localhost:8000/api/match-cv', formData);
  }

  public getIASuggestions(candidatId: number) {
    return this.http.get<any[]>(`http://localhost:8000/api/match-cv/${candidatId}`);
  }
}