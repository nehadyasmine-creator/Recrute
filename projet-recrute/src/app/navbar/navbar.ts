import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Router, NavigationEnd, RouterLink } from '@angular/router';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, CommonModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.scss',
})

export class Navbar {
  currentUrl: string = '';

  constructor(private router: Router) {
    // On écoute les changements de page
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe((event: any) => {
      this.currentUrl = event.url;
    });
  }
//faudra surement trouver une autre maniere de faire
  isDeconnecte(): boolean {
    return this.currentUrl === '/';
  }

}