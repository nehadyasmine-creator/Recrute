import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ApiService } from '../service/api.service';
import { RouterLink } from '@angular/router';

interface Candidat {
  id: number;
  utilisateur: {
    id: number;
    nom: string;
    prenom: string;
    email: string;
    pdp: string | null;
  };
  typeContrat: string;
  ville: string;
  disponibilite: string;
  cv: string | null;
}

@Component({
  selector: 'app-liste-candidats',
  imports: [CommonModule, RouterLink],
  templateUrl: './liste-candidats.component.html',
  styleUrl: './liste-candidats.component.scss',
})
export class ListeCandidatsComponent implements OnInit {
  private apiService = inject(ApiService);

  candidats: Candidat[] = [];
  loading = true;
  error = '';
  searchTerm = '';
  filtreContrat = '';

  ngOnInit(): void {
    this.loadCandidats();
  }

  private loadCandidats(): void {
    this.apiService.getCandidats().subscribe({
      next: (candidats) => {
        this.candidats = candidats;
        this.loading = false;
      },
      error: () => {
        this.error = 'Impossible de charger les candidats pour le moment.';
        this.loading = false;
      }
    });
  }

  get candidatsFiltres(): Candidat[] {
    return this.candidats.filter(c => {
      const nomComplet = `${c.utilisateur?.prenom ?? ''} ${c.utilisateur?.nom ?? ''} ${c.utilisateur?.email ?? ''}`.toLowerCase();
      const matchSearch = nomComplet.includes(this.searchTerm.toLowerCase());
      const matchContrat = !this.filtreContrat || c.typeContrat === this.filtreContrat;
      return matchSearch && matchContrat;
    });
  }

  onSearch(event: Event): void {
    this.searchTerm = (event.target as HTMLInputElement).value;
  }

  onFiltreContrat(event: Event): void {
    this.filtreContrat = (event.target as HTMLSelectElement).value;
  }

  getInitiales(prenom?: string, nom?: string): string {
    const p = prenom?.[0] ?? '';
    const n = nom?.[0] ?? '';
    return (p + n).toUpperCase() || '?';
  }
}