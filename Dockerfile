FROM debian:jessie
MAINTAINER a@b.com

ENV OPENFIRE_VERSION 4_0_3
ENV JAVA_HOME /opt/java

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y locales \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y wget postgresql \
  && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz -O /tmp/jdk-7u80-linux-x64.tar.gz \
  && wget "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}.tar.gz" -O /tmp/openfire_${OPENFIRE_VERSION}.tar.gz \
  && cd /opt && tar zxf /tmp/openfire_4_0_2.tar.gz \
  && tar zxf /tmp/jdk-7u80-linux-x64.tar.gz \
  && ln -s /opt/jdk1.7.0_80 /opt/java \
  && rm -rf /tmp/openfire_${OPENFIRE_VERSION}.tar.gz /tmp/jdk-7u80-linux-x64.tar.gz \
  && apt-get -y clean

ADD startup.bash /startup.bash
RUN chmod 755 /startup.bash

CMD ["/startup.bash"]

EXPOSE 3478
EXPOSE 3479
EXPOSE 5222
EXPOSE 5223
EXPOSE 5229
EXPOSE 5269
EXPOSE 7070
EXPOSE 7443
EXPOSE 7777
EXPOSE 9090
EXPOSE 9091
