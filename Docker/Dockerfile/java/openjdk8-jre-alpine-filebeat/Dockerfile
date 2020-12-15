FROM ismeade/java:openjdk8-jre-alpine
LABEL maintainer="yang.li@51vcheck.cn"

COPY ./run.sh /tmp/run.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update-cache curl libc6-compat && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.1-linux-x86_64.tar.gz && \
    tar xzvf filebeat-7.10.1-linux-x86_64.tar.gz -C / && \
    apk del curl && \
    rm filebeat-7.10.1-linux-x86_64.tar.gz && \
    chmod +x /tmp/run.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

EXPOSE 8080
