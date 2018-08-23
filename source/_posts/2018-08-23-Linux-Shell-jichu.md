title: Linux Shell  编程基础
date: 2018-08-24 23:13:56
updated: 2018-08-24 23:26:12
tags: [Shell, Linux]
categories: 

- Program 
- Shell
description: Linux&#58; 本文介绍 Linux 常用 Shell 命令及简单 Shell 脚本。
---
## 第一讲

zh_CN.GB18030
`cat /etc/shells` 可以查看系统的 shell 种类。`echo $SHELL` 查看当前使用的shell。在当前shell中运行其它shell，例：

```bash
# /bin/csh ls -lh。 
chomod u=rwx,g+w,o+r file 
chown -R jack /etc/test/ #把这个目录下所有的子目录和文件的拥有者都改变成jack
```

把这个目录下所有的子目录和文件的拥有者都改变成jack。

`chown jack.jack /etc/test/ -R`
umask   文件   目录
0	6	7
1	5	6
2	4	5
3	3	4
4	2	3
5	1	2
6	0	1
7	0	0
/etc/profile 文件中可以设定 umask 值。

`alias ll='ls -alh'`

`cat $HOME/.bashrc` , 别名都放在这个文件中。

命令替换：`ls \`cat myfile\` -al`，这个反引号就是1左边的键，把myfile的内容输出到ls的输入。
后台运行：# nohup tar -czf abc.tar.gz /etc/abc/ &。jobs -l查看后台运行情况。
模式匹配：ls *.txt -l。

## 第二讲

本地变量在用户现在的shell生命期的脚本中使用，例在当前shell中设置变量，ABC=123，然后exit退出当前shell，再进入系统用set指令(显示本地变量)发现ABC变量无。readonly ABC，把ABC设置成只读变量。只是用readonly指令显示当前shell中有哪些只读变量。

环境变量用于所有用户进程（经常称为子进程）。登录进程称为父进程，shell中执行的用户进程均称为子进程。不像本地变量(只用于现在的shell)环境变量可用于所有子进程，这包括编辑器，脚本和应用。 
$HOME/.bash_profile(/etc/profile)
export，例：export ABC="shell program"，把ABC这个变量变成环境变量。直接输入export也可以查看环境变量有哪些。readonly ABC，把环境变量ABC变成只读的。

变量替换：
${var name}	显示实际值到var name
${var name:+value}	如果设置了var name，则显示其值value，否则为空
${var name:?value}	如果未设置var name，显示用户定义错误信息value
${var name:-value}	如果未设置var name，显示其值value，如果设置了var name则显示var name的值
${var name:=value}	如果未设置var name，设置其值并显示，如果设置了var name则显示var name的值
env
unset ABC，删除ABC变量，但是用readonly声明的变量是不能被unset的。

位置变量：先看下面的脚本

```bash
#!/bin/bash
#parms
echo "program name is $0"
echo "1 parm is $1"
echo "2 parm is $2"
echo "3 parm is $3"
echo "4 parm is $4"
```

然后运行这个脚本：./parms a b c d，就会显示结果,$0表示脚本名称，$1-9分别表示位置变量名，在运行脚本时代入脚本中。
再例如：

```bash
#!/bin/bash
#parm.sh
find /home/chinaitlab/shell -name $1 -print
```

然后运行这个脚本: `./parm.sh abc.txt` 。

标准变量：bash 默认建立了一些标准环境变量，可在 /etc/profile 中定义。
 EXINIT，运行 vi 时初始化设置一些参数
HOME
IFS
LOGNAME
MAIL
MAILCHECK
MAILPATH
PATH
PS1
PS2
SHELL
TERMINFO
TERM
TZ
EDITOR
PWD
MANPATH

