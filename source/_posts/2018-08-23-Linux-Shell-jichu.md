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

## 第三讲 Shell 输入与输出

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



---

#### 常用命令

#### linux使用备忘

查看linux文件目录的大小和文件夹包含的文件数：

du -sh xmldb/ #查看xmldb文件大小
du -sm * | sort -n  #统计当前目录大小 并安大小 排序
du -sk * | sort -n 

#### 压缩文件：

tar -zcvf  a.tgz aa   #压缩aa文件为a.tgz
tar -zxvf a.tgz #解压

#### 查找文件：

find / -name filename #在所有目录下查找filename
find /opt -name file* #在/opt下查找以find开头的文件
find / -amin -10 # 查找在系统中最后10分钟访问的文件
find / -atime -2 # 查找在系统中最后48小时访问的文件
find / -empty # 查找在系统中为空的文件或者文件夹
find / -group cat # 查找在系统中属于 groupcat的文件
find / -mmin -5 # 查找在系统中最后5分钟里修改过的文件
find / -mtime -1 #查找在系统中最后24小时里修改过的文件
find / -nouser #查找在系统中属于作废用户的文件
find / -user fred #查找在系统中属于FRED这个用户的文件

---

小红帽企业版的telnet为krb5-telnet，依附于xinetd服务，将/etc/xinetd.d/krb5-telnet
的disable设置为no，重启xinetd即可启用telnet服务，默认是不允许root用户登录。允许普通的telnet登陆，但也可使用kerberos5验证 

个人版RedHat Linux的telnet也是同样的道理，也是依附于xinetd服务，配置文件是/etc/xinetd.d/telnet。提供telnet服务，使用未加密的用户/密码组进行验证

用passwd修改用户密码，常常提示“BAD PASSWORD: it is based on a dictionary word”，实际上
linux要求的密码的验证机制是在/etc/login.defs中规定最小密码字符数。还要受到/etc/pam.d/passwd的限定，但是在root用户下怎么设置都可以，可以不受验证机制的约束，即便出来“BAD PASSWORD: it is based on a dictionary word”也可以修改成功。

但是普通用户修改自己的密码，如果不符合密码验证机制的话就修改不成功，会有各种报错，“BAD PASSWORD: it's WAY too short”，这是报密码太短，不符合/etc/login.defs的设置，“BAD PASSWORD: it is based on your username”，这是密码与帐号不能同名，这是不符合/etc/pam.d/passwd的设置。“BAD PASSWORD: it is based on a dictionary word”这是因为出现了字典里的字符串，如果你英文与数字组合使用，就不会报错。

----

### 目录

#### 1.ln 命令详解

`ln -s  源文件 目标文件`     -s 是 symbolic的意思。 
例：` ln  -s  /lib/lsb   /usr/lj`
即：在usr目录下建立指向/lib/lsb目录的lj文件。

`ln -s /opt/oracle /opt/app/oracle`
建立链接`/opt/oracle` 链接目录 `/opt/app/oracle`
比如在/data目录下建立一个a目录的连接b
`ln -s /data/a /data/b`
例如：
`ln -s db_1 /opt/oracle/product/10.2.0/db_1`
这条命令式在 /opt/oracle/product/10.2.0/db_1 下建立一个 db_1 的链接。
现在 /opt/oracle/product/10.2.0/db_1 下应该会还有个db_1

ln 是 Linux 中一个非常重要命令。它的功能是为某一个文件在另外一个位置建立一个同步的链接，这个命令最常用的参数是-s,具体用法是： 

ln -s  源文件 目标文件    -s 是 symbolic的意思。 
例： `ln  -s  /lib/lsb   /usr/lj`
即：在 usr 目录下建立指向 /lib/lsb 目录的lj文件。

备份命令
`tar -cvf oraclehome.tar /opt/oracle/product/10.2.0/db_1` 
备份一下 
解压命令
`tar -xvfz /opt/oracle/product/allbackup.tar.gz /opt/oracle/product/10.2.0`

