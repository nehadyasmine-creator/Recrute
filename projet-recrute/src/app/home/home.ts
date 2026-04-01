import { Component, inject } from '@angular/core';
import { RouterLink , Router} from '@angular/router';
import { AuthService } from '../service/auth.service';
import { FormsModule } from '@angular/forms';


interface Utilisateur{
  id_utilisateur: number;
  nom: string;
  prenom: string;
  email:string;
  telephone:string;
  motdepasse:string;
}

@Component({
  selector: 'app-home',
  imports: [RouterLink, FormsModule],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home {
  loginData = {
    email:'',
    password:''
  }
  errorMessage: string = '';

  constructor(private authService: AuthService, private router: Router) {}

  onLogin() {
    this.authService.login(this.loginData.email, this.loginData.password).subscribe({
      next: (response) => {
        console.log('Connexion réussie !', response);
        this.router.navigate(['/liste-offres']); 
      },
      error: (err) => {
        this.errorMessage = "Identifiants incorrects. Veuillez réessayer.";
        console.error(err);
      }
    });
  }
}
