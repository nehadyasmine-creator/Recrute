import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ApiService } from '../service/api.service';
import { RouterLink } from '@angular/router';

interface Competence {
  id: number;
  nom: string;
  category: string;
}

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
  competences?: Competence[];
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
  filtreVille = '';
  filtreDisponibilite = '';
  filtreCompetence = '';
  toutesLesCompetences: string[] = [];

  ngOnInit(): void {
    this.loadCandidats();
  }

  private loadCandidats(): void {
    this.apiService.getCandidats().subscribe({
      next: (candidats) => {
        this.candidats = candidats.filter(c => c.ville && c.disponibilite);
        let remaining = this.candidats.length;

        if (remaining === 0) {
          this.loading = false;
          return;
        }

        this.candidats.forEach((candidat, index) => {
          this.apiService.getCompetencesByCandidat(candidat.id).subscribe({
            next: (comps) => {
              this.candidats[index].competences = comps.map((c: any) => c.competence);
              this.majCompetences();
              remaining--;
              if (remaining === 0) this.loading = false;
            },
            error: () => {
              this.candidats[index].competences = [];
              remaining--;
              if (remaining === 0) this.loading = false;
            }
          });
        });
      },
      error: () => {
        this.error = 'Impossible de charger les candidats.';
        this.loading = false;
      }
    });
  }

  private majCompetences(): void {
    const toutes = new Set<string>();
    this.candidats.forEach(c => {
      c.competences?.forEach(comp => toutes.add(comp.nom));
    });
    this.toutesLesCompetences = Array.from(toutes).sort();
  }

  get candidatsFiltres(): Candidat[] {
    return this.candidats.filter(c => {
      const nomComplet = `${c.utilisateur?.prenom ?? ''} ${c.utilisateur?.nom ?? ''}`.toLowerCase();
      const matchSearch = nomComplet.includes(this.searchTerm.toLowerCase());
      const matchContrat = !this.filtreContrat || c.typeContrat === this.filtreContrat;
      const matchVille = !this.filtreVille || c.ville?.toLowerCase().includes(this.filtreVille.toLowerCase());
      const matchDispo = !this.filtreDisponibilite || c.disponibilite <= this.filtreDisponibilite;
      const matchCompetence = !this.filtreCompetence || c.competences?.some(comp => comp.nom === this.filtreCompetence);
      return matchSearch && matchContrat && matchVille && matchDispo && matchCompetence;
    });
  }

  onSearch(event: Event): void {
    this.searchTerm = (event.target as HTMLInputElement).value;
  }

  onFiltreContrat(event: Event): void {
    this.filtreContrat = (event.target as HTMLSelectElement).value;
  }

  onFiltreVille(event: Event): void {
    this.filtreVille = (event.target as HTMLInputElement).value;
  }

  onFiltreDisponibilite(event: Event): void {
    this.filtreDisponibilite = (event.target as HTMLInputElement).value;
  }

  onFiltreCompetence(event: Event): void {
    this.filtreCompetence = (event.target as HTMLSelectElement).value;
  }

  getInitiales(prenom?: string, nom?: string): string {
    const p = prenom?.[0] ?? '';
    const n = nom?.[0] ?? '';
    return (p + n).toUpperCase() || '?';
  }
}