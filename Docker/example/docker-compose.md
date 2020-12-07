### 启动redis
```yaml
version: '2'
services:
    redis:
        image: redis:4-alpine
        network_mode: "bridge" #设置使用默认网络
        volumes: 
            - /data/redis/db:/data
        ports:  #使用link方式 可以不对外映射端口
            - "6379:6379"
        container_name: redis
```
### link到redis
```
docker run -ti --rm --link redis redis:4-alpine redis-cli -h redis -p 6379
#后边的-h -p 是 redis-cli的参数
```

### 幕再
```yaml
version: '3'
services:
    munichre-mall:
        image: registry-vpc.cn-beijing.aliyuncs.com/vcheck/munichre-mall:1.0-beta
        network_mode: "bridge"
        volumes:
            - /home/admin/project/munichre-mall-logs:/usr/local/tomcat/logs
#        ports:
#            - 8080
        environment:
            - JAVA_OPTS='-Xmx1024m'
        external_links: # 临时
            - mysql
#        container_name: munichre-mall
#    nginx:
#        image: nginx:latest
#        volumes:
#            - type: bind
#              source: /home/admin/project/nginx.conf
#              target: /etc/nginx/nginx.conf
#        depends_on:
#            - munichre-mall
#        ports:
#            - 8080:80
    mall-lb:
        image: dockercloud/haproxy
        network_mode: "bridge"
        links:
            - munichre-mall
        ports:
            - 8080:80
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock
        depends_on:
            - munichre-mall
        
```