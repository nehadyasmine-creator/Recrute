import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ApiService } from '../service/api.service';
import { FormatTaillePipe } from '../shared/pipes/format-taille.pipe';

interface Entreprise {
  id: number;
  nom: string;
  secteur?: string | null;
  siegeSocial?: string | null;
  siren?: string | null;
  taille?: string | null;
  siteWeb?: string | null;
}

@Component({
  selector: 'app-detail-entreprise',
  imports: [CommonModule, RouterLink, FormatTaillePipe],
  templateUrl: './detail-entreprise.html',
  styleUrl: './detail-entreprise.scss',
})
export class DetailEntreprise implements OnInit {
  private apiService = inject(ApiService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  entreprise: Entreprise | null = null;
  loading = true;
  errorMessage = '';

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const id = Number(idParam);

    if (!id || Number.isNaN(id)) {
      this.errorMessage = 'Entreprise introuvable.';
      this.loading = false;
      return;
    }

    this.apiService.getEntrepriseById(id).subscribe({
      next: (entreprise) => {
        this.entreprise = entreprise;
        this.loading = false;
      },
      error: () => {
        this.errorMessage = 'Impossible de charger cette entreprise pour le moment.';
        this.loading = false;
      },
    });
  }

  goBack(): void {
    this.router.navigate(['/liste-offres']);
  }

  displayOrFallback(value: unknown, fallback = 'Non renseigné'): string {
    if (value === null || value === undefined) return fallback;
    const str = String(value).trim();
    return str ? str : fallback;
  }

  websiteHref(): string | null {
    const siteWeb = this.entreprise?.siteWeb?.trim();
    if (!siteWeb) return null;
    if (/^https?:\/\//i.test(siteWeb)) return siteWeb;
    return `https://${siteWeb}`;
  }

}
