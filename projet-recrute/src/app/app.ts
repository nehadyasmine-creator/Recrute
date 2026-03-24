import { Component, signal } from '@angular/core';
import { Navbar } from "./navbar/navbar";
import { FooterComponent } from './footer/footer';
import { RouterOutlet } from "@angular/router";

@Component({
  selector: 'app-root',
  imports: [Navbar, FooterComponent, RouterOutlet],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  protected readonly title = signal('projet-recrute');
}
