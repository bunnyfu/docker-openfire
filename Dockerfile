FROM debian:jessie
MAINTAINER sameer@damagehead.com

ENV OPENFIRE_VERSION=4.0.3 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire

RUN apt-get update && apt-get install -y apt-transport-https
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre
RUN cd /tmp
RUN wget -O openfire.deb https://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb
RUN dpkg -i openfire.deb
RUN mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin
RUN rm -rf openfire_${OPENFIRE_VERSION}_all.deb
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
