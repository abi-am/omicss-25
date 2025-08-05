# Contributors
Primary contributor: Siras Hakobyan  
Contributing authors: Antranig Vardanian, Anahit Yeghiazaryan

## 🗂️ Course Content & Schedule

| Section                                | Duration     |
|----------------------------------------|--------------|
| [📚 Lecture](#-lecture)                | 60 minutes   |
| [🔐 Generating SSH Keys](#-generating-an-ssh-key-pair) | 10 minutes   |
| [🌐 Connecting to the Server](#-connecting-to-the-server) | 30 minutes   |
| [🧪 Command Line: Introductory Materials](#-command-line-introductory-materials) | 180 minutes  |
| [🧰 Tmux: Terminal Multiplexer](#-tmux-terminal-multiplexer) | 30 minutes   |
| [🧮 AWK Tutorial (advanced)](#-awk-tutorial)      | — |
| **🧮 Total Time**                      | **310 minutes (~5h 10m)** |

## ⚠️ Before You Connect

We highly recommend that all participants **complete the [Command Line: Introductory Materials](#-command-line-introductory-materials)** section *before attempting to connect to the server*. 

This will help ensure you are comfortable navigating the Linux terminal and reduce the likelihood of connection or usage issues during the course.

# Welcome to the Linux Command Line Course (omicss-25)

## 📚 Lecture

Before starting the course, we will have an introductory lecture covering the basics of computer systems, the Unix operating system, and its historical development. The session will also provide an overview of modern Linux distributions that are actively used in bioinformatics.

➡️ **[Link to the presentation]()**

---

## 🔐 Generating an SSH Key Pair

Please follow the provided instructions to generate your SSH key pair (public and private).

🔗 [How to Generate an SSH Key Pair](https://github.com/abi-am/it-resources/blob/main/access-to-server/howto.md)

After generating the keys, email your **public key** to:

📧 **antranigv@abi.am**

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
ssh -l yourusername@comp1.abi.am
```
⚠️ **Note:** Replace `yourusername` with the username you received via email.

---

## Command Line: Introductory Materials

Once you're logged into the server, it's a great time to start practicing basic command-line usage.

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

## 🧮 AWK Tutorial (advanced)

**AWK** is one of the essential tools for processing large text files, which are very common in bioinformatics workflows. It is especially useful for extracting columns, filtering data, and performing basic calculations in a fast and efficient manner—often directly in the terminal.

To get started, we recommend the following online tutorial:

🔗 [AWK Tutorial – Tutorialspoint](https://www.tutorialspoint.com/awk/index.htm)


---

## 🖥️ How to Access the Command Line (Bash)

### 💻 macOS Users

- Open the **Terminal** app, which comes pre-installed with macOS.
- You will be using the **Bash** or **Zsh** shell.
- To check which shell you're using, type:
  ```bash
  echo $SHELL
  ```
- To switch to Bash (if needed), type:
  ```bash
  bash
  ```

### 🪟 Windows Users

#### Option 1: PowerShell or CMD (Recommended with MobaXterm)

- If you've installed **MobaXterm**, use its terminal window (it supports SSH and Bash emulation).
- If using **Windows Terminal** or **PowerShell**, these do not natively support Bash syntax.
  You can still practice some basics but not all Bash commands will behave identically.

#### Option 2: Use Windows Subsystem for Linux (WSL)

- Install WSL with Ubuntu:
  [WSL Setup Instructions](https://learn.microsoft.com/en-us/windows/wsl/install)
- Once installed, open the Ubuntu app to access a full Linux Bash shell.

#### Option 3: Use an Online Bash Terminal (if no setup is possible)

If you do not have access to PowerShell, WSL, or MobaXterm, use an online Bash terminal:

🌐 [JDOODLE Bash Online Shell](https://www.jdoodle.com/bash-shell-busybox/)  
🌐 [OnlineGDB Linux Terminal](https://www.onlinegdb.com/online_bash_shell)

These allow you to practice basic Bash commands directly in your browser.

---

