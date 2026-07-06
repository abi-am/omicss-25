# Git - Version Control Basics

What are Git and Github

Git is an open source tool used to track changes in tiles and manage collaborative code projects. It was written in april 2005 by the famous creator of the Linux Kernel - Linus Torvalds.

Git is a "version control system." It lets you keep track of everychange you've made to your codebase, and assists with keeping multiple developers' versions of the same codebase in sync and up-to-date. Accidentally make a change that breaks production? You can revert it with Git. You and your coworker both make a modification to the same file? Git can usually merge them automatically for you, or at the very least give you a good breakdown of where your changes conflict.

For hosting code remotely we need a Git server (E.g. Github, Gitlab, ABI git server). Those also provide issue tracking, a nice frontend for managing incoming changes to your repository in the form of pull requests. 

Some terminology for starters:

repository / repo = the whole project directory

main / master = a branch that you and other contributors upload code onto for production feature.

branch = a branch you work in to add to the codebase that started as a copy of main/master

pull request = A proposal to merge your branch with changes with another branch.

staging = a local place that holds your changed files that you are happy with to eventually push into the repo.

Commands with a scenario:

Suppose that after successfully getting an account in the ABI git server you have been asigned to fix a sequencing algorith in some project.

