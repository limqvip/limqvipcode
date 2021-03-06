---
title: Debian-Mysq配置
comments: true
date: 2018-08-31 19:45:45
updated: 2018-08-31 19:45:45
tags:
categories:
---

### Debian下MySQL配置

#### **1 修改MySQL的口令**　　

由于MySQL默认没有口令，为了安全起见，一定要修改你的口令！
　　先来看看你的mysql是不是真的没有口令：



`$ mysqladmin version`

　　如果你能够看到mysql的版本信息，证明目前MySQL没有口令。
　　好，运行mysqladmin password xxxxxx 修改口令:

`mysqladmin password xxxxxx`

　　这里xxxxxx是你的新口令。
　　现在你需要运行 mysqladmin version --user=root --pass,然后输入口令，才能查看版本号等信息。
　　注意，上面命令中的--user=root --pass这一部分，可以简写为-u root -p。我们来测试一下，看口令是否生效：

`mysqladmin version -u root -p Enter password:`

#### **2 打开3306端口监听**

　　这项工作要慎重。处于安全考虑，默认情况下，Debian把3306端口关闭了。因为，不少黑客通过它来攻击你的系统。如果你不通过其他机器来存取数据库，那么不要打开这个端口。
　　修改/etc/mysql/my.cnf，找到：

`skip-networking`

　　把它注释掉：

`#skip-networking`

#### **3 修改默认字符集**　　

　　让MySQL把简体中文作为默认的字符集。编辑/etc/init.d/mysql，找到这一行：

`/usr/bin/safe_mysqld > /dev/null 2>&1 &`

 　　改成：

`/usr/bin/safe_mysqld > --default-character-set=gb2312 > /dev/null 2>&1 &`

　　好，重新启动MySQL:

`#/etc/init.d/mysql restart`



---

1. Mysql安装

   `apt-get install mysql-server` 安装 Mysql

2. Mysql 登录

   `sudo mysql`

3. 查看已有数据库
   `show databases;`

4. 创建一个数据库

   `CREATE DATABASE my_suppliers;`

5. 选择数据库

   `USE my_suppliers;`

6. 创建一个表

   ```sql
   CREATE TABLE IF NOT EXISTS Suppliers
   (Supplier_Name VARCHAR(20),
   Invoice_Number VARCHAR(20),
   Part_Number VARCHAR(20),
   Cost FLOAT,
   Purchase_Date DATE);
   ```

7. 查看表结构
   `DESCRIBE Suppliers;`

8. 创建一个新用户设置密码

   `CREATE USER 'username'@'localhost' IDENTIFIED BY 'secret_password';`

9. 给用户授权

   ```sql
   GRANT  ALL PRIVILEGES ON my_suppliers.* TO 'username'@'localhost';
   FLUSH PRIVILEGES;
   ```

----

然大家可能在python2.x中用习惯了mysqldb，但是在python3.x中已经不支持那个组件了。

取而代之的是：

import pymysql

所以，大家pip起来吧。另外，mysql官方出了个mysql.connector，也可以用。

我这用的例子如下：

import pymysql 
conn = pymysql.connect(host=’127.0.0.1’, port=3306, user=’root’, passwd=’test’, 
db=’mysql’) 
cur = conn.cursor() 
cur.execute(“SELECT * FROM user”) 
for r in cur.fetchall(): 
print(r) 
\#cur.close() 
conn.close()

----

[Python3 连接 Mysql](https://www.cnblogs.com/sheng-247/p/7681039.html)



----

# inux打通两台机器的ssh功能（linux远程连接可以不输入密码）

2017年05月25日 17:58:01 

标签： [linux](http://so.csdn.net/so/search/s.do?q=linux&t=blog)[ssh](http://so.csdn.net/so/search/s.do?q=ssh&t=blog)[免密](http://so.csdn.net/so/search/s.do?q=%E5%85%8D%E5%AF%86&t=blog)更多

个人分类： [ssh](https://blog.csdn.net/yan_wenliang/article/category/6938951)



> **注意：** 
> .ssh 这个文件夹需要有700权限 
> 执行**chmod -R 700 .ssh && chmod 700 .ssh/. && chmod 700 .ssh/..** 
> 记住，两个隐藏文件夹也要有700权限。

ssh-copy-id 方法：

```java
//到用户目录
cd

//生成一对密钥：id_rsa（私钥）和id_rsa.pub（公钥），保存在~/.ssh目录。
//遇到停顿，一直回车就可以。
//如果之前生成过，不用操作这个步骤
ssh-keygen -t rsa

//将公钥拷贝到目标机器，需要密码
ssh-copy-id -i ~/.ssh/id_rsa.pub $username@$ip12345678910
```

scp方法

```java
cd           

//如果之前生成过，不用操作这个步骤
ssh-keygen -t rsa

scp ~/.ssh/id_dsa.pub $username@$ip:~/.ssh/source-machine-key

//登录到目标主机，这次需要密码
ssh $username@$ip

cat ~/.ssh/source-machine-key >> ~/.ssh/authorized_keys
```







-----










































































