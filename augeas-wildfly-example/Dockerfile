FROM jboss/wildfly

MAINTAINER Luciano Mores

USER root

RUN mkdir /augeas-conf

ADD augeas-conf /augeas-conf/
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
