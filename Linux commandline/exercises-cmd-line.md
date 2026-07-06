# Command Line Exercises

These exercises will help you practice the commands covered in [command-line.md](./command-line.md).
Do them in order, as each one builds on the previous.

> **Pro Tip:** Use `<TAB>` to autocomplete file and directory names — it saves a lot of typing.

---

## Exercise 1 — Where am I?

1. Print your current working directory.
2. List the contents of the directory you are in.
3. List the contents again, but this time show hidden files and extra details.
4. Move to your home directory, then confirm you are there.

**Commands to practice:** `pwd`, `ls`, `ls -la`, `cd`

---

## Exercise 2 — Create your workspace

1. In your home directory, create a new folder called `practice`.
2. Inside `practice`, create three subfolders: `data`, `scripts`, and `results`.
3. Move into `data`, then go back to the previous directory you were in using the shortcut.
4. List the contents of `practice` to confirm all three folders exist.

**Commands to practice:** `mkdir`, `cd`, `cd -`, `ls`

---

## Exercise 3 — Create and view files

1. Inside `practice/data`, create three empty files: `sample1.txt`, `sample2.txt`, and `sample3.txt`.
2. Open `sample1.txt` in a text editor and write three lines of text (e.g. your name, today's date, and a short sentence). Save and exit.
3. Display the full content of `sample1.txt` in the terminal without opening the editor.
4. Show only the first 2 lines of the file.

**Commands to practice:** `touch`, `vim` (or `nano`), `cat`, `head -n`

---

## Exercise 4 — Copy and move files

1. Copy `sample1.txt` to `sample1_copy.txt` inside the same `data` folder.
2. Move `sample2.txt` from `data` into the `scripts` folder.
3. Move `sample3.txt` from `data` into the `results` folder.
4. List the contents of all three folders (`data`, `scripts`, `results`) to verify where each file ended up.

**Commands to practice:** `cp`, `mv`, `ls`

---

## Exercise 5 — Edit more files and search

1. Open `sample2.txt` (now in `scripts`) in the editor and write a few lines of text. Include the word `genome` at least once. Save and exit.
2. Do the same for `sample3.txt` in `results`, and include the word `genome` at least once.
3. Print the contents of both files using `cat`.
4. Search for the word `genome` inside `sample2.txt`.

**Commands to practice:** `vim` (or `nano`), `cat`, `grep`

---

## Exercise 6 — Copy a whole directory

1. Go back to the `practice` folder.
2. Make a full recursive copy of the `data` folder and name it `data_backup`.
3. List the contents of `data_backup` to confirm the files inside were copied too.
4. Remove the original `data` folder (and everything inside it) without being asked for confirmation.

**Commands to practice:** `cp -r`, `ls`, `rm -rf`

---

## Exercise 7 — Rename and clean up

1. Rename `data_backup` to `data`.
2. Inside `data`, remove `sample1_copy.txt`.
3. List the contents of `data` to confirm the file is gone.
4. Remove `sample3.txt` from the `results` folder.

**Commands to practice:** `mv`, `rm`, `ls`

---

## Exercise 8 — File permissions

1. Inside `data`, check the permissions of `sample1.txt` using `ls -la`.
2. Add execute permission for the owner of `sample1.txt`.
3. Remove write permission for everyone except the owner.
4. Check the permissions again to confirm the changes.

**Commands to practice:** `ls -la`, `chmod`

---

## Exercise 9 — System and disk information

1. Display the manual page for the `ls` command. Read a bit, then quit.
2. Show how much disk space is available on the server, in a human-readable format.
3. List all currently running processes on the system.
4. Clear your terminal screen.

**Commands to practice:** `man`, `df -h`, `ps aux`, `clear`

---

## Exercise 10 — Put it all together

1. Go to your home directory.
2. Display the list of commands you have entered so far in this session.
3. Create a new folder called `final_project`.
4. Inside it, create a file called `README.txt` and write a short summary of what you learned today.
5. Copy the `practice` folder (with all its contents) inside `final_project`.
6. Search for the word `genome` recursively inside `final_project`.
7. Remove the entire `final_project` folder when you are done.

**Commands to practice:** `cd`, `history`, `mkdir`, `vim` (or `nano`), `cp -r`, `grep`, `rm -rf`