特殊变量：
$#(传递到脚本的参数个数)
$*(以一个单字符串显示所有向脚本传递的参数。与位置变量不同，此选项参数可超过9个)
$$(脚本运行的当前进程ID号)
$!(后台运行的最后一个进程的进程ID号)
$@(与$#相同，但是使用时加引号，并在引号中返回每个参数)
$-(显示shell使用的当前选项，与set命令功能相同)
$?(显示最后命令的推出状态。0表示没有错误，其它任何值表明有错误)

影响变量的命令：
declare
-设置或显示变量
-f 只显示函数名
-r 创建只读变量(declare和typeset)
-x 创建转出变量
-i 创建整数变量
- 使用+替代-，可以颠倒选项的含义
  export
  -用于创建传给予shell的变量(环境变量)
- --表明选项结束，所有后续参数都是实参
- -f表明在"名-值"对中的名字是函数名
- -n把全局变量转换成局部变量，换句话说，命令的变量不再传给shell
- -p显示全局变量列表
  unset
- 用于取消变量的定义
- --表明选项结束
- -f删除只读变量，但不能取消从shell环境中删除指定的变量和函数如：PATH，PS1，PS2，PPID，UID，EUID等的设置。
  shift[n]
- 用于移动位置变量，调整位置变量，使$3的值赋予$2,$2的值赋予$1。
  typeset
  -用于显示或设置变量
  -是declare的同义词

引号：
使用双引号可以引用除字符$,`(反引号),\外的任意字符或字符串。例：echo -e "ert, $SHELL'\n* china`echo itlab`"。
单引号会忽略其中所有的特殊含义的字符，例：echo 'ert, $SHELL * china`echo itlab`'。
反引号用于设置系统命令的输出到变量，shell将反引号中的内容作为一个系统命令，并执行其内容。
反斜杠：如果一个字符有特殊含义，反斜杠防止shell误解其含义，即屏蔽其特殊含义，这些字符有特殊含义： $,*,+,&,",|,?,^例：echo *，显示当前目录下的所有文件名，echo \*，则显示*。

运算符类型：
按位运算符	~,<<,>>,&,|,^
运算符		说明
~op1		反运算符，把op1中所有的二进制为1变为0，0变为1
op1<<op2	左移运算符，把op1中的二进制位向左移动op2位，忽略最左端移出的各位，最右端的各位补0值，每做一次按位左移就有实现op1乘以2。
op1>>op2	右移运算符，把op1中的二进制位向右移动op2位，忽略最右端移出的各位，最左端的各位补0值，每做一次按位右移就有实现op1除以2。
op1&op2		与比较运算符，op1和op2对应位，对于每个二进制位来说，如果二者该位都是1，则结果为1，否则为0。
op1^op2		异或运算符，op1和op2对应位，对于每个二进制位来说，如果二者该位互补，则结果为1否则为0。
op1|op2		或运算符。
$[]表示形式告诉shell对方括号中的表达式求值，例：echo $[2+8]，echo $[2>>8]，echo $[2<<4]，echo $[2^4]，echo $[~3]。
逻辑运算符：&&,||,>,==,<,!=例：echo $[2&&2]，echo $[1||0]。
赋值运算符：=,+=,-=,*=,/=,%=,&=,^=,|=,<<=,>>=
let $count=$count+$change
let $count+=$change
$[]可以接受不同基数的数字
- [ base#n ] n表示基数从2到36的任何基数，例：echo $[10#8+1]，8进制的10加上1，结果为9。

## 第三讲

echo [option] string

- e解析转义字符
- -n回车不换行，linux系统默认回车换行，例：echo "hello"和echo -n "hello"的区别。
- string中的转义符(\c,\f,\t,\n)，\c表示回车不换行，\f表示禁止，\t表示跳格(tab)，\n表示回车换行
  例：
  ```bash
  #!/bin/bash
  #echod
  echo -e "This echo's 3 new lines\n\n\n"
  echo "OK"
  echo
  echo "This echo's 3 new lines\n\n\n"
  echo "The log files have all been done">mylogfile.txt
  ```

read语句可以从键盘或文件的某一行文本中读入信息，并将其赋给一个变量。
read var1 var2...
-如果只指定了一个变量，那么read将会把所有的输入赋给该变量，直至遇到第一个文件结束符或回车；如果给出了多个变量，他们按顺序分别被赋予不同的变量。shell将用空格作为变量之间的分隔符。
例：
#!/bin/bash
#readname
echo -n "First name:"
read firstname
echo -n "Last name:"
read lastname
echo -e "Your First Name is :${firstname}\n"
echo -e "Your Last Name is :${lastname}\n"

cat可显示文件内容，创建文件还可以显示控制字符。
cat [options] file1 file2...
- -v显示控制字符
  使用cat命令时要注意，它不会在文件分页符处停下来，它会一下显示完整个文件，如果希望每次显示一页，可以使用more。例：cat file1 file2 file3，会在屏幕上同时显示三个文件的内容，cat file1 file2 file3>file123，会把这三个文件的内容合并到一个文件file123中，cat -v dos.txt，显示这个windows下生成的文件，并显示控制字符(这些控制字符是在windows生成这个文件时加入的)。
  管道举例：df -k|awk '{print $1}'|grep -v "Filesystem"。
  tee命令把输出的一个副本输送到标准输出，另一个副本拷贝到相应的文件中。
  tee -a files
- 如果希望在看到输出的同时，也将其存入一个文件，那么这个命令再合适不过了，一般用于管道之后，-a参数表示追加写入files中，如果没有-a参数，则覆盖写入这个文件中。例：who | tee -a who.out。

标准输入输出和错误
在shell中执行命令时，每个进程都和三个打开的文件相联系，并使用文件描述符来引用这些文件，由于文件描述符不容易记忆，shell同时给出了相应的文件名。
文件			文件描述符
输入文件-标准输入	0(缺省是键盘，也可以是文件或其它命令的输出)
输出文件-标准输出	1(缺省是屏幕，也可以是文件)
错误输出文件-标准错误	2(缺省是屏幕，也可以是文件)
系统中实际上有12个文件描述符，可以任意使用文件描述符3到9。

文件重定向
command > file		把标准输出重定向到一个新文件中
command >> file		把标准输出重定向到一个文件中(追加)
command 1 > file	把标准输出重定向到一个文件中
command > file 2>&1	把标准输出和标准错误一起重定向到一个文件中
command 2 > file	把标准错误重定向到一个文件中
command 2>> file	把标准输出重定向到一个文件中(追加)
command >> file 2>&1	把标准输出和标准错误一起重定向到一个文件中(追加)
command < file > file2	command命令以file作为标准输入，file2文件作为标准输出
command < file		command命令以file作为输入
command << dclimiter	从标准输入中读入，直至遇到dclimiter分界符
command < &m		把文件描述符m作为标准输入
command > &m		把标准输出重定向到文件描述符m中
command < &-		关闭标准输入
例：>nullfile，创建一个新的空文件。sort < file，把file作为输入源，排序然后输出到屏幕上。sort < name.txt > name.out。cat account_new.txt account_old.txt 1>accounts.out 2>accounts.err，account_new.txt存在，account_old.txt不存在，那么accounts.out将包含account_new.txt的内容，不会包含account_old.txt的内容，account_old.txt不存在的错误信息会写入accounts.err中。
合并标准输出和标准错误的时候，切忌shell是从左至右分析相应的命令，例：grep "standard" standard.txt > grep.out 2>&1。

exec命令可以用来替代当前shell；换句话说，并没有启动子shell，使用这一命令时任何现有环境都会被清除，并重新启动一个shell。
exec command
-其中的command通常是一个shell脚本。
对文件描述符进行操作的时候(也只有在这时)，它不会覆盖你当前的shell。

文件描述符：
3-9文件描述符
exec与文件描述符的结合
例：
#!/bin/bash
#file_desc
exec 3<&0 0<name.txt
read line1
read line2
exec 0<&3
echo $line1
echo $line2

## 第四讲 控制流结构
```bash
if 条件1
then
	命令1
elif 条件2
then
	命令2
else
	命令3
fi
```
例：

```bash
#!/bin/bash
#if test
if [ "10" -lt "12" ]
then
   echo "yes,10 is less than 12"
fi
```

可以使用man test获得条件的帮助。
再例：

```bash
#!/bin/bash
#iftest2
echo -n "Enter your name:"
read NAME
if [ "$NAME" == "" ];then
	echo "You did not enter your name"
fi
```

再例：

```bash
#!/bin/bash
#ifcp
if cp myfile.bak myfile;then
echo "good copy"
else echo "basename $0:error could not copy files" >&2
fi
```

再例：

```bash
#!/bin/bash
#ifelif
echo -n "Enter your name:"
read NAME
if [ -z $NAME ] || [ "$NAME" = "" ];then
	echo "you do not enter a name."
elif [ "$NAME" = "root" ];then
	echo "hello root"
elif [ "$NAME" = "chinaitlab" ];then
	echo "hello chinaitlab"
else
	echo "you are not root or chinaitlab,but hi,$NAME"
fi
```

case语句格式: 

```bash
case 值 in
模式1)
	命令1
	;;
