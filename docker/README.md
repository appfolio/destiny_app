# destiny_app with Docker

destiny_app has docker image builds, check out it's [docker hub page](https://hub.docker.com/r/myanaros/destiny_app/tags/).

#####Make sure you have Docker [installed](https://www.docker.com/products/docker).

You can build your own image if you want to copy over allowed_domains and/or google\_oauth\_secrets.yml

## Quick Start

After making sure Docker is installed, pull the docker image...

`
docker pull myanaros/destiny_app:general
`

Start the docker container with one of the two following commands...

`./scripts/launch_container_linux.sh` for docker with Linux


*OR*

`./scripts/launch_container_osx.sh` for docker with OSX


Visit the URL echo'd by the respective launch script and have fun!


## Building your own Docker image

You can use the [myanaros/destiny_app:general](https://hub.docker.com/r/myanaros/destiny_app/tags/) docker image as a base to build your own image from.

Place your own allowed\_domains.yml and google_oauth\_secrets.yml in the same directory as your Dockerfile.

Here is an example Dockerfile...

```
# Dockerfile for [Your docker image name here]
FROM myanaros/destiny_app:general 
MAINTAINER [Your name here] <[Your email here]> 
 
########################################### 
###  COPY over configuration files  ####### 
########################################### 
COPY google_oauth_secrets.yml /usr/src/destiny_app/config/google_oauth_secrets.yml 
COPY allowed_domains.yml /usr/src/destiny_app/config/allowed_domains.yml 
 
RUN chown root setup.sh && chmod 700 setup.sh 
 
########################################### 
###  SETUP production environment ######### 
########################################### 
# Bogus rails secret in ENV for rake task only
RUN service mysql start && \ 
    su - destiny-setup && \ 
    PEPPER="NOTPERSISTENT" SECRET_KEY="NOTPERSISTENT" \ 
    RAILS_ENV=production rake db:migrate 
 
########################################### 
### START mysql and rails application ##### 
########################################### 
EXPOSE 80 
cmd ./setup.sh 2> /dev/null && \ 
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf 

```

Then run the following command to build your docker image...

`build -t [your docker image name here] .`

*IMPORTANT*:
Modify the launch_container\_* scripts in the scripts/ directory to use your docker image instead of the default ones.

```
...
#Inside your launch script
IMAGE_NAME="[image name here]"
...
```

You can find the Dockerfiles for the myanaros/destiny\_app related images here in the docker/ directory. (Built in this order: ruby:2.3.0 -> destiny\_app:general\_build -> destiny_app:general)

*PRO TIP*: you can run the clean_docker.sh script to make sure your storage doesn't get taken up by all the containers you start.
