import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { environment } from '../../environments/environment';
import { BehaviorSubject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private loggedIn = new BehaviorSubject<boolean>(this.hasToken());
  private apiUrl = environment.apiUrl;

  isLoggedIn$ = this.loggedIn.asObservable();

  private hasToken(): boolean {
    return !!localStorage.getItem('token');
  }

  constructor(private http: HttpClient) {}

  register(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/auth/register`, data);
  }

  login(email: string, motDePasse: string): Observable<any> {
  return this.http.post(`${this.apiUrl}/auth/login`, { email, motDePasse }).pipe(
    tap((response: any) => {
      localStorage.setItem('token', response.token);
      // On stocke l'ID s'il est présent dans la réponse du backend
      if (response.id) {
        localStorage.setItem('userId', response.id.toString());
      }
      this.loggedIn.next(true);
    })
  );
}

// Ajoute cette petite méthode pour récupérer l'ID facilement
getUserId(): number | null {
  const id = localStorage.getItem('userId');
  return id ? parseInt(id, 10) : null;
}

// Et n'oublie pas de nettoyer au logout
logout() {
  localStorage.removeItem('token');
  localStorage.removeItem('userId');
  this.loggedIn.next(false);
}

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }
  uploadCV(candidatId: number, formData: FormData): Observable<any> {
  // L'URL doit correspondre à @PostMapping("/{id}/cv")
  // Vérifie si le préfixe est bien /api/candidats ou autre dans le @RequestMapping en haut du fichier Java
  return this.http.post(`http://localhost:8080/candidats/${candidatId}/cv`, formData, {
    responseType: 'text' // Car ton Java renvoie ResponseEntity<String> et non un JSON
  });
}
}