# Dockerfile for destiny_app:general_build
# This is meant to not contain user specific secrets
# Create your own specific image with you credentials from this image
FROM myanaros/ruby:2.3.0
MAINTAINER Mark Yanaros <mark.yanaros@gmail.com>

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/destiny_app
WORKDIR /usr/src/destiny_app

###########################################
### INSTALL Services ######################
###########################################
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -q -y install mysql-server
RUN apt-get -q -y install supervisor
RUN apt-get -q -y install cron
RUN ["/bin/bash", "-c", "debconf-set-selections <<< \"postfix postfix/mailname string destiny_app.com\" && \
debconf-set-selections <<< \"postfix postfix/main_mailer_type string 'Internet Site'\" && \
apt-get install -y postfix"]

###########################################
### INSTALL Application ###################
###########################################
RUN cd /usr/src && git clone https://github.com/appfolio/destiny_app.git

###########################################
### SET users, groups and permissions #####
###########################################
RUN groupadd rails-setup
RUN useradd -ms /bin/bash destiny-setup
RUN usermod -a -G rails-setup destiny-setup
RUN chgrp -R rails-setup /usr/local/bundle
RUN chmod -R 775 /usr/local/bundle/
RUN chown -R destiny-setup .

###########################################
### BUNDLE rails application ##############
### MIGRATE rails db         ##############
###########################################
USER destiny-setup
RUN bundle install
USER root
RUN service mysql start && \
    su - destiny-setup && rake db:create && rake db:migrate
