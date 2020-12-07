# Docker search 命令

docker search : 从Docker Hub查找镜像

## 语法

> docker search [OPTIONS] TERM

### OPTIONS说明：

- --automated :只列出 automated build类型的镜像；
- --no-trunc :显示完整的镜像描述；
- -s :列出收藏数不小于指定值的镜像。

## 例子

```sh 
# 收藏数大于10的镜像
docker search -s 10 nginx
``

