FROM nginx:1.19.5-alpine
LABEL maintainer="yang.li@51vcheck.cn"

# 修改时区
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
    apk add --no-cache --update-cache bash tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

ENV LANG=C.UTF-8 \ 
    SERVICE_NAME=tomcat \
    LOG_PATH=/usr/local/tomcat/logs \
    LOGSTASH_HOST=

ADD ./filebeat-7.10.1-linux-x86_64.tar.gz / 
COPY ./entrypoint.sh /filebeat-7.10.1-linux-x86_64/entrypoint.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

RUN apk add --update-cache libc6-compat \
    && mv /filebeat-7.10.1-linux-x86_64 /filebeat \
    && chmod +x /filebeat/entrypoint.sh