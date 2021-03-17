# minimun: node v12.21.0
# recommended: latest LTS, as possible
FROM node:14-buster-slim

LABEL maintainer="Docker Images Builders <releases@madebythepins.tk>"

# install deps as per manual install for Debian
RUN apt-get update && apt-get install -y \
    build-essential graphicsmagick \
    ca-certificates fontconfig \
    # clean up apt lists cache after installing deps
    && rm -rf /var/lib/apt/lists/*

# Download latest release from the Releases API
RUN curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz \
    && tar -xzf /tmp/rocket.chat.tgz -C /app

RUN groupadd -g 65533 -r rocketchat \
    && useradd -u 65533 -r -g rocketchat rocketchat \
    && mkdir -p /app/uploads \
    && chown rocketchat:rocketchat /app/uploads \
    && chown rocketchat:rocketchat /app

USER rocketchat

VOLUME /app/uploads

# install modules, since we don't need to mess up
# with chown again.
RUN cd /app/bundle/programs/server && npm install

ENV DEPLOY_METHOD=docker \
    NODE_ENV=production \
    HOME=/tmp \
    PORT=3000 \
    Accounts_AvatarStorePath=/app/uploads

RUN groupadd -g 65533 -r rocketchat \
    && useradd -u 65533 -r -g rocketchat rocketchat \
    && mkdir -p /app/uploads \

WORKDIR /app/bundle

EXPOSE 3000

# import these variables during build time
ADD envChecker.sh /app/envChecker.sh
ADD run-server.sh /app/run-server.sh

CMD ["bash", "/app/run-server.sh"]
