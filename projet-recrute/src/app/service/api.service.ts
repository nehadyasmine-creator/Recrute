import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

const API = environment.apiUrl;

@Injectable({ providedIn: 'root' })
export class ApiService {
  private http = inject(HttpClient);

  // Auth
  register(data: any): Observable<any> {
    return this.http.post(`${API}/auth/register`, data);
  }
  login(email: string, motDePasse: string): Observable<any> {
    return this.http.post(`${API}/auth/login`, { email, motDePasse });
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
  uploadPdp(id: number, file: File): Observable<any> {
    const formData = new FormData();
    formData.append('file', file);
    return this.http.post(`${API}/utilisateurs/${id}/pdp`, formData);
  }

  // Offres
  getOffres(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/offres`);
  }
  getOffresOuvertes(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/offres/ouvertes`);
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
  createRecruteur(data: any): Observable<any> {
    return this.http.post(`${API}/recruteurs`, data);
  }

  // Entreprises
  getEntreprises(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/entreprises`);
  }
  createEntreprise(data: any): Observable<any> {
    return this.http.post(`${API}/entreprises`, data);
  }

  // Competences
  getCompetences(): Observable<any[]> {
    return this.http.get<any[]>(`${API}/competences`);
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
  getCandidaturesByCandidat(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidatures/candidat/${id}`);
  }
  getCandidaturesByOffre(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/candidatures/offre/${id}`);
  }
  createCandidature(data: any): Observable<any> {
    return this.http.post(`${API}/candidatures`, data);
  }

  // Messagerie
  getMessagesByCandidature(id: number): Observable<any[]> {
    return this.http.get<any[]>(`${API}/messagerie/candidature/${id}`);
  }
  sendMessage(data: any): Observable<any> {
    return this.http.post(`${API}/messagerie`, data);
  }
}