当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。例如：`ln -s /bin/less /usr/local/bin/less-s 是代号（symbolic）的意思。这里有两点要注意：第一，ln命令会保持每一处链接文件的同步性，也就是说，不论你改动了哪一处，其它的文件都会发生相同的变化；第二，ln的链接又软链接和硬链接两种，软链接就是ln -s ** **,它只会在你选定的位置上生成一个文件的镜像，不会占用磁盘空间，硬链接ln ** **,没有参数-s, 它会在你选定的位置上生成一个和源文件大小相同的文件，无论是软链接还是硬链接，文件都保持同步变化。软链接是可以跨分区的，但是硬链接只能在同一分区内。如果你用ls察看一个目录时，发现有的文件后面有一个@的符号，那就是一个用ln命令生成的文件，用ls -l命令去察看，就可以看到显示的link的路径了当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。例如：`ln -s /bin/less /usr/local/bin/less `
注意： 

第一，ln命令会保持每一处链接文件的同步性，也就是说，不论你改动了哪一处，其它的文件都会发生相同的变化； 

第二，ln的链接又软链接和硬链接两种，软链接就是ln -s ** **,它只会在你选定的位置上生成一个文件的镜像，不会占用磁盘空间，硬链接ln ** **,没有参数-s, 它会在你选定的位置上生成一个和源文件大小相同的文件，无论是软链接还是硬链接，文件都保持同步变化。软链接是可以跨分区的，但是硬链接只能在同一分区内。
第三：目录不能建立硬链接，但可以建立软链接。 

```bash
Linux操作系统下共享文件夹设置方法介绍 

首先当然是要安装samba了，呵呵： 

sudo apt-get install samba 

sudo apt-get install smbfs 

下面我们来共享群组可读写文件夹，假设你要共享的文件夹为： /home/ray/share 

首先创建这个文件夹 

mkdir /home/ray/share 

chmod 777 /home/ray/share 

备份并编辑smb.conf允许网络用户访问 

sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup 

sudo gedit /etc/samba/smb.conf 

搜寻这一行文字 

; security = user 

用下面这几行取代 

security = user 

username map = /etc/samba/smbusers 

将下列几行新增到文件的最后面，假设允许访问的用户为：newsfan。而文件夹的共享名为 Share 

[Share] 

comment = Shared Folder with username and password 

path = /home/ray/share 

public = yes 

writable = yes 

valid users = newsfan 

create mask = 0700 

directory mask = 0700 

force user = nobody 

force group = nogroup 

available = yes 

browseable = yes 

然后顺便把这里改一下，找到［global］把 workgroup = MSHOME 改成 

workgroup = WORKGROUP 

display charset = UTF-8 

unix charset = UTF-8 

dos charset = cp936 

后面的三行是为了防止出现中文目录乱码的情况。其中根据你的local，UTF-8 有可能需要改成 cp936。自己看着办吧。 

现在要添加newsfan这个网络访问帐户。如果系统中当前没有这个帐户，那么 

sudo useradd newsfan 

要注意，上面只是增加了newsfan这个用户，却没有给用户赋予本机登录密码。所以这个用户将只能从远程访问，不能从本机登录。而且samba的登录密码可以和本机登录密码不一样。 

现在要新增网络使用者的帐号： 

sudo smbpasswd -a newsfan 

sudo gedit /etc/samba/smbusers 

在新建立的文件内加入下面这一行并保存 

newsfan = "network username" 

如果将来需要更改newsfan的网络访问密码，也用这个命令更改 

sudo smbpasswd -a newsfan 

删除网络使用者的帐号的命令把上面的 -a 改成 -x 

sudo testparm 

sudo /etc/init.d/samba restart 

如果还是不行查看Iptables（防火墙是否开启），如果开启可以先将服务停止。

最后退出重新登录或者重新启动一下机器。 

 

 

 

利用Samba配置文件共享服务

配置文件 /etc/samba/

//设置samba密码文件

# cat /etc/passwd|mksmbpasswd.sh > /etc/samba/smbpasswd

//为安全起见，设置文件和目录的权限

# chown root.root /etc/samba/smbpasswd

# chmod 500 /etc/samba

# chmod 600 /etc/samba/smbpasswd

//为用户设置口令

#smbpasswd root

//检查配置文件的正确性

# testparm

//检查服务器所共享的资源

# smbclient –L localhost

//列出资源使用情况

# smbstatus [-b]

//配置文件

节：

l         [Global] 定义全局参数和缺省值

l         [Homes] 定义用户的Home目录共享

l         [Printers] 定义打印机共享

l         [Userdefined_ShareName] 用户自定义共享（可有多个）

变量：

l         %S 当前服务名

l         %P 当前服务的根路径

l         %u 当前服务的用户名

l         %g 给定%u的所在工作组名

l         %H 给定%u的宿主目录

l         %v Samba版本号

l         %h 运行服务的主机名

l         %m 客户机的NETBIOS名

l         %L 服务器的NetBIOS名

