#setting up your own google api keys for oauth
#setup your own credentials
#https://console.developers.google.com
#add them to config/google_oauth_secrets.yml

GUARD_PASS="guardpassword"
HOST="localhost"
PORT="4000"
ALLOW_REGISTRATION="TRUE"

rails s -e development -p $PORT
