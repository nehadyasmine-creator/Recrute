# 🚀 RECRUTE! — Guide d'installation

Marketplace RH spécialisée dans l'ingénierie.
Stack : Spring Boot 3.5.11 + PostgreSQL 16 + MongoDB + Docker + Angular + Python (IA)

## 📋 Prérequis
Avant de lancer le projet, installe :

- [Java 17](https://adoptium.net/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Python 3.x](https://www.python.org/downloads/)
- [Node.js / npm](https://nodejs.org/)
- VS Code

Vérifie tes installations :
```bash
java -version     # doit afficher 17.x.x
docker --version  # doit afficher 20.x ou plus
```

> ⚠️ L'ordre de lancement est important : IA → Backend → Frontend

## 1️⃣ Module IA (Python)
### Installation des dépendances

```bash
cd recrute-python
pip install pymongo
pip install fastapi uvicorn python-multipart
python.exe -m pip install --upgrade pip
pip install pdfplumber
pip install sentence_transformers
```

## 2️⃣ Backend (Spring Boot)
### Se placer dans le dossier backend

```bash
cd recrute-backend
```

### Lancer les bases de données

```bash
docker-compose up -d
```

Vérifie que les conteneurs tournent :
```bash
docker ps
```

Tu dois voir 4 conteneurs actifs :

| Conteneur | Description | Port |
|---|---|---|
| `recrute-db` | PostgreSQL 16 | `5433` |
| `recrute-adminer` | Interface base de données PostgreSQL | `8082` |
| `recrute-mongo` | MongoDB | `27017` |
| `recrute-mongo-express` | Interface base de données MongoDB | `8081` |

### Lancer Spring Boot

```bash
./mvnw spring-boot:run
```

### Accéder à la base de données PostgreSQL
Ouvre http://localhost:8082 et connecte-toi avec :

| Champ | Valeur |
| Système | PostgreSQL |
| Serveur | `postgres` |
| Utilisateur | `recrute_user` |
| Mot de passe | `recrute_pass` |
| Base de données | `recrute` |

### Accéder à la base de données MongoDB
Ouvre http://localhost:8081 dans ton navigateur pour accéder à l'interface Mongo Express.


## 3️⃣ Frontend (Angular)
### Se placer dans le dossier frontend

```bash
cd projet-recrute
```

### Installer la dépendance nécessaire au lancement des scripts Python depuis l'application

```bash
npm install --save-dev concurrently
```

### Lancer l'application

```bash
npm run dev
```

> ❌ Ne pas utiliser `ng serve` seul, sinon les scripts Python (IA) ne seront pas lancés avec le front.


## 🛑 Arrêter le projet

Arrêter Spring Boot / Frontend :
```bash
CTRL + C
```

Arrêter les conteneurs Docker :
```bash
docker-compose down
```


## ❓ Problèmes fréquents
Le port 5433 est déjà utilisé
> Un autre PostgreSQL tourne sur ta machine. Identifie le conteneur en conflit puis stoppe-le :

```bash
docker ps
docker kill <nom_ou_id_du_conteneur>
```