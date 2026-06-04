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
  showProfileDropdown: boolean = false;
  isLoggedIn: boolean = false;
  currentUrl: string = '';
  avatarUrl: string | null = null;
  avatarInitials: string = 'U';
  userRole: string | null = null;
  entrepriseId: number | null = null;
  messageUnreadCount = 0;
  private subscriptions = new Subscription();
  private readonly profileUpdatedListener = () => this.loadAvatar();
    dropdownTimeout: any;


  constructor(private router: Router, private authService: AuthService, private apiService: ApiService) {}

  ngOnInit(): void {
    this.currentUrl = this.router.url;
    this.userRole = this.normalizeRole(this.authService.getUserRole());

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
        this.userRole = null;
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
    return !this.isLoggedIn;
  }

  isRecruiter(): boolean {
    return this.userRole === 'recruteur';
  }

  isCandidate(): boolean {
    return !this.userRole || this.userRole === 'candidat';
  }

  isAdmin(): boolean {
    return this.userRole === 'admin';
  }

  getLogoLink(): string {
    if (!this.isLoggedIn) {
      return '/';
    }

    if (this.isRecruiter()) {
      return '/liste-candidats';
    }

    if (this.isAdmin()) {
      return '/admin';
    }

    return '/liste-offres';
  }

  getProfileLink(): string {
    if (this.isAdmin()) {
      return '/admin';
    }
    return this.isRecruiter() ? '/modifier-profil-employeur' : '/modifier-profil-candidat';
  }

  isProfileRouteActive(): boolean {
    if (this.isAdmin()) {
      return this.router.url.includes('/admin');
    }
    return this.isRecruiter()
      ? this.router.url.includes('/modifier-profil-employeur')
      : this.router.url.includes('/modifier-profil-candidat');
  }

  private loadAvatar(): void {
    const userId = this.authService.getUserId();
    if (!userId) {
      this.clearAvatarUrl();
      this.avatarInitials = 'U';
      this.userRole = null;
      return;
    }

    this.apiService.getUtilisateurById(userId).subscribe({
      next: (utilisateur) => {
        this.userRole = this.normalizeRole(utilisateur?.role);
        this.avatarInitials = this.computeInitials(utilisateur?.prenom, utilisateur?.nom);

        if (this.isRecruiter()) {
          this.loadRecruiterContext(userId);
          this.loadMessageBadgeForRecruiter(userId);
        } else if (this.isCandidate()) {
          this.entrepriseId = null;
          this.loadMessageBadgeForCandidate(userId);
        } else {
          this.entrepriseId = null;
          this.messageUnreadCount = 0;
        }

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
        this.userRole = null;
        this.messageUnreadCount = 0;
      },
    });
  }

  getEntrepriseLink(): string | null {
    return this.isRecruiter() && this.entrepriseId ? `/detail-entreprise/${this.entrepriseId}` : null;
  }

  private loadRecruiterContext(userId: number): void {
    this.apiService.getRecruteurByUtilisateurId(userId).subscribe({
      next: (recruteur) => {
        this.entrepriseId = recruteur?.entreprise?.id ?? null;
      },
      error: () => {
        this.entrepriseId = null;
      },
    });
  }

  private loadMessageBadgeForRecruiter(userId: number): void {
    this.apiService.getRecruteurByUtilisateurId(userId).subscribe({
      next: (recruteur) => {
        if (!recruteur?.id) {
          this.messageUnreadCount = 0;
          return;
        }

        this.apiService.getMessagesByRecruteur(recruteur.id).subscribe({
          next: (messages) => {
            this.messageUnreadCount = (messages || []).filter((message) => this.isUnreadFromOppositeSide(message, 'recruteur')).length;
          },
          error: () => {
            this.messageUnreadCount = 0;
          },
        });
      },
      error: () => {
        this.messageUnreadCount = 0;
      },
    });
  }

  private loadMessageBadgeForCandidate(userId: number): void {
    this.apiService.getCandidatByUtilisateurId(userId).subscribe({
      next: (candidat) => {
        if (!candidat?.id) {
          this.messageUnreadCount = 0;
          return;
        }

        this.apiService.getMessagesByCandidat(candidat.id).subscribe({
          next: (messages) => {
            this.messageUnreadCount = (messages || []).filter((message) => this.isUnreadFromOppositeSide(message, 'candidat')).length;
          },
          error: () => {
            this.messageUnreadCount = 0;
          },
        });
      },
      error: () => {
        this.messageUnreadCount = 0;
      },
    });
  }

  private normalizeRole(role?: string | null): string | null {
    const normalizedRole = (role || '').trim().toLowerCase();
    return normalizedRole || null;
  }

  private isUnreadFromOppositeSide(message: any, currentRole: 'recruteur' | 'candidat'): boolean {
    if (message?.lu) {
      return false;
    }

    const senderRole = this.normalizeRole(message?.expediteurRole);
    if (senderRole) {
      return currentRole === 'recruteur'
        ? senderRole === 'candidat'
        : senderRole === 'recruteur';
    }

    return currentRole === 'recruteur'
      ? !!message?.candidat?.id && !message?.recruteur?.id
      : !!message?.recruteur?.id && !message?.candidat?.id;
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

  logout(){
    this.authService.logout();
  }

  isActive(url: string): boolean {
    return this.router.url.includes(url);
  }

  openDropdown() {
    if (!this.isLoggedIn) {
      return;
    }
    clearTimeout(this.dropdownTimeout);
    this.showProfileDropdown = true;
  }

  closeDropdown() {
    this.dropdownTimeout = setTimeout(() => {
      this.showProfileDropdown = false;
    }, 200); 
  }
}