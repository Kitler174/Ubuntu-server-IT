#!/bin/bash
# sudo chmod +x /root/start.sh

# example start.sh script to start Docker containers using docker-compose via autostart.service

echo ">>> Starting containers via autostart.service <<<"
docker-compose up -d --remove-orphans
echo ">>> Containers started <<<"
