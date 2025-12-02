#!/bin/bash

# deploy.sh script to fetch latest code, build and restart Docker containers


set -e
cd /root/Workplace || exit 1

echo ">>> Fetching latest code"
git fetch origin workplace

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/workplace)

if [ "$LOCAL" = "$REMOTE" ]; then
    echo ">>> No changes, skipping deploy."
    exit 0
fi

echo ">>> Changes detected. Starting deploy..."
git reset --hard origin/workplace

echo ">>> Stopping containers"
docker-compose down --remove-orphans
# Lista portów do zwolnienia
PORTS=(8001)

for PORT in "${PORTS[@]}"; do
    while lsof -i :$PORT > /dev/null; do
        echo ">>> Port $PORT used, killing process..."
        lsof -ti :$PORT | xargs -r kill -9
        sleep 1
    done
done
# Usuń porzucone sieci, jeśli istnieją
docker network prune -f

echo ">>> Building containers"
chmod -R 755 /root/Workplace/staticfiles
if ! docker-compose build --pull --no-cache; then
    echo ">>> Build failed. Checking for Python image issues..."
    
    IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "^python:3.10$")
    if [ -n "$IMAGES" ]; then
        echo ">>> Removing problematic Python images: $IMAGES"
        docker rmi -f $IMAGES
    fi

    echo ">>> Retry build"
    docker-compose build --no-cache || {
        echo ">>> Build failed again. Exiting."
        exit 1
    }
fi

echo ">>> Starting containers"
docker-compose up -d --remove-orphans


# crontab -e

#* * * * * /root/deploy.sh >> /root/work.log 2>&1             <- check every minute for changes
