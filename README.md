# Docker Compose for Home Assistant

# Setup

Clone this repo

```git clone https://github.com/randyr505/ha_docker_compose.git```

Modify the .env file for your setup. Then run the setup.sh script to create volume dirs

```
cd <path_to_repo>
cp .env_template .env
# Modify the .env file above before running the setup script
# Make setup.sh executable
chmod u+x setup.sh
# Run setup script
./setup.sh
# Ensure docker is installed
# i.e. https://docs.docker.com/compose/install/#install-compose-on-linux-systems
docker-compose up -d
```
