```sh
# 1.编译项目
$mvn clean package 
# 2.制作Images
$docker build -t registry.cn-beijing.aliyuncs.com/vcheck/munichre-mall:1.0-beta -f docker/Dockerfile .
# 3.设置标签 ImageId:镜像id 通过docker images查看， 镜像版本号:设置该镜像的版本
$docker tag registry.cn-beijing.aliyuncs.com/vcheck/munichre-mall:1.0-beta registry.cn-beijing.aliyuncs.com/vcheck/munichre-mall:1.0-beta
# 4.登录阿里云容器服务 不用每次登陆
$docker login --username=北京人人检 registry.cn-beijing.aliyuncs.com
# 5.推送镜像到阿里云容器服务
$docker push registry.cn-beijing.aliyuncs.com/vcheck/munichre-mall:1.0-beta
```

```Dockerfile tomcat
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

# ENTRYPOINT  不会被run命令覆盖
```

```Dockerfile munichre-mall
FROM registry.cn-beijing.aliyuncs.com/vcheck/tomcat:8.5.40-jre8-alpine
LABEL maintainer="yang.li@51vcheck.cn"

ENV ACTIVE uat

COPY ./docker/run.sh /usr/local/tomcat/bin/run.sh
RUN chmod +x /usr/local/tomcat/bin/run.sh
RUN wget http://gosspublic.alicdn.com/ossutil/1.7.0/ossutil64 && \
    chmod 755 ossutil64 && \
    ./ossutil64 config -e oss-cn-beijing-internal.aliyuncs.com -i LTAI4G2wSDchDfDzr1WN4ab2 -k b4MfNt4dcFfmWvcFrx5k4jaH27xTD7

#EXPOSE 8080

COPY ../target/mz-mall/ /usr/local/tomcat/webapps/mz-mall/

CMD ["sh", "/usr/local/tomcat/bin/run.sh"]

```