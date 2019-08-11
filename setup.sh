#!/bin/sh

. ./.env

# Find container_dir from .env file and use as pattern to
# search docker-compose.yaml for volume paths to create
volume_paths=$(grep $(awk -F= '/container_dir/{print$2}' .env) docker-compose.yaml | awk '{print$2}' | awk -F: '{print$1}')

mkdir -p $container_dir

for vp in $volume_paths
do
  mkdir -p $vp
done
