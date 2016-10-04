FROM debian:jessie
MAINTAINER a@b.com

ENV OPENFIRE_VERSION 4_0_3 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire
ENV JAVA_HOME /opt/java

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y locales \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre
RUN wget "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}.tar.gz" -O /tmp/openfire_${OPENFIRE_VERSION}.tar.gz
RUN tar zxf /tmp/openfire_${OPENFIRE_VERSION}.tar.gz
RUN rm -rf /tmp/openfire_${OPENFIRE_VERSION}.tar.gz
RUN apt-get -y clean

ADD startup.bash /startup.bash
RUN chmod 755 /startup.bash

CMD ["/startup.bash"]

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 5269/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
