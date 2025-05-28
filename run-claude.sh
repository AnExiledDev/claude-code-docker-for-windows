#!/bin/bash

IMAGE_NAME="claude-code-cli"

# Ensure image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
  echo "📦 Docker image '$IMAGE_NAME' not found. Please build it first:"
  echo "    docker build -t $IMAGE_NAME ."
  exit 1
fi

PROJECT_DIR="$(pwd)"

# Ensure ~/.claude.json is a file, not a directory
if [ -d "$HOME/.claude.json" ]; then
  echo "❌ ~/.claude.json is a directory. Deleting and recreating as file."
  rm -r "$HOME/.claude.json"
  touch "$HOME/.claude.json"
elif [ ! -f "$HOME/.claude.json" ]; then
  touch "$HOME/.claude.json"
fi


# Ensure host config dirs exist
mkdir -p "$HOME/.claude"

# Run container with persistent login
docker run -it --rm \
  -v "$PROJECT_DIR":/app \
  -v "$HOME/.claude":/root/.claude \
  -v "$HOME/.claude.json":/root/.claude.json \
  "$IMAGE_NAME"
