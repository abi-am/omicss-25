# Armenian Literature Archive — Repair Mission

You have been hired as the new **Armenian Literature Archive Repairer**. The previous
archivist was a disaster: poems are filed in the wrong authors, a poet sits in the wrong
era, an author who isn't even Armenian slipped in, forbidden poems are hidden in the
archive, and at least one poet is missing altogether. Your job: put everything back where
it belongs and reorganize the archive by century.

The archive lives in `armenian-literature/`. Work through the tasks in order.

> Pro tip: `<TAB>` autocompletes file and directory names. Use it constantly.
> Reference for every command is in `../command-line.md`.

---

## The goal — what "done" looks like

When you finish, your `armenian-literature/` folder must look exactly like this:

```
armenian-literature/
├── 5th/
│   ├── buzand_5th.txt
│   ├── khorenatsi_5th.txt
│   ├── koryun_5th.txt
│   ├── mashtots_5th.txt
│   └── yeghishe_5th.txt
├── 10th/
│   └── narekatsi_10th.txt
├── 12th/
│   └── shnorhali_12th.txt
├── 13th/
│   ├── frik_13th.txt
│   └── kecharetsi_13th.txt
├── 16th/
│   └── kuchak_16th.txt
├── 18th/
│   └── sayat_nova_18th.txt
├── 19th/
│   ├── abovyan_19th.txt
│   ├── duryan_19th.txt
│   ├── paronyan_19th.txt
│   ├── raffi_19th.txt
│   ├── shirvanzade_19th.txt
│   ├── sundukyan_19th.txt
│   └── zohrap_19th.txt
└── 20th/
    ├── bakunts_20th.txt
    ├── charents_20th.txt
    ├── isahakyan_20th.txt
    ├── mahari_20th.txt
    ├── sevak_20th.txt
    └── tumanyan_20th.txt
```

Notes about the goal state:
- No hidden `.forbidden_literature` file remains anywhere.
- The old era folders (`ancient_medieval/`, `modern/`, `soviet_20th/`) are gone, replaced by century folders.
- No `wilde_*.txt` file remains — Oscar Wilde is not Armenian.
- Every author's poems live only in that author's file.

When your archive matches the tree above, head to the final exercise to submit it.

---

## Era table (your reference)

| Era | Dates | Authors |
|-----|-------|---------|
| Ancient & Medieval (Ոսկեդար → 18th c.) | 5th – 18th century | **Mesrop Mashtots**, **Koryun**, **Movses Khorenatsi**, **Yeghishe**, **Pavstos Buzand** (5th, Golden Age); **Grigor Narekatsi** (10th); **Nerses Shnorhali** (12th); **Khachatur Kecharetsi**, **Frik** (13th); **Nahapet Kuchak** (16th); **Sayat-Nova** (18th, troubadour) |
| Modern (Zartonk) | early 19th – 1918 | **Khachatur Abovyan**, **Raffi**, **Gabriel Sundukyan**, **Alexander Shirvanzade**, **Hovhannes Tumanyan**, **Avetik Isahakyan**, **Hakob Paronyan**, **Petros Duryan**, **Grigor Zohrap** |
| Soviet / 20th century | 1920 – 1990 | **Yeghishe Charents**, **Axel Bakunts**, **Paruyr Sevak**, **Abu-Lala Mahari** |

Each author file is named `<surname>_<century>.txt` (e.g. `sevak_20th.txt`, `narekatsi_10th.txt`). Filenames already tell you which century a poet belongs to.

---

## Exercise 1 — Locate the archive

Find out where you are, enter the archive, look around — including anything the previous
archivist might have hidden.

**Commands you'll need:** `pwd`, `cd`, `ls`, `ls -la`

---

## Exercise 2 — Reveal the forbidden literature

The previous archivist hid a file somewhere in the archive — a file so sensitive it was
made **hidden** (its name starts with a `.`). Find it, then read what's inside it.

**Commands you'll need:** `cd`, `ls -a`, `cat`, `less`

---

## Exercise 3 — Send the forbidden poems home

The hidden file you just found contains two forbidden poems — one by **Charents** and one
by **Mahari**, both Soviet-era (20th c.) poets. Add each poem's title to the correct author
file in `soviet_20th/` (`charents_20th.txt` or `mahari_20th.txt`), matching the format
already in those files. Once both poems have been moved to their rightful authors, delete
the hidden file.

