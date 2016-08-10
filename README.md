# destiny_app

destiny_app is a web application security training tool with a focus on [ruby on rails](http://rubyonrails.org/) applications that can be ran locally on your mac or linux box. It covers relevant security issues from [OWASP's Top Ten Project](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) and the [Rails Security Guide](http://guides.rubyonrails.org/security.html) for rails 4. It also has [Docker images](docker/) that are plug and play!

## Quick Start

Prereqs: _install ruby, rails, and mysql for this app to work without modification._ (using the [Docker images](docker/) may be easier and quicker)

You can run the rails destiny_app locally by...

`git clone git@github.com:appfolio/destiny_app.git`

`cd destiny_app && bundle`

`rake db:create && rake db:migrate`

`./script/start_dev`

And navigating to http://localhost:4000

###Google API Keys

[Setup your own keys for google oauth](https://github.com/zquestz/omniauth-google-oauth2#google-api-setup) at the [Google Developer Console](https://console.developers.google.com)

With the Authorized redirect URI as `http://localhost:4000/users/auth/google_oauth2/callback`

Place the credentials in config/google\_oauth_secrets.yml

```yaml
#config/google_oauth_secrets.yml

client_id: "your-credentials.apps.googleusercontent.com"
client_secret: "yoursecret"
```



## Running destiny_app in production

When running in production you will need to set the following environment
variables.

- HOST
- PORT
- SECRET\_KEY_BASE (Can be generated with `rake secret`)
- SECRET_KEY (Can be generated with `rake secret`)
- PEPPER (Can be generated with `rake secret`)
- GUARD_PASS (Can be generated with `rake secret`)


Additional parameters that you can set in all environments...

- ALLOW_REGISTRATION (FALSE by default)
	* TRUE allows registration through registerable and omniauthable.
	* FALSE allows registration through omniauthable only.

YAML Files you may want to modify...

- allowed_domains.yml (will only be applied in production environment)
	* Contains an array of strings that are domains that users are allowed to authenticate through omniauthable from. The default domain is "gmail.com", so everyone with an address ending in that will be able to authenticate.

## Experimenting with Sqlmap
After gaining a good understanding of the basics from the SQL Injection Reference you can learn about Sqlmap to get a thorough guideline for digging deeper into SQLI. Here's a sample command to run against destiny_app with Sqlmap. Your CSRF token in the header and session cookie will be different.

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
Sqlmap has a lot of great features, check out the site [here](http://sqlmap.org/).

## Sources and Credit

destiny_app makes use of [phantomjs](https://github.com/ariya/phantomjs) with [poltergeist](https://github.com/teampoltergeist/poltergeist) and [capybara](https://github.com/jnicklas/capybara) to make the challenges section more interactive and realistic.

[![phantomjs](http://phantomjs.org/img/phantomjs-logo.png)](http://phantomjs.org/)

Sql Injection Reference section was inspired by the [Inject Some SQL](http://rails-sqli.org/) project.

Image used in Challenge taken from [Clip Art Lord](http://www.clipartlord.com/free-cartoon-castle-clip-art-2/).