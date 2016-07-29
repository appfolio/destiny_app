#You can pass in other arguments for the rails command as you see fit

export GUARD_PASS="rakesecretthis"
export PORT="4000"
export ALLOW_REGISTRATION="FALSE"

rails s -e production -p $PORT
