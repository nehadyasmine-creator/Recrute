import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ApiService } from '../service/api.service';

interface Offre {
  id: number;
  titre: string;
  description: string;
  lieu: string;
  typeContrat: string;
  salaire: number;
  teletravail: boolean;
}

@Component({
  selector: 'app-liste-offres',
  imports: [CommonModule],
  templateUrl: './liste-offres.html',
  styleUrl: './liste-offres.scss',
})
export class ListeOffres implements OnInit {
  private apiService = inject(ApiService);

  offres: Offre[] = [];
  loading = true;
  error = '';

  ngOnInit(): void {
    this.apiService.getOffresOuvertes().subscribe({
      next: (offres) => {
        this.offres = offres;
        this.loading = false;
      },
      error: () => {
        this.error = 'Impossible de charger les offres pour le moment.';
        this.loading = false;
      }
    });
  }
}