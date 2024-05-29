#!/bin/bash

if ! ps aux | grep -v grep "/usr/local/searxng" > /dev/null; then
    if ! systemctl is-active docker.service > /dev/null; then
        echo "Docker service is not running. Starting it now..."
        sudo systemctl start docker.service
        sleep 2
    fi

    if ! sudo docker ps -a | grep "searxng" > /dev/null; then
        echo "Searxng is not running. Starting it now..."
        sudo docker compose -f /usr/local/searxng-docker/docker-compose.yaml up -d
        sleep 2
    fi
fi

xdg-open http://127.0.0.1:8080
