## 基础镜像
目的：在基础镜像添加filebeat来采集本地日志，发送到日志服务

### 基础镜像 Dockerfile 增加
```Dockerfile

COPY ./run.sh /tmp/run.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update-cache curl libc6-compat && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.1-linux-x86_64.tar.gz && \
    tar xzvf filebeat-7.10.1-linux-x86_64.tar.gz -C / && \
    apk del curl && \
    rm filebeat-7.10.1-linux-x86_64.tar.gz && \
    chmod +x /tmp/run.sh
COPY ./filebeat.yml /filebeat-7.10.1-linux-x86_64/filebeat.yml

```

### filebeat.yml 内容, 修改path路径为日志路径
```yaml
filebeat.inputs:
- type: log
  enable: true
  fields:
    service_name: unknown
  fields_under_root: true
  paths:
    - /usr/local/tomcat/logs/*.log # 修改为日志路径，未来基于这个镜像的项目，日志都放这里

output.logstash:
  hosts: ["localhost:5044"]
```

### run.sh 内容，不需要修改
```sh
#!/bin/bash
sed -i "s/unknown/${SERVICE_NAME}/g" /filebeat-7.10.1-linux-x86_64/filebeat.yml

if [ -n "$LOGSTASH_HOST" ]; then
    sed -i "s/localhost/${LOGSTASH_HOST}/g" /filebeat-7.10.1-linux-x86_64/filebeat.yml
    nohup /filebeat-7.10.1-linux-x86_64/filebeat -e -c /filebeat-7.10.1-linux-x86_64/filebeat.yml -d "publish" > /dev/null >2& >1 &
fi
```

### 制作基础镜像，下载filebeat安装包可能比较慢，多试几次

## 项目镜像
基于上边制作的基础镜像

### 配置文件改造
不同环境需要调整的配置文件，常规配置文件不需要，比如数据库信息  
比如xxxxx.xxx是本地的配置文件  
添加xxxxx-uat.xxx 和 xxxxx-pro.xxx 配置文件  
uat: 模拟生产环境  
pro: 生产环境
