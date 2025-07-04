  # Contributors
    Primary contributor: Stepan Nersisyan, Suren Davitavyan
    Contributing authors: Siras Hakobyan
  # Contents
| Content | Duration |
|----------|----------|
| 🧰 1. Practice part 1 | ~60-80m  |
| 1.1 Input data||
| 1.2 Pre-filtering||
| 1.3 Differential expression analysis||
| 1.4 p-values and adjusted p-values||
| 1.5 Task 1||
| 1.6 Exploring and exporting results||
| 1.7 EnhancedVolcano||
| 1.8 Multi-factor designs||
| 🧰 2. Practice part 2 | ~40-60m  |
| 2.1 Task for students||
| Overall  | ~120m (2h)  |

  # TODO
    Primary contributor assigns tasks to contributing authors with deadlines

# Welcome to the Practice of the Transcriptomics Course (omicss-25)

A basic step in analyzing RNA-seq count data is finding genes that are expressed differently between conditions. The data usually come in a table showing, for each sample, how many sequencing reads map to each gene. Similar types of data also come from experiments like ChIP-Seq, HiC, shRNA screens, and mass spectrometry. An important question in analysis is to measure and test if there are real differences between conditions, beyond the normal variability seen within each condition. The DESeq2 package helps test for differential expression using negative binomial models. It uses data-based prior distributions to improve the estimates of variability and log fold changes.

---

## 🧰 Package installation

Please follow the provided instructions to install _"DESeq2"_ package.

To install this package, start R (version "4.5") and enter:

      if (!require("BiocManager", quietly = TRUE))

        install.packages("BiocManager")

      BiocManager::install("DESeq2")



➡️ **[Link to the presentation](https://docs.google.com/presentation/d/1Q-kH2b7tVQWlsNbOMMSBRgaV5apPos2axDYLrwrFP5o/edit?usp=sharing)**

---

## 🧰 Description of repository

**dataset/** - Input data folder

  **STAR_counts.tsv** - read counts matrix
  
  **gencode.v42.genes.tsv** - gene annotation
  
  **metadata.tsv** - sample metadata
  
**Diffexpression_analysis.R** - Rscript file (DESeq2 practice)

---
