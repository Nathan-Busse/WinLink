#!/bin/bash
# This script is used to start the Docker Compose services defined in the compose.yaml file.
# Ensure the script is run from the directory containing the compose.yaml file
# and that Docker Compose is installed.
# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose could not be found. Please install it first."
    exit 1
fi
# Check if the compose.yaml file exists
if [ ! -f "./compose.yaml" ]; then
    echo "compose.yaml file not found in the current directory."
    exit 1
fi
# Start the Docker Compose services
echo "Starting Docker Compose services..."
docker compose --file ./compose.yaml up