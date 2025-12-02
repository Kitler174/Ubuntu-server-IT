#!/bin/bash
set -e

BACKUP_DIR="/root/wol_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Pobierz wszystkie wolumeny Dockera
VOLUMES=$(docker volume ls -q)

echo "I found: $VOLUMES"

for VOL in $VOLUMES; do
    DEST="$BACKUP_DIR/$VOL"
    mkdir -p "$DEST"
    echo ">>> copied $VOL to $DEST"

    docker run --rm \
      -v "$VOL:/from" \
      -v "$DEST:/to" \
      alpine ash -c "cd /from && cp -a . /to"

    echo ">>> Copy $VOL done."
done

echo ">>> Good backup"


# crontab -e

#1 0 * * * /root/wol_backup/backup_wol.sh >> /var/log/backup_workplace.log 2>&1             <- daily at 1am    
