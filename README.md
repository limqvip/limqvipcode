# limqvipcode
limqvip.github.io code
5 pull、fetch与clone
　　pull与push相反，是将代码从远程仓库同步至本地仓库并merge的命令

git pull origin master
　　而fetch是单纯将代码从远程仓库同步至本地仓库，并不作merge。

git fetch
git diff origin/master
git merge origin
     三个步骤分别代表：取远程仓库至本地，保存版本号至.git/FETCH_HEAD；比较远程origin/master分支与本地差别；将远程origin/master merge至本地仓库。与直接pull相比，fetch后可以直观看到远程仓库的不同，再决定是否要merge，更加安全。

　　clone不是同步，而类似于下载。我们不仅可以clone自己的仓库，还可以clone别人的仓库，只需要知道相应的URL即可　　

git clone git@github.com:AndyQiao/makefile_test.git code1
　　注：code1是目标文件夹。

　　git还是很牛逼的。不过有些项目用SVN更方便一些。以前在Window下编程我都用SVN的。要好好学习一下git！下午查各种资料，各种试验，再写博客，收获很多。加油。
