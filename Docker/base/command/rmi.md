# Docker rmi 命令

docker rmi : 删除本地一个或多少镜像。

## 语法

> docker rmi [OPTIONS] IMAGE [IMAGE...]

### OPTIONS说明：

- -f :强制删除；
- --no-prune :不移除该镜像的过程镜像，默认移除；

## 例子

```sh  
docker rmi nginx:latest

docker rmi $(docker images -f "dangling=true" -q)
```
