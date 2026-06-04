import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'formatTaille',
  standalone: true,
})
export class FormatTaillePipe implements PipeTransform {
  private map: Record<string, string> = {
    startup: 'Startup',
    pme: 'PME',
    eti: 'ETI',
    grand_groupe: 'Grand Groupe',
  };

  transform(value: unknown, fallback = 'Non renseigné'): string {
    if (value === null || value === undefined) return fallback;
    const key = String(value).trim();
    if (!key) return fallback;

    const mapped = this.map[key];
    if (mapped) return mapped;

    // Generic: replace underscores and title-case
    const human = key.replace(/_/g, ' ').toLowerCase().replace(/(^|\s)\S/g, (s) => s.toUpperCase());
    return human;
  }
}
