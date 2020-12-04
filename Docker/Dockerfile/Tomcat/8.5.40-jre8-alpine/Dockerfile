# Version 1.0.0
FROM tomcat:8.5.40-jre8-alpine
LABEL maintainer="yang.li@51vcheck.cn"

RUN rm -rf /usr/local/tomcat/webapps/*
# ADD ./ROOT/ /usr/local/tomcat/webapps/ROOT/
# ADD ./server.xml /usr/local/tomcat/conf/server.xml
# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG=C.UTF-8

RUN apk add --no-cache --update-cache bash tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

RUN sed -i '249a\JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Duser.timezone=GMT+08"' /usr/local/tomcat/bin/catalina.sh && \
    sed -i '20a\<Resources cachingAllowed="true" cacheMaxSize="102400" />' /usr/local/tomcat/conf/context.xml


EXPOSE 8080
# ADD ./run.sh /usr/local/tomcat/bin/run.sh
# RUN chmod +x /usr/local/tomcat/bin/run.sh
# CMD ["sh", "/usr/local/tomcat/bin/run.sh"]
