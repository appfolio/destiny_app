# destiny_app

destiny_app is a web application security training tool with a focus on [ruby on rails](http://rubyonrails.org/) applications that can be run locally on your mac or most linux boxes. It covers relevant security issues from [OWASP's Top Ten Project](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) and the [Rails Security Guide](http://guides.rubyonrails.org/security.html) for rails 4.

When running in production you will need to set the following environment
variables.

- HOST (Host and port for confirmation email links to point to)
- PORT
- SECRET_KEY (Can be generated with `rake secret`)
- PEPPER
- GUARD_PASS

## Running Destiny with Docker

destiny_app has docker image builds, check out it's [docker hub page](https://registry.hub.docker.com/u/appfolio/destiny_app/).

Example docker run command (Don't forget to set those environment variables)

```bash
docker run -e HOST=$HOST \
		   -e PORT=$PORT \ 
		   -e SECRET_KEY=$SECRET_KEY \
		   -e PEPPER=$PEPPER \
		   -e GUARD_PASS=$GUARD_PASS \
		   -p 80:80 appfolio/destiny_app:prod > /dev/null &
```

If you want to run the app in development mode in a docker container (not recommended) you can use the following command. If you are using boot2docker the links in the confirmation email will point to localhost still, which won't work.

```bash
docker run -p 80:4000 -it appfolio/destiny_app:dev
```

## Experimenting with Sqlmap
After gaining a good understanding of the basics from the SQL Injection Reference you can learn about Sqlmap to get a thorough guideline for digging deeper into SQLI. Here's a sample command to run against destiny with Sqlmap. Your CSRF token in the header and session cookie will be different.

```bash
python sqlmap.py -u http://localhost:4000/sql_injection/where \
				 -t ex_traffic \
				 --data="column=" \
				 --headers="X-Requested-With: XMLHttpRequest\nX-CSRF-Token: +ZZhAHJpNbvD99YcQHSxNhp6pTn/ICaXzVcABMs1gRY=" \
				 --cookie="_destiny_app_session=R0ZoYzlHK3hMMzBjV004UHdUOXA2SVFCekNTdHVCUk96S2JSRUxkazFDc0d6eWxDaDE3TFJDQUlOdjU5TEFuREY2SW5LSkFwMzJjN0FSR3ZoZXdNOTdEL0NDcE5rdUczNnkvbmg2L1lGdWFrQTJyS3ZuamRId2g3L0h4d2dRTXJzTkpINUxZODN5dUFiOWxSS1dML2NXSkxla1FRZGRUb3VQSG9saTlzT0toZ0N2VUJnUXhWMFp5Qk92c0gvY2xGQ1lHTktweCtmM09veFVHMnp3MkRVVGo3dXA3NnZPamtIWEJUeGxtaHpjVUF0RDlGaXAvdVRQOTlYVUp1RjlSbkpxTnU5dDVGN2h6SlE1NTJtRi9VNUFVaUR6VzJiYTdRL0dsTitHWjZzRTBVNHYvZDI1M3EyUFZ0YlJ6bTFVMkZKd3ZlNUkyVjZxeFVHTm9YODBFb1N0K0NUNmphTlpyWDk2dHQ5UUVJbERFPS0tV2FacmhyUFdFaGpBaFcwRGszaGRpUT09--272dc3389c727588a9c642902b814b35c0fb6efc" \
				 --prefix="')" \
				 --delay="0.4" \
				 --string="success"

```
Sqlmap has a lot of great features that I leave to you to take a look into, check out the site [here](http://sqlmap.org/).

## Sources and Credit

destiny_app makes use of [phantomjs](https://github.com/ariya/phantomjs) with [poltergeist](https://github.com/teampoltergeist/poltergeist) and [capybara](https://github.com/jnicklas/capybara) to make the challenges section more interactive and realistic.

[![phantomjs](http://phantomjs.org/img/phantomjs-logo.png)](http://phantomjs.org/)

Sql Injection Reference section was inspired by the [Inject Some SQL](http://rails-sqli.org/) project.

Image used in Challenge taken from [Clip Art Lord](http://www.clipartlord.com/free-cartoon-castle-clip-art-2/).