  # Contributors
    Primary contributor: Siras Hakobyan
    Contributing authors: Antranig Vardanian, Anahit Yeghiazaryan
  # Content  
  # TODO
    Primary contributor assigns tasks to contributing authors with deadlines

# Welcome to the Linux Command Line Course (omics-25)

## 📚 Lecture

Before starting the course, we will have an introductory lecture covering the basics of computer systems, the Unix operating system, and its historical development. The session will also provide an overview of modern Linux distributions that are actively used in bioinformatics.

➡️ **[Link to the presentation]()**

---

## 🔐 Generating an SSH Key Pair

Please follow the provided instructions to generate your SSH key pair (public and private).  
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
ssh -l yourusername nameofserver.abi.am


Replace yourusername with the actual username you received.

🧪 Introductory Materials for Command Line Practice
Once you're logged in to the server, it's a good time to start practicing basic command-line skills.

The following resources will help you become familiar with the terminal environment and foundational Linux commands:

📖 Reading Material:
Command Line for Beginners (Ubuntu)

🎥 Video Tutorial:
Linux Command Line Crash Course

🧰 Tmux: Terminal Multiplexer
When working on multiple tasks or running long processes on a server, it’s helpful to keep sessions persistent even after disconnection. This is where tmux becomes very useful.

Tmux allows you to:

Manage multiple terminal windows and panes within a single session

Detach and reattach sessions at any time

Avoid losing progress when the SSH connection drops

🎥 Introductory Video:
Watch here
(Skip the installation part—Tmux is already installed on the server.)

🧮 AWK Tutorial
AWK is a powerful command-line tool for text processing and data extraction. It’s commonly used for working with structured data such as CSV and TSV files.

More details and practical examples will be added soon.
