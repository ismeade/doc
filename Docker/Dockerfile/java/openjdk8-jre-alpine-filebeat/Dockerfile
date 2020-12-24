FROM ismeade/java:openjdk8-jre-alpine
LABEL maintainer="yang.li@51vcheck.cn"

ENV SERVICE_NAME=unknown \
    LOG_PATH=/logs \
    LOGSTASH_HOST=

ADD ./filebeat-7.10.1-linux-x86_64.tar.gz / 
COPY ./entrypoint.sh /filebeat-7.10.1-linux-x86_64/entrypoint.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update-cache libc6-compat \
    && mv /filebeat-7.10.1-linux-x86_64 /filebeat \
    && chmod +x /filebeat/entrypoint.sh

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk update && \
    apk add --no-cache openjdk8 curl && \
    curl -O https://arthas.aliyun.com/arthas-boot.jar

# ENTRYPOINT [ "/filebeat/entrypoint.sh" ]