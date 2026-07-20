Table of content

- What are servers? (+- computer parts) 
- How to generate an ssh key?
- files, directories and filepaths
- command line introduction and exercises
- optional: git basics


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
