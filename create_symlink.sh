#!/bin/bash

# Path to the root .env file
ROOT_ENV_FILE=".env"

# Check if the root .env file exists
if [ ! -f "$ROOT_ENV_FILE" ]; then
  echo "Root .env file not found!"
  exit 1
fi

# Find all directories containing docker-compose.yml or docker-compose.yaml
find . -type f \( -name "docker-compose.yml" -o -name "docker-compose.yaml" \) | while read compose_file; do
  dir=$(dirname "$compose_file")
  target="$dir/.env"
  # Only link if .env does not already exist in the target directory
  if [ ! -e "$target" ]; then
    ln -s "$(realpath "$ROOT_ENV_FILE")" "$target"
    echo "Linked $ROOT_ENV_FILE to $target"
  else
    echo "$target already exists, skipping."
  fi
done