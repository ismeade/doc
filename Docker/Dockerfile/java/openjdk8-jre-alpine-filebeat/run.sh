#!/bin/bash
sed -i "s/unknown/${SERVICE_NAME}/g" /filebeat-7.10.1-linux-x86_64/filebeat.yml

if [ -n "$LOGSTASH_HOST" ]; then
    sed -i "s/localhost/${LOGSTASH_HOST}/g" /filebeat-7.10.1-linux-x86_64/filebeat.yml
    nohup /filebeat-7.10.1-linux-x86_64/filebeat -e -c /filebeat-7.10.1-linux-x86_64/filebeat.yml -d "publish" > /dev/null >2& >1 &
fi