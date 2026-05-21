import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';

@Component({
  selector: 'app-infos-candidat',
  imports: [CommonModule, RouterLink],
  templateUrl: './infos-candidat.html',
  styleUrl: './infos-candidat.scss',
})
export class InfosCandidat implements OnInit {
  private route = inject(ActivatedRoute);
  private apiService = inject(ApiService);

  candidat: any = null;
  experiences: any[] = [];
  competences: any[] = [];
  loading = true;
  error = '';

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.loadCandidat(id);
  }

  private loadCandidat(id: number): void {
    this.apiService.getCandidatById(id).subscribe({
      next: (candidat) => {
        this.candidat = candidat;
        this.loadExperiences(id);
        this.loadCompetences(id);
      },
      error: () => {
        this.error = 'Impossible de charger le profil.';
        this.loading = false;
      }
    });
  }

  private loadExperiences(id: number): void {
    this.apiService.getExperiencesByCandidat(id).subscribe({
      next: (exps) => {
        this.experiences = exps;
        this.checkLoading();
      },
      error: () => this.checkLoading()
    });
  }

  private loadCompetences(id: number): void {
    this.apiService.getCompetencesByCandidat(id).subscribe({
      next: (comps) => {
        this.competences = comps.map((c: any) => c.competence);
        this.checkLoading();
      },
      error: () => this.checkLoading()
    });
  }

  private checkLoading(): void {
    if (this.experiences !== null && this.competences !== null) {
      this.loading = false;
    }
  }

  getInitiales(): string {
    const p = this.candidat?.utilisateur?.prenom?.[0] ?? '';
    const n = this.candidat?.utilisateur?.nom?.[0] ?? '';
    return (p + n).toUpperCase() || '?';
  }
}