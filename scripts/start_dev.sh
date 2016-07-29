#You can pass in other arguments for the rails command as you see fit

export PORT="4000"
export ALLOW_REGISTRATION="TRUE"

rails s -e development -p $PORT
