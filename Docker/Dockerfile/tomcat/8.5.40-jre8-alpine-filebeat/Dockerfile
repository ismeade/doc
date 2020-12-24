# Version 1.0.0
FROM tomcat:8.5.40-jre8-alpine
LABEL maintainer="yang.li@51vcheck.cn"

ENV LANG=C.UTF-8 \ 
    SERVICE_NAME=tomcat \
    LOG_PATH=/usr/local/tomcat/logs \
    LOGSTASH_HOST=

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
    apk add --no-cache --update-cache bash tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /usr/local/tomcat/webapps/* && \
    sed -i '249a\JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Duser.timezone=GMT+08"' /usr/local/tomcat/bin/catalina.sh && \
    sed -i '20a\<Resources cachingAllowed="true" cacheMaxSize="102400" />' /usr/local/tomcat/conf/context.xml 

ADD ./filebeat-7.10.1-linux-x86_64.tar.gz / 
COPY ./entrypoint.sh /filebeat-7.10.1-linux-x86_64/entrypoint.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

RUN apk add --update-cache libc6-compat \
    && mv /filebeat-7.10.1-linux-x86_64 /filebeat \
    && chmod +x /filebeat/entrypoint.sh

# ADD ./arthas-packaging-3.4.5-bin.zip /

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk update && \
    apk add --no-cache openjdk8 curl && \
    curl -O https://arthas.aliyun.com/arthas-boot.jar

EXPOSE 8080 