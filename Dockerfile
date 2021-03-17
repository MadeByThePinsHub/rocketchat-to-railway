FROM node:12.21.0-buster-slim

LABEL maintainer="buildmaster@rocket.chat"

# dependencies
RUN groupadd -g 65533 -r rocketchat \
    && useradd -u 65533 -r -g rocketchat rocketchat \
    && git clone -b master https://github.com/RocketChat/Rocket.Chat.git /app \
    && chowon rocketchat:rocketchat /app \
    && mkdir -p /app/uploads \
    && chown rocketchat:rocketchat /app/uploads \
    && apt-get update \
    && apt-get install -y --no-install-recommends fontconfig \
    && curl https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

RUN aptMark="$(apt-mark showmanual)" \
    && apt-get install -y --no-install-recommends g++ make python ca-certificates \
    && cd /app/bundle/programs/server \
    && npm install \
    && apt-mark auto '.*' > /dev/null \
    && apt-mark manual $aptMark > /dev/null \
    && find /usr/local -type f -executable -exec ldd '{}' ';' \
       | awk '/=>/ { print $(NF-1) }' \
       | sort -u \
       | xargs -r dpkg-query --search \
       | cut -d: -f1 \
       | sort -u \
       | xargs -r apt-mark manual \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && npm cache clear --force

USER rocketchat

VOLUME /app/uploads

## Do build here
RUN meteor build --server-only --directory /app/build-ci \
    && cd /app/build-ci/bundle/programs/server \
    && npm install \
    && mv -vf /app/build-ci/bundle/ /app/bundle/

WORKDIR /app/bundle

ENV DEPLOY_METHOD=docker \
    NODE_ENV=production \
    HOME=/tmp \
    PORT=3000 \
    Accounts_AvatarStorePath=/app/uploads

EXPOSE 3000

# import these variables during build time
# --chown requires Docker 17.12 and works only on Linux
ADD envChecker.sh /app/envChecker.sh
RUN bash /app/envChecker.sh && echo "DB URL Validator: ${MONGO_URL}" && echo "DB URL Validator: ${MONGO_OPLOG_URL}"

CMD ["node", "main.js"]
