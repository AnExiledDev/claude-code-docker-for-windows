FROM node:20

# Add user and group "claude"
RUN groupadd -g 1001 claude && \
    useradd -m -s /bin/bash -u 1001 -g claude claude

# Set working directory in claude's home
WORKDIR /home/claude/app

RUN npm install -g @anthropic-ai/claude-code@latest
RUN claude update

# Copy app files (adjust this if your actual files go somewhere else)
COPY . .

# Fix permissions (especially needed for mounted volumes and copied files)
RUN chown -R claude:claude /home/claude

# Switch to claude user by default
USER claude

# Set default shell (optional but helps on bash-based entry)
ENV SHELL=/bin/bash
