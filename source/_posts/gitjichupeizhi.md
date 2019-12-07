---
title: git基础配置命令
date: 2018-08-20 11:13:56
tags: [Git,版本控制]
categories: 
- Program 
- Git
---





### 关于版本控制

什么是“版本控制”？我为什么要关心它呢？ 版本控制是一种记录一个或若干文件内容变化，以便将来查阅特定版本修订情况的系统。 在本书所展示的例子中，我们对保存着软件源代码的文件作版本控制，但实际上，你可以对任何类型的文件进行版本控制。 Git 就是一种版本控制工具。Git 自诞生于 2005 年以来，Git 日臻成熟完善，在高度易用的同时，仍然保留着初期设定的目标。 它的速度飞快，极其适合管理大项目，有着令人难以置信的非线性分支管理系统（参见 [Git 分支](https://git-scm.com/book/zh/v2/ch00/ch03-git-branching)）。 

### 命令行

Git 有多种使用方式。 你可以使用原生的命令行模式，也可以使用 GUI 模式，这些 GUI 软件也能提供多种功能。 

假如你是 Mac 用户，我们希望你懂得如何使用终端（Terminal）；假如你是 Windows 用户，我们希望你懂得如何使用命令窗口（Command Prompt）或 PowerShell。 如果你尚未掌握以上技能，我们建议你先停下来快速学习一下，本文讲述和举例将用到这些技能。

### 安装 Git

在你开始使用 Git 前，需要将它安装在你的计算机上。 即便已经安装，最好将它升级到最新的版本。 你可以通过软件包或者其它安装程序来安装，或者下载源码编译安装。 

#### 在 Windows 上安装

在 Windows 上安装 Git 也有几种安装方法。 官方版本可以在 Git 官方网站下载。 打开 [Downloading Git](http://git-scm.com/download/win)，下载会自动开始。 要注意这是一个名为 Git for Windows的项目（也叫做 msysGit），和 Git 是分别独立的项目；更多信息请访问 <http://msysgit.github.io/>。 

### git基础配置


安装完成 git 后需要做一些配置就可以使用 git 托管代码带 GitHub 上面了。开始使用 Git, 打开 开始 > 所有程序 > Git > git-bash。这样就进入的 GIt 的命令行。

```bash
# git 初始配置
git config --global user.name "limq-debianvm-home"
git config --global user.email "gylimingqi@163.com"
git config --global push.default simple
# git 添加远程分支
git remote add origin git@github.com:dadiqq/nework-git.git
git remote add origin_soft  git@github.com:dadiqq/software.git
#创建 ssh-key
[root@ora11g ~]# mkdir .ssh
[root@ora11g ~]# cd .ssh/
 #用ssh-keygen命令来生成密钥对，passphrase我们输入或不输入都行。
[root@ora11g .ssh]# ssh-keygen -t rsa -C "gylimigqi@163.com"
[root@ora11g .ssh]#ls
[root@ora11g etl]# echo 'unset SSH_ASKPASS' >> ~/.bashrc && source ~/.bashrc

git clone https://github.com/dadiqq/nework-git.git   [路径]
git clone https://github.com/dadiqq/VFP.git
git remote remove <name>
git remote -v
```

### 设置github上的公钥
#### 步骤如下：

​    a. 登陆github后 -> "Account Setting" -> "SSH Keys"
    b. "Add SSH Key"
    c. Title随便填写一个，Key那里我们把把id_rsa.pub里的内容拷贝进去。

### 测试

ssh -T git@github.com

### 常用命令 

```bash
[root@ora11g etl]# echo 'unset SSH_ASKPASS' >> ~/.bashrc && source ~/.bashrc   
#查看远程库
env GIT_SSL_NO_VERIFY=true  
git remote show origin
#下载 GitHub 上项目
env GIT_SSL_NO_VERIFY=true   
git clone https://github.com/dadiqq/nework-git.git
git clone  git@github.com:dadiqq/nework-git.git
git clone --no-checkout https://github.com/dadiqq/nework-git.git tmp

git reset --hard HEAD
git push -u origin master
curl http://curl.haxx.se/ca/cacert.pem -o /etc/pki/tls/certs/ca-bundle.crt
```

工作的时候经常需要在各个目录之间跳转，可以通过环境变量对目录进行缩写，方便地在多个目录直接切换。
在 ~/.bashrc 添加：

export wd="/d/Projects/MyProject/git"
export doc="/d/Projects/documents/"

下面来验证以上的说法。
创建一个空的项目，
```bash
$ mkdir project
$ cd project
$ git init
$ vi  readme    # 添加一行文字并保存，比如“1111”
$ git add readme
$ git commit -m "1st commit"

此时来看仓库中的对象目录

$ tree .git/objects/
```
### 如果我们往一个非空的目录下 clone git 项目，就会提示错误信息：

`fatal: destination path '.' already exists and is not an empty directory.`

#### 解决的办法是：
```bash
1. 进入非空目录，假设是 /workdir/proj1
2. git clone --no-checkout https://git.oschina.net/NextApp/platform.git tmp
3. mv tmp/.git .   #将 tmp 目录下的 .git 目录移到当前目录
4. rmdir tmp
5. git reset --hard HEAD
```
然后就可以进行各种正常操作了。

#### 第二方案
```bash
ls -a  
rm .git/ -rf 
```


- [ ] 跑步
- [ ] 写博客
- [ ] 学习
