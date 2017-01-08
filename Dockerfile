FROM debian:jessie

MAINTAINER t0kx <t0kx@protonmail.ch>

# install debian stuff
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget apache2 php5 gcc make \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# configure vuln application
RUN wget ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz && \
    tar xfz proftpd-1.3.5.tar.gz && \
    cd proftpd-1.3.5 && \
    ./configure --with-modules=mod_copy && \
    make && make install

RUN chmod 777 -R /var/www/html/

EXPOSE 21 80

COPY main.sh /
ENTRYPOINT ["/main.sh"]
CMD ["default"]
