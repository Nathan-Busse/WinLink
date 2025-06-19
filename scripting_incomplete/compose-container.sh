#!usr/bin/bash
# This script is used to compose a docker caontainer using the docker-compose.yml file.
# Usage: ./compose-container.sh [up|down|restart]
set -e
if [ -z "$1" ]; then
    echo "Usage: $0 [up|down|restart]"
    exit 1
fi
ACTION=$1
if [ "$ACTION" == "up" ]; then
    docker-compose up -d
elif [ "$ACTION" == "down" ]; then
    docker-compose down
elif [ "$ACTION" == "restart" ]; then
    docker-compose down && docker-compose up -d
else
    echo "Invalid action: $ACTION"
    echo "Usage: $0 [up|down|restart]"
    exit 1
fi
echo "Docker Compose action '$ACTION' completed successfully."
# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose could not be found. Please install it first."
    exit 1
fi
# Check if docker is running
if ! systemctl is-active --quiet docker; then
    echo "Docker is not running. Please start Docker first."
    exit 1
fi
# Check if docker-compose.yml file exists
if [ ! -f docker-compose.yml ]; then
    echo "docker-compose.yml file not found in the current directory."
    exit 1
fi
# Check if the user has permission to run docker commands
if ! docker ps &> /dev/null; then
    echo "You do not have permission to run Docker commands. Please check your user permissions."
    exit 1
fi
# Check if the docker-compose.yml file is valid
if ! docker-compose config &> /dev/null; then
    echo "The docker-compose.yml file is not valid. Please check the syntax."
    exit 1
fi
# Check if the required environment variables are set
if [ -z "$DOCKER_COMPOSE_PROJECT_NAME" ]; then
    echo "The DOCKER_COMPOSE_PROJECT_NAME environment variable is not set. Please set it before running this script."
    exit 1
fi
# Check if the required services are defined in the docker-compose.yml file
if ! grep -q "services:" docker-compose.yml; then
    echo "No services defined in the docker-compose.yml file. Please define at least one service."
    exit 1
fi
# Check if the required images are available
if ! docker images | grep -q "your_image_name"; then
    echo "The required Docker image 'your_image_name' is not available. Please build or pull the image first."
    exit 1
fi
# Check if the required ports are available
if ! netstat -tuln | grep -q ":80"; then
    echo "Port 80 is not available. Please free up the port before running this script."
    exit 1
fi
# Check if the required volumes are available
if ! docker volume ls | grep -q "your_volume_name"; then
    echo "The required Docker volume 'your_volume_name' is not available. Please create the volume first."
    exit 1
fi
# Check if the required networks are available
if ! docker network ls | grep -q "your_network_name"; then
    echo "The required Docker network 'your_network_name' is not available. Please create the network first."
    exit 1
fi
# Check if the required environment variables are set in the docker-compose.yml file
if ! grep -q "environment:" docker-compose.yml; then
    echo "No environment variables defined in the docker-compose.yml file. Please define at least one environment variable."
    exit 1
fi
# Check if the required secrets are defined in the docker-compose.yml file
if ! grep -q "secrets:" docker-compose.yml; then
    echo "No secrets defined in the docker-compose.yml file. Please define at least one secret."
    exit 1
fi
# Check if the required configs are defined in the docker-compose.yml file
if ! grep -q "configs:" docker-compose.yml; then
    echo "No configs defined in the docker-compose.yml file. Please define at least one config."
    exit 1
fi
# Check if the required health checks are defined in the docker-compose.yml file
if ! grep -q "healthcheck:" docker-compose.yml; then
    echo "No health checks defined in the docker-compose.yml file. Please define at least one health check."
    exit 1
fi
# Check if the required logging options are defined in the docker-compose.yml file
if ! grep -q "logging:" docker-compose.yml; then
    echo "No logging options defined in the docker-compose.yml file. Please define at least one logging option."
    exit 1
fi
# Check if the required deploy options are defined in the docker-compose.yml file
if ! grep -q "deploy:" docker-compose.yml; then
    echo "No deploy options defined in the docker-compose.yml file. Please define at least one deploy option."
    exit 1
fi
# Check if the required build options are defined in the docker-compose.yml file
if ! grep -q "build:" docker-compose.yml; then
    echo "No build options defined in the docker-compose.yml file. Please define at least one build option."
    exit 1
fi
# Check if the required depends_on options are defined in the docker-compose.yml file
if ! grep -q "depends_on:" docker-compose.yml; then
    echo "No depends_on options defined in the docker-compose.yml file. Please define at least one depends_on option."
    exit 1
fi
# Check if the required networks are defined in the docker-compose.yml file
if ! grep -q "networks:" docker-compose.yml; then
    echo "No networks defined in the docker-compose.yml file. Please define at least one network."
    exit 1
fi
# Check if the required volumes are defined in the docker-compose.yml file
if ! grep -q "volumes:" docker-compose.yml; then
    echo "No volumes defined in the docker-compose.yml file. Please define at least one volume."
    exit 1
fi
# Check if the required services are defined in the docker-compose.yml file
if ! grep -q "services:" docker-compose.yml; then
    echo "No services defined in the docker-compose.yml file. Please define at least one service."
    exit 1
fi
# Check if the required version is defined in the docker-compose.yml file
if ! grep -q "version:" docker-compose.yml; then
    echo "No version defined in the docker-compose.yml file. Please define the version."
    exit 1
fi
# Check if the required x- options are defined in the docker-compose.yml file
if ! grep -q "x-" docker-compose.yml; then
    echo "No x- options defined in the docker-compose.yml file. Please define at least one x- option."
    exit 1
fi
# Check if the required profiles are defined in the docker-compose.yml file
if ! grep -q "profiles:" docker-compose.yml; then
    echo "No profiles defined in the docker-compose.yml file. Please define at least one profile."
    exit 1
fi
# Check if the required secrets are defined in the docker-compose.yml file
if ! grep -q "secrets:" docker-compose.yml; then
    echo "No secrets defined in the docker-compose.yml file. Please define at least one secret."
    exit 1
fi
# Check if the required configs are defined in the docker-compose.yml file
if ! grep -q "configs:" docker-compose.yml; then
    echo "No configs defined in the docker-compose.yml file. Please define at least one config."
    exit 1
fi
# Check if the required health checks are defined in the docker-compose.yml file
if ! grep -q "healthcheck:" docker-compose.yml; then
    echo "No health checks defined in the docker-compose.yml file. Please define at least one health check."
    exit 1
fi
