# Version 1.0.0
FROM tomcat:8.5.40-jre8-alpine
LABEL maintainer="yang.li@51vcheck.cn"

ENV LANG=C.UTF-8 \ 
    SERVICE_NAME=tomcat \
    LOGSTASH_HOST=

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
    apk add --no-cache --update-cache bash tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /usr/local/tomcat/webapps/* && \
    sed -i '249a\JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Duser.timezone=GMT+08"' /usr/local/tomcat/bin/catalina.sh && \
    sed -i '20a\<Resources cachingAllowed="true" cacheMaxSize="102400" />' /usr/local/tomcat/conf/context.xml 

COPY ./run.sh /tmp/run.sh
RUN apk add --update-cache libc6-compat && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.1-linux-x86_64.tar.gz && \
    tar xzvf filebeat-7.10.1-linux-x86_64.tar.gz -C / && \
    rm filebeat-7.10.1-linux-x86_64.tar.gz && \
    chmod +x /tmp/run.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

EXPOSE 8080 

# ENTRYPOINT ["sh", "/tmp/run.sh"]
# ADD ./run.sh /usr/local/tomcat/bin/run.sh
# RUN chmod +x /usr/local/tomcat/bin/run.sh
# CMD ["sh", "/usr/local/tomcat/bin/run.sh"]
