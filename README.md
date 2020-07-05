# Docker Compose for Home Assistant

# Setup

Modify the .env file for your setup. Then run the setup.sh script to create volume dirs

```
cp .env_template .env
# Modify the .env file above before running the setup script
chmod u+x setup.sh
./setup.sh
# Ensure docker is installed
# i.e. https://docs.docker.com/compose/install/#install-compose-on-linux-systems
docker-compose up -d
```
