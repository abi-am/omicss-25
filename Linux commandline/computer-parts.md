A quick AI-Generated intro for people who happened to be unfamilliar with computer parts

## What are the computer parts doing?

You already heard the words CPU, RAM, storage and network thrown around 

- **CPU (Central Processing Unit)** is the brain. It is the one doing the actual *thinking* - crunching numbers, running your programs, making decisions. Any time a computation happens, the CPU is the one sweating. On servers it has many *cores* (think of them as multiple brains working in parallel), so it can juggle many tasks at once instead of switching back and forth like a laptop does.

- **RAM (Random Access Memory)** is the short-term memory (hypocampus :). When a program runs, the data it is working on is loaded from storage into RAM, because RAM is *fast* - much faster than any disk. RAM is volatile, meaning the moment you cut the power, everything in it vanishes. That is why you have to *save* your work to storage before shutting down. More RAM = a bigger workbench = bigger datasets fit in at once (shout out to genome assemblies).

- **Storage** is the long-term memory, the library of the server. Everything that needs to survive a reboot lives here - the operating system, your files, raw sequencing data, results, databases. Storage is slower than RAM but persistent and much, much bigger. When you *save* a file, it gets written here; when you *load* or *open* it, the relevant chunk is pulled into RAM for the CPU to chew on.

- **Power supply (PSU)** keeps the lights on. Servers often have *redundant* power supplies - two or more feeding the machine at once - so if one dies the others seamlessly take over and the server keeps running. Data centers also have UPS (uninterruptible power supply) units - basically huge battery backups - so a blackout doesn't kill your week-long job in the last hour.

- **Motherboard** is the spine that ties it all together - the big board every other component plugs into so they can talk to each other.

- **GPU (Graphics Processing Unit)** is the math-obsessed cousin of the CPU. The initial intention of GPUs was drawing pictures on the screen, but it turned out GPUs are surprisingly good at math. Often used in machine learning, heavy computing and handling vast datasets. Our fellow datacenters have plenty of these.

So in short: the **CPU thinks**, the **RAM remembers for now**, the **storage remembers forever**, the **network talks to the world**, and the **power, cooling and motherboard** keep the whole organism alive and well. When you run a job, data flows from storage -> RAM -> CPU (and back), and possibly out through the network - that's the circle of (server) life.

That's it. Thank you.
