## Command Line: Introduction

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

Instead of specifying multiple flags each with their own dash, you can use one dash for every option. This means that `ls -la` is exactly the same as `ls -l -a`. Also, the order doesn’t matter. `ls -al` is exactly the same as `ls -la`.

## How to understand what a command does

every time you see a command, e.g. `ls, rm, mkdir` and you want to see what is it and what you can do with it - you can read the manual.

In unix, every command has a manual with it, which is revealed with the command `man`, short for manual. Not Y chromosome.

```
man <command>
```

you can read the description, check out the flags, the arguments and compose a command that does exatly what and exactly how you want.
For instance we take the command `rm` - remove. 

When we want to remove a directory by using `rm dirname/` it will give us an error like this:

```
rm: cannot remove 'dirname/': Is a directory
```

We can assume that the rm command has a flag for making it work for directories. So we check the manual with `man rm`.

there we can find this flag for recursive deletion

```
    -r, -R, --recursive
            remove directories  and  their  contents  recur‐
            sively
```

and by adding it - `rm -r dirname/`  - we can delete the directory.

Manuals are very helpful. Alternatively you can google examples and see what works. 

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