模式2)
	命令2
	;;
esac
```

case取值后面必须为单词in，每一个模式必须以右括号结束。取值可以为变量或常数，匹配发现取值符合某一模式后，其间所有命令开始执行直至;;。模式匹配符*表示任意字符,?表示任意单字符，[..]表示类或范围中任意字符。
例：

```bash
#!/bin/bash
#case select 
echo -n "Enter a number from 1 to 3:"
read ANS
case $ANS in
1)
	echo "you select 1"
	;;
2)
	echo "you select 2"
	;;
3)
	echo "you select 3"
	;;
Y|y)
	echo "you select $ANS"
	;;
*)
	echo "basename $0:This is not between 1 and 3" >&2
	exit;
	;;
esac
```

for循环格式：

```bash
for 变量名 in 列表
do
	命令1
	命令2
done
```

当变量值在列表里，for循环即执行一次所有命令，使用变量名访问列表中取值。命令可为任何有效的shell命令和语句。变量名为任何单词。In列表用法是可选的，如果不用它，for循环使用命令行的位置参数。in列表可以包含替换，字符串和文件名。
例：

```bash
#!/bin/bash
#forlist1
for loop in 1 2 3 4 5
do
	echo $loop
done
```

再例：

```bash 
#!/bin/bash
#forlist2
for loop in "orange red blue grey"
do
  echo $loop
