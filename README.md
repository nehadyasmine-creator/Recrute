# 🚀 RECRUTE! — Backend

Backend de la marketplace RH spécialisée dans l'ingénierie.  
Développé avec **Spring Boot 3.5.11** + **PostgreSQL 16** + **Docker**.

## 📋 Prérequis

Avant de lancer le projet, assure-toi d'avoir installé :

- [Java 17](https://adoptium.net/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- VS Code

Vérifie tes installations :
```bash
java -version     # doit afficher 17.x.x
docker --version  # doit afficher 20.x ou plus
```

Important d'installer pour lancer les scripts Python depuis l'application
```bash
npm install --save-dev concurrently
```
Et lancer avec :
```bash
npm run dev
```

Installer les librairies Python suivantes : 

```bash
cd recrute-pyton
pip install pymongo
python.exe -m pip install --upgrade pip
pip install pdfplumber
pip install sentence_transformers
```


## ⚙️ Installation & Lancement

### 1 — Se mettre dans le back-end

```bash
cd recrute-backend
```

### 2 — Lancer la base de données

```bash
docker-compose up -d
```

Vérifie que les conteneurs tournent :
```bash
docker ps
```

Tu dois voir **2 conteneurs** actifs :
| Conteneur | Description | Port |
|---|---|---|
| `recrute-db` | PostgreSQL 16 | `5433` |
| `recrute-adminer` | Interface base de données | `8082` |

### 3 — Lancer Spring Boot

```bash
./mvnw spring-boot:run
```

## 🗄️ Accéder à la base de données

Ouvre **http://localhost:8082** dans ton navigateur et connecte-toi avec :

| Champ | Valeur |
|---|---|
| Système | PostgreSQL |
| Serveur | `postgres` |
| Utilisateur | `recrute_user` |
| Mot de passe | `recrute_pass` |
| Base de données | `recrute` |

## 🛑 Arrêter le projet

Arrêter Spring Boot :
```bash
CTRL + C
```

Arrêter les conteneurs Docker :
```bash
docker-compose down
```

## ❓ Problèmes fréquents

**Le port 5433 est déjà utilisé**
> Un autre PostgreSQL tourne sur ta machine. Stoppe-le 

```bash
docker kill (référence)
```
