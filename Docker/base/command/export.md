# Docker export 命令

docker export :将文件系统作为一个tar归档文件导出到STDOUT。

## 语法

> docker export [OPTIONS] CONTAINER

### OPTIONS说明：

- -o :将输入内容写到文件。

## 例子

```sh 
docker export -o mysql.tar a404c6c174a2
docker export -o mysql-`date +%Y%m%d`.tar a404c6c174a2

```
