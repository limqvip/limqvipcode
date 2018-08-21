---
title: Winddows bat 基础
date: 2018-08-20 11:13:56
tags: [bat, Windows]
categories: bat
---

### bat语法

```cmd
cd  ./RptFile/%Today%
dir /B /A-D .\end.ok 2>nul | find /V /C "">D:/TT/count.txt
set /P c=<D:/TT/count.txt
echo END.OK   %c%个
```

```cmd
::此脚本用来统计目录下文件与文件夹个数 与wind属性相似。
::把D:\putty替换成统计目录

@echo off&title limq @ BAT-GO  At:2010-09-19 12:23:59
set Today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
echo 今天是%Today%下面开始统计文件
echo 统计中~~~
for /f "delims=" %%a in ('dir /s/b/a-d D:\putty ') do set/a a+=1
for /f "delims=" %%a in ('dir /s/b/ad  D:\putty ') do set/a b+=1
set /p=【D:\putty 】文件夹内有 %b% 个文件夹， %a% 个文件，<nul&pause
```
例子1：
`for /r %%i in (  ) do echo %%i`
解释：
如果在括号里的是一些无特殊意义的字符如"."  "abc"之类的， 那输出的%%i
的值为遍历到的文件夹的绝对地址（地址带有\号）后加上这些特殊字符。

如果括号里的是含有通配符（* ？）的，那么不是像上边那样直接加在文件夹地址后了。含有通配符的字符串会被扩展成实际存在的文件名。
比如 `for /r %%i in (1.t*t) do echo %%i` 这个代码将显示所有符合要求（比如 1.txt 1.tt 1.tst）的文件的绝对路径。



例子2：
`for /d /r %%i in ( ) do echo %%i`
解释：
第一种情况和上面相似，直接把字符加在路径后面。

如果含有通配符的，那么它将显示所有的文件夹名符合通配规则的文件夹的绝对路径，同时去掉\号。

ps：

例子1的代码会把当前目录和子目录显示出来，而例子2只显示当前目录的子目录。
例子1显示的结果可以看成是文件，而例子2显示的结果则应该看成是文件夹，因为有/d 的存在。
如果输出的%%i格式达不到要求，还可以用%%~fi 之类的修正。