# destiny_app

destiny_app is a web application security training tool with a focus on [ruby on rails](http://rubyonrails.org/) applications that can be run locally on your mac or most linux boxes. It covers relevant security flaws from [OWASP's Top Ten Project](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) and the [Rails Security Guide](http://guides.rubyonrails.org/security.html) for rails 4.

When running in production you will need to set the following environment
variables.

- HOST (Host and port for confirmation email links to point to)
- PORT
- SECRET_KEY (Can be generated with `rake secret`)
- PEPPER
- GUARD_PASS

destiny_app has docker image builds, check out it's [docker hub page](https://registry.hub.docker.com/u/appfolio/destiny_app/).

Example docker run command

```bash
docker run -e HOST=$HOST \
		   -e PORT=$PORT \ 
		   -e SECRET_KEY=$SECRET_KEY \
		   -e PEPPER=$PEPPER \
		   -e GUARD_PASS=$GUARD_PASS \
		   -p 80:80 appfolio/destiny_app:prod > /dev/null &
```

## Sources and Credit

destiny_app makes use of [phantomjs](https://github.com/ariya/phantomjs) with [poltergeist](https://github.com/teampoltergeist/poltergeist) and [capybara](https://github.com/jnicklas/capybara) to make the challenges section more interactive and realistic.

[![phantomjs](http://phantomjs.org/img/phantomjs-logo.png)](http://phantomjs.org/)