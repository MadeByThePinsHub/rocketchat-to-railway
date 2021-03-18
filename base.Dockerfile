# minimun: node v12.21.0
# recommended: latest LTS, as possible
FROM node:14-buster-slim

LABEL maintainer="Docker Images Builders <releases@madebythepins.tk>"

# install deps as per manual install for Debian
RUN apt-get update && apt-get install -y \
    build-essential graphicsmagick \
    ca-certificates fontconfig curl \
    # clean up apt lists cache after installing deps
    && rm -rf /var/lib/apt/lists/*

# Download latest release from the Releases API
RUN curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz \
    && mkdir /app \
    && tar -xzf /tmp/rocket.chat.tgz -C /app

RUN groupadd -g 65533 -r rocketchat \
    && useradd -u 65533 -r -g rocketchat rocketchat \
    && mkdir -p /app/uploads \
    && chown rocketchat:rocketchat /app/uploads \
    && chown rocketchat:rocketchat /app

USER rocketchat

# install modules, since we don't need to mess up
# with chown again.
WORKDIR /app/bundle/programs/server
RUN npm install

ENV DEPLOY_METHOD=docker \
    NODE_ENV=production \
    HOME=/tmp \
    PORT=3000 \
    Accounts_AvatarStorePath=/app/uploads
