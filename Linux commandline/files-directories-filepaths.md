## What are files and directories

Files and directories are the two main characters of any file system.

- A **file** is a container for data. It could be text you can read, a program you can run, an image you can view, or just a blob of bytes. To the operating system, *every file is ultimately just a sequence of bytes on the storage device*, plus a name and some metadata (owner, size, permissions, timestamps). What those bytes *mean* is decided by the program that opens them, not by the file itself.
- Dictionaries are everywhere in your life, and labels that group things together - that's exactly what **directories** are. In linux folders are called "directories" and the two words are completely synonymous, but Unix folks usually say "directory". A directory, essentially, is a special kind of file that holds a list of other files (and possibly other directories) - the library shelves that organize the books.

To use the familiar analogy: a file is a sheet of paper with content on it, a directory is a folder that holds sheets of paper and possibly other folders. The whole structure - directories inside directories inside directories - forms a tree.

Between the start of your data on the storage drive and the content you actually want there is a system called the **filesystem**. It is the operating system's bookkeeping layer that knows which physical blocks belong to which file, who is allowed to read or write what, where each directory begins and ends, and so on. Every time you save or open a file, the filesystem is doing the heavy lifting behind your back.

## file extensions

A file "extension" is the snippet after the last dot in a filename: `notes.txt`, `image.png`, `reference.fasta`, `forecasts.csv`. The dot-plus-extension convention (`file.txt`, `data.bam`) is purely a *hint for humans and for some programs* - extensions are just part of the filename, not a separate field.

In Windows the extension is treated very seriously: `.txt` is opened by Notepad, `.py` is run by Python, and renaming `report.docx` to `report.zip` would make Windows very confused.

In linux on the other hand, the filesystem basically shrugs at extensions. It does not care that `notes.txt` is supposedly text - it just knows it is a file. When you ask the system to do something with a file, the actual decision is made by:

- The file permissions (does this file have the executable bit set?).
- The program you give it to (a program reads the bytes and either makes sense of them or not).
- Hints that some programs themselves parse - for example, many tools peek at the first few bytes ("magic numbers") to guess the type, the way `file` command does: `file some_image.png` will tell you the truth no matter what you name the file.

So you'll see plenty of files on our server without any extension at all - `README`, `Dockerfile`, `Makefile` - and programs that work just fine because they don't run on names, they run on content. Still, extensions are a friendly convention and you should use them: they make the file's purpose obvious to *you*, to your colleagues, and to file managers.

## what are executables

An **executable** is a file that the operating system can run as a program. Confusingly, "executable" has two meanings in linux:

1. The permission bit called **execute** (`x`). Whichever entity (owner, group, others) has this bit on a file is allowed to "run" it. You turn it on or off with the `chmod` command.
2. The actual content - whether the bytes inside are something the OS knows how to launch: a compiled machine-code binary, an interpreter-friendly script (starting with a `#!` line, the "shebang", e.g. `#!/bin/bash`), or something else.

Both pieces have to be in place: a file needs the execute bit *and* real runnable content. For example, a `python_script.py` you just wrote has plenty of runnable content but the x-bit may be off - so you typically run it via `python my_script.py` (asking the `python` program to interpret it) rather than `./my_script.py`.

## what are hidden files

A hidden file is just a file whose name begins with a dot - `.bashrc`, `.gitignore`, `.ssh/`. There is nothing special, secret, or locked about it; it is literally a single leading-dot rule that the designers of Unix chose aeons ago to keep your configuration dotfiles from cluttering normal directory listings.

By default, `ls` hides them. Add the `-a` (all) flag and they appear:

```bash
ls -a
```

Hidden files are mostly used for **configuration** - the personal settings of programs that live in your home directory, like `.bashrc` (settings for the bash shell every time you log in), `.ssh/` (your SSH keys and known hosts), `.git` (the inner state of a git repository), `.config/` (modern per-application config), etc. You will edit them by hand a lot as you grow up on a server, so don't be afraid of the dotfiles - they're friends.

## what are permissions of files

Because a server is a shared machine and many users live on it at once, the filesystem has to answer for every file: **who can read it, who can change it, who can run it.** These three accesses hold the answer, and they are stored in the file's **permissions**.

For every file, linux tracks three categories of users:

- **owner** - the user who created or owns the file
- **group** - a set of users who share access (for example, all members of a project lab)
- **others** - literally everyone else on the system

and for each category it records three rights:

- **r** - read (view the file / list the directory)
- **w** - write (modify the file / add or remove entries in the directory)
- **x** - execute (run the file / enter the directory)

The most common way to display these is the `ls -l` output: `-rw-r--r--` means a regular file where the owner can read-write, the group can read, and others can read; `drwxr-x---` means a directory where the owner can do everything, the group can enter and list, and others are shut out entirely.

You change permissions with the **`chmod`** command, and you change *who owns* the file with **`chown`**. A quick example:

```bash
chmod +x my_script.sh      # make my_script.sh executable
chmod 644 notes.txt        # rw-r--r-- (owner rw, group r, others r)
chown alice:lab data.csv   # set owner=alice, group=lab
```

These tiny three letters `rwx` look trivial but, taken seriously, are the whole foundation of multi-user security on a server. Get them right and your colleagues will love you; get them wrong and you either leak a private key to everyone or you accidentally lock yourself out of your own data.

