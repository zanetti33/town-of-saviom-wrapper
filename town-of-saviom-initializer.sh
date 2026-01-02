#!/bin/bash

# Repositories
REPOS=(
  "https://github.com/zanetti33/town-of-saviom.git"
  "https://github.com/zanetti33/login-api.git"
  "https://github.com/zanetti33/lobby-api.git"
  "https://github.com/Pedro-1309/stats-api"
  "https://github.com/Pedro-1309/gameplay-api.git"
)

echo "Starting Environment Setup..."

for REPO_URL in "${REPOS[@]}"; do
    REPO_NAME=$(basename "$REPO_URL" .git)

    if [ -d "$REPO_NAME" ]; then
        echo "$REPO_NAME already exists. Skipping."
    else
        echo "Cloning $REPO_NAME..."
        git clone "$REPO_URL"
    fi
done

echo "Setup complete!"

echo "Booting..."

docker network create town-of-saviom-shared-net 2>/dev/null || true
docker compose up --build -d
# Da modificare una volta implementata la versione di produzione con anche l'interfaccia dentro docker
cd ./town-of-saviom
npm install
npm run dev