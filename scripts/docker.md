## Running Destiny with Docker

destiny_app has docker image builds, check out it's [docker hub page](https://registry.hub.docker.com/u/appfolio/destiny_app/).

Example docker run command (Don't forget to set those environment variables)

```bash
docker run -e HOST=$HOST \
           -e PORT=$PORT \
           -e SECRET_KEY_BASE=$SECRET_KEY_BASE
           -e SECRET_KEY=$SECRET_KEY \
           -e PEPPER=$PEPPER \
           -e GUARD_PASS=$GUARD_PASS \
           -e ALLOW_REGISTRATION=$ALLOW_REGISTRATION \
           -p 80:80 appfolio/destiny_app:prod > /dev/null &
```

If you want to run the app in development mode in a docker container (not recommended) you can use the following command. If you are using boot2docker the links in the confirmation email will point to localhost still, which won't work.

```bash
docker run -p 80:4000 -it appfolio/destiny_app:dev
```
