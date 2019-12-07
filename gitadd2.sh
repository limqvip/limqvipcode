git status -s

git status -s | awk ' $2 { print ( $2 ) }'>/c/Users/Administrator/addgit
git add `more /c/Users/Administrator/addgit`
git status -s
git commit -m " `date "+%Y-%m-%d %H:%M:%S"`  `git status -s`"
git status -s
