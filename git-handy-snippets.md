
# Setting Up

### Configure GIT
```
git config --global user.email ateneva@gmail.com
git config --global user.name angelinateneva
git config --global core.editor atom

# configure default branch name for all repositories
git config --global init.defaultBranch <name>

# configure default pull strategy
git config --global pull.rebase false  # merge local branches when pulling
git config --global pull.rebase true   # rebase pull strategy
git config --global pull.ff only       # fast-forward only
```

Explanation:
https://www.atlassian.com/git/tutorials/syncing/git-pull

PRO:
https://sdqweb.ipd.kit.edu/wiki/Git_pull_--rebase_vs._--merge
https://coderwall.com/p/7aymfa/please-oh-please-use-git-pull-rebase

CON:
https://stackoverflow.com/questions/2472254/when-should-i-use-git-pull-rebase


### Add .gitignore file
```
# specify a global exclusion list
git config --global core.excludesfile ~/.gitignore

# adding .DS_Store to that list
echo .DS_Store >> ~/.gitignore

# remove any existing files from the repo, skipping over ones not in repo
find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch
```

### Review GIT configuration
```
git config user.name          # display the configured user name
git config user.email         # display the configured email
git config core.editor        # display the configured editor
git config core.excludesfile  # review excluded files
```

### Clone a remote repository
```
mkdir prj
cd prj
git clone <url-to-project-name.git>
```

### Create local repository
```
mkdir proj
cd proj
git init
```

### Add local repository as a remote
```
git remote add origin <url-to-project-name.git>

git add README.md
git commit -m "initial commit"

# setup tracking b/n local and remote
git push -u [<remote>] [<branch>]
git push -u git@gitlab.example.com:namespace/nonexistent-project.git main   

OR

git push --set-upstream <remote> <branch>
git push --set-upstream git@gitlab.example.com:namespace/nonexistent-project.git main
```

### Rename/Remove remote repository
```
git remote rename <old> <new>
git remote remove <name>
```
https://www.git-tower.com/learn/git/faq/set-upstream/


### Change local repo default tracking branch
```
git branch -m master main       # move from master to maim
git fetch origin
git branch -u origin/main main  # set up tracking to main
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
# could be a handy strategy to keep commit history clean
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

### amend a commit message
```
git commit --amend -m "New commit message"
```
* if the commit has already been pushed then you will need to force push after amending
https://stackoverflow.com/questions/179123/how-to-modify-existing-unpushed-commit-messages


### push force
* needed to sync your remote branch after rebasing local branch
```
git push origin <branch> -f
git push origin <branch> --force
git push <remote> <branch> -f
```
https://stackoverflow.com/questions/43567577/what-is-the-different-between-force-push-and-normal-push-in-git#
https://stackoverflow.com/questions/5509543/how-do-i-properly-force-a-git-push
https://stackoverflow.com/questions/34995726/why-when-should-one-ever-force-push

### discard local changes
```
git clean -df            # discard untracked files
git checkout -- <file>   # disard changes to unstaged files
git checkout -- .
```

### unstage files
```
git restore --staged <file>
git restore --staged <directory>

OR

git reset HEAD -- <file>
git reset HEAD -- <directory>
```

### stash local changes
```
# keeps a copy of your uncommitted changes in stashes
# and removes them from working tree so you can switch between branches
# only applies to files that are already tracked
git stash

# to stash untracked files
git stash -u


# restore your stashed changes to working tree and remove them from stashes
# this only applies to the latest stash
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

# Advanced Tips

## Merging vs. Rebasing
The major benefit of rebasing is that you get a much cleaner project history. 

First, it eliminates the unnecessary merge commits required by git merge
Second, rebasing also results in a perfectly linear project history
    —you can follow the tip of feature all the way to the beginning of the project without any forks. 

* It can be harmful to do it in shared branches. 
* It can cause complex and hard to resolve merge conflicts. 
In these cases, instead of rebasing your branch against the default branch, 
consider pulling it instead (git pull origin master). 

* It has a similar effect without compromising the work of your contributors.

* So, before you run git rebase, always ask yourself, “Is anyone else looking at this branch?” 
  * If the answer is yes, take your hands off the keyboard and start thinking about a non-destructive way to make your changes 
    * (e.g., the git revert command). Otherwise, you’re safe to re-write history as much as you like.

```
git fetch origin main
git checkout my-feature-branch

git pull --rebase origin development
git push origin my-feature-branch -f
```

If you try to push the rebased main branch back to a remote repository, 
    Git will prevent you from doing so because it conflicts with the remote main branch. 
But, you can force the push to go through by passing the --force flag, like so:

https://www.atlassian.com/git/tutorials/merging-vs-rebasing
https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

https://docs.gitlab.com/ee/topics/git/git_rebase.html
https://stackoverflow.com/questions/52625081/git-pull-another-remote-branch-into-my-local-branch

## Resetting & Revertting

* commit level
```
git reset       # Discard commits in a private branch or throw away uncommited changes
git checkout    # switch between branches
git revert      # undo commits in a public branch
```

* file level
```
git reset       # unstage a file
git chewckout   # discard chnages in the working directory
```

You can also think of: 
* git revert as a tool for undoing committed changes, 
* git reset HEAD is for undoing uncommitted changes.

https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting