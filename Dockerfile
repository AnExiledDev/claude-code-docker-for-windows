FROM node:20

ENV PATH="/home/claude/.local/bin:$PATH"

# Install Python 3.13 from source (since it's not in Debian repos)
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3.11 \
    python3-pip \
    pipx

# Add user and group "claude"
RUN groupadd -g 1001 claude && \
    useradd -m -s /bin/bash -u 1001 -g claude claude

# Set working directory in claude's home
WORKDIR /home/claude/app

RUN npm install -g @anthropic-ai/claude-code@latest
RUN claude update

# Fix permissions (especially needed for mounted volumes and copied files)
RUN chown -R claude:claude /home/claude

# Switch to claude user by default
USER claude

# Install uv
RUN pipx install uv

# Set default shell (optional but helps on bash-based entry)
ENV SHELL=/bin/bash
