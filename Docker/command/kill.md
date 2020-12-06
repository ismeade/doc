# Docker kill 命令

docker kill :杀掉一个运行中的容器。

## 语法

> docker kill [OPTIONS] CONTAINER [CONTAINER...]

### OPTIONS说明：

- -s :向容器发送一个信号

## 例子
```sh 
docker kill -s KILL nginx
```
