#!/bin/bash

# Minimal setup for dev containers
# Only creates essential directories and symlinks

# Create directories with proper permissions
mkdir -p /app/.claude
mkdir -p /app/.serena
chmod 755 /app/.claude
chmod 755 /app/.serena

# Create symlinks for persistent configuration
# Use -f flag to overwrite if they already exist
ln -sf /app/.claude ~/.claude
ln -sf /app/.serena ~/.serena

echo "Dev container setup complete - directories and symlinks created"