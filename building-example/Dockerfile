FROM ubuntu:14.04

RUN mkdir -p /data

ADD entrypoint.sh /
ADD config-example.xml /data/

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
