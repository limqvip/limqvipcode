---
title: 数据库基础1
comments: true
date: 2018-08-20 17:05:48
updated: 2018-08-20 17:05:48
tags:
categories:
- Program
- test
---

## 4.1 关系代数运算       

传统的几何运算。并、差、交、笛卡尔积等。        
专门的关系运算。选择、投影、连接等。    
### 4.1.1 关系运算   

(1)并(Union)     
(2)差（Difference）  
(3)交（Intersect）
![图片](2018-08-20-shujukujichu1\Image.png)


### 4.1.2专门的关系运算        

(1)选择            
select * from students where 性别='男'        
(2)投影            
select 学号，姓名，身份证号 from students       
(3)连接            
连接是关系的横向结合。连接运算将两个关系模式拼接成一个更宽的关系模式，生成新关系中包含满足条件的元祖。连接过程是通过连接条件来控制的，连接条件中将出现两个表中的公共属性名，或者具有相同语义、可比的属性。连接结果是满足条件的所有记录，连接运算需要两个表作为操作对象，操作结果产生一个关系。若需要连接两个以上的表，则应当两两进行连接。一般可以描述为：JOIN <关系1> AND <关系2> WHERE <条件>SELECT *　FROM STUDENTS A INNER JOIN SECORES B ON A.学号=B.学号该命令查出学生表和成绩表中有相同学号的全部信息。 