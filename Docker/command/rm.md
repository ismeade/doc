# Docker rm 命令

docker rm ：删除一个或多个容器。

## 语法

> docker rm [OPTIONS] CONTAINER [CONTAINER...]

### OPTIONS说明：

- -f :通过 SIGKILL 信号强制删除一个运行中的容器。
- -l :移除容器间的网络连接，而非容器本身。
- -v :删除与容器关联的卷。

## 例子

```sh 
docker rm nginx
```
