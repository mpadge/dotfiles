#!/bin/bash

if ! pgrep -f "/usr/local/searxng/dockerfiles/docker-entrypoint.sh" > /dev/null; then

    if ! systemctl is-active docker.service > /dev/null; then
        echo "Docker service is not running. Starting it now..."
        systemctl start docker.service
        sleep 2
    fi

    if ! docker ps -a | grep "searxng" > /dev/null; then
        echo "Searxng is not running. Starting it now..."
        docker compose -f /usr/local/searxng-docker/docker-compose.yaml up -d
        sleep 2
    fi
fi

firefox http://127.0.0.1:8080 &