l         %L 当前的日期和时间

 

//使用符号链接组织本地共享资源

# vi /etc/samba/smb.conf

[Resource]

    comment = Local Resource

    path = /var/samba/resource

    public = yes

writeable = yes

// -p  parent(no error if existing, make parent directories as needed)

# mkdir –p /var/samba/resource

#cd /var/samba/resource

//-s, --symbolic

# ln –s /usr/share/doc doc

//为所有用户配置只读共享和读写共享

# vi /etc/samba/smb.conf

[tmp]

    comment = Temporary file space

    path = /tem

    read only = no

    public = yes

 

[cdrom]

    comment = CDROM

    path = /mnt/cdrom

    read only = yes

public = yes

//为指定用户或组配置共享

# useradd samba

# passwd samba

# mkdir /var/samba/samba

//更改目录属主

# chown samba.samba /var/samba/samba

# vi smb.conf

 

[sambadir]

    comment = Samba's service

    path = /var/samba/samba

    valid users = samba

    public = no

writable = yes

 

//保存修改

//Linux环境下访问Samba共享

# cat /etc/samba/lmhosts

# smbclient –L IP –U 用户名

# smbmount //win/tools /mnt/smb/win

 

linux smb.conf详解

17行workgroup

语法 workgtoup = <工作组群>;
预设 workgroup = MYGROUP
说明 设定 Samba Server 的工作组
例 workgroup = workgroup 和WIN2000S设为一个组，可在网上邻居可中看到共享

21行server string

语法 server string = <说明>;
预设 sarver string = Samba Server
说明 设定 Samba Server 的注释
其他 支持变量 t%-访问时间 I%-客户端IP m%-客户端主机名 M%-客户端域名 S%-客户端用户名
例 server string = this is a Samba Server 设定出现在Windows网上邻居的 Samba Server 注释为 this is a Samba Server

28行hosts allow
语法 hosts aoolw = <IP地址>; …
预设 ; host allow = 192.168.1. 192.168.2. 127.
说明 限制允许连接到 Samba Server 的机器，多个参数以空格隔开。表示方法可以为
完整的IP地址，如 192.168.0.1
网段，如 192.168.0.
例 hosts allow = 192.168.1. 192.168.0.1 表示允许192.168.1 网段的机器 网址为192.168.0.1 的机器 连接到自己的samba server

32行printcap name

语法 printcap name = <打印机配置文件>;
预设 printcap name = /etc/printcap
说明 设定 samba srever 打印机的配置文件
例 printcap name = /etc/printcap 设定 samba srever 参考 /etc/printcap 档的打印机设定

33行load printers

语法 load printers = <yes/no>;
预设 load printers = yes
说明 是否在开启 samba server 时即共享打印机

38行printing
语法 printing = <打印机类型>;
预设 printing = lprng
说明 设定 samba server 打印机所使用的类型,37行为目前所支持的类型

42行guest account
语法 guert account = <帐户名称>;
预设 guert account = pcguest
说明 设定访问 samba server 的来宾帐户(即访问时不用输入用户名和密码的帐户),若设为pcguest的话则为默认为”nobody”用户
例 guert account = andy 设定设定访问 samba server 的来宾帐户以andy用户登陆,则此登陆帐户享有andy用户的所有权限

46行log file
语法 log file = <日志文件>;
预设 log file = /var/log/samba/%m.log
说明 设定 samba server 日志文件的储存位置和文件名(%m代表客户端主机名)

49行max log size
语法 max log size = <??KB>;
预设 max log size = 0
说明 设定日子文件的最大容量,单位KB 这里的预设值0代表不做限制

53行security
语法 security = <等级>;
预设 security = user
说明 设定访问 samba server 的安全级别 共有四种
share—不需要提供用户名和密码
user—-需要提供用户名和密码,而且身份验证由 samba server 负责
server–需要提供用户名和密码,可指定其他机器(winNT/2000/XP)或另一台 samba server作身份验证
domain–需要提供用户名和密码,指定winNT/2000/XP域服务器作身份验证

60行password server
语法 password server = <IP地址/主机名>;
预设 password server = <NT-Server-Name>;
说明 指定某台服务器(包括windows 和 linux)的密码,作为用户登入时验证的密码
其他 此项需配合 security = server时,才可设定本参数

64行password level
65行username level
语法 password level = <位数>;
username level = <位数>;
预设 password level = 8
username level = 8
说明 设定用户名和密码的位数,预设为8位字符

