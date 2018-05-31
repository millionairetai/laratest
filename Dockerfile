# Copyright (c) 2018  Project. All rights reserved.
# ---------------------------------------------------------------------------------------
# NOTICE:  All information contained herein is, and remains
# the property of Vietnam and its suppliers,
# if any.  The intellectual and technical concepts contained
# herein are proprietary to Vietnam
# and its suppliers and may be covered by Vietnamese Law,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from
# ---------------------------------------------------------------------------------------
# Author:
#       Tai Tran <tai.tran@gmail.com>
#Download base image ubuntu 16.04
FROM ubuntu:16.04
MAINTAINER Tai Tran <tai.tran@gmail.com>
 
# Install PHP and its modules
RUN apt-get update && apt-get install -y \
      php \
      libapache2-mod-php \
      php-mcrypt \
      php-mysql 

# Install modules of php
RUN apt-get install -y \
	    curl \
	    php-curl \
	    php7.0-mbstring

#Install tools to administrate
RUN apt-get install -y \
	    vim

#Install mysql server
ENV MYSQL_PWD 1234
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get install -y \ 
        mysql-server

#Install apache
RUN apt-get install -y \
		apache2

#Enable rewrite mode for apache
RUN a2enmod rewrite

#Grant authority for folder html
RUN chown -R www-data:www-data /var/www/html

# Override default configuration of apache, mysql and php
COPY misc/etc/php /etc/php/7.0/apache2
COPY misc/etc/apache2/sites-available /etc/apache2/sites-available
COPY misc/etc/mysql /etc/mysql/mysql.conf.d

#Enable site.
RUN a2ensite test.local.conf

#COPY src/wordpress/ /var/www/html/

ADD . .

# Chmod permission for source directory
RUN chmod +x misc/start.sh
RUN chmod +x misc/mysql.sh

#Run shell script
RUN misc/start.sh
RUN misc/mysql.sh

#Run necessary configuration.
#RUN misc/start.sh


# Volume configuration
# Declare working directory and mount volume
WORKDIR /www
VOLUME ["/www"]

# Expose a default port for apache2
EXPOSE 80 3306

COPY misc/start-container.sh /

#Run some configuration on starting container.
ENTRYPOINT ["/start-container.sh"]

# Starting point
#CMD ["/bin/bash"]
