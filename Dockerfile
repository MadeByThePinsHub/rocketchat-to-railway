# For stablility reasons, we want to use the official image
# maintained by Docker comittee, but we preferred to use
# the official image managed by Rocket.Chat maintainers
# itself.
FROM rocket.chat:latest

WORKDIR /app/bundle

# import these variables during build time
ADD envChecker.sh /app/envChecker.sh
#ADD run-server.sh /app/run-server.sh

# pull build arguments here
# to ensure that our build pass, we copied the defaults
# from upstream-image-repo-source:master/.docker/Dockerfile
ARG MONGO_URL
ARG MONGO_OPLOG_URL
ARG ROOT_URL
ENV MONGO_URL=${MONGO_URL:-mongodb://mongo:27017/rocketchat} \
    ROOT_URL=${ROOT_URL:-http://localhost:300} \
    MONGO_OPLOG_URL=${MONGO_OPLOG_URL}

RUN bash /app/envChecker.sh
