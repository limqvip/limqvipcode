---
title: freebsdinstall.md
comments: true
date: 2018-09-20 16:43:43
updated: 2018-09-20 16:43:43
tags: [FreeBSD]
categories: 
- FreeBSD
---

ssh 172.16.210.128

1. #### 不通用户获得 su 权限FreeBSD系统下su:sorry的解决办法

         在FreeBSD上要使用su命令成为root用户，不但要知道root的口令，还需要经过特别设置，否则就不能成功使用这个命令。这是因为 FreeBSD对执行su命令的用户进行了更严格的限制，能使用su命令的用户必须属于wheel组（root的基本属组，组ID为0），否则就不能通过 这个命令成为root用户。因此需要编辑组设置文件/etc/group，将需要超级用户权力的管理成员加入到wheel组中。
         可以使用如下命令给普通用户su - root的权力：
         pw groupmod wheel -m <username>
         pw user mod <username> -g wheel
         或者直接修改/etc/group文件，把相应的用户加到wheell组就可以
         wheel:*:0:root,username
      FreeBSD系统下默认是不允许root用户直接通过ssh连接到服务器的，在安装FreeBSD系统时要创建一个额外的用户，切忌一定要把这个用户加 入到wheel组中（如果不加入到这个组中的话就无法ssh），也可以安装完系统后创建用户，并把这个用户加入wheel组。



   跟用户和组有关的两个文件：/etc/passwd   /etc/group

   用vipw可以直接修改/etc/passwd里的内容

#### 安装sudo

root# cd /usr/ports/security/sudo root# make install clean root# rehash sudo的配置文件是/usr/local/etc/sudoers，同时该目录下还有一个sudoers.default初始配置文件。 sudo的配置文件不能直接用其他编辑工具编辑，而必须用visudo来进行修改。 root# visudo                      注意后面不需要文件名 下面是配置sudo的简单方法： # User privilege specification root    ALL=(ALL) ALL test    ALL=(ALL) ALL %wheel ALL=(ALL) ALL





#### reebsd开启root远程登录服务器的操作



freebsd开启root远程登录服务器的操作
vi /etc/ssh/sshd_config

找到

\#PermitRootLogin no

改为
PermitRootLogin yes

 重新启动sshd
/etc/rc.d/sshd restart



#### FreeBSD安装VIM最简单的方法

