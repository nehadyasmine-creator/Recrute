import { Pipe, PipeTransform } from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

@Pipe({
  name: 'linkify',
  standalone: true,
})
export class LinkifyPipe implements PipeTransform {
  constructor(private sanitizer: DomSanitizer) {}

  transform(value: unknown): SafeHtml {
    if (value === null || value === undefined) return '' as unknown as SafeHtml;
    const text = String(value);

    // Escape HTML to avoid XSS, then replace URLs with anchors
    const escapeHtml = (s: string) =>
      s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\"/g, '&quot;');

    const escaped = escapeHtml(text);

    // Simple URL regex (http(s) and www.)
    const urlRegex = /((https?:\/\/|www\.)[\w\-@:%_\+.~#?,&//=]+[^\s\"'<> ])/gi;

    const replaced = escaped.replace(urlRegex, (match: string) => {
      let href = match;
      if (!href.match(/^https?:/i)) {
        href = 'http://' + href;
      }
      return `<a class="lieu-link" href="${href}" target="_blank" rel="noopener noreferrer">${match}</a>`;
    });

    return this.sanitizer.bypassSecurityTrustHtml(replaced);
  }
}
