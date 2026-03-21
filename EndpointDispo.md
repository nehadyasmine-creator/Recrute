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

---
