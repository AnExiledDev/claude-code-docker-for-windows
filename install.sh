#!/bin/bash

set -e

SCRIPT_NAME="run-claude"
SOURCE_PATH="$(pwd)/run-claude.sh"
TARGET_PATH="/usr/local/bin/$SCRIPT_NAME"

echo "🛠 Installing Claude CLI wrapper (symbolic link only)"

# 1. Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "❌ Docker is not installed. Please install Docker and try again."
  exit 1
fi

# 2. Verify the source script exists
if [ ! -f "$SOURCE_PATH" ]; then
  echo "❌ Source script not found at: $SOURCE_PATH"
  echo "Please run this script from the directory where 'run-claude.sh' exists."
  exit 1
fi

# 3. Create a symbolic link in /usr/local/bin
echo "🔗 Creating symbolic link: $TARGET_PATH → $SOURCE_PATH"
sudo ln -sf "$SOURCE_PATH" "$TARGET_PATH"

# 4. Ensure the source script is executable
chmod +x "$SOURCE_PATH"

# 5. Done
echo "✅ Installed successfully!"
echo "You can now use the command: run-claude"
echo "Just type it from any directory to launch Claude CLI inside Docker."
