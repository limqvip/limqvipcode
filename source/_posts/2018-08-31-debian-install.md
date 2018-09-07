---
title: debian-install
comments: true
date: 2018-08-31 19:45:45
updated: 2018-08-31 19:45:45
tags:
categories:
---

# 制作 Debian 安装 U 盘

用 Debian8 ios

更新源 /etc/apt/sources.list

## 安装中文搜狗输入法

```bash
bash
#apt-get update
#apt-get install fcitx
#gdebi   *.deb  # 类似于dpkg 自动下载相关依赖
#im-config 配置fcitx为第一输入。

get update`
```



## 安装 flux 护眼小程序



## 安装 Teamview 远程控制软件

# 安装nodejs

1、去官网下载和自己系统匹配的文件：

 英文网址：https://nodejs.org/en/download/

 中文网址：http://nodejs.cn/download/

 通过  uname -a  命令查看到我的Linux系统位数是64位（备注：x86_64表示64位系统， i686 i386表示32位系统），如图

![img](https://images2015.cnblogs.com/blog/625378/201703/625378-20170301104556454-1441797328.png)

故下载一下红色框中文件 ，版本为v6.10.0

![img](https://images2015.cnblogs.com/blog/625378/201703/625378-20170301103915345-1771725166.png)

2、下载下来的tar文件上传到服务器并且解压，然后通过建立软连接变为全局；

1）上传服务器可以是自己任意路径，目前我的放置路径为  cd /app/software/

2）解压上传（解压后的文件我这边将名字改为了nodejs，这个地方自己随意，只要在建立软连接的时候写正确就可以）

    ① tar -xvf   node-v6.10.0-linux-x64.tar.xz   
    
    ② mv node-v6.10.0-linux-x64  nodejs 
    
    ③确认一下nodejs下bin目录是否有node 和npm文件，如果有执行软连接，如果没有重新下载执行上边步骤；

3）建立软连接，变为全局

 

   ①ln -s /app/software/nodejs/bin/npm /usr/local/bin/ 

 

   ②ln -s /app/software/nodejs/bin/node /usr/local/bin/

 

4）最后一步检验nodejs是否已变为全局

 

   在Linux命令行node -v 命令会显示nodejs版本，如图所示为大功告成

![img](https://images2015.cnblogs.com/blog/625378/201703/625378-20170301111018532-950176454.png)





[linux 下 tar.gz tar bz2 zip 等压缩解压缩命令小结](https://www.jb51.net/LINUXjishu/43356.html)

#### **压缩** 

> tar –cvf jpg.tar *.jpg //将目录里所有jpg文件打包成tar.jpg 
> tar –czf jpg.tar.gz *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用gzip压缩，生成一个gzip压缩过的包，命名为jpg.tar.gz 
> tar –cjf jpg.tar.bz2 *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用bzip2压缩，生成一个bzip2压缩过的包，命名为jpg.tar.bz2 
> tar –cZf jpg.tar.Z *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为jpg.tar.Z 
> rar a jpg.rar *.jpg //rar格式的压缩，需要先下载rar for linux 
> zip jpg.zip *.jpg //zip格式的压缩，需要先下载zip for linux

#### **解压**

> tar –xvf file.tar //解压 tar包 
> tar -xzvf file.tar.gz //解压tar.gz 
> tar -xjvf file.tar.bz2 //解压 tar.bz2 
> tar –xZvf file.tar.Z //解压tar.Z 
> unrar e file.rar //解压rar 
> unzip file.zip //解压zip 
> 

#### **总结**

> 1、*.tar 用 tar –xvf 解压 
> 2、*.gz 用 gzip -d或者gunzip 解压 
> 3、*.tar.gz和*.tgz 用 tar –xzf 解压 
> 4、*.bz2 用 bzip2 -d或者用bunzip2 解压 
> 5、*.tar.bz2用tar –xjf 解压 
> 6、*.Z 用 uncompress 解压 
> 7、*.tar.Z 用tar –xZf 解压 
> 8、*.rar 用 unrar e解压 
> 9、*.zip 用 unzip 解压

#### **Linux下解压RAR软件下载和解压.zip和.rar文件**

下载地址：http://www.rarsoft.com/download.htm（目前最新为RAR 3.71 for Linux）

以最新的为准。

对于Window下的常见压缩文件.zip和.rar，Linux也有相应的方法来解压它们：

#### **1:对于.zip**

linux下提供了zip和unzip程序，zip是压缩程序，unzip是解压程序。它们的参数选项很多，这里只做简单介绍，举例说明一下其用法：

[?](https://www.jb51.net/LINUXjishu/43356.html#)

```
`# zip all.zip *.jpg(这条命令是将所有.jpg的文件压缩成一个zip包)``# unzip all.zip(这条命令是将all.zip中的所有文件解压出来)`
```

#### **2:对于.rar**

要在linux下处理.rar文件，需要安装RAR for Linux，可以从网上下载，但要记住，RAR for Linux不是免费的；可从http://www.rarsoft.com/download.htm下载RAR 3。60 for Linux ，然后安装其安装操作如下:

[?](https://www.jb51.net/LINUXjishu/43356.html#)

```
`# tar -xzpvf rarlinux-3.2.0.tar.gz``# cd rar``# make`
```

这样就安装好了，安装后就有了rar和unrar这两个程序，rar是压缩程序，unrar是解压程序。它们的参数选项很多，举例说明一下其用法

[?](https://www.jb51.net/LINUXjishu/43356.html#)

```
`# rar a all *.jpg`
```

这条命令是将所有.jpg的文件压缩成一个rar包，名为all.rar，该程序会将.rar 扩展名将自动附加到包名后。

[?](https://www.jb51.net/LINUXjishu/43356.html#)

```
`# unrar e all.rar`
```

这条命令是将all.rar中的所有文件解压出来。

xxxx.tar.gz文件使用tar带zxvf参数，可以一次解压开。XXXX为文件名。例如：


[?](https://www.jb51.net/LINUXjishu/43356.html#)

```
`$tar zxvf xxxx.tar.gz`
```

**gzip -d**

语 法：gzip [-acdfhlLnNqrtvV][-S <压缩字尾字符串>][-<压缩效率>][--best/fast][文件...] 或 gzip [-acdfhlLnNqrtvV][-S <压缩字尾字符串>][-<压缩效率>][--best/fast][目录]

补充说明：gzip是个使用广泛的压缩程序，文件经它压缩过后，其名称后面会多出".gz"的扩展名。

参 数：


-a或--ascii 使用ASCII文字模式。 
-c或--stdout或--to-stdout 把压缩后的文件输出到标准输出设备，不去更动原始文件。 
-d或--decompress或----uncompress 解开压缩文件。 
-f或--force 强行压缩文件。不理会文件名称或硬连接是否存在以及该文件是否为符号连接。 
-h或--help 在线帮助。 
-l或--list 列出压缩文件的相关信息。 
-L或--license 显示版本与版权信息。 
-n或--no-name 压缩文件时，不保存原来的文件名称及时间戳记。 
-N或--name 压缩文件时，保存原来的文件名称及时间戳记。 
-q或--quiet 不显示警告信息。 
-r或--recursive 递归处理，将指定目录下的所有文件及子目录一并处理。 
-S<压缩字尾字符串>或----suffix<压缩字尾字符串> 更改压缩字尾字符串。 
-t或--test 测试压缩文件是否正确无误。 
-v或--verbose 显示指令执行过程。 
-V或--version 显示版本信息。 
-<压缩效率> 压缩效率是一个介于1－9的数值，预设值为"6"，指定愈大的数值，压缩效率就会愈高。 
--best 此参数的效果和指定"-9"参数相同。 
--fast 此参数的效果和指定"-1"参数相同。

1、*.tar 用 tar –xvf 解压
2、*.gz 用 gzip -d或者gunzip 解压
3、*.tar.gz和*.tgz 用 tar –xzf 解压
4、*.bz2 用 bzip2 -d或者用bunzip2 解压
5、*.tar.bz2用tar –xjf 解压
6、*.Z 用 uncompress 解压
7、*.tar.Z 用tar –xZf 解压
8、*.rar 用 unrar e解压
9、*.zip 用 unzip 解压

Linux下*.tar.gz文件解压缩命令

#### **1.压缩命令：**

命令格式：tar -zcvf 压缩文件名.tar.gz 被压缩文件名

可先切换到当前目录下。压缩文件名和被压缩文件名都可加入路径。

#### **2.解压缩命令：**

命令格式：tar -zxvf 压缩文件名.tar.gz

解压缩后的文件只能放在当前的目录。

你可以使用 zip 命令同时处理多个文件和目录，方法是将它们逐一列出，并用空格间隔：

zip -r filename.zip file1 file2 file3 /usr/work/school 


压缩单个目录命令zip -r filename.zip filename

上面的命令把 file1、file2、 file3、以及 /usr/work/school 目录的内容（假设这个目录存在）压缩起来，然后放入 filename.zip 文件中。

