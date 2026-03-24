import { Routes } from '@angular/router';
import { Home } from './home/home';
import { Faq } from './faq/faq';
import { Contact } from './contact/contact';

export const routes: Routes = [
    { path: '', component: Home },
    { path: 'faq', component: Faq },
    { path: 'contactez-nous', component: Contact},
    { path: '**', redirectTo: '' }
];
