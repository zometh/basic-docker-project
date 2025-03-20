# Utilisation d'une image Python officielle
FROM python:3.9-slim

# Repertoire de travail
WORKDIR /app

# Copie des fichiers du projet dans le conteneur
COPY app/ .

# Exposition du port utilisé par le serveur
EXPOSE 8000

# Commandes pour démarrer le serveur
CMD ["python", "server.py"]