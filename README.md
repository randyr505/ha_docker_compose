# Docker Compose for Home Assistant

# Setup

Modify the .env file for your setup. Then run the setup.sh script to create volume dirs

```
cp .env_template .env
# Modifythe .env file above before running the setup script
./setup.sh
docker-compose up -d
```
