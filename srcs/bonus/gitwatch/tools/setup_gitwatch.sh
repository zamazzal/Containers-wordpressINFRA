cd /var/www/wordpress
if [ ! -d "/var/www/wordpress/.git" ]; then
git init /var/www/wordpress
git config --global user.email $GIT_AUTHOR
git fetch $GIT_REMOTE
echo "inception" > README.md
git add .
git commit -m "gitwatch sync"
git branch -M $GIT_BRANCH
git remote add origin $GIT_BRANCH
git push -f $GIT_REMOTE $GIT_BRANCH
fi
echo "starting gitwatch..."
gitwatch -r $GIT_REMOTE -b $GIT_BRANCH /var/www/wordpress/