70行encrypt passwords
语法 encrypt passwords = <yes/no>;
预设 encrypt passwords = yse
说明 设定是否对samba的密码加密

71行smb passwd file
语法 smb passwd file = <密码文件>;
预设 smb passwd file = /etc/samba/smbpasswd
说明 设定samba的密码文件

130行local master
语法 local master = <yes/no>;
预设 local master = no
说明 设定 samba server 是否要担当LMB角色(LMB负责收集本地网络的Browse List资源),通常无特殊原因设为no

134行os level = 33
语法 os level = <数字>;
预设 os level = 33
说明 设定 samba server的os level. os level从 0 到 255 . winNT的os level为33, win95/98的os level 是 1 .
若要拿samba server 当LMB或DMB则它的os level至少要大于NT的33以上

139行domain master
语法 domain master = <yes/no>;
预设 domain master = yes
说明 设定 samba server 是否要担当DMB角色(DMB会负责收集其他子网的Browse List资源),通常无特殊原因设为no

143行preferred master
语法 preferred master = <yes/no>;
预设 preferred master = yes
说明 设定 samba server 是否要担当PDC角色(PDC会负责追踪网络帐户进行的一切变更),通常无特殊原因设为no.
(同一网段内不可有两个PDC,他们会每5分钟抢主控权一次)

163行wins support
语法 wins support = <yes/no>;
预设 wins support = yes
说明 设定samba server 是否想网络提供WINS服务,通常无特殊原因设为no.
除非所处网络上没有主机提供WINS服务且需要此台samba server提供WINS服务是才设yes
其他 wins support 和 wins server 只能选择一个

167行wins server
语法 wins server = <IP地址>;
预设 wins server = w.x.y.z
说明 设定samba server 是否要使用别台主机提供的WINS服务.通常无特殊原因设为no.除非所处网络上有一台主机提供WINS服务才要设yes
其他 wins support 和 wins server
例 wins server = 192.168.0.1 表示samba server要使用192.168.0.1提供的WINS服务

#============================== Share Definitions =============================

[homes]
comment = Home Directories
browseable = no
writable = yes
valid users = %S

使用者本身的”家”目录，当使用者以samba使用者身份登入samba server 后，
samba server 底下会看到自己的家目录，目录名称是使用者自己的帐号

[分享的资源名称]
<指令1>; = (参数)
<指令2>; = (参数)
……………………..

要提供分享资源时，须先把欲分享的资源以 [ ] 符号括住，底下通常会带指令和参数来表示此资源的设定和存取权限等,详情如下

comment———注释说明
path————分享资源的完整路径名称，除了路径要正确外，目录的权限也要设对
browseable——是yes/否no在浏览资源中显示共享目录，若为否则必须指定共享路径才能存取
printable——-是yes/否no允许打印
hide dot ftles–是yes/否no隐藏隐藏文件
public———-是yes/否no公开共享，若为否则进行身份验证(只有当security = share 时此项才起作用)
guest ok——–是yes/否no公开共享，若为否则进行身份验证(只有当security = share 时此项才起作用)
read only——-是yes/否no以只读方式共享当与writable发生冲突时也writable为准
writable——–是yes/否no不以只读方式共享当与read only发生冲突时，无视read only
vaild users—–设定只有此名单内的用户才能访问共享资源(拒绝优先)(用户名/@组名)
invalid users—设定只有此名单内的用户不能访问共享资源(拒绝优先)(用户名/@组名)
read list——-设定此名单内的成员为只读(用户名/@组名)
write list——若设定为只读时，则只有此设定的名单内的成员才可作写入动作(用户名/@组名)
create mask—–建立文件时所给的权限
directory mask–建立目录时所给的权限
force group—–指定存取资源时须以此设定的群组使用者进入才能存取(用户名/@组名)
force user——指定存取资源时须以此设定的使用者进入才能存取(用户名/@组名)
allow hosts—–设定只有此网段/IP的用户才能访问共享资源
allwo hosts = 网段 except IP
deny hosts——设定只有此网段/IP的用户不能访问共享资源

allow hosts=本网段指定IP指定IP

deny hosts=指定IP本网段指定IP

