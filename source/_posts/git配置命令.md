---
title: git配置命令
date: 2018-08-20 11:13:56
tags: Python
categories: life
---

### git配置
```bash
git config --global user.name "limq-debianvm-home"
git config --global user.email "gylimingqi@163.com"
git config --global push.default simple
git remote add origin git@github.com:dadiqq/nework-git.git
git remote add origin_soft  git@github.com:dadiqq/software.git
git config --global user.name "debian"
git config --global user.email "gylimingqi@163.com"
### git config --global push.default simple
[root@ora11g ~]# mkdir .ssh
[root@ora11g ~]# cd .ssh/
 //用ssh-keygen命令来生成密钥对，passphrase我们输入或不输入都行。
[root@ora11g .ssh]# ssh-keygen -t rsa -C "gylimigqi@163.com"
[root@ora11g etl]# echo 'unset SSH_ASKPASS' >> ~/.bashrc && source ~/.bashrc
git remote add origin git@github.com:dadiqq/nework-git.git
git remote add origin_soft  git@github.com:dadiqq/software.git
git remote add origin  git@github.com:dadiqq/VFP.git
git clone https://github.com/dadiqq/nework-git.git
git clone https://github.com/dadiqq/VFP.git

```

### 设置github上的公钥
#### 步骤如下：

​    a. 登陆github后 -> "Account Setting" -> "SSH Keys"
    b. "Add SSH Key"
    c. Title随便填写一个，Key那里我们把把id_rsa.pub里的内容拷贝进去。

#### 上传 
```bash
 env GIT_SSL_NO_VERIFY=true git push
[root@ora11g etl]# echo 'unset SSH_ASKPASS' >> ~/.bashrc && source ~/.bashrc   
查看远程库
env GIT_SSL_NO_VERIFY=true  git remote show origin
下载
env GIT_SSL_NO_VERIFY=true   git clone https://github.com/dadiqq/nework-git.git
https://github.com/dadiqq/nework-git.git  
 git clone  git@github.com:dadiqq/nework-git.git
git remote add origin  git@github.com:dadiqq/nework-git.git
git clone --no-checkout https://github.com/dadiqq/nework-git.git tmp
mv tmp/.git   ./nework-git/.git
rmdir tmp
cd nework-git
git reset --hard HEAD
git push -u origin master
curl http://curl.haxx.se/ca/cacert.pem -o /etc/pki/tls/certs/ca-bundle.crt
```
#### 测试 

ssh -T git@github.com
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
	1. 
ls -a  
	2. 
rm .git/ -rf 

```


- [ ] 跑步
- [ ] 写博客
- [ ] 学习
