# Git - Version Control Basics

What is Git

Git is an open source tool used to track changes in tiles and manage collaborative code projects. It was written in april 2005 by the famous creator of the Linux Kernel - Linus Torvalds.

Git is a "version control system." It lets you keep track of everychange you've made to your codebase, and assists with keeping multiple developers' versions of the same codebase in sync and up-to-date. Accidentally make a change that breaks production? You can revert it with Git. You and your coworker both make a modification to the same file? Git can usually merge them automatically for you, or at the very least give you a good breakdown of where your changes conflict.

For hosting code remotely we need a **Git server** (E.g. Github, Gitlab, ABI git server). Those also provide issue tracking, a nice frontend for managing incoming changes to your repository in the form of pull requests. 

Some terminology for starters:

```
repository / repo = the whole project directory

main / master = a branch that you and other contributors upload code onto for production feature.

branch = a branch you work in to add to the codebase that started as a copy of main/master

pull request = A proposal to merge your branch with changes with another branch.

staging = a local place that holds your changed files that you are happy with to eventually push into the repo.
```

# Commands with a scenario:

## Cloning the repository 

Suppose that after successfully getting an account in the ABI git server you have been asigned to fix a sequencing algorith in some project.

First you need to **find the repository** of that project in the git server in your browser (using the search bar :p) and **copy its' ssh link** to your clipboard.

After, come back to your working command line environment, **clone the repository** and enter it 

```
git clone <repo link>
cd <repo name>
```

## Make a branch

Then, you want to **make a new branch** for your new changes and **switch to that branch**

```
git branch -c <new branch name> 
git switch <new branch name>
```

And make your smart new changes to the code.

## When do i add? When do i commit?

__Now pay attention, here is the principle of securing your code__

- If you edited the file - save the file (Ctrl+S)
- If you Made some changes that serve the same purpose - add them together and commit.

```
    git add file1.py file2.py file3.py
    git commit -m "a description-message to your changes" 
```

Every time you finish some little block of code that you want to secure in git history - do not forget to **commit that change**. Coding is a very non-linear process with its' ups and downs, Hence - **make a commit** every time you make something that you would want to roll back to. With git there are less regrets.

## Pushing commits to the server

When you are satisfied with what you have accomplished - it is time to **push** your changes back to the server, to make it publicly accessible. 

```
    git push
```

And voila! you are done on the command line :)

## Pull-Request

Now before you go to sleep, there is one last thing you want to do - **Open a pull-request** (PR).  A PR is a request to the project owner for merging your changes into the code-base, so they become an official part of the production. The owner may comment on your code and/or request changes. A pull request is where a feedback loop is created, so collaboration happens with ease.

For opening a PR, go to the repo again in the browser, go to "branches" and click on your branch. You will see a "New Pull Request" button. Click that, describe your contributions, request a review and submit. Now the project owner can get notified and review it, and eventually merge your code :)

## Commit history

When you push multiple commits you accumulate a **commit history**. A commit history represent the "evolution" of your codebase. And when you make a new branch you basically copy the commit hisotry of another branch of your choice. 

## A recap of the story

   ```
    git clone <repo link> = clone the remote repo into local environment

    git pull = give me the code from a branch

    git pull origin main = give me all the new changes from the codebase

    git status = "Where the hell am I? What files have I changed?:

    git add . = "Add all the files I changed to staging"

    git commit -m "my commit message" = take the changes staging and push it up to the repo.

    git push = post changes on that branch
    ```

Happy coding ^^

Varinka Ohanyan