Samba的主配置文件。但所包含的内容并不是很全，详见man smb.conf
所有以;或#开头的行为注释行，将被忽略掉。在这个例子中我们使用；表示可以由你来修改或设置的部分，而#则表示真正意义上的注释。
注意：不论你何时何地修改了这个文件，你都应运行一下命令“testparm“来测试你是否犯了一些基本语法的错误。
1、全局设置
[global]
# workgroup = NT-Domain-Name or Workgroup-Name
workgroup = MYGROUP
下面的这句话是后加的，加入的意义为：使WIN用户可以看到主机的名字，但我将此行注释掉后，没看到什么影响。
netbios name = express
下面设置的是服务器的字符串，相当于NT中的计算机说明部分
server string = Samba Server
下面的选项对于安全性很重要。他允许你对是否可以进行本地网络连接的机器进行了限制。
hosts allow = 192.168.1.50 192.168.1.43 192.168.1.44 192.168.1.45 192.168.1.46 192.168.1.47 192.168.1.48 192.168.1.49
如果想要自动共享打印机而不是个别地进行单独设置，使用下面的选项：
printcap name = /etc/printcap
load printers = yes
除非你是非标准的，否则下面的选项对于你说清楚打印系统的类型并不是很必要。当前支持的打印系统主要有以下几类：
# bsd, sysv, plp, lprng, aix, hpux, qnx, cups
printing = cups
如果想要一个guest账号的话就不用注释下面的行。你必须把这个加入到/etc/passwd中，否则用户“nobody“会被使用。
; guest account = pcguest
下面的选项告诉samba对不同的机器连接使用不同的日志文件。小心如果你允许访问的机器太多的话，文件可能极多哟！！！：）
log file = /var/log/samba/%m.log
设置log文件的大小（KB）（# Put a capping on the size of the log files (in Kb).）
max log size = 0
安全格式。大多数用户使用用户级安全。详见security_level.txt。
security = share
使用密码服务选项，仅用于security = server模式
参数列表可以包括：
# password server = My_PDC_Name [My_BDC_Name] [My_Next_BDC_Name]
# 或自动查找域控制器
# password server = *
; password server = 
对于所有的上面和下面的组成部分的_n_characters密码所允许的匹配级别
; password level = 8
; username level = 8
你可能想使用密码编码。见在samba文档中的ENCRYPTION.txt, Win95.txt和WinNT.txt。
除非你已经仔细的读过了那些文档，否则不要激活下面的选项：
encrypt passwords = yes
smb passwd file = /etc/samba/smbpasswd
当samba被建成为支持SSL的模式时，下面需要从大量的假的错误中保持smbclient。（原文如下：
# The following is needed to keep smbclient from spouting spurious errors
# when Samba is built with support for SSL.
; ssl CA certFile = /usr/share/ssl/certs/ca-bundle.crt
下面的选项需要允许从windows对linux系统的密码进行修改。
# 注意：上面带有’encrypt passwords’ 和’smb passwd file’选项使用这些。
# 另： 如果仅是允许工作站改变加密的SMB密码那么你不需要这些。它们允许Unix密码与SMB密码保持同步。
unix password sync = Yes
passwd program = /usr/bin/passwd %u
passwd chat = *New*password* %n\n *Retype*new*password* %n\n *passwd:*all*authentication*tokens*updated*successfully*
你可以使用PAM的密码改变控制标记。如果激活的活，当一个SMB客户端请求代替了在密码程序列表时，PAM将用于密码改变。对于大多数的设置，不改变密码字符参数而激活这个也是可能的。
pam password change = yes
Unix用户可能映射不同的SMB用户名。
username map = /etc/samba/smbusers
在每一台机器的基础上，使用下面的行可以使你定制你的配置。%m以连接机器的netbios名代替。
; include = /etc/samba/smb.conf.%m
这个参数控制samba是否服从于PAM账号和对话管理指示。默认情况下是使用PAM仅清除文本证明且忽略任何的账号或对话管理。注意：当加密密码=yes时，samba总是忽略PAM的证明。
obey pam restrictions = yes
很多人都会发现这个选项优化了性能。详见speed.txt和帮助手册页。
socket options = TCP_NODELAY SO_RCVBUF=8192 SO_SNDBUF=8192
配置samba使用多重接口。
如果你有多个网络接口的话，必须把他们在下面列出来。详见man。
; interfaces = 192.168.12.2/24 192.168.13.2/24
配置请求播出同步到远程浏览器，或从一个主机同步浏览器列表或从/到整个子网（如下）。
; remote browse sync = 192.168.3.25 192.168.5.255
使主机将自己广播到本地的子网。
; remote announce = 192.168.1.255 192.168.2.44
浏览器控件选项：
如果你不想让你的samba在你的网络中变成一个主浏览器，那么设置local master为no，否则将采用正常的规则。
; local master = no
os level决定在主浏览器的中被提取的优先级。默认值是很合理的。
; os level = 33
域master指定samba是域主浏览器。这允许samba在子网之间比较浏览列表。如果你已经有了一个Win NT的主域控制器的话，就不要设置这个选项。
; domain master = yes
首选master使samba在启动时拒绝一个本地浏览器的选出，且给他一些小的较高的机会让其来选出。
; preferred master = yes
如果你要samba成为Win95工作站的域登录服务器的话则激活它。
; domain logons = yes
如果你激活了domain logons，那么你可以让每一台机器或每一个用户登录角本运行一个指定的登录批处理文件。原文如下：if you enable domain logons then you may want a per-machine or per user logon script run a specific logon batch file per workstation (machine)
; logon script = %m.bat
每一个用户名都运行一个指定的登录批处理文件
; logon script = %U.bat
# 存储动态的profile（仅针对95与NT）
# %L 代表netbios name, %U 是一个用户名
# 不能注释掉下面的[Profiles]共享。
; logon path = \%L\Profiles\%U
支持WINS部分：告诉samba组件的NMBD去激活WINS服务。
; wins support = yes
WINS服务器-告诉samba组件的NMBD成为一个WINS客户端。
注意：samba即可以是一个WINS服务器，也可以是一个客户端，或都不是。
; wins server = w.x.y.z
WINS 代理-原文如下，没法翻译（Tells Samba to answer name resolution queries on behalf of a non WINS capable client,），执行这件事必须要求在网络中至少有一个Wins服务器。默认情况下是NO。
; wins proxy = yes
# DNS Proxy – 告诉samba是否经过DNS的nslookup试着去解析NETBIOS名。1.9.17的内置默认值是yes，目前已经改为1.9.18的no。
dns proxy = no
实例保存可以很简洁-系统默认值是_no_
注意：可以在每一个共享基础上设置
; preserve case = no
; short preserve case = no
默认实例是对于所有的DOS文件都大写
; default case = lower
对于此选项要很小心-它可能带来一些想不到的事情。
; case sensitive = no
[homes]
comment = Home Directories
browseable = no
writable = yes
valid users = %S
create mode = 0664
directory mode = 0775
如果不想要samba不承认已经映射为guest的用户，可用如下设置
; map to guest = bad user
如果想创建netlogon目录给域登录，不要注释下面的内容。
; [netlogon]
; comment = Network Logon Service
; path = /usr/local/samba/lib/netlogon
; guest ok = yes
; writable = no
; share modes = no
想提供一个指定的不固定的共享profile那么就不要注释下面的内容，默认使用用户主目录。
;[Profiles]
; path = /usr/local/samba/profiles
; browseable = no
; guest ok = yes
注意：如果你有一个BSD风格的打印系统，则没有必须单独的特别指定每一个打印机。
[printers]
comment = All Printers
path = /var/spool/samba
browseable = no
设置public=yes表示允许’guest account’打印
guest ok = no
writable = no
printable = yes
下面的内容对人们共享文件是有用的。
;[tmp]
; comment = Temporary file space
; path = /tmp
; read only = no
; public = yes
公用的可访问的目录，除了在staff组中的成员外，对其它人为只读
;[public]
; comment = Public Stuff
; path = /home/nw
; public = yes
; writable = yes
; printable = no
; write list = @staff
私有打印机，仅仅fred本人可用。打印池中的数据将被放到fred的主目录中。注意：fred用户无论在什么地方都必须对打印池有写访问的权限。
;[yingou]
; comment = qlj’s Printer
; valid users = yingouqlj
; path = /home/yingouqlj
; public = no
; writable = no
; printable = yes
私有目录，仅能对fred开放。注意fred对这个目录需要写访问的权限。
;[fredsdir]
; comment = qlj’s Service
; path = /usr/somewhere/private
; valid users = yingouqlj
; public = no
; writable = yes
; printable = no
允许你制作配置文件去引入的连接到这里的每一台机器都有不同的目录的服务。
使用%U选去配置用户名，%m代替连接到的机器名。
;[yingouqlj]
; comment = PC Directories
; path = /usr/local/pc/%m
; public = no
; writable = yes
公共可访问的目录，对所有的用户都可读/写。注意：在这个目录中的所有由用户创建的文件都会被标识成默认用户所有。所以有访问仅限的用户可以删除别的用户的文件。很明显这个目录必须是可以被默认用户写的。另一个用户当然可以指定，这样所有的文件都将被那个用户所替代。
[public]
path = /tmp/aaaa
public = yes
guest ok = yes
writable = yes
printable = no
下面的两个例子是怎样共享一个目录给两个用户，在这个共享目录中他们可以放置文件且分别属于各自所有。在这个设置中，目录将可以被两个用户同时使用且在其上有粘滞位保护。很明显，可以扩展为多个用户的情况。
;[myshare]
; comment = Mary’s and Fred’s stuff
; path = /usr/somewhere/shared
; valid users = mary fred
; public = no
; writable = yes
; printable = no
; create mask = 0765
以下是个人实际的设置
[sharedir]
path = /home/nw
public = yes
guest ok = yes
writable = yes


在RHEL下如何使用VPN？怎么往一个Samba(SMB)共享里添加一个用户？  2007-09-10 21:28:13|  分类： 默认分类 |  标签： |字号大中小 订阅 

允许用户浏览Samba共享的一种方法是在Samba服务器上拥有一个UNIX帐号。可以通过命令 adduser [用户名] 和 passwd [用户名]来建立UNIX帐号。 

当用户有了一个本地帐号，他的Samba密码可以这样初始化： 

    smbpasswd -a [用户名]-a选项增加用户名到Samba的密码文件里面里。 

在/etc/smb.conf配置文件里修改Samba共享，允许新增加的用户浏览该共享资源。 

[ashare]    comment = A Shared Directory    path = /usr/somewhere/shared    valid users = mary [新用户]    public = no    writable = yes用testparm显示升级后的共享资源。
用service smb reload命令重载smb.conf配置文件。 

-- Create the user 
create user NC56
  identified by "nc56"
  default tablespace NNC_DATA01
  temporary tablespace TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to NC56 with admin option;
grant dba     to NC56 with admin option;



```

#### Linux 压缩命令汇总

```bash
09在Windows下最常见的压缩文件就只有两种，一是,zip，另一个是.rar。可是Linux就不同了，它有.gz、.tar.gz、tgz、bz2、.Z、.tar等众多的压缩文件名，此外windows下的.zip和.rar也可以在Linux下使用，不过在Linux使用.zip和.rar的人就太少了。本文就来对这些常见的压缩文件进行一
番小结，希望你下次遇到这些文件时不至于被搞晕icon_smile.gif

