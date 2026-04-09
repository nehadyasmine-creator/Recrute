import { CommonModule } from '@angular/common';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router, NavigationEnd, RouterLink } from '@angular/router';
import { filter } from 'rxjs/operators';
import { Subscription } from 'rxjs';
import { AuthService } from '../service/auth.service';
import { ApiService } from '../service/api.service';

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, CommonModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.scss',
})

export class Navbar {

  isLoggedIn: boolean = false;
  currentUrl: string = '';
  avatarUrl: string | null = null;
  avatarInitials: string = 'U';
  private subscriptions = new Subscription();
  private readonly profileUpdatedListener = () => this.loadAvatar();

  constructor(private router: Router, private authService: AuthService, private apiService: ApiService) {}

  ngOnInit(): void {
    this.currentUrl = this.router.url;

    const navSub = this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe((event: any) => {
      this.currentUrl = event.url;
    });

    const authSub = this.authService.isLoggedIn$.subscribe(status => {
      this.isLoggedIn = status;
      if (status) {
        this.loadAvatar();
      } else {
        this.clearAvatarUrl();
        this.avatarInitials = 'U';
      }
    });

    this.subscriptions.add(navSub);
    this.subscriptions.add(authSub);
    window.addEventListener('profile-updated', this.profileUpdatedListener);
    this.loadAvatar();
  }

  ngOnDestroy(): void {
    this.subscriptions.unsubscribe();
    window.removeEventListener('profile-updated', this.profileUpdatedListener);
    this.clearAvatarUrl();
  }

  isDeconnecte(): boolean {
    return this.currentUrl === '/';
  }

  private loadAvatar(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.clearAvatarUrl();
      this.avatarInitials = 'U';
      return;
    }

    this.apiService.getUtilisateurById(userId).subscribe({
      next: (utilisateur) => {
        this.avatarInitials = this.computeInitials(utilisateur?.prenom, utilisateur?.nom);
        if (!utilisateur?.pdp) {
          this.clearAvatarUrl();
          return;
        }

        this.apiService.downloadPdp(userId).subscribe({
          next: (blob) => {
            this.clearAvatarUrl();
            this.avatarUrl = window.URL.createObjectURL(blob);
          },
          error: () => {
            this.clearAvatarUrl();
          }
        });
      },
      error: () => {
        this.clearAvatarUrl();
      },
    });
  }

  private computeInitials(prenom?: string, nom?: string): string {
    const p = (prenom || '').trim();
    const n = (nom || '').trim();

    if (p && n) {
      return `${p.charAt(0)}${n.charAt(0)}`.toUpperCase();
    }
    if (p) {
      return p.charAt(0).toUpperCase();
    }
    if (n) {
      return n.charAt(0).toUpperCase();
    }
    return 'U';
  }

  private clearAvatarUrl(): void {
    if (this.avatarUrl) {
      window.URL.revokeObjectURL(this.avatarUrl);
      this.avatarUrl = null;
    }
  }

}