## Command Line: Introduction

Once you're logged into the server, it's a great time to start practicing basic command-line usage.

In the command line environment your surroundings are files and directories (what people like to call 'folders').
You can move in the file system (the wholeness of files and directories) and you can run commands.

## Anatomy of a command

Commands are programs that get options and arguments. It is easier to see the anatomy of a linux command on examples

> Example 1: ls -a mydir

This command is split into **ls, -a, and mydir/**. The first part of the command is always the **name of the program** you’re running, and the rest are **arguments** passed to that program.

```txt
(1) ls      : list             // the program (the WHAT)
(2) -a      : all              // the flag    (the HOW)
(3) mydir   : the directory    // the normal argument (the WHO) 
```

Notice the dash, it’s important. A dash before an argument means it’s an __option/switch/flag__ (the terms are synonymous) instead of a normal argument. Options (which are optional, haha!) affect __how the program runs__, and normal arguments are targets for the program. 

Without the `-a` flag, the `ls` program would list only normal files in mydir directory and not show the hidden files.

In this case we can tell that `ls -a mydir/` means “list ALL FILES in mydir (the target specified by the normal arguement), even hidden files (the altered behavior specified by the option).”

**Arguments of options** 

Although it’s not shown here, options can also take their own arguments. In that case, the argument goes directly after the option and you have to read the man page to find out whether the argument is for the option or to the program itself.

## The algebra of a command :)

There is no limit on the number of flags and arguments you can pass to a program, although the program might set its own limits.

> Example 2: ls -la --human-readable mydir

As before, this will split on whitespace and call the `ls` command, this time with three arguments: **-la , --human-readable and mydir**. In this section, we’re going to focus on the first two, because they represent a couple different ways to use switches.

Instead of specifying multiple flags each with their own dash, you can use one dash for every option. This means that `ls -la` is exactly the same as `ls -l -a`. Also, the order doesn’t matter. `ls -al` is exactly the same as `ls -la`.

## Paths and Navigation

In linux (which we use on our HPC) directories have **paths**. A path of a directory or a file is the hierarchical route of directories you must traverse through the file system to reach it. A typical example:

```
path of some genome program - /home/username/workspace/genome_analysis
path of omicss26 directory - /mnt/nas1/proj/omicss26
```

Using paths you can navigate through the file system and do many-many operations with the files
Here are reference commands for doing what you need:  

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
| vim | Opens a simple command-line text editor |

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
