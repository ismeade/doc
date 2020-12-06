# Docker ps 命令

docker ps : 列出容器

## 语法

> docker ps [OPTIONS]

### OPTIONS说明：

- -a :显示所有的容器，包括未运行的。
- -f :根据条件过滤显示的内容。
- --format :指定返回值的模板文件。
- -l :显示最近创建的容器。
- -n :列出最近创建的n个容器。
- --no-trunc :不截断输出。
- -q :静默模式，只显示容器编号。
- -s :显示总的文件大小。

## 例子

```sh
docker ps 
# 根据name过滤
docker ps -f name=nginx
# 根据状态过滤
docker ps -f status=running
# 根据image name过滤
docker ps -f ancestor=nginx
# 根据image id 过滤
docker ps -f ancestor=d0e008c6cf02

```

状态|说明
---|---
created|已创建
restarting|重启中
running / Up|运行中
removing|迁移中
paused|暂停
exited|停止
dead|死亡

