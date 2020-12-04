# <center>Git代码提交规范</center> #
##### <center>2020年10月14日</center> #####
##### <center>北京人人检科技有限公司</center> ####
---

### 项目结构 ###
项目根目录必须要有 __.gitignore__ 文件，文件内容可以直接复制附录部分。  
```
project
   |-src/
   |-xxx/
   |-xxx.xxx
   |-README.md
   |-.gitignore
```

开发工具产生的本地文件 __禁止__ 提交到代码仓库。  
> 如：.idea .project .classpath target等


### 提交commit ###
commit message 要是有意义的文字描述，有助于后期维护和项目管理。  

#### 格式 ####
```html
<type>(<scope>):<subject>
<body>
# 两段之间空行
...
```

##### type(必须) #####
用于说明git commit的类别，只允许使用下面的标识。
```
# 主要type
feat:     增加新功能
fix:      修复bug

# 特殊type
docs:     只改动了文档相关的内容
style:    不影响代码含义的改动，例如去掉空格、改变缩进、增删分号
build:    构造工具的或者外部依赖的改动，例如webpack，npm
refactor: 代码重构时使用
revert:   执行git revert打印的message

# 暂不使用type
test:     添加测试或者修改现有测试
perf:     提高性能的改动
ci:       与CI（持续集成服务）有关的改动
chore:    不修改src或者test的其余修改，例如构建过程或辅助工具的变动
```
##### scope(可选) #####
用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。

##### subject(必须) #####
简单描述，可以直接标注功能编号或bug编号等

##### body(可选) #####
本次提交的详细说明

示例
```
feat:用户登录
需求文档xxxx部分

fix:修复jira 23# 

```

---

### ~~分支branchs~~ ###

~~master或main为主干分支，平时开发应该尽量避免在主干上直接提交，应提前创建好对应~~  
~~版本号的远程分支(remote branch)，确定上线版本后，合并到主干并保留tags。~~

分支部分我会提前创建好，主干也会设置成保护状态。

---


### 附录 ###

#### .gitignore 文件内容 ####

```.gitignore
HELP.md
target/
!.mvn/wrapper/maven-wrapper.jar
!**/src/main/**
!**/src/test/**

### STS ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache

### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
build/

### VS Code ###
.vscode/
```

### 参考资料 ###
[angular团队Git规范](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit)

[Git提交规范](https://zhuanlan.zhihu.com/p/88870009)
