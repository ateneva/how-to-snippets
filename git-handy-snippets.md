
# Setting Up

### Configure GIT
```
git config --global user.email ateneva@gmail.com
git config --global user.name angelinateneva
git config --global core.editor atom

# configure default pull strategy
git config --global pull.rebase false  # merge local branches when pulling
git config --global pull.rebase true   # rebase pull strtegy
git config --global pull.ff only       # fast-forward only
```

### Review GIT configuration
```
git config user.name        # display the configured user name
git config user.email       # display the configured email
git config core.editor      # display the configured editor
```

### Change local repo default tracking branch
```
git branch -m master main       # move from master to maim
git fetch origin
git branch -u origin/main main  # set up tracking to main
```

### Add local repository as a remote
```
git remote add <repo>
git push [-u] [<repository>] [<branch>]     # -u sets up tracking b/n local and remote repo
git remote rename <old> <new>
git remote remove <name>
```

# Daily Usage

## Branches
### review remote repository commit history
```
git log
git log --all                           # shows both local and tracking branches
git log --stat                          # shows more details about the commit

git log --oneline                       # shortens the GIT IDs
git log --oneline -2                    # shows the last two commits on current branch
git log --oneline --graph -10           # shows the last 10 commits in a graph

git log origin/master --oneline -5      # shows the last 5 commits on master branch
git log origin --oneline -5             # shows the last 5 commits on default tracking branch
```

### create a new branch
```
git branch <branch name>            # create a new branch
git checkout <branch name>          # switch to a different branch
git checkout -b <branch name>       # create a new branch and switch to it
```

### review existing branches
```
git branch
git branch -r         # display only remote branches
git branch -a         # display both remote and local branches

git branch --remote   # display only remote branches
git branch --all      # display both remote and tracking branches
```

### merge branches
```
git merge <branch>
git merge <branch> --ff        # fast-forward merge
git merge <branch> --no-ff     # merge commit
git merge <branch> --ff-only   # abort merge if fast-forward not possible
```

### squash merge
```
# could be a handy startegy to keep commit history clean
# it only works if the original branch is deleted

git checkout master 
git merge --squash featureX   
git commit 
git branch -D feature X
```

### merge conflicts
```
git merge --abort
git checkout --ours [filename]     # keep your changes
git checkout --theirs [filename]   # keep their changes
git rm <filename>                  # remove a file from working tree
```

### delete branches
```
git branch -d <branch name>             # delete local branch only
git branch -D <branch name>             # delete branch with unmerged commits
git push -d <remote_name> <branch_name> # delete remote branch
git push -d origin <branch_name>        # often remote name is origin
```

## Committing

### check local repository status 
```
git status
git status -s
git status --short

git status -l
git status --long 

git status -v
git status --verbose
```

### show current commit 
```
git show HEAD -s                 # show current commit on current branch
git show origin/master HEAD -s   # show current commit on master branch
```

### stage & commit files 
```
git add <file>
git add <directory>
git add .

git commit -m "Commit message here"

git push origin feature/login
git push origin master
```

### discard local changes
```
git clean -df            # discard untracked files
git checkout -- <file>   # disard changes to unstaged files
git checkout -- .
```

### stash local changes
```
# keeps a copy of your uncomitted changes in stashes
# and removes them from working tree so you can switch between branches
git stash

# restore your stashed changes to working tree and remove them from stashes
git stash pop

# restore your stashed changes to working tree and keep them in your stash
# useful if you want to apply them to multiple branches
git stash apply

# list all your stashes
git stash list

# clean up a stash
git stash drop stash@{1}

# delete all your stashes 
git stash clear
```


