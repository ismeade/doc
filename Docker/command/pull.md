# Docker pull 命令

docker pull : 从镜像仓库中拉取或者更新指定镜像

## 语法

> docker pull [OPTIONS] NAME[:TAG|@DIGEST]

### OPTIONS说明：

- -a :拉取所有 tagged 镜像
- --disable-content-trust :忽略镜像的校验,默认开启

## 例子

```sh 
docker pull nginx

# 不常用
docker pull -a java
```
