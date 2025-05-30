# 📦 Claude Code Docker Wrapper

A lightweight, dependency-free way to run [Claude Code CLI](https://www.anthropic.com/index/claude-code) using Docker — no need for `node`, `npm`, or global installations.

> ✅ Ideal for developers who prefer **not to pollute their local environment** with NodeJS-based dependencies.

---

## 🚀 Features

- Run Claude CLI in **any project folder** using `run-claude`
- Works on **Linux, macOS, WSL**, or any system with Docker
- CLI login and API session are **persisted across runs**
- Mounts current directory into the container for context-aware use

---

## 🧱 Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- Bash shell (`bash`, `zsh`, or similar)

---

## 🔧 Installation

```bash
git clone https://github.com/kristijansoldo/claude-code-docker.git
cd claude-code-docker
chmod +x install.sh run-claude.sh
./install.sh
```

This will create a global `run-claude` command available from any directory.

---

## 🛠️ First-time setup

After installation:

```bash
cd /path/to/your/project
run-claude
```

Inside the container:

```bash
claude login
```

Your login will be stored locally in `~/.claude` and reused for future sessions.

---

## 🧪 Example usage

From any project folder:

```bash
run-claude
```

Then:

```bash
claude ask "What does this repo do?"
```

Claude will analyze your mounted code and answer contextually.

---

## 🔁 Rebuilding the Docker image

If you ever need to rebuild the image (e.g. after modifying the Dockerfile):

```bash
docker build -t claude-code-cli .
```

---

## 📁 Folder Structure

```
claude-code-docker/
├── Dockerfile         # Defines the Node environment and installs Claude CLI
├── install.sh         # Installs 'run-claude' globally via symlink
├── run-claude.sh      # Main script that launches Claude CLI container
└── README.md
```

---

## 🧹 Uninstall (optional)

If you want to remove everything:

```bash
sudo rm /usr/local/bin/run-claude
docker rmi claude-code-cli
rm -rf ~/.claude ~/.claude.json
```
