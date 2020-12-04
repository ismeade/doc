# Git 基础

## Git是什么

> **全局信息追踪器 Global Information Tracker**

Git 是一个开源的分布式版本控制系统，用于敏捷高效地处理任何或小或大的项目。

## 建立仓库/克隆已有仓库 init clone

```sh
# 建立仓库
$git init

# 克隆仓库
$git clone xxxx.git
```

## 添加新文件 add
working dir -> staged
```sh
# 添加某一个文件
$git add filename
or
# 添加所有
$git add .
```

```sh
# 有个文件不想add，但是误输了add .
$git rm --cache filename

# 去掉不需要提交的文件
# 如.classprth .idea/ .vscode/ logs/ target/

# 已经添加的文件，可以使用 -f 可以同时删除文件
$git rm -f filename
```

## 提交版本 commit
staged -> commit history  
```sh
$git commit -m "提交信息"
or
# 不使用-m会弹出文本编辑器
$git commit

# 提交信息输错了
$git commit --amend
```

## 配置远程仓库地址 remote
```sh
# 添加
$git remote add origin xxxxx.git

# 删除
$git remote remove origin

# 修改
$git remote set-url origin xxxxx.git
```

## 发布版本 push

将本地提交推送到服务器
```sh
$git push origin master
# 上边的命令是省略了的
$git push origin master:master

# 直接创建远程分支
$git push origin master:dev/1.1

# 删除远程分支
$git push origin :dev/1.1
or
$git push origin -d dev/1.1

# 错误的push，有错误commit push到远程仓库
$git revert commitid
```

## 获取版本 fetch pull 

从服务器获取版本到本地仓库
```sh
$git pull

#pull实际上做了两件事情
$git fetch
and
$git merge origin/master

#查看远程分支版本
$git ls-remote
```

## 分支 branch
```sh
# 创建分支
$git branch name

# 查看分支
$git branch
# -l list -a all -r remote

# 切换分支
$git checkout name

# 创建并切换分支
$git checkout -b name

# 重命名分支
$git branch -m old_name new_name

# 删除本地分支
$git branch -d name

# 合并分支 把name分支 合并到 当前分支
$git merge name
```

## 标签 tag
和分支的区别：不能提交。每个上线的版本，对应一个tag，分支合并到主干，也要留下tag
```sh
$git tag
$git tag -l
# *通配查找
$git tag -l 'v1.0.*'

# 创建标签
$git tag -a name -m "desc"

# 投送tag 和 分支一样
$git push origin name
or
$git push origin --tags

# 删除tag
$git tag -d name
# 删除远程仓库tag
$git push origin :name

# 切换分支
$git checkout name

```

## 本地提交管理
```sh
# 本地回退到某个版本，所有后边的提交都不要了
$git reset --hard commitid

# 恢复未commit的文件
$git checkout filename
# 恢复未commit的所有文件
$git checkout .

# 暂存所有未commit的文件
$git stash save
# 取出暂存文件
$git stash pop

```
