#You can pass in other arguments for the rails command as you see fit

export GUARD_PASS="place-your-rake-secret-here-6a7b5d6a898503b25"
export PORT="4000"
export ALLOW_REGISTRATION="FALSE"
export SECRET_KEY_BASE="place-your-rake-secret-here-6a7b5d6a898503b26"
export SECRET_KEY="place-your-rake-secret-here-6a7b5d6a898503b27"
export PEPPER="place-your-rake-secret-here-6a7b5d6a898503b28"

rails s -e production -p $PORT
