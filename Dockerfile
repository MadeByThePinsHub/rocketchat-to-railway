# While there's the official image managed by Docker called 'rocket.chat', but we
# preferred to go to the official image maintained by Rocket.Chat maintainers itself
FROM rocketchat/rocket.chat:latest

ENV PORT 3000
EXPOSE 3000

# just in case Railway is mighty sus for
# defaulting new apps to 'development'
ENV NODE_ENV production