## what are directories

We already flirted with directories a few paragraphs above, but let's give them their proper moment.

A **directory** (or *folder*, if you will) is a special file whose content is a *list of files*. That's it. It's a name you give to a group of related files. Directories can contain other directories, and so on, producing the classic tree structure of a filesystem.

A few directory-flavored things worth knowing:

- The **root directory** is the topmost directory of the filesystem. It has no name and is written simply as `/`. Every single file path on the system is reachable by starting at `/` and walking down.
- Your **home directory** is your personal corner of the server - `~` for short, typically `/home/username`. When you log in you start here. Nobody else can read your private data unless you give explicit permission. Everything you don't have a reason to put elsewhere belongs in `~`.
- A **parent directory** contains the directory you are currently in. This relationship, just like a family tree, is referenced through `..` (two dots). The current directory itself is `.` (one dot). These two shorthands are extremely useful in paths and commands - e.g. `cd ..` to step one level up, or `cp file ..` to copy a file into the parent directory.

## what directories are there on the server

Our HPC follows the classic linux way of organizing things - nothing exotic, just folders with a purpose. Here's a quick tour of what you'll meet the first time you log in.

- `/` - the root. Everything lives under here somewhere.
- `/home` - where users' personal home directories live, e.g. `/home/username`. This is your bedroom on the server: keep your dotfiles here, your small work files, your notes, your git repos. Don't dump huge data here forever.
- `/mnt/nas1`, `/mnt/nas2`, etc. - network-attached storage (NAS) mounts. These are large shared drives that all the compute nodes can see, which is why your jobs running on different machines can all read the same datasets. Project data lives here - for instance, our course material is in `/mnt/nas1/proj/omicss26`.
- `/mnt/space` (or similarly named) - big but temporary "scratch" space where you put intermediate files you don't care to keep. **Important: scratch is not backed up and is cleaned periodically.** Never put anything you can't reproduce there.
- `/tmp` - even more temporary. The operating system's scratch pad. Poof, gone after a reboot, sometimes gone sooner. Use it for fleeting intermediates inside a script and clean up after yourself.
- `/usr`, `/bin`, `/sbin`, `/lib`, `/etc`, `/var`, `/opt` - the system's own directories, where the OS, the installed programs and their configs live. You will mostly *read* from these (especially `/etc` for configs) but rarely *write*. Normal users don't have write permission here, and that's a feature, not a bug - it keeps one bad `rm` from taking down the whole server.

You will spend almost all your time inside `/home/your_username` and `/mnt/nas1/proj/...`. The rest is scenery you'll learn to recognize.

## file hierarchy

When you put files into directories, directories into directories, and so on up to the root, you get the **file hierarchy** - one giant tree that holds the whole filesystem. At the top sits `/`, and every path on the system is just a route through this tree.

```
/
├── home
│   ├── alice
│   │   ├── notes.txt
│   │   └── projects
│   │       └── omicss26
│   └── bob
├── mnt
│   └── nas1
│       └── proj
│           └── omicss26
├── usr
├── etc
├── tmp
└── ...
```

There is exactly one tree on a linux system. Drives, network shares, USB sticks - none of them get their own "drive letter" like `C:` or `D:` on Windows. Instead they are *mounted* somewhere inside the single tree, so that `/mnt/nas1` happens to be the place where the NAS storage is attached, and `/` happens to be where the system drive sits. Wherever you go, you're always navigating the *same* tree.

## file paths - relative and absolute paths

A **path** is the textual route you write down to reach a file or directory in that tree. It's a string of directory names separated by slashes `/`, ending (optionally) at the file or directory you actually want. For example:

```
/home/alice/projects/omicss26/notes.md
```

There are two flavors of paths and it is critical to know the difference:

- **Absolute path**: starts from the root `/`. No matter where you are in the filesystem, an absolute path always points to the *same* file. `/mnt/nas1/proj/omicss26` means the exact same thing whether you're sitting in `/home/alice` or in `/tmp`. Absolute paths are unambiguous - they always work.
- **Relative path**: does *not* start with `/`. It is interpreted *relative to your current working directory* (the directory you're currently "in" - check it with `pwd`). For example, if you are in `/home/alice`, the relative path `projects/omicss26/notes.md` is equivalent to the absolute path `/home/alice/projects/omicss26/notes.md`. Change your directory, and the same relative path suddenly means a different file.

A few special path shortcuts come in extremely handy:

| shorthand | meaning |
| --- | --- |
| `.` | the current directory |
| `..` | the parent directory (one level up) |
| `~` | your home directory (`/home/username`) |
| `~alice` | alice's home directory |

So if you're inside `/mnt/nas1/proj/omicss26/exercise` and you want to reach `/mnt/nas1/proj/omicss26/README.md`, you could write:

- absolute: `/mnt/nas1/proj/omicss26/README.md`
- relative from current dir: `../README.md`

Both reach the same file. The absolute one always works no matter where you stand; the relative one is shorter and is anchored to *where you are right now*.

A quick rule of thumb: **use absolute paths in scripts** (they should never be subject to where you happened to run the script from), and **use relative paths at the interactive prompt** when you find them shorter and clearer. Whichever you pick, just remember the golden question - "what does this path resolve to *from where I am right now?*" - and you'll never get lost in the tree.