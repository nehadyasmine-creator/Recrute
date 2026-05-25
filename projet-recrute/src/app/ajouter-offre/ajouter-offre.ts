import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { FormArray, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { forkJoin, of } from 'rxjs';
import { ApiService } from '../service/api.service';
import { AuthService } from '../service/auth.service';

interface CompetenceOption {
  id: number;
  nom: string;
  category: string;
}

interface CompetenceRowValue {
  category: string;
  nom: string;
  obligatoire: boolean;
}

interface OffreFormPayload {
  idRecruteur: number | null;
  titre: string;
  description: string;
  lieu: string;
  typeContrat: string;
  salaire: number | null;
  duree: string;
  experienceRequise: number | null;
  dateDebut: string | null;
  datePublication: string | null;
  teletravail: boolean;
  statut: string;
}

@Component({
  selector: 'app-ajouter-offre',
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './ajouter-offre.html',
  styleUrl: './ajouter-offre.scss',
})
export class AjouterOffre implements OnInit {
  private fb = inject(FormBuilder);
  private apiService = inject(ApiService);
  private authService = inject(AuthService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  loading = true;
  saving = false;
  errorMessage = '';
  successMessage = '';
  editMode = false;
  offerId: number | null = null;
  recruiterName = '';
  recruiterId: number | null = null;

  readonly categoriesCompetence = ['technique', 'soft_skill', 'langue', 'autre'];
  readonly typeContratOptions = ['CDI', 'CDD', 'Stage', 'Alternance', 'Freelance', 'Interim'];
  readonly statutOptions = ['ouverte', 'fermee'];

  form = this.fb.group({
    titre: this.fb.control('', [Validators.required, Validators.maxLength(255)]),
    description: this.fb.control('', [Validators.required, Validators.maxLength(4000)]),
    lieu: this.fb.control('', [Validators.required, Validators.maxLength(255)]),
    typeContrat: this.fb.control('', Validators.required),
    salaire: this.fb.control<number | null>(null, [Validators.min(0)]),
    duree: this.fb.control('', [Validators.maxLength(100)]),
    experienceRequise: this.fb.control<number | null>(null, [Validators.min(0)]),
    dateDebut: this.fb.control(''),
    datePublication: this.fb.control(''),
    teletravail: this.fb.control(false),
    statut: this.fb.control('ouverte', Validators.required),
    competences: this.fb.array([]),
  });

  ngOnInit(): void {
    const userId = this.authService.getUserId();
    const role = this.authService.getUserRole();

    if (!userId) {
      this.errorMessage = 'Vous devez être connecté pour gérer une offre.';
      this.loading = false;
      return;
    }

    if (role && role !== 'recruteur') {
      this.errorMessage = 'Cette page est réservée aux recruteurs.';
      this.loading = false;
      return;
    }

    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam) {
      this.editMode = true;
      this.offerId = Number(idParam);
    }

    this.apiService.getRecruteurByUtilisateurId(userId).subscribe({
      next: (recruteur) => {
        this.recruiterId = recruteur?.id ?? null;
        this.recruiterName = [recruteur?.utilisateur?.prenom, recruteur?.utilisateur?.nom].filter(Boolean).join(' ');

        if (!this.recruiterId) {
          this.errorMessage = 'Profil recruteur introuvable.';
          this.loading = false;
          return;
        }

        if (this.editMode && this.offerId) {
          this.loadOfferForEdit(this.offerId);
        } else {
          this.competences.clear();
          this.addCompetenceRow();
          this.form.patchValue({
            datePublication: this.todayIsoDate(),
            statut: 'ouverte',
            teletravail: false,
          });
          this.loading = false;
        }
      },
      error: () => {
        this.errorMessage = 'Impossible de récupérer votre profil recruteur.';
        this.loading = false;
      },
    });
  }

  get competences(): FormArray {
    return this.form.get('competences') as FormArray;
  }

  addCompetenceRow(value?: Partial<CompetenceRowValue>): void {
    this.competences.push(
      this.fb.group({
        category: this.fb.control(value?.category ?? 'technique', Validators.required),
        nom: this.fb.control(value?.nom ?? '', [Validators.required, Validators.maxLength(255)]),
        obligatoire: this.fb.control(!!value?.obligatoire),
      })
    );
  }

  removeCompetenceRow(index: number): void {
    if (this.competences.length <= 1) {
      this.competences.at(0)?.reset({ category: 'technique', nom: '', obligatoire: false });
      return;
    }

    this.competences.removeAt(index);
  }

  hasDuplicateCompetences(): boolean {
    const keys = this.competences.controls
      .map((control) => `${String(control.get('category')?.value ?? '').trim().toLowerCase()}::${String(control.get('nom')?.value ?? '').trim().toLowerCase()}`)
      .filter((value) => value !== '::');

    return new Set(keys).size !== keys.length;
  }

  save(): void {
    this.errorMessage = '';
    this.successMessage = '';

    if (this.form.invalid) {
      this.form.markAllAsTouched();
      this.errorMessage = 'Veuillez remplir tous les champs obligatoires.';
      return;
    }

    if (this.competences.length === 0) {
      this.errorMessage = 'Ajoutez au moins une compétence nécessaire.';
      return;
    }

    if (this.hasDuplicateCompetences()) {
      this.errorMessage = 'Chaque catégorie et compétence doit être unique.';
      return;
    }

    const payload = this.buildOfferPayload();
    this.saving = true;

    const saveOffer$ = this.editMode && this.offerId
      ? this.apiService.updateOffre(this.offerId, payload)
      : this.apiService.createOffre(payload);

    saveOffer$.subscribe({
      next: (savedOffer) => {
        const offerId = savedOffer?.id ?? this.offerId;
        if (!offerId) {
          this.saving = false;
          this.errorMessage = 'Impossible de récupérer l’offre enregistrée.';
          return;
        }

        this.syncCompetences(Number(offerId));
      },
      error: () => {
        this.saving = false;
        this.errorMessage = this.editMode ? 'Erreur lors de la modification de l’offre.' : 'Erreur lors de la création de l’offre.';
      },
    });
  }

  goBack(): void {
    if (this.editMode && this.offerId) {
      this.router.navigate(['/detail-offre', this.offerId]);
      return;
    }

    this.router.navigate(['/liste-offres']);
  }

  trackByRow(index: number): number {
    return index;
  }

  private loadOfferForEdit(offerId: number): void {
    this.apiService.getOffreById(offerId).subscribe({
      next: (offre) => {
        this.form.patchValue({
          titre: offre?.titre ?? '',
          description: offre?.description ?? '',
          lieu: offre?.lieu ?? '',
          typeContrat: offre?.typeContrat ?? '',
          salaire: this.asNumberOrNull(offre?.salaire),
          duree: offre?.duree ?? '',
          experienceRequise: this.asNumberOrNull(offre?.experienceRequise),
          dateDebut: this.toInputDate(offre?.dateDebut),
          datePublication: this.toInputDate(offre?.datePublication),
          teletravail: !!offre?.teletravail,
          statut: offre?.statut ?? 'ouverte',
        });

        this.apiService.getCompetencesByOffre(offerId).subscribe({
          next: (competencesOffre) => {
            this.competences.clear();

            if (!competencesOffre || competencesOffre.length === 0) {
              this.addCompetenceRow();
            } else {
              competencesOffre.forEach((item: any) => {
                this.addCompetenceRow({
                  category: item?.competence?.category ?? 'technique',
                  nom: item?.competence?.nom ?? '',
                  obligatoire: !!item?.obligatoire,
                });
              });
            }

            this.loading = false;
          },
          error: () => {
            this.competences.clear();
            this.addCompetenceRow();
            this.loading = false;
          },
        });
      },
      error: () => {
        this.errorMessage = 'Impossible de charger l’offre à modifier.';
        this.loading = false;
      },
    });
  }

  private syncCompetences(offerId: number): void {
    this.apiService.getCompetencesByOffre(offerId).subscribe({
      next: (existingCompetences) => {
        const deleteRequests = (existingCompetences || [])
          .map((item: any) => item?.competence?.id ?? item?.id?.idCompetence ?? item?.idCompetence)
          .filter((competenceId: number | undefined) => !!competenceId)
          .map((competenceId: number) => this.apiService.deleteCompetenceOffre(offerId, competenceId));

        const remove$ = deleteRequests.length > 0 ? forkJoin(deleteRequests) : of([]);

        remove$.subscribe({
          next: () => {
            const rows = this.competences.controls
              .map((control) => ({
                category: String(control.get('category')?.value ?? 'technique'),
                nom: String(control.get('nom')?.value ?? '').trim(),
                obligatoire: !!control.get('obligatoire')?.value,
              }))
              .filter((row) => !!row.nom);

            const createCompetenceRequests = rows.map((row) =>
              this.apiService.createCompetence({
                category: row.category,
                nom: row.nom,
              })
            );

            const createCompetences$ = createCompetenceRequests.length > 0 ? forkJoin(createCompetenceRequests) : of([]);

            createCompetences$.subscribe({
              next: (createdCompetences: any) => {
                const competenceList = Array.isArray(createdCompetences) ? createdCompetences : [];
                const linkRequests = competenceList.map((competence: any, index: number) => {
                  const row = rows[index];
                  return this.apiService.createCompetenceOffre({
                    id: {
                      idOffre: offerId,
                      idCompetence: competence.id,
                    },
                    offre: { id: offerId },
                    competence: { id: competence.id },
                    obligatoire: row?.obligatoire ?? false,
                  });
                });

                const link$ = linkRequests.length > 0 ? forkJoin(linkRequests) : of([]);

                link$.subscribe({
                  next: () => {
                    this.saving = false;
                    this.successMessage = this.editMode ? 'Offre modifiée avec succès.' : 'Offre créée avec succès.';
                    this.router.navigate(['/detail-offre', offerId]);
                  },
                  error: () => {
                    this.saving = false;
                    this.errorMessage = 'L’offre a été enregistrée, mais les compétences n’ont pas pu être synchronisées.';
                  },
                });
              },
              error: () => {
                this.saving = false;
                this.errorMessage = 'Impossible de créer les compétences de l’offre.';
              },
            });
          },
          error: () => {
            this.saving = false;
            this.errorMessage = 'Impossible de synchroniser les compétences de l’offre.';
          },
        });
      },
      error: () => {
        this.saving = false;
        this.errorMessage = 'Impossible de synchroniser les compétences de l’offre.';
      },
    });
  }

  private buildOfferPayload(): OffreFormPayload {
    const raw = this.form.getRawValue();

    return {
      idRecruteur: this.recruiterId,
      titre: raw.titre?.trim() ?? '',
      description: raw.description?.trim() ?? '',
      lieu: raw.lieu?.trim() ?? '',
      typeContrat: raw.typeContrat ?? '',
      salaire: this.asNumberOrNull(raw.salaire),
      duree: raw.duree?.trim() ?? '',
      experienceRequise: this.asNumberOrNull(raw.experienceRequise),
      dateDebut: raw.dateDebut || null,
      datePublication: raw.datePublication || this.todayIsoDate(),
      teletravail: !!raw.teletravail,
      statut: raw.statut ?? 'ouverte',
    };
  }

  private toInputDate(value?: string | null): string {
    if (!value) {
      return '';
    }

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) {
      return value;
    }

    return date.toISOString().slice(0, 10);
  }

  private todayIsoDate(): string {
    return new Date().toISOString().slice(0, 10);
  }

  private asNumberOrNull(value: unknown): number | null {
    if (value === null || value === undefined || value === '') {
      return null;
    }

    const numberValue = Number(value);
    return Number.isFinite(numberValue) ? numberValue : null;
  }
}
