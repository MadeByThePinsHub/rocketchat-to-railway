# Rocket.Chat to Railway

An repo for easily deploying Rocket.Chat into Railway using Dockerfiles.

The reason why we made this is [forking the official repo](https://github.com/RocketChat/Rocket.Chat) and deploying into Railway can be an distater due to the missing `meteror`
executable.

## Setup

### One-Click Deploy

1. Click the **Deploy on Railway** below to get started.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new?template=https%3A%2F%2Fgithub.com%2FMadeByThePinsHub%2Frocketchat-to-railway%2Ftree%2Fmain&plugins=mongodb&envs=MONGO_OPLOG_URL%2CROOT_URL&MONGO_OPLOG_URLDesc=Replicaset+MongoDB+for+replicating+Rocket.Chat+DB+data.+Can+be+also+your+MongoDB+in+another+project+or+elsewhere%2C+so+please+replace+the+placeholder+with+real+values.+This+is+required+as+per+Rocket.Chat+Docs.&ROOT_URLDesc=The+root+URL+of+your+shiny+Rocket.Chat+instance.+If+using+custom+domain%2C+make+sure+you+edit+your+deploy+domains+first%21+Please+don%27t+use+the+placeholder+URL+as+Rocket.Chat+may+eject+instead+of+starting+up.&MONGO_OPLOG_URLDefault=mongodb%3A%2F%2Fuser%3Apass%40your-mongodb-instance.here.dev&ROOT_URLDefault=https%3A%2F%2Fsome-random-sus.webapp.io)

2. In the `Where should the new repo live?`, leave it as is. If you created that
repo, see next section instead. You can also create a new repo to your GitHub org
instead.

3. Confirgure environment variables as you like. Here are some docs:
    - Replace the value of `MONGO_OPLOG_URL` with the MongoDB URL of your instance.
    It can be your other Railway project if you want.
    - For the `ROOT_URL`, if you planning to use custom domain, then please
    replace the placeholder with real values. Otherwise,
    make sure you remove the `ROOT_URL` variable in the **Variables** page.

4. Hit **deploy** and cross your fingers! Railway should redirect you into your
shiny app dashboard for your Rocket.Chat instance.

5. Navigate into the **Deployments** screen and check if the latest deployment is now `Deployed`.
If stuck at `Deploying` after few minutes, check the logs then [file a new issue here](https://github.com/MadeByThePinsHub/rocketchat-to-railway/issues/new).
If it's configuration problem on your variables, fix it first.

6. Visit your Rocket.Chat instance and register. The first user to be registered should automatically
granted adminstrative powers.

7. Profit!

### Manual

WIP

## Known Issues

- Rocket.Chat requires either oplog or replicaset to run, as per <https://docs.rocket.chat/installation/manual-installation/mongo-replicas/>. The only current workaround is setup another MongoDB instance in another Railway project or elsewhere with replicaset enabled.
And since this is untested on Railway-hosted MongoDB instances, prepare for the worst case scenario.
