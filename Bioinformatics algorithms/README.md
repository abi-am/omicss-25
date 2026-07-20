# Contributors
    Primary contributor: Lilit Nersisyan

Slides: [Alignment Algorithms](https://docs.google.com/presentation/d/1IrP1jassw3BEltLmHbtc97drI0smJ0hU/edit?slide=id.p23#slide=id.p23)
## What's covered

- **The problem** — alignment means finding where each of billions of ~100 bp
  reads came from on a ~3 Gb reference genome.
- **The naive approach** — slide-and-compare pattern matching, and why counting
  the work (`O(L × m)` per read) shows it never finishes at genome scale.
- **Why alignment is hard**
  1. *Too many comparisons* — billions of reads against billions of positions.
  2. *Matches are inexact* — sequencing errors and real variants create
     substitutions, insertions, and deletions, so "found it / didn't" is the
     wrong question.
- **Skipping smartly** — Boyer–Moore's bad-character and good-suffix rules as a
  first taste of "avoid needless work."
- **Scoring inexact matches** — dynamic programming on a grid (edit distance),
  Needleman–Wunsch vs. Smith–Waterman.
- **How modern tools work** — seed-and-extend: cheap pattern matching narrows
  millions of positions to a few, expensive DP runs only there.
- **Indexing** — building an index once (like a sorted dictionary) so seed
  lookups no longer depend on genome size; the Burrows–Wheeler transform (BWT)
  and FM-index behind Bowtie.
- **Quality-aware scoring** — using Phred base qualities to weight mismatches.
- **In practice** — `bowtie2-build` to index the reference once, then `bowtie2`
  to align reads against it.
- **State of the art** — BWA-MEM2 & Bowtie2 (short reads), minimap2 (long
  reads), and hardware acceleration (DRAGEN FPGA, NVIDIA Parabricks GPU).

## Go deeper

- **Practice:** [Rosalind](https://rosalind.info) — code pattern matching, edit
  distance, and DP yourself.
- **Watch:** Ben Langmead, *Algorithms for DNA Sequencing* (YouTube / Coursera).
- **Read:** Langmead et al., *Bowtie*, Genome Biology 2009.
