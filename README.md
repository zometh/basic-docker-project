# Projet DevOps - Serveur HTTP Minimaliste avec Docker

Ce projet met en place un serveur HTTP minimaliste utilisant uniquement les bibliothèques standards de Python, déployé via Docker.

## Structure du projet

```
basic-docker-project/
├── app/
│   ├── server.py
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Prérequis

- Docker installé (version 19.03 ou supérieure recommandée)
- Docker Compose installé (version 1.27 ou supérieure recommandée)

## Exécution du projet

### Méthode 1: Avec Docker Compose (recommandée)

Clonez ce dépôt et accédez au répertoire du projet:
```bash
git clone <url-du-dépôt>
cd basic-docker-project
```

Lancez l'application avec Docker Compose:
```bash
docker-compose up -d
```

Pour arrêter l'application:
```bash
docker-compose down
```

### Méthode 2: Avec Docker sans Compose

Construisez l'image Docker:
```bash
docker build -t http-server-min .
```

Lancez un conteneur basé sur cette image:
```bash
docker run -d -p 8000:8000 --name http-server http-server-min
```

Pour arrêter et supprimer le conteneur:
```bash
docker stop http-server
docker rm http-server
```

## Accès à l'application

Une fois le serveur démarré, accédez à l'application via votre navigateur à l'adresse:
```
http://localhost:8000
```

## Partie B: Pousser l'image vers DockerHub

### Construction et push de l'image

Construisez l'image Docker:
```bash
docker build -t zomethdev/http-server-min:latest .
```

Connectez-vous à DockerHub:
```bash
docker login
```

Poussez l'image vers DockerHub:
```bash
docker push zomethdev/http-server-min:latest
```

### Récupération de l'image depuis DockerHub

Pour utiliser l'image directement depuis DockerHub:
```bash
docker pull zomethdev/http-server-min:latest
docker run -d -p 8000:8000 zomethdev/http-server-min:latest
```

## Partie C: Pipeline CI/CD pour l'automatisation

Un pipeline CI/CD a été configuré pour automatiser la construction et le push de l'image Docker vers DockerHub à chaque modification du code source sur la branche principale.

Le pipeline est implémenté avec GitHub Actions et utilise des secrets pour sécuriser l'authentification DockerHub.

Pour utiliser la dernière version de l'image publiée automatiquement:
```bash
docker pull zomethdev/http-server-min:latest
```
