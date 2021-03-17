# While there's the official image managed by Docker called 'rocket.chat', but we
# preferred to go to the official image maintained by Rocket.Chat maintainers itself
FROM rocketchat/rocket.chat:latest

# Not needed since these are on the image's Dockerfile
#ENV PORT 3000
#EXPOSE 3000

# just in case Railway is mighty sus for
# defaulting new apps to 'development'
ENV NODE_ENV production

# import these variables during build time
# --chown requires Docker 17.12 and works only on Linux
ADD envChecker.sh /app/envChecker.sh
RUN bash /app/envChecker.sh