　　在具体总结各类压缩文件之前呢，首先要弄清两个概念：打包和压缩。打包是指
将一大堆文件或目录什么的变成一个总的文件，压缩则是将一个大的文件通过一些压
缩算法变成一个小文件。为什么要区分这两个概念呢？其实这源于Linux中的很多压
缩程序只能针对一个文件进行压缩，这样当你想要压缩一大堆文件时，你就得先借助
另它的工具将这一大堆文件先打成一个包，然后再就原来的压缩程序进行压缩。

　　Linux下最常用的打包程序就是tar了，使用tar程序打出来的包我们常称为tar包
，tar包文件的命令通常都是以.tar结尾的。生成tar包后，就可以用其它的程序来进
行压缩了，所以首先就来讲讲tar命令的基本用法：

　　tar命令的选项有很多(用man tar可以查看到)，但常用的就那么几个选项，下面
来举例说明一下：

　　# tar -cf all.tar *.jpg
　　这条命令是将所有.jpg的文件打成一个名为all.tar的包。-c是表示产生新的包
，-f指定包的文件名。

　　# tar -rf all.tar *.gif
　　这条命令是将所有.gif的文件增加到all.tar的包里面去。-r是表示增加文件的
意思。
# tar -uf all.tar logo.gif
　　这条命令是更新原来tar包all.tar中logo.gif文件，-u是表示更新文件的意思。


　　# tar -tf all.tar
　　这条命令是列出all.tar包中所有文件，-t是列出文件的意思

　　# tar -xf all.tar
　　这条命令是解出all.tar包中所有文件，-x是解开的意思

　　以上就是tar的最基本的用法。为了方便用户在打包解包的同时可以压缩或解压
文件，tar提供了一种特殊的功能。这就是tar可以在打包或解包的同时调用其它的压
缩程序，比如调用gzip、bzip2等。

　　1) tar调用gzip

　　gzip是GNU组织开发的一个压缩程序，.gz结尾的文件就是gzip压缩的结果。与gzip
相对的解压程序是gunzip。tar中使用-z这个参数来调用gzip。下面来举例说明一下
：

