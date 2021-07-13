#!/bin/bash
if [ -n "$LOGSTASH_HOST" ]; then
    nohup /filebeat/filebeat -c /filebeat/filebeat.yml -d "publish" > /dev/null 2>&1
fi
