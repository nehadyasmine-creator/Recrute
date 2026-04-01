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
        this.loggedIn.next(true);
      })
    );
  }

  logout() {
    localStorage.removeItem('token');
    this.loggedIn.next(false);
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }
}