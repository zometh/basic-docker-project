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

### Méthode 1: Avec Docker Compose 

Clonez ce dépôt et accédez au répertoire du projet:
```bash
git clone "https://github.com/zometh/basic-docker-project.git"
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

Après avoir démarrer le serveur, accédez à l'application via votre navigateur à l'adresse:
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

Cette partie est la mise en place d'un pipeline CI/CD pour automatiser la construction et le push de l’image Docker vers DockerHub à chaque modification du code source

## Structure du projet
```
basic-docker-project/
    ├── app/
    │   ├── server.py
    ├── Dockerfile
    ├── docker-compose.yml
    ├── .github/workflows/docker-publish.yml
    └── README.md
```
## Prérequis
Avant d'exécuter le pipeline, assure-toi d’avoir :

Un compte DockerHub.

Un repository DockerHub (ex: zomethdev/http-server-min).

Un dépôt GitHub connecté à DockerHub.

Ajouté tes identifiants DockerHub comme secrets GitHub :

DOCKER_USERNAME → Ton nom d’utilisateur DockerHub.

DOCKER_PASSWORD → Ton mot de passe DockerHub (ou un token d’accès personnel).

## Contenu du fichier.github/workflows/docker-publish.yml

```
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        
      - name: Login to DockerHub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
        
      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/http-server-min:latest
```

## push du fichier  fichier.github/workflows/docker-publish.yml

```
git add .github/workflows/docker-publish.yml
git commit "Ajout du pipeline"
git push origin main
```
Après avoir ajouté le pipeline, on pourra modifier notre fichier server.py et tester si notre pipeline marche correctement.
Pour cela on tape la commande suivante pour cloner l'image depuis docker hub

```
docker pull zomethdev/http-server-min:latest

```

## test du server
```
docker run -d -p 8000:8000 zomethdev/http-server-min:latest
localhost:8000 //depuis le navigateur
```
Si notre pipeline fonctionne normalement, on verra les changements effectués récemment.