## What is a server
 
A server is a mutant-computer with exxagerated resources - more RAM, more cpu and more storage. While personal computers are built for one user at a time to run apps and browse the web, servers run continuously to "serve" data, resources, or services to other computers (clients) over a network.
 So scale is different, servers need to work faster, be protected better, they require more maintanace from the admin team and their impact is more. Their path is harder because their calling is higher. 

## What is a server made of

Servers are built for heavy, non-stop workloads. They usually feature more processing power (CPU cores), greater memory (RAM), more space for data (Storage) and redundant components (like multiple power supplies) so they are harder-better-faster-stronger. 

This lovely hardware soup is governed by the operating system.
Unlike our delightful Windows or MacOS laptops with intuitive interfaces that make us happy every day, the servers often run Linux or FreeBSD. Albeit no visual candies, these are highly customizable, lightweight, secure, and, most importantly, free.

Unix is awesome, and every time a person experiences comfort with it - a kitten revives :) I am not willing to gaslight you that it is user-friendly, but when you stop fighting Unix and become its' friend - you reach computer-nirvana.

## How much of CPU, RAM and Memory do we have?

Our server is divided into "rooms", each allocated for specific purpose and designed differently. Some rooms are big, and some are rather small - some have more resources than others. We can assume that our heavy computing operations are delegated to big rooms, and compact rooms host neat, small activities like logins, dowloading something, viewing the logs, etc etc.  

Our house-server has 7 rooms (nodes), of which 3 are big nodes called 'compute' nodes. If it was a real house its plan would look something like this:

![img](./nodes)

We can notice that more compute nodes are armed with a looot of resources, so they can think, work and serve faster. You connect to the ssh nodes, aka login nodes to start your day. dl-01 and dl-02 are called download nodes and here your download jobs must be running. And last but not least, compute nodes - thin-01, thin-02 and thick-01 - for running heavier jobs (e.g. genome sequencing, analysis of oral microbiome samples, etc) that go on and on for days until finished.

## How to connect to a server

To connect to a server you need three things: the server's address (so your computer knows where to find the server), a way in (a username on that server), and proof of identity (a password or, much better, an SSH key). The tool that does the connecting is called SSH (Secure Shell), and you will be using it constantly throughout this course. A more detailed tutorial is written at the bottom of the file :)

## Why dont we want passwords, What is an SSH key and how does it work


Thanks to ssh the server will identify you and not ask for a password each time. But why don't we want passwords, what has that poor password done to us?
The problem is that a password is a single secret: if somebody steals it, they are you. An **SSH key** is much stronger because it is *asymmetric cryptography* - there are two keys, a matched pair, and each one is useless without the other.

1. The **private key** lives only on *your* computer and never, ever leaves it. You guard it like your diary.
2. The **public key** is the lock that goes with it. You can hand copies of the public key to anyone - the server, GitHub, your friends - and it is mathematically designed to be safe to share. From the public key alone, nobody can reconstruct the private one.

When you connect, the server checks whether you hold the private key that matches the public key it has on file for you. It sends you a mathematical challenge; only the real private key can answer it correctly, and the answer proves nothing about the key itself. It's like the server asking "if you really have the key, what is 2 + 2?" and only the genuine key being able to quietly compute "4" - except the math is so hard that an attacker who only saw the answer still can't figure out the key that produced it.

This way the server never even asks for a password, and the private key never travels over the network. The whole protocol is encrypted, so anyone snooping on the wire sees only gibberish. That is why SSH (and SSH keys) is the standard way of reaching servers worldwide, and why our admin team asks you to email them your *public* key the very first thing - so the server knows to trust your matching private key from day one.

## How to connect to a server

To connect to a server you need three things: the server's address (so your computer knows where to find the server), a way in (a username on that server), and proof of identity (a password or, much better, an SSH key). The tool that does the connecting is called SSH (Secure Shell), and you will be using it constantly throughout this course. Thanks to ssh the server will identify you and not ask for a password each time.

From a macOS or Linux laptop the command is rather short:

```bash
ssh yourusername@ssh.abi.am
```

You replace `yourusername` with the username given to you by the admin team, and `ssh.abi.am` is the address of our server's *login nodes* (you always enter the house through them). Windows users typically do the same thing through a friendly program called **MobaXterm**.

Somtimes you will not have the address of the server as convenient combinaiton of words like 'ssh.abi.am' or 'google.com' or 'github.com', instead you will have the address represented in numbers like 172.20.200.57 or 8.8.8.8 or 123.45.234.56 , and these are what we call an 'IP address'.

Once you run the command, your local terminal asks the server to log you in as `yourusername`, and if all goes well it drops you into a shell on the server.
Now you might see your command line as username@ssh-01.abi.am.
From that point on, every keystroke runs on the server ssh-01, not on your laptop.
