# RECRUTE! — Documentation API Backend

**Base URL** : `http://localhost:8080`  
**Stack** : Spring Boot 3.5.11 · PostgreSQL 16 · Docker

---

## Endpoints disponibles

### Candidats — `/candidats`
| Méthode | URL | Description |
|---|---|---|
| GET | `/candidats` | Tous les candidats |
| GET | `/candidats/{id}` | Un candidat par ID |
| POST | `/candidats` | Créer un candidat |
| PUT | `/candidats/{id}` | Modifier un candidat |
| DELETE | `/candidats/{id}` | Supprimer un candidat |
| POST | `/candidats/{id}/cv` | Uploader un CV (PDF, max 10MB) |
| GET | `/candidats/{id}/cv` | Télécharger le CV d'un candidat |

### Compétences — `/competences`
| Méthode | URL | Description |
|---|---|---|
| GET | `/competences` | Toutes les compétences |
| GET | `/competences/{id}` | Une compétence par ID |
| POST | `/competences` | Créer une compétence |
| PUT | `/competences/{id}` | Modifier une compétence |
| DELETE | `/competences/{id}` | Supprimer une compétence |

### Compétences Candidat — `/competences-candidats`
| Méthode | URL | Description |
|---|---|---|
| GET | `/competences-candidats` | Toutes les compétences candidats |
| GET | `/competences-candidats/candidat/{id}` | Compétences d'un candidat |
| POST | `/competences-candidats` | Ajouter une compétence à un candidat |
| DELETE | `/competences-candidats` | Supprimer une compétence d'un candidat |

### Expériences — `/experiences`
| Méthode | URL | Description |
|---|---|---|
| GET | `/experiences` | Toutes les expériences |
| GET | `/experiences/{id}` | Une expérience par ID |
| GET | `/experiences/candidat/{id}` | Expériences d'un candidat |
| POST | `/experiences` | Ajouter une expérience |
| PUT | `/experiences/{id}` | Modifier une expérience |
| DELETE | `/experiences/{id}` | Supprimer une expérience |

### Liens — `/liens`
| Méthode | URL | Description |
|---|---|---|
| GET | `/liens` | Tous les liens |
| GET | `/liens/{id}` | Un lien par ID |
| GET | `/liens/candidat/{id}` | Liens d'un candidat |
| POST | `/liens` | Ajouter un lien |
| PUT | `/liens/{id}` | Modifier un lien |
| DELETE | `/liens/{id}` | Supprimer un lien |

### Candidatures — `/candidatures`
| Méthode | URL | Description |
|---|---|---|
| GET | `/candidatures` | Toutes les candidatures |
| GET | `/candidatures/{id}` | Une candidature par ID |
| GET | `/candidatures/candidat/{id}` | Candidatures d'un candidat |
| GET | `/candidatures/offre/{id}` | Candidatures pour une offre |
| POST | `/candidatures` | Postuler à une offre |
| PUT | `/candidatures/{id}` | Modifier une candidature |
| DELETE | `/candidatures/{id}` | Supprimer une candidature |

### Messagerie — `/messagerie`
| Méthode | URL | Description |
|---|---|---|
| GET | `/messagerie` | Tous les messages |
| GET | `/messagerie/{id}` | Un message par ID |
| GET | `/messagerie/candidature/{id}` | Messages d'une candidature |
| GET | `/messagerie/candidat/{id}` | Messages d'un candidat |
| GET | `/messagerie/recruteur/{id}` | Messages d'un recruteur |
| POST | `/messagerie` | Envoyer un message |
| DELETE | `/messagerie/{id}` | Supprimer un message |

---
