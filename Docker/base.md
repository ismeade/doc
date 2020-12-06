## 什么是 Docker
Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中,然后发布到任何流行的Linux机器或Windows 机器上,也可以实现虚拟化,容器是完全使用沙箱机制,相互之间不会有任何接口。
- Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从 Apache2.0 协议开源。

- Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。

- 容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。


## 应用场景
- Web 应用的自动化打包和发布。
- 自动化测试和持续集成、发布。
- 在服务型环境中部署和调整数据库或其他的后台应用。

## Docker 的优点
### 1. 快速，一致地交付您的应用程序
Docker 允许开发人员使用您提供的应用程序或服务的本地容器在标准化环境中工作，从而简化了开发的生命周期。

容器非常适合持续集成和持续交付（CI / CD）工作流程，请考虑以下示例方案：
- 您的开发人员在本地编写代码，并使用 Docker 容器与同事共享他们的工作。
- 他们使用 Docker 将其应用程序推送到测试环境中，并执行自动或手动测试。
- 当开发人员发现错误时，他们可以在开发环境中对其进行修复，然后将其重新部署到测试环境中，以进行测试和验证。
- 测试完成后，将修补程序推送给生产环境，就像将更新的镜像推送到生产环境一样简单。

### 2. 响应式部署和扩展
- Docker 是基于容器的平台，允许高度可移植的工作负载。Docker 容器可以在开发人员的本机上，数据中心的物理或虚拟机上，云服务上或混合环境中运行。

- Docker 的可移植性和轻量级的特性，还可以使您轻松地完成动态管理的工作负担，并根据业务需求指示，实时扩展或拆除应用程序和服务。

### 3. 在同一硬件上运行更多工作负载
- Docker 轻巧快速。它为基于虚拟机管理程序的虚拟机提供了可行、经济、高效的替代方案，因此您可以利用更多的计算能力来实现业务目标。Docker 非常适合于高密度环境以及中小型部署，而您可以用更少的资源做更多的事情。

## 架构

Docker 包括三个基本概念

- **镜像（Image）**：Docker 镜像（Image），就相当于是一个 root 文件系统。比如官方镜像 ubuntu:16.04 就包含了完整的一套 Ubuntu16.04 最小系统的 root 文件系统。
- **容器（Container）**：镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的类和实例一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。
- **仓库（Repository）**：仓库可看成一个代码控制中心，用来保存镜像。

Docker 使用客户端-服务器 (C/S) 架构模式，使用远程API来管理和创建Docker容器。

Docker 容器通过 Docker 镜像来创建。

容器与镜像的关系类似于面向对象编程中的对象与类。

<div STYLE="page-break-after: always;"></div>

## 开始使用
### 安装

```bash
$curl -fsSL https://get.docker.com -o get-docker.sh
$chmod u+x get-docker.sh
$./get-docker

$sudo docker info
```

## 命令

[run](./command/run.md): 创建一个新的容器并运行一个命令
[start](./command/start_stop_restart.md): 启动一个或多个已经被停止的容器
[stop](./command/start_stop_restart.md): 停止一个运行中的容器
[restart](./command/start_stop_restart.md): 重启容器
[kill](./command/kill.md): 杀掉一个运行中的容器
[rm](./command/rm.md): 删除一个或多个容器
[pause](./command/pause_unpause.md): 暂停容器中所有的进程
[unpause](./command/pause_unpause.md): 恢复容器中所有的进程
[create](./command/create.md)

[ps](./command/ps.md): 容器列表
[top](./command/top.md): 查看容器中运行的进程信息，支持 ps 命令参数。
[logs](./command/logs.md): 获取容器的日志
[exprot](./command/export.md): 将文件系统作为一个tar归档文件导出到STDOUT
[port](./command/port.md): 列出指定的容器的端口映射


## 镜像

### 搜索镜像
```bash
$docker search nginx
```
或者  
https://hub.docker.com/


### 拉取镜像
```bash
$docker pull nginx # 默认latest
# 等同于
$docker pull nginx:latest
# 想查找指定版本的镜像 只能去docker hub去搜
```

### 镜像操作
```sh
# 查看
$docker images
# 只看镜像id
$docker images -q
# 查看版本悬空状态的镜像
$docker images -f "dangling=true"

# 删除
$docker rmi 镜像名:版本
$docker rmi 镜像ID
# 和 images命令组合使用 删除所有版本悬空状态镜像
$docker rmi $(docker images -f "dangling=true" -q)

# 标签
$docker tag 镜像名:版本 镜像名:版本
                 ^         ^
                 |         |- 标签的名称和版本
                 |
                 |- 原本的名称和版本

# 推送 （要先login)
$docker push 镜像名:版本

```

### 登录
```sh
$docker login

# 登录其他仓库 输入用户名密码
$docker login --username=北京人人检 registry.cn-beijing.aliyuncs.com

```

## 容器

### 创建/运行容器
```sh
# 基础命令
$docker create 镜像名称:版本号
# 启动后台容器
$docker run -d # 后台运行
            -v /home/liyang/redis/db:/data # 映射目录或文件
            -p 6379:6379 # 映射端口
            --name redis # 起个容器名
            redis:4-alpine # 镜像名称 版本号

# 启动交互式容器
$docker run -t # 在新容器内指定一个伪终端或终端
            -i # 允许你对容器内的标准输入 (STDIN) 进行交互
            --link redis # 连接到名字是redis的容器
            --rm # 容器stop后自动删除
            redis:4-alpine # 要启动的容器
            redis-cli -h redis # 启动后运行的命令

# 运行容器里明令
$docker exec redis pwd
$docker exec redis cat /etc/hosts
```

### 容器操作
```sh
# 查看容器列表
$docker ps -a

# 暂停/恢复
$docker pause nginx
$docker unpause nginx

# 停止/启动/重启
$docker stop nginx
$docker start nginx
$docker restart nginx

# 快速停止
$docker kill nginx

# 删除容器
$docker rm nginx
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


## 制作镜像
```sh
# 注意最后的.
$docker build -t 镜像名:版本 .
$docker build -t 镜像名:版本 -f xxxx/Dockerfile .
```






<div STYLE="page-break-after: always;"></div>

## 相关链接
[https://www.docker.com](https://www.docker.com)

[https://hub.docker.com/](https://hub.docker.com/)

[https://github.com/docker/docker-ce](https://github.com/docker/docker-ce)

