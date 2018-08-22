---
title: 用 Hexo + Github 搭建属于自己的博客
date: 2018-08-20 11:13:56
tags: Python
categories: 
- Program
- hexo
---

最近几天一直想做一个自己的博客，把学习过的技术看过的文章都整理起来，花了几天的时间[博客](limqvip.github.io)初步搭建完成，看了很多大佬文章，但是自己搭建还是遇到很多坑，下面就写写搭建过程。希望对看到的人有帮助。

本文主要介绍 Windows 7 x64 下 Hexo: 3.7.1 + GitHub 搭建（不同的 Hexo 版本，有的设置可能会有差异）。

## 搭建环境

#### 	1. 安装 git

可以到 [git](https://git-scm.com/download/win) 官网下载相应平台版本进行安装。

#### 	2. 申请 GitHub 账号

进入 [GitHub ](https://link.jianshu.com/?t=https://github.com/) 注册。注册过程略。

#### 	3. 安装 node.js

到 [node.js](https://link.jianshu.com/?t=https://nodejs.org/en/download/) 官网下载相应平台的最新版本，傻瓜式安装（自带安装 npm）。在 git bash 下执行`npm -v` 查看是否安装成功 npm。如果安装成功会显示对应版本号。

```bash
$ npm -v
5.6.0
```

#### 4. 安装 Hexo

打开 git bash 或者 cmd, 执行以下命令:
`npm install -g hexo`

## 搭建 Hexo

#### 1. 初始化 

执行`hexo init myblog`创建一个名为 myblog 的博客。该命令会生成一个 myblog 文件夹。进入 myblog 目录 `cd myblog `, myblog 是博客的主目录。

#### 2. 安装必须依赖包

`hexo install <name>`

#### 3. 生成静态页面

`hexo generate` or `hexo g`

#### 4. 本地运行

`hexo server` 或者 `hexo s`

打开浏览器，在地址栏输入localhost:4000，就可以看到我们搭建好的本地博客了。到此只是搭建好了本地博客。

## 部署博客到 GitHub , 通过域名访问博客。
#### 1.新建repository

建立与你用户名对应的仓库，仓库名必须为【 your_username.github.io】,例如我的博客 limqvip.github.io. 

#### 2.部署博客

##### 1. 修改配置文件

进入你的hexo文件夹根目录下，用编辑器打开 _config.yml, 修改 deploy 项，如下（根据你的 GitHub 进行相应更改）：

```bash
deploy:
  type: git       #注意：有的版本type是github
  repo: https://github.com/limqvip/limqvip.github.io.git
  branch: master
```

##### 2. 执行 `hexo d` 部署到 github 上。

```bash
INFO  Deploying: git
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
INFO  Copying files from extend dirs...
…略
 create mode 100644 "tags/\347\211\210\346\234\254\346\216\247\345\210\266/index.html"
Branch master set up to track remote branch master from git@github.com:limqvip/limqvip.github.io.git.
To github.com:limqvip/limqvip.github.io.git
   5867eb8..f25e3d4  HEAD -> master
INFO  Deploy done: git
```

此时就完成部署了，用浏览器访问 https://limqvip.github.io 即可(第一次发布可能会有 10 分钟的延迟)。

每次修改完本地的文件后要执行以下命令，重新部署到 github 上：

`hexo clean`
`hexo generate`
`hexo deploy` 或者 `hexo d`

#### 常用命令

`hexo new "postName"` #新建文章
`hexo new page "pageName"` #新建页面
`hexo generate` #生成静态页面至public目录
`hexo server` #开启预览访问端口（默认端口 4000, 'ctrl + c' 关闭 server）
`hexo deploy` #将 .deploy 目录部署到 GitHub
`hexo help` # 查看帮助
`hexo version` #查看 Hexo 的版本

#### 报错总结

1. 出现 error deployer not found:git 或者 error deployer not found:github 的错误

   解决办法：执行 npm install hexo-deployer-git --save

2. 出现类似 FATAL can not read a block mapping entry; a multiline key may not be an implicit key at line 70, column 1: ... 错误

   解决办法：_config.yml 中配置项的英文冒号后面要用空格隔开，再跟内容。

3. 中文乱码问题

   解决办法：将文件的内容编码改为 UTF8 格式

4. 'hexo sever' 能够成功运行，但是 localhost:4000 无法访问

   解决办法：执行 hexo s -p 5000, 改用其他端口启动

   ---

   安装步骤很简单，但中间走了很多弯路，因此，主要记录一下那些曾经走过的弯路。

   1. 新建项目时报错：
npm WARN deprecated istanbul-lib-hook@1.2.1: 1.2.0 should have
 been a major version bumpnpm ERR! Unexpected end of JSON input while parsing near ‘...registry.npm.taobao.o‘ npm ERR! A complete log of this run can be found in:npm ERR!     
C:\Users\Admin\AppData\Roaming\npm-cache\_logs\2018-06-08T14_01_13_067Z-debug.logPackage install failed, see above. 如下所示：

      解决方法：网上查找的一般是说运行：`npm cache clean --force`，但清除缓存之后，再次新建项目，还是报这个错。然后根据提示信息，取消了淘宝镜像，问题解决。

      取消淘宝镜像：

      ```bash
      npm uninstall -g angular-cli 
      npm uninstall -g @angular/cli 
      npm cache clean 
      ```

      运行 `npm config edit` 可看到 registry 中已经变成了默认镜像。参考：设置和取消淘宝镜像 

   2. 新建项目时报的警告：npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"}) ‘git‘ 不是内部或外部命令，也不是可运行的程序或批处理文件。 安装git插件

   3. 卸载 angular, 因为反反复复卸载重装了好几次 angular, 因此也记录一下卸载过程吧。

      ```bash
      npm uninstall -g angular-cli 
      npm uninstall -g @angular/cli
      npm cache clean  
      ```

       在运行 `npm cache clean`  时报错如下图，根据信息提示改成了 `npm cache verify`  总结：一定要根据官网教程安装，网上的教程很多很乱，开始就是根据网上教程装的很混乱，   导致报了很多莫名其妙的错。 本文由职坐标整理并发布，希望对同学们有所帮助。了解更多详情请关注 WEB 前端 Node.js 频道！ 