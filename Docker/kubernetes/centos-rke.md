## 基础

配置公钥登录

> 注意 .ssh权限 700 authorized_keys 权限 600 否则不能公钥登录

配置阿里yum源
```
#CentOS 6
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-6.repo
或者
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-6.repo
#CentOS 7
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
或者
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
#CentOS 8
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
或者
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo

yum makecache
```

## 安装docker

centos8以上需要
```
sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
```

删除docker
```
# Uninstall installed docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
```
配置阿里云Docker Yum源
```
# Set up repository
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Use Aliyun Docker
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

安装指定版本
查看Docker版本：
```
yum list docker-ce --showduplicates
```

安装Docker较新版本（比如Docker 18.06.0)时加上rpm包名的版本号部分：
```
sudo yum install docker-ce-18.06.0.ce
```

启动Docker服务
```
# Start docker service
systemctl enable docker
systemctl start docker
```

配置镜像加速器
针对Docker客户端版本大于 1.10.0 的用户

您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器
```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://spvpg8ux.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

添加docker sudo权限
```
# 没有就添加一个 正常是有的
sudo groupadd docker
# 将用户加入该 group 内。然后退出并重新登录
sudo gpasswd -a ${USER} docker 
sudo systemctl restart docker
newgrp  docker
重新登录session或重启
```

## 修改配置
主机名：

如果是克隆的系统一定要修改主机名，hostname主机名必须不同！
```
hostnamectl set-hostname  自己想要的名字
```

主机文件：

/etc/hosts要配置正确，一定要有127.0.0.1 localhost 这一项。Hosts文件中包含所有主机节点的IP和名称列表。使用vi进行编辑，不能使用中文全角的空格；


SELinux：

必须关闭！Ubuntu 16.04默认未安装，无需设置。CentOS7下可修改配置文件/etc/sysconfig/selinux，设置SELINUX=disabled ，重启后永久关闭。
```
sudo vim /etc/sysconfig/selinux

SELINUX=disabled
```

IPV4转发：

必须开启！Ubuntu 16.04下默认已启用，无需设置。CentOS7 下可编辑配置文件/etc/sysctl.conf，设置启用转发,
```
sudo vim /etc/sysctl.conf

net.ipv4.ip_forward = 1              
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
执行sudo sysctl -p 立刻生效。
```

防火墙：

开放集群主机节点之间6443、2379、2380端口，如果是刚开始试用，可以先关闭防火墙；Ubuntu默认未启用UFW防火墙，无需设置。也可手工关闭：sudo ufw disable
```
# centos
sudo systemctl disable firewall.service
sudo systemctl stop firewall.service
sudo systemctl status firewall.service

# centos 8.2
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl status firewalld
```

禁用SWAP：

一定要禁用swap，否则kubelet组件无法运行，永久禁用swap可以直接修改/etc/fstab文件，注释掉swap项。swapoff -a 只是临时禁用，下次关机重启又恢复原样；

启用Cgroup：

修改配置文件/etc/default/grub，启用cgroup内存限额功能,配置两个参数：
```
sudo vim /etc/default/grub

GRUB_CMDLINE_LINUX_DEFAULT="cgroup_enable=memory swapaccount=1"
GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"

# 注意：要执行sudo update-grub 更新grub，然后重启系统后生效。
# centos 
grub2-mkconfig -o /boot/grub2/grub.cfg
```

SSH免密登录：

## rke-k8s
下载 

新建cluster.yml文件
```
nodes:
    - address: 192.168.56.2
      port: 22
      user: liyang
      role:
        - controlplane
        - etcd
        - worker
      docker_socket: /var/run/docker.sock
      ssh_key_path: ~/.ssh/id_rsa
    - address: 192.168.56.3
      port: 22
      user: liyang
      role:
        - worker
      docker_socket: /var/run/docker.sock
      ssh_key_path: ~/.ssh/id_rsa

# 如果设置为true，则可以使用不受支持的Docker版本
# ignore_docker_version: true
```

安装命令
```
rke up --config cluster.yml
```
然后程序会开始跑,有可能因为网络等原因失败,没关系 如果失败了 rke remove --config cluster.yml 删除集群,然后重新执行rke up --config cluster.yml 