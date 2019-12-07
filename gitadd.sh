git status -s

git status -s | awk ' $2 { print ( $2 ) }'>/mnt/c/Users/limq/addgit
git add `more /mnt/c/Users/limq/addgit`
git status -s
git commit -m " `date "+%Y-%m-%d %H:%M:%S"`  `git status -s`"
git status -s