个人分类： [FreeBSD](https://blog.csdn.net/Illina/article/category/7036069)

  查阅了相关资料，FreeBSD系统有两种方法可以安装vim。

  **方法一：**

  通过ports工具安装

  \#cd /usr/ports/editor/vim

  \#make install

  安装过程提示失败，也没有找到解决方法，尝试方法二

  **方法二：**

  通过pkg命令安装

  \#pkg install vim

---



#### [推荐】freeBSD优秀学习站点](https://blog.csdn.net/fngsong/article/details/18622999)

http://www.freebsd.org.cn/snap/doc/zh_CN.GB2312/books/handbook/（最新版FreeBSD使用手册）
http://man.chinaunix.net/bsd/freebsd/zh/ （另外一个freeBSD使用手册）
http://ohaha.ks.edu.tw/ （一个优秀的TW freeBSD学习站点）
http://www.twbsd.org/index.php （又一个优秀的TW freeBSD学习站点）

ftp://freebsd.csie.nctu.edu.tw/ （freeBSD下载版本很全）
http://www.freebsd.org.cn/snap/d ... s/porters-handbook/ （FreeBSD Porter 手册）
http://ebook.cnfug.org/ebook/pub/BSD/FreeBSD%20Unleshed/ （freeBSD技术内幕[英]） 
http://kajaa.bbs.us/ApacheManual/ （Apache 2.0手册中文版）

http://kukusky.8800.org/ （Kukusky  Freebsd资源网）


中文站点

[台大电机Maxwell BBS BSD精华区](http://bbs.ee.ntu.edu.tw) 
[TW FreeBSD总站，交大资工FreeBSD](http://freebsd.csie.nctu.edu.tw) 
[中研院FreeBSD](http://freebsd.sinica.edu.tw) 
[FreeBSD Chinese HOWTO](http://freebsd.sinica.edu.tw/zh-tut/) 
[蓝色泡泡的OHAHA](http://ohaha.ks.edu.tw) 
[大南国小的FreeBSD](http://freebsd.lab.mlc.edu.tw/) 
[FreeBSD 使用大全](http://tech.sina.com.cn/focus/FreeBSD/index.shtml) 

英文站点

[FreeBSD总部](http://www.freebsd.org) 
[FreeBSD Handbook](http://www.freebsd.org/doc/) 
[FreeBSD Cheat Sheets](http://www.mostgraveconcern.com/freebsd/) 
[Fresh Ports](http://www.freshports.org/) 
[ONLamp.com:FreeBSD Basics](http://www.onlamp.com/bsd/)
[A Comprehensive Guide to FreeBSD]

---



10下载](https://download.freebsd.org/ftp/releases/amd64/amd64/ISO-IMAGES/10.4/)
[笔记本电脑BSD](https://wiki.freebsdchina.org/doc/k/kernel#bootloaderconf_%E9%85%8D%E7%BD%AE)

[安装vMware问题及解决](https://www.cyberciti.biz/faq/howto-install-kernel-headers-package/)

[12下载地址](https://download.freebsd.org/ftp/snapshots/arm64/aarch64/ISO-IMAGES/12.0/)

[FreeBSDchina.org](https://www.freebsdchina.org/forum/viewforum.php?f=34&sid=1600eee36fe6834d8d2fb00f815d7312)





#### freebsd 强制重新安装最新版 pkg 命令



个人分类： [所有](https://blog.csdn.net/joyous/article/category/1112594)[FreeBSD](https://blog.csdn.net/joyous/article/category/1072684)



进入 pkg 目录

cd /usr/ports/ports-mgmt/pkg

运行删除及重新安装，并且忽略兼容性

make clean deinstall reinstall -D ALLOW_UNSUPPORTED_SYSTEM

而直接强制安装则是

make clean install -D ALLOW_UNSUPPORTED_SYSTEM



若要强制安全其他的软件，也是类似。



#### [FreeBSD下修改安装源的方法](https://blog.csdn.net/willhuo/article/details/49384445)

**说明：**

FreeBSD中安装软件一般有两种方式：

（一）、使用pk_add -r Package 来安装软件，Package安装的是已经编译好的二进制软件包，Package默认下载软件包的路径是在/var/db/pkg中

（二）、使用Ports方式编译安装，Ports是下载源码到本地，再执行编译安装，ports软件包的路径是在/usr/ports中

以上两种安装方式都需要从网络下载软件包，默认是从官方的源下载软件包的，速度比较慢，可以修改配置文件指定国内的镜像源来快速安装软件

**1、修改Pcakage源为163的镜像源**

setenv PACKAGESITE 

http://mirrors.163.com/FreeBSD/releases/i386/8.1-RELEASE/packages/Latest/

pkg_add -r package    #package为要安装的软件名

**2、安装Ports源**

portsnap fetch -s portsnap.cn.freebsd.org 

    \#安装ports

ee /etc/portsnap.conf   #编辑文件

SERVERNAME=portsnap.cn.FreeBSD.org

    \#更改服务器为国内镜像

按esc 回车，再按a保存

portsnap fetch extract 

  \#下载ports快照

portsnap update  #更新

ee /etc/make.conf  #编辑文件，添加下面代码

MASTER_SITE_BACKUP?=http://mirrors.163.com/FreeBSD/distfiles/${DIST_SUBDIR}/

MASTER_SITE_OVERRIDE?=${MASTER_SITE_BACKUP}

cd  /usr/ports

make search name=nginx    #查找ports中是否有nginx这个软件

cd  /usr/ports/www/nginx   #进入软件包目录

make install clean    #安装

make deinstall clean   #卸载

make deinstall reinstall clean  #升级

来源 系统运维 osyunwei.com

---

[FreeBSD 11.0安装完成初设定](http://blog.chinaunix.net/uid-26577845-id-5755035.html)

---

[freebsd从安装到想要的状态配置](http://blog.51cto.com/cmdschool/1728933)





# [FreeBSD应该装gnome3做桌面](https://www.cnblogs.com/x3d/p/4747052.html)



目前freebsd pkg包管理体系的repo源多了一些，速度快了很多。

仓库中目前的版本为3.14，安装gnome3很简单。

```
pkg install xorg gnome3

echo "exec /usr/local/bin/gnome-session" > ~/.xinitrc
vi /etc/rc.conf

hald_enable="YES"
dbus_enable="YES"
gdm_enable="YES"
```

就搞定了。

桌面的体验比gnome2感觉要流畅很多。

---

安装初始状态：FreeBSD 11.0标准化安装流程进行完后，未进行任何操作的裸机。

首先进行的是

\#portsnap fetch update

\#portsnamp extercet

1、安装wget

\#cd /usr/port/ftp/wget

\#make install clean



[FreeBSD安装各种字体](https://www.linuxidc.com/Linux/2014-02/96133.htm)

[[最近几天玩freebsd奋斗成果总结](http://www.cnblogs.com/william-lee/archive/2015/08/26/4761358.html)

[bsd博客很多](https://www.cnblogs.com/x3d/category/409118.html)