**Commands you'll need:** `vim` (or `nano`), `cat`, `head -n`, `rm`

---

## Exercise 4 — A misplaced Charents poem

A poem by **Charents** was accidentally filed inside another author's file in
`ancient_medieval/`. Find the misplaced poem, remove it from the file it doesn't belong
in, and add it back to `soviet_20th/charents_20th.txt`.

**Commands you'll need:** `grep`, `vim` (or `nano`), `cat`

---

## Exercise 5 — An intruder who isn't Armenian

Somehow a non-Armenian author slipped into the archive. Find him and delete his file.

**Commands you'll need:** `grep`, `rm`, `ls`

---

## Exercise 6 — A poet in the wrong era

The medieval poet **Frik** (13th c.) has been filed under `modern/`. Move him back to
`ancient_medieval/`, next to his 13th-century peers.

**Commands you'll need:** `ls`, `mv`

---

## Exercise 7 — The missing poet: Axel Bakunts

One Soviet-era author is missing entirely from the archive: **Axel Bakunts** (1899–1937).
Your supervisor has handed you his poems to file:

```
bakunts — Ալփիական պատմվածք
bakunts — Մթնշաղ
bakunts — Խոնարհ մարդիկ
```

Create a file for him in the correct era folder and put these titles inside.

**Commands you'll need:** `touch`, `vim` (or `nano`), `cat`, `ls`

---

## Exercise 8 — Reorganize the archive by century

The era folders (`ancient_medieval/`, `modern/`, `soviet_20th/`) are too broad. Reorganize
the archive by **century** instead.

1. Inside `armenian-literature/`, create one folder per century that actually appears in
   the archive: `5th/`, `10th/`, `12th/`, `13th/`, `16th/`, `18th/`, `19th/`, `20th/`.
2. Move each author file into the folder matching its century (the filename tells you
   which century — e.g. `narekatsi_10th.txt` → `10th/`).
3. Once every file has been moved out, delete the now-empty era folders
   (`ancient_medieval/`, `modern/`, `soviet_20th/`).
4. List `armenian-literature/` and compare it to the goal tree at the top of this file.

**Commands you'll need:** `mkdir`, `mv`, `ls`, `rm -rf`

---

## Exercise 9 — Protect the Golden Age

The 5th-century histories are the oldest, most precious items in the archive. Make sure
nobody but the archive owner can accidentally overwrite `5th/khorenatsi_5th.txt`: add
execute permission for the owner, and remove write permission for everyone else. Confirm
the new permission bits.

**Commands you'll need:** `ls -la`, `chmod`

---

## Exercise 10 — Back up the oldest era

Before any further work, make a safety copy of the `5th/` folder.

1. From `armenian-literature/`, make a full recursive copy of `5th/` named `5th_backup/`.
2. Verify everything inside the backup was copied.
3. Delete the original `5th/` folder and everything in it, without confirmation.
4. Rename `5th_backup/` back to `5th/`.

**Commands you'll need:** `cp -r`, `ls`, `rm -rf`, `mv`

---

## Exercise 11 — System & process check

1. Open the manual page for `grep`. Skim the section on the `-v` flag, then quit.
2. Show how much disk space is free on the server, in human-readable units.
3. List every currently running process on the system.
4. Display the list of commands you have typed so far in this session.
5. Clear your terminal screen when done.

**Commands you'll need:** `man`, `df -h`, `ps aux`, `history`, `clear`

---

## Exercise 12 — Final audit & submission

1. From `armenian-literature/`, search **recursively** for the word `charents`. Confirm
   every hit lives inside `20th/charents_20th.txt` — nowhere else.
2. Search recursively for `wilde` — you should get **no hits**.
3. Search recursively for `bakunts` — confirm the new poet is filed in `20th/`.
4. Search recursively for `forbidden` — you should get no hits (the hidden file removed).
5. Compare your directory tree to the goal tree at the top of this file. They must match.
6. Display your command history one last time — this is your repair log.
7. **Submit:** your instructor will give you a git repository URL. Initialize git in the
   `exercise/` folder, commit your repaired archive, and push it to that repository.
   Follow `../git-basics.md` if you need a refresher.

**Commands you'll need:** `grep -r`, `history`, `clear` + the git commands from `git-basics.md`

---

Welcome to the team, archivist. The archive is counting on you.
