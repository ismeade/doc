# Docker logs 命令

docker logs : 获取容器的日志

## 语法

> docker logs [OPTIONS] CONTAINER

### OPTIONS说明：

- -f : 跟踪日志输出
- --since :显示某个开始时间的所有日志
- -t : 显示时间戳
- --tail :仅列出最新N条容器日志

## 例子

```sh 
docker logs -f nginx

docker logs --since="2020-12-01" --tail=10 nginx
```