　　# tar -czf all.tar.gz *.jpg
　　这条命令是将所有.jpg的文件打成一个tar包，并且将其用gzip压缩，生成一个
gzip压缩过的包，包名为all.tar.gz

　　# tar -xzf all.tar.gz
　　这条命令是将上面产生的包解开。

　　2) tar调用bzip2

　　bzip2是一个压缩能力更强的压缩程序，.bz2结尾的文件就是bzip2压缩的结果。
与bzip2相对的解压程序是bunzip2。tar中使用-j这个参数来调用gzip。下面来举例
说明一下：

　　# tar -cjf all.tar.bz2 *.jpg
　　这条命令是将所有.jpg的文件打成一个tar包，并且将其用bzip2压缩，生成一个
bzip2压缩过的包，包名为all.tar.bz2

　　# tar -xjf all.tar.bz2
　　这条命令是将上面产生的包解开。
3)tar调用compress

　　compress也是一个压缩程序，但是好象使用compress的人不如gzip和bzip2的人
多。.Z结尾的文件就是bzip2压缩的结果。与 compress相对的解压程序是uncompress
。tar中使用-Z这个参数来调用compress。下面来举例说明一下：

　　# tar -cZf all.tar.Z *.jpg
　　这条命令是将所有.jpg的文件打成一个tar包，并且将其用compress压缩，生成
一个uncompress压缩过的包，包名为all.tar.Z

　　# tar -xZf all.tar.Z
　　这条命令是将上面产生的包解开

　　有了上面的知识，你应该可以解开多种压缩文件了，下面对于tar系列的压缩文
件作一个小结：

　　1)对于.tar结尾的文件

　　tar -xf all.tar

　　2)对于.gz结尾的文件

　　gzip -d all.gz
　　gunzip all.gz

　　3)对于.tgz或.tar.gz结尾的文件

　　tar -xzf all.tar.gz
　　tar -xzf all.tgz

　　4)对于.bz2结尾的文件

　　bzip2 -d all.bz2
　　bunzip2 all.bz2

　　5)对于tar.bz2结尾的文件

　　tar -xjf all.tar.bz2

　　6)对于.Z结尾的文件

　　uncompress all.Z

　　7)对于.tar.Z结尾的文件

　　tar -xZf all.tar.z

　　另外对于Window下的常见压缩文件.zip和.rar，Linux也有相应的方法来解压它
们：

　　1)对于.zip

　　linux下提供了zip和unzip程序，zip是压缩程序，unzip是解压程序。它们的参
数选项很多，这里只做简单介绍，依旧举例说明一下其用法：

　　# zip all.zip *.jpg
　　这条命令是将所有.jpg的文件压缩成一个zip包
# unzip all.zip
　　这条命令是将all.zip中的所有文件解压出来

　　2)对于.rar

　　要在linux下处理.rar文件，需要安装RAR for Linux，可以从网上下载，但要记
住，RAR for Linux
不是免费的；可从[url]http://www.rarsoft.com/download.htm[/url]下载RARfor Linux 3.2.
0，然后安装：

　　# tar -xzpvf rarlinux-3.2.0.tar.gz
　　# cd rar
　　# make

　　这样就安装好了，安装后就有了rar和unrar这两个程序，rar是压缩程序，unrar
是解压程序。它们的参数选项很多，这里只做简单介绍，依旧举例说明一下其用法：


　　# rar a all *.jpg
　　这条命令是将所有.jpg的文件压缩成一个rar包，名为all.rar，该程序会将.rar
扩展名将自动附加到包名后。

　　# unrar e all.rar
　　这条命令是将all.rar中的所有文件解压出来

　　到此为至，我们已经介绍过linux下的tar、gzip、gunzip、bzip2、bunzip2、compress
、 uncompress、 zip、unzip、rar、unrar等程式，你应该已经能够使用它们对.tar
、.gz、.tar.gz、.tgz、.bz2、.tar.bz2、. Z、.tar.Z、.zip、.rar这10种压缩文
件进行解压了，以后应该不需要为下载了一个软件而不知道如何在Linux下解开而烦
恼了。而且以上方法对于Unix也基本有效。

　　本文介绍了linux下的压缩程式tar、gzip、gunzip、bzip2、bunzip2、compress
、uncompress、 zip、 unzip、rar、unrar等程式，以及如何使用它们对.tar、.gz
、.tar.gz、.tgz、.bz2、.tar.bz2、.Z、. tar.Z、.zip、.rar这10种压缩文件进行
操作。
```

