# Dockerfile for destiny_app:general
# This is meant to be modified by users to create their own specific docker image
# for destiny. Run this docker file from a directory containing the files
# to be copied over (google_oauth_secrets.yml and allowed_domains are optional)
FROM myanaros/destiny_app:general_build
MAINTAINER Mark Yanaros <mark.yanaros@gmail.com>

###########################################
###  COPY over configuration files  #######
###########################################
COPY setup.sh /usr/src/destiny_app/setup.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY google_oauth_secrets.yml /usr/src/destiny_app/config/google_oauth_secrets.yml
#COPY allowed_domains.yml /usr/src/destiny_app/config/allowed_domains.yml

RUN chown root setup.sh && chmod 700 setup.sh

###########################################
###  SETUP production environment #########
###########################################
# Random rails secret will be generated in ENV for rake tasks
RUN service mysql start && \
    su - destiny-setup && \
    PEPPER="NOTPERSISTENT" SECRET_KEY="NOTPERSISTENT" \
    RAILS_ENV=production rake db:create ; \
    PEPPER="NOTPERSISTENT" SECRET_KEY="NOTPERSISTENT" \
    RAILS_ENV=production rake db:migrate

###########################################
### START mysql and rails application #####
###########################################
EXPOSE 80
cmd ./setup.sh 2> /dev/null && \
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
