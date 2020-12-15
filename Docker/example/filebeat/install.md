## 基础镜像
目的：在基础镜像添加filebeat来采集本地日志，发送到日志服务

### 基础镜像 Dockerfile 增加
```Dockerfile

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

```

### filebeat.yml 内容
```yaml
filebeat.inputs:
- type: log
  enable: true
  fields:
    service_name: ${SERVICE_NAME}
  fields_under_root: true
  paths:
    - ${LOG_PATH}/*.log

output.logstash:
  hosts: ["${LOGSTASH_HOST}:5044"]
```

### entrypoint.sh 内容
```sh
#!/bin/bash
if [ -n "$LOGSTASH_HOST" ]; then
    nohup /filebeat/filebeat -e -c /filebeat/filebeat.yml -d "publish" > /dev/null >2& >1 &
fi
```