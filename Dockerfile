FROM debian:jessie

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y open-cobol apache2
RUN a2enmod cgid

RUN mkdir /cobol
ADD files/gnucobolcgi.cob /cobol/
ADD files/rest.cob /cobol/

WORKDIR /cobol
RUN cobc -x gnucobolcgi.cob
RUN cobc -free -x rest.cob
RUN cp gnucobolcgi /usr/lib/cgi-bin/
RUN cp rest /usr/lib/cgi-bin/

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
RUN mkdir /var/lock/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
RUN mkdir /var/run/apache2
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid

EXPOSE 80

CMD /usr/sbin/apache2 -D FOREGROUND
