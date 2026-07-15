# Contributors

**Contributing authors:** Davit Hakobyan, Siras Hakobyan

# Resources

This 3-day R programming session introduces R syntax, packages, and usage to OMICSS-26 students. This page collects lecture slides, tests, exercises, and other learning resources used across the sessions.

### Day 0

- [Guide for Installing R and RStudio](https://rstudio-education.github.io/hopr/starting.html)

### Day 1

- [Introduction to R Lecture](https://docs.google.com/presentation/d/1ZZ1T-GsKrkeJ-Si6d7lESObEju5313pc/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true)
- [R Basics — Short Test](https://www.w3schools.com/r/exercise.asp?filename=exercise_syntax1)
- [R Exercises — Additional](https://www.geeksforgeeks.org/r-language/r-programming-exercises-practice-questions-and-solutions/)
- The R Mindset Workshop *(link TBD)*
- [Bioconductor installation & BiocManager guide](https://www.bioconductor.org/install/)
- [R Markdown Cheat Sheet (PDF)](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rmarkdown-2.0.pdf)
- [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)

### Day 2 (Homework)

Work through these **before** Day 2. They keep the session fast-paced and interactive; we will also cover further exercises together after discussing the strongly recommended set.

**Rosalind exercises.** Short, well-designed programming challenges that introduce core bioinformatics concepts one step at a time — one of the best ways to get comfortable with R while solving real bioinformatics problems.

- Topic-grouped overview: [Rosalind problem tree](https://rosalind.info/problems/tree-view/)
- Course workbook: [`exercise_sets/rosalind_strong_set.Rmd`](exercise_sets/rosalind_strong_set.Rmd)
- Worked solutions: [`exercise_sets/rosalind_strong_set_solutions.Rmd`](exercise_sets/rosalind_strong_set_solutions.Rmd)
- Extra R practice (with solutions): [GeeksforGeeks R Exercises](https://www.geeksforgeeks.org/r-language/r-programming-exercises-practice-questions-and-solutions/)

**Introductory Rosalind map**

```
Bioinformatics (Rosalind)
│
├── Level 1 – R Warm-up: Strings and Counting
│   ├── DNA    Counting DNA Nucleotides
│   ├── RNA    Transcribing DNA into RNA
│   ├── REVC   Reverse Complement
│   ├── HAMM   Counting Point Mutations
│   └── GC     Computing GC Content
│
├── Level 2 – Pattern Matching and Data Structures
│   ├── SUBS   Finding a Motif in DNA
│   ├── CONS   Consensus and Profile
│   ├── FIB    Rabbits and Recurrence Relations
│   ├── FIBD   Mortal Fibonacci Rabbits
│   └── PROT   Translating RNA into Protein
│
├── Level 3 – Working with FASTA and Collections
│   ├── GRPH   Overlap Graphs
│   ├── LCSM   Shared Motif
│   ├── SSEQ   Finding a Spliced Motif
│   └── SPLC   RNA Splicing
│
├── Level 4 – Probabilities and Genetics
│   ├── IPRB   Mendel's First Law
│   ├── IEV    Expected Offspring
│   ├── LIA    Independent Alleles
│   └── AFRQ   Disease Carrier Frequency
│
└── Level 5 – Algorithms
    ├── EDIT   Edit Distance
    ├── LONG   Genome Assembly
    ├── PDST   Distance Matrix
    └── TREE   Completing a Tree
```

**Strongly recommended set**

| ID | Title |
|----|-------|
| DNA | Counting DNA Nucleotides |
| RNA | Transcribing DNA into RNA |
| REVC | Reverse Complement |
| HAMM | Counting Point Mutations |
| GC | Computing GC Content |
| SUBS | Finding a Motif in DNA |
| CONS | Consensus and Profile |
| PROT | Translating RNA into Protein |

**Apply-family focus.** The apply family (`sapply`, `lapply`, `vapply`, `apply`, `mapply`) is one of the clearest practical differences between R and Python — and it is genuinely useful. When your first instinct is a `for` loop, pause and ask whether an apply-family call can express the same idea more cleanly. Prefer that style especially for:

- GC
- CONS
- DNA
- PROT
- HAMM
- SPLC

### Day 2

- Live discussion and solutions of the Rosalind homework set (see above)
- Bioconductor intro and package installation ([Bioconductor install guide](https://www.bioconductor.org/install/))

### Day 3

- Core bioinformatics packages in R
- Guided hands-on analysis with a biological dataset
- Independent exercises, discussion, and wrap-up

### Useful links

- [Introduction to R Course](https://www.w3schools.com/r/r_intro.asp)
- [1-Hour Crash Course Video About R](https://www.youtube.com/watch?v=eR-XRSKsuR4)
- [Addressing R Package Installation Problems](https://predictiveecology.org/training/_book/TroubleshootingPackageInstallation.html)
- [R Data Visualization](https://r-graph-gallery.com)
- [Which-Plot-To-Make Decision Tree](https://www.data-to-viz.com)
- [Rosalind — Bioinformatics Stronghold](https://rosalind.info/problems/tree-view/)
- [Bioconductor — Install](https://www.bioconductor.org/install/)

# Timeline

### Day 1

| Time | Activity |
| ---- | -------- |
| 18:00–18:10 | Installation troubleshooting |
| 18:10–18:20 | Why R? History, ecosystem, where it is used |
| 18:20–18:45 | Rapid-fire R syntax lecture |
| 18:45–19:00 | Quick syntax warm-up test (W3Schools) |
| 19:00–19:10 | Break |
| 19:10–20:00 | **Thinking in R: Vectorization and Data Manipulation Workshop** |

### Day 2

| Time | Activity |
| ---- | -------- |
| 18:00–18:15 | Review and questions from Day 1 |
| 18:15–19:10 | Discussion and live solutions of Rosalind exercises |
| 19:10–19:20 | Break |
| 19:20–19:40 | Introduction to Bioconductor and the R bioinformatics ecosystem |
| 19:40–20:00 | Installing and exploring key bioinformatics packages |

### Day 3

| Time | Activity |
| ---- | -------- |
| 18:00–18:10 | Review of previous sessions |
| 18:10–18:35 | Introduction to one or two core bioinformatics packages |
| 18:35–19:10 | Guided hands-on analysis with a real biological dataset |
| 19:10–19:20 | Break |
| 19:20–20:00 | Independent exercises, discussion, and wrap-up |
