# Dockerfile
FROM node:18-slim

WORKDIR /app

RUN npm install -g @anthropic-ai/claude-code

CMD [ "bash" ]
