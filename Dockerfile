FROM node:20

ENV PATH="/home/claude/.local/bin:$PATH"

# Install Python and development tools
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
    pipx \
    git \
    curl \
    vim \
    nano \
    zsh \
    fzf \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add user and group "claude" with sudo access
RUN groupadd -g 1001 claude && \
    useradd -m -s /bin/bash -u 1001 -g claude claude && \
    echo "claude ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /app

RUN npm install -g @anthropic-ai/claude-code@latest
RUN claude update

# Fix permissions (especially needed for mounted volumes and copied files)
RUN chown -R claude:claude /home/claude

# Ensure /app directory has correct permissions
RUN mkdir -p /app && chown claude:claude /app

# Switch to claude user by default
USER claude

# Install uv
RUN pipx install uv

# Set default shell (optional but helps on bash-based entry)
ENV SHELL=/bin/bash

# Build arguments for API keys from .env file
ARG TAVILY_API_KEY
ARG REF_TOOLS_API_KEY


# Environment variables for API keys (from build args)
ENV TAVILY_API_KEY=$TAVILY_API_KEY
ENV REF_TOOLS_API_KEY=$REF_TOOLS_API_KEY

# Configure ZSH for better development experience
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
USER claude
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# Switch back to root for final setup
USER root
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Set default command for dev container
CMD ["/bin/bash"]