done
```

再例：
```bash
#!/bin/bash
#forlist2
for loop in `cat myfile`
do
  echo $loop
done
until循环格式：
until 条件
do
  命令1
  命令2
  ...
done
```
注：条件可为任意测试条件，测试发生在循环末尾，因此循环至少执行一次。
例：
```bash
#!/bin/bash
#until_mon
#监控分区
Part="/backup"
#得到磁盘使用的百分比
LOOK_OUT=`df|grep "$Part"|awk '{print $5}'|sed 's/%//g'`
echo $LOOK_OUT
until ["$LOOK_OUT" gt "90"]
do
  echo "FileSystem /backup is nearly full" |mail root
  LOOK_OUT=`df|grep "$Part"|awk '{print $5}'|sed 's/%//g'`
  sleep 3600
done
```
然后# nohup ./dfuntil &让这个程序在后台运行，一小时检测一次看这个分区的空间占用率是否大于90%。

while格式：
```bash
while 命令
do
  命令1
  命令2
  ...
done
```
注：在while和do之间虽然通常只使用一个命令，但可以放几个命令，命令通常用作测试条件。
例：
```bash
#!/bin/bash
#whileread
echo "按住<ctrl>+D退出输入。"
while echo -n "输入你最喜欢的电影：";read FILM
do
	echo "Yeah.${FILM}是一部好电影！"
