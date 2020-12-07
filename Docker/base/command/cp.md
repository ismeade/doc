# Docker cp 命令

docker cp :用于容器与主机之间的数据拷贝。

## 语法

> docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-

> docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH

### OPTIONS说明：

- -L :保持源目标中的链接

## 例子

```sh
# 将主机 ./data 目录拷贝到容器96f7f14e99ab的/da目录下。
docker cp ./data 96f7f14e99ab:/da/

# 将主机 ./data 录拷贝到容器96f7f14e99ab的/中，目录重命名为da
docker cp ./data 96f7f14e99ab:/da

# 将容器96f7f14e99ab的/da 目录拷贝到主机的/tmp目录中。
docker cp  96f7f14e99ab:/da /tmp/
```
