FROM logstash:7.10.1
LABEL maintainer="yang.li@51vcheck.cn"

COPY ./logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./file.conf /usr/share/logstash/conf.d/file.conf

USER root