  # Contributors
    Primary contributor: Siras Hakobyan, Varinka Ohanyan
    Contributing authors: Antranig Vartanyan, Maria Nikoghosyan

## 🗂️ Course Content & Schedule

| Section                                | Duration     |
|----------------------------------------|--------------|
| [📚 Lecture](#-lecture)                | 60 minutes   |
| [🔐 Generating SSH Keys](#-generating-an-ssh-key-pair) | 10 minutes   |
| [🌐 Connecting to the Server](#-connecting-to-the-server) | 30 minutes   |
| [🧪 Command Line: Introductory](#-command-line-introductory) | 180 minutes  |
| Git | 50 minutes |
| [🧰 Tmux: Terminal Multiplexer](#-tmux-terminal-multiplexer) | 30 minutes   |
| **🧮 Total Time**                      | **310 minutes (~5h 10m)** |

# Welcome to the Linux Command Line Course (omicss-26)

## 📚 Lecture

Before starting the course, we will have an introductory lecture covering the basics of computer systems, the Unix operating system, and its historical development. The session will also provide an overview of modern Linux distributions that are actively used in bioinformatics.

➡️ **[Link to the presentation]()**

---

## Generating an SSH Key Pair

Please follow the provided instructions to generate your SSH key pair (public and private).

[How to Generate an SSH Key Pair](https://github.com/abi-am/it-resources/blob/main/access-to-server/howto.md)

After generating the keys, email your **public key** to:

mail to: **it-support@abi.am**

---

## 🌐 Connecting to the Server

After submitting your public key, you will receive an email with all the necessary information to connect to the server.

### 🔧 For Windows Users

If you're using Windows, we recommend installing **MobaXterm** to connect to the server.  
Follow this setup guide:

🔗 [MobaXterm Setup Guide](https://github.com/abi-am/it-resources/blob/main/access-to-server/windows-users.md)

### 💻 For macOS/Linux Users

You can connect directly using your terminal. Use the following command:

```bash
ssh yourusername@ssh.abi.am
```
⚠️ **Note:** Replace `yourusername` with the username you received via email.

---

## Command Line: Introductory Materials

Once you're logged into the server, it's a great time to start practicing basic command-line usage.

In the command line environment your surroundings are files and directories (what people like to call 'folders').
You can move in the file system (the wholeness of files and directories) and you can run commands.
The simplest type of commands are UNIX commands.

In linux (which we use on our HPC) directories have path. A path of a directory or a file is the hierarchical route of folders (or directories) you must traverse through the file system to reach it. A typical example:

/home/username/workspace/genome_analysis
/mnt/nas0/proj/omicss26

Using paths you can navigate through the file system and do many-many operations with the files.

## Files and navigation 

|command | operation |
| ---- | ---- |
| pwd | prints your currect working directory |
| cd /path/to/directory | changes your working directory to /path/to/directory |  
| cd | changes the working directory to your home directory |
| cd - | changes the working directory to previous working directory |
| ls | list directory contents |
| ls -la | lists directory contents, hidden items and further details |

### File & Directory Management

| command | operation |
| ---- | ---- |
| mkdir | Creates a brand new empty directory |
| touch | Creates an empty file immediately |
| cp | Copies files or entire directories elsewhere |
| cp -r | Copies directories and their data recursively |
| mv | Moves or renames files and folders |
| rm | Deletes files permanently from the system |
| rm -rf | Force deletes directories recursively without confirmation |

### Text Processing & Viewing

| command | operation |
| ---- | ---- |
| cat | Outputs entire text file content directly |
| less | Opens large text files with scroll features |
| head -n 10 | Shows only first ten lines cleanly |
| tail -f | Monitors log file additions in real-time |
| grep | Searches text data for specific matching patterns |
| nano | Opens a simple command-line text editor |

To copy or paste something in the command line environment press Ctrl+Shift+C and Ctrl+Shift+V.

### Permissions & System Controls

| command | operation |
| ---- | ---- |
| chmod | Modifies file read, write, execute permissions |
| chown | Alters specific file owner and group settings |
| ps aux | Captures every actively running system process |
| top / htop | Launches interactive active resource monitoring screens |
| df -h | Displays readable details about hard drive space |

### Essential Terminal Shortcuts

| command | operation |
| ---- | ---- |
| Tab | Press &lt;TAB&gt; to autocomplete file and path text |
| clear | Wipes terminal clean of visible text history |
| history | Displays list of previously entered terminal commands |
| man | Displays comprehensive digital instruction manuals for commands |

The following resources will help you become familiar with the Linux terminal environment:

- 📖 **Reading Material:**  
  [Command Line for Beginners (Ubuntu)](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)

- 🎥 **Video Tutorial:**  
  [Linux Command Line Crash Course – by Traversy Media](https://youtu.be/oxuRxtrO2Ag?si=Kdp28s4ho4GYLCnI)

---

## 🧰 Tmux: Terminal Multiplexer

When working on multiple projects or running long jobs on a server, it's important to keep your sessions active even if you disconnect. **Tmux** helps you do exactly that.

### Benefits of Tmux

- Split your terminal into multiple panes  
- Run and resume sessions remotely  
- Keep your work persistent across logins

🎥 **Tmux Introductory Video:**  
[Watch here](https://youtu.be/BHhA_ZKjyxo?si=NkWWDbREiCCncdOQ)  
*Skip the installation part—Tmux is already installed on our server.*

---

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

First you need to find the repository of that project in the git server (using the search bar :p) and copy its' ssh link to your clipboard.

After, come back to your working command line environment, clone the repository and enter it 

git clone <repo link>
cd <repo name>

Then, you want to make a new branch for your new changes and switch to that branch

git branch -c <new branch name> 
git switch <new branch name>

And make your smart new changes to the code.

Here is the principle of securing your code

Edited the file - save the file (Ctrl+S)
    Made some changes that serve the same purpose - add them together and commit.

    git add file1.py file2.py file3.py
    git commit -m "a description-message to your changes" 

    every time you finish some little block of code that you want to secure in git history - do not forget to commit that change. Coding is a very non-linear process with its' ups and downs, hence make commits of everything that you think you would want to roll back to. With git there are less regrets.

    After feeling satisfied with what you have accomplished it is time to "push" your changes for everyone else to see. 

    git push

    And you are done on the command line :) Now one last thing you want to do in the git server before you go to sleep is opening a merge resquest (a pull-request) so your changes become the part of the production.

    go to the repo again, go to "branches" and click on your branch. You will see a "New Pull Request" button. Click that, review your changes, describe your pull request and submit. Now the project owner can review it, request changes and eventually merge your code :) 

    Happy coding. 

    A recap of the story -

    git clone <repo link> = clone the remote repo into local environment

    git pull = give me the code from a branch

    git pull origin main = give me all the new changes from the codebase

    git status = "Where the hell am I? What files have I changed?:

    git add . = "Add all the files I changed to staging"

    git commit -m "my commit message" = take the changes staging and push it up to the repo.

    git push = post changes on that branch
