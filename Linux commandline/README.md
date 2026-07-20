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
