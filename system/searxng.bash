#!/bin/bash

if ! systemctl is-active docker.service; then
    echo "Docker service is not running. Starting it now..."
    sudo systemctl start docker.service
    sleep 2
fi

if ! sudo docker ps -a | grep "searxng" > /dev/null; then
    echo "Searxng is not running. Starting it now..."
    sudo docker compose -f /usr/local/searxng-docker/docker-compose.yaml up -d

    sleep 2
else
    echo "Searxng is already running."
fi

xdg-open http://127.0.0.1:8080