done
```
再例：
```bash
#!/bin/bash
#whileread
while read LINE
do
	echo $LINE
done <names.txt
```
把names.txt这个文件的内容按每行输出到屏幕。
break与continue：
break[n]
-退出循环，如果是在一个嵌入循环里，可以指定n来跳出的循环个数。
例：
```bash
#!/bin/bash
#breakout
while :
do
  echo -n "Enter any number[1..5]:"
  read ANS
  case $ANS in
  1|2|3|4|5)
	echo "you enter a number between 1 and 5."
	;;
  *)
	echo "wrong number,bye."
	break
	;;
  esac
done
```
再例：
```bash
#!/bin/bash
#breakout
while :
do
  echo -n "Enter any number[1..5]:"
  read ANS
  case $ANS in
  1|2|3|4|5)
	echo "you enter a number between 1 and 5."
	;;
  *)
	echo -n "wrong number,continue(y/n)?:"
	read IS_CONTINUE
	case $IS_CONTINUE in
		y|yes|Y|YES)
			continue
			;;
		*)
			break
			;;
	esac
  esac
done
```
## 第五讲

正则表达式：一种用来描述文本模式的特殊语法，由普通字符(a到z)以及特殊字符(称为元字符，如/,*,?等)
匹配的字符串
文本过滤工具在某种模式下都支持正则表达式
基本元字符集及含义
字符	含义
^	只匹配行首
$	只匹配行尾

*	匹配0个或多个此单字符
  ]	只匹配[]内字符，可以是一个单字符，也可以是字符序列。可以使用-表示[]内字符序列范围，如用[1-5]代替[12345]。
  	只用来屏蔽一个元字符的特殊含义
  	只匹配任意单字符
  attern\{n\}	只用来匹配前面pattern出现次数。n为次数
  attern\{n,\}	含义同上，但次数最少为n
  attern\{n,m\}	含义同上，但pattern出现次数在n与m之间。
    例：
    ^d
  rwxrwxrw-	匹配
  rw-rw-rw	不匹配
    ^...1
  482XC56D	不匹配
  442XW7134	不匹配
  451ABC123	匹配
  D11XC9871	匹配
    trouble$--匹配以单词trouble结尾的所有字符
    ^$--匹配空行
    ^.$--匹配包含一个字符的行
    用\屏蔽一个特殊字符，特殊字符有",',||,^,*,.,+等，\*\.pas正则表达式中匹配以*.pas结尾的所有字符或文件。

逗号将括弧内要匹配的不同字符串分开，用-表示一个字符串范围
[0123456789]或[0-9]：任意一个数字
[a-z]：任意小写字母
[A-Z a-z]：任意大小写字母
[A-Z a-z 0-9]：任意字母或数字
[S,s]：匹配大小写s

A\{2\}B：A出现2次：AAB
A\{4,\}B：A最少出现4次，AAAAB，AAAAAB...
A\{2,4\}B：A出现次数范围2-4次，AAB，AAAB，AAAAB
[0-9]\{3\}\.[0-9]\{3\}\.[0-9]\{3\}\.[0-9]\{3\}：匹配IP地址

find命令形式
find pathname -option [-print -exec -ok]
-pathname查找路径，例如用.来表示当前目录，用/表示系统根目录。-print，find命令将匹配的文件输出到标准输出。-exec，find命令对匹配的文件执行该参数所给出的shell命令，相应命令的形式为'command'{} \;'，注意{}和\；之间的空格。-ok和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前都会给出提示，让用户来确定是否执行。
find命令的一般形式：
-name按照文件名找文件
-perm按照文件权限来找文件
-user按照文件属主来找文件
-group按照文件所属的组来找文件
-mtime -n +n按照文件的更改时间来查找文件。-n表示文件更改时间距现在n天以内，+n表示文件更改时间距现在n天以前。find命令还有-atime和-ctime选项，但他们都和-mtime选项相似
-size n[c]查找文件长度为n块的文件，带有c时表示文件长度以字节计。
-nogroup查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
-nouser查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
-newer file1 ! -newer file2查找更改时间比文件file1新但比文件file2旧的文件。
-type查找某一类的文件，比如：b块设备文件，d目录，c字符设备文件，p管道文件，l符号链接文件，f普通文件。

举例：
-name：可以使用某种文件名模式来匹配文件，记住要用引号将文件名模式引起来，例：
find -name "*.txt" -print，没有路径表示查找当前路径。find ./ -name "*.txt" -print。find ./ -name "[A-Z]*" -print，find /etc -name "host*" -print。
-perm：find . -perm 755 -print。
-user和-nouser：find `pwd` -user root -print。find `pwd` -nouser -print。
-group和-nogroup：find ./ -group itlab -print，find / -nogroup -print。
-mtime：find /var -mtime -5 -print，find /var -mtime +3 -print。
-newer：find `pwd` -newer "myfile" ! -newer "myfile123" -print。
-type：find /etc -type d -print。
-size：find . -size +1000000c -print查找文件大小大于1000000字节的文件，find . -size +10 -print，查找大小大于10块的文件。
-depth：使用find命令时，可能希望先匹配所有的文件，再在子目录中查找，find / -name "con.file" -depth -print。
-exec或ok：find . -type f -exec ls -l {} \;
find . -name "*.log" -mtime +5 -ok rm{} \;
-xargs:在使用find命令的-exec选项处理匹配到的文件时，find命令将所有匹配到的文件一起传递给exec，不幸的是有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟后就会出现溢出错误。错误信息通常是“参数列太长”或“参数列溢出”，这就是xargs命令的用处所在，特别是与find命令一起使用。exec会发起多个进程，而xargs不会多个，只有一个。例：find ./ -perm -7 -print | xargs chmod o-w，
find ./ -type f -print | xargs file。

grep介绍
对文本文件进行模式查找，grep有三种变形
-Grep：标准grep命令
-Egrep：扩展grep，支持基本及扩展的正则表达式
-Fgrep：快速grep
grep一般格式为：
-grep[选项]基本正则表达式[文件]
-字符串参数(基本正则表达式)最好采用双引号，一是以防被误解为shell命令，二是可以用来查找多个单词组成的字符串。
grep命令选项：
-c：只输出匹配行的计数
-i：不区分大小写(只适用于单字符)
-h：查询多文件时不显示文件名
-H：显示文件名
-l：查询多文件时只输出包含匹配字符的文件名
-n：显示匹配行及行号
-s：不显示不存在或无匹配文本的错误信息
-v：显示不包含匹配文本的所有行
例：
grep "jenny" *.txt
grep "sort it" *
grep -c "2004" myfile
grep -n "2004" myfile
grep -i "Jul" myfile
grep -v "2004:22" myfile
grep "2004:22:5[0-9]" myfile
grep "^[^210]" myfile，查找行首不是2或1或0的行。
grep "[5-8][6-9][0-2]" myfile
grep "4\{2\}" myfile
grep "4\{2,\}" myfile
grep "4\{2,4\}" myfile
grep "^$" myfile
grep "\?" myfile
grep "^d" myfile
grep "^[^d]" myfile

grep命令类名类等价的正则表达式
[[:upper:]][A-Z]
[[:alnum:]][0-9a-zA-Z]
[[:lower:]][a-z]
[[:space:]]	空格或tab键
[[:digit:]][0-9]
[[:alpha:]][a-zA-Z]
例：grep "5[[:digit:]][[:digit:]]" myfile

awk介绍
可从文件或字符串中基于指定规则浏览和抽取信息，是一种自解释的编程语言，三种方式调用awk：
-命令行方式：
	awk [-F field-spearator]'command' input-files，field-spearator默认是空格。
-awk脚本
	所有awk命令插入一个文件，并使awk程序可执行，然后用awk命令解释器作为脚本的首行，以便通过键入脚本名称来调用它。
-awk命令插入一个单独文件
	awk -f awk-script-file input-files

awk脚本由各种操作和模式组成
模式和动作：
    -模式部分决定动作语句何时出发及出发事件。(BEGIN,END)
    -动作对数据进行处理，放在大括号{}内指明。(input)
分隔符，域和记录：
    -awk执行时，其浏览域标记为$1,$2...$n。这种方法称为域标识。$0为所有域，即这条记录。
    -注意执行时不要混淆符号$和shell提示符$，他们是不同的。
例：awk '{print $0}' score.txt | tee score.out。
awk -F . '{print $0}' score.txt |tee score.out。
awk '{print $1 "\t"$4}' score.txt。
awk 'BEGIN {print "Name Maths\n------"} {print $1"\t"$4} END {print "end-of-report"}' score.txt。

awk中的特殊元字符：+和？，+表示匹配任意字符，？表示匹配单个字符。
匹配操作符：~(表示匹配),!~(表示不匹配)，要匹配的内容放在两个\之间。
cat score.txt|awk '$0 ~/218.79.131.96/'。
awk '$0 !~/218.79.131.96/' score.txt。
awk '{if($1=="218.79.131.96") print $0}' score.txt。

sed介绍
sed不与初始化文件打交道，它操作的只是一个拷贝，然后所有的改动如果没有重定向到一个文件，将输出到屏幕。sed是一种重要的文本过滤工具，使用一行命令或使用管道与grep与awk相结合。非交互性文本流编辑。调用sed有三种方式：
-使用sed命令行格式
   sed [选项] sed命令 输入文件
-使用sed脚本文件，格式为：
   sed [选贤] -f sed脚本文件 输入文件
-sed脚本文件[选项] 输入文件
-不管是使用shell命令行方式或脚本文件方式，如果没有指定输入文件，sed从标准输入中接受输入，一般是键盘或重定向结果。
sed命令选项：
-n不打印
-c下一命令是编辑命令
-f如果正在调用sed脚本文件

sed在文件中查找文本的方式
-使用行号，可以是一个简单数字或是一个行号范围
-使用正则表达式
x			x为一行号
x,y			表示行号范围从x到y
/pattern/		查询包含模式的行
/pattern/pattern/	查询包含两个模式的行
pattern/,x		在给定的行号上查询包含模式的行
x,/pattern/		通过行号和模式查询匹配行
x,y!			查询不包含指定行号x和y的行 
基本sed编辑命令：
p	打印匹配行
=	显示文件行号
a\	在定位行号后附加新文本信息
i\	在定位行号后插入新文本信息
d	删除定位行
c\	用新文本替换定位文本
s	使用替换模式替换相应模式
r	从另一个文件中读文本
w	写文本到一个文件
q	第一个模式匹配完成后退出或立即退出
l	显示与八进制ASCII代码等价的控制字符
{}	在定位行执行的命令组
n	从另一个文件中读文本下一行，并附加在下一行
g	将模式2粘贴到/pattern n/
y	传送字符

例：
sed '2p' score.txt，单引号中的是命令，打印score.txt这个文件的第二行，这里全部打印，因为没有加-n，这样匹配到的和没匹配到的都打印。
sed -n '2p' score.txt，-n表示不打印没匹配到的，只打印第二行。
sed -n '1,4p' score.txt，打印1~4行。
sed -n '/los/p' myfile.txt，打印包含los字符的所有行。
sed -n '4,/los/p' myfile.txt，从第四行开始匹配到第一个los结束，如果los在第六行，那么从第四行到第六行都打印，如果下面还有los也不打印了。
sed -n '/^$/=' myfile.txt，显示空行的行号。
sed -n -e '/^$/p' -e '/^$/=' myfile，打印空白行打印行号。
sed -n '/chinaitlab/a\shenzhen' myfile.txt。
sed -n '/chinaitlab/i\shenzhen' myfile.txt。
sed -n '/chinaitlab/c\chinaitlab shenzhen' myfile.txt。
sed '1,2d' myfile.txt，把第一第二行删除。
sed 's/chinaitlab/chinaitlab shenzhen/g' myfile.txt，当有多个chinaitlab时，加g表示全部替换。
sed -n 's/chinaitlab/& hello/p' myfile.txt， 在匹配到的所有的chinaitlab的后面加 hello。
sed -n 's/chinaitlab/hello &/p' myfile.txt，在匹配到的所有的chinaitlab的前面加 hello。
sed 'lr ctrl.txt' myfile.txt。
sed 'china/q' myfile.txt。
sed -n '/china/l' myfile.txt。

合并与分割
sort[options] files
-许多不同的域按不同的列顺序分类
-c测试文件是否已经分类
-m合并两个分类文件
-u删除所有复制行
-o存储sort结果的输出文件名
-t域分隔符：用非空格或tab键分割域
+n n为域号，使用此域号开始分类
n指定分类是域上的数字分类项
-r比较求逆

例：
sort -c myfile，检查这个文件是否已经排序。
sort -u myfile，





## 第六讲shell函数

定义函数格式：
函数名()
{
命令1
...
}
function 函数名()
{
...
}
函数可以放在同一个文件中作为一段代码，也可以放在只包含函数的单独文件中。
#!/bin/bash
#hellofun
function hello()
{
echo "hello,today is `date`"
return 0
}
echo "now going to the function hello"
hello
echo "back from the function"

参数传递：向函数传递参数就像在脚本中使用位置变量$1,$2...$9
例：
#!/bin/bash
#func
function hello()
{
echo "Hello,$1 today is `date`"
}
echo "now going to the function hello"
hello chinaitlab
echo "back from the function"

函数文件
#!/bin/bash
#func
#source function
. hellofun
echo "now going to the function hello"
hello
echo "back from the function"

#!/bin/bash
#hellofun
function hello()
{
echo "Hello, today is `date`"
return 0
}

检查载入函数和删除函数
察看载入函数set
删除函数unset
例：
#!/bin/bash
#func
#source function
. hellofun
set #察看加载的函数和变量信息
echo "now going to the function hello"
unset hello#删除这个函数
hello
echo "back from the function"

函数返回值：
#!/bin/bash
#hellofun
function hello()
{
echo "Hello, today is `date`"
return 0
}
#!/bin/bash
#func
echo "now going to the function hello"
hello
echo $?
echo "back from the function"

## 第七讲脚本参数传递

shift命令,每次讲参数位置向左偏移n位。
#!/bin/bash
#opt2
usage()
{
echo "usage:`basename $0` filenames"
}
totalline=0
if[ $# -lt 2 ];then
	usage
	exit#退出系统，下面的代码不执行
fi
while [ $# -ne 0]#参数个数不等于0
do
line=`cat $1|wc -l`
echo "$1:${line}"
totalline=$[$totalline+$line]
shift#调用shift时$#(参数个数)也跟着减1
done
echo "-----------"
echo "total:${totalline}"

getopts获得多个命令行参数
#!/bin/bash
ALL=false
HELP=false
FILE=false
VERBOSE=false
while getopts ahfvc OPTION
do
	case $OPTION in
	a)
		ALL=true
		echo "ALL IS $ALL"
		;;
	h)
		HELP=true
		echo "HELP is $HELP"
		;;
	f)
		FILE=true
		echo "FILE is $FILE"
		;;
	v)
		VERBOSE=true
		echo "VERBOSE is $VERBOSE"
		;;
	c)
		echo "c value is $c"
		;;
	\?)
		echo "`basename $0` -[a h f v] -[c value] file "
		;;
	esac
done