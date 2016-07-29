SECRET_KEY_BASE=$(rake secret)
SECRET_KEY=$(rake secret)
PEPPER=$(rake secret)
GUARD_PASS=$(rake secret)
HOST="localhost"
PORT="80"
ALLOW_REGISTRATION="TRUE"

IMAGE_NAME="myanaros/destiny_app:general"

echo -e "Launching docker container from $IMAGE_NAME image on http://$HOST:$PORT"

docker run -e HOST=$HOST \
           -e PORT=$PORT \
           -e SECRET_KEY_BASE=$SECRET_KEY_BASE \
           -e SECRET_KEY=$SECRET_KEY \
           -e PEPPER=$PEPPER \
           -e GUARD_PASS=$GUARD_PASS \
           -e ALLOW_REGISTRATION=$ALLOW_REGISTRATION \
           -p $PORT:$PORT $IMAGE_NAME > /dev/null &
