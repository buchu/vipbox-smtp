
FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update \
    && apt-get -y install supervisor postfix sasl2-bin opendkim opendkim-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Add files
ADD assets/filter.py /etc/postfix/filter.py 
ADD assets/install.sh /opt/install.sh

EXPOSE 25/tcp
CMD /opt/install.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
