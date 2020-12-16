FROM php:7.3-fpm-alpine

# Version
ENV PHPREDIS_VERSION 4.0.0 

# 修改时区
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache --update-cache bash tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata 

# ngin
RUN apk add nginx && \
    mkdir /run/nginx/
COPY ./nginx.conf /etc/nginx/nginx.conf

# Libs
RUN apk add --no-cache curl \
    vim \
    wget \
    git \
    openssl-dev \
    zip \
    unzip \
    g++ make autoconf && \
    # gd库
    apk add --no-cache libpng libpng-dev && \
    docker-php-ext-install gd && \
    apk del libpng-dev && \
    # Composer
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update --clean-backups 
    # 安装扩展
    # docker方式安装PDO extension
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install sysvmsg && \
    docker-php-ext-install -j$(nproc) bcmath

    # Redis extension
RUN wget http://pecl.php.net/get/redis-${PHPREDIS_VERSION}.tgz -O /tmp/redis.tar.tgz && \
    pecl install /tmp/redis.tar.tgz && \
    rm -rf /tmp/redis.tar.tgz && \
    docker-php-ext-enable redis
    # 修改php.ini的文件 extension=redis.so
    #切换镜像
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    mkdir /www && \
    chown www-data /www

ENV SERVICE_NAME=php \
    LOG_PATH=/logs \
    LOGSTASH_HOST=

# 安装filebeat
ADD ./filebeat-7.10.1-linux-x86_64.tar.gz / 
COPY ./entrypoint.sh /filebeat-7.10.1-linux-x86_64/entrypoint.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

RUN apk add --update-cache libc6-compat \
    && mv /filebeat-7.10.1-linux-x86_64 /filebeat \
    && chmod +x /filebeat/entrypoint.sh
EXPOSE 80

#设置工作目录
WORKDIR /www

#CMD ["nginx","-c","/etc/nginx/nginx.conf","-g","daemon off;"]