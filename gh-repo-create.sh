gh auth login
REPO=wsl-setup
gh repo create $REPO --public --clone; cd $REPO
REMOTE=$(git remote get-url origin)
git add .
git commit -m "initial commit"
git push --set-upstream origin master
git status
