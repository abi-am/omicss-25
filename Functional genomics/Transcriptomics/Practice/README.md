  # Contributors
    Primary contributor: Stepan Nersisyan, Suren Davitavyan
    Contributing authors: Siras Hakobyan
  # Contents
| Content | Duration |
|----------|----------|
| 🧰 1. Practice part 1 | ~60-80m  |
| 1.1 System preparation||
| 1.2 Input data generation||
| 1.3 Differential expression analysis||
| 1.4 Volcano plots||
| 1.5 Exporting results||
| 🧰 2. Practice part 2 | ~40-60m  |
| 2.1 Task for students||
| Overall  | ~120m (2h)  |

# Welcome to the Practice of the Transcriptomics Course (omicss-25)

A basic step in analyzing RNA-seq count data is finding genes that are expressed differently between conditions. The data usually come in a table showing, for each sample, how many sequencing reads map to each gene. Similar types of data also come from experiments like ChIP-Seq, HiC, shRNA screens, and mass spectrometry. An important question in analysis is to measure and test if there are real differences between conditions, beyond the normal variability seen within each condition. The DESeq2 package helps test for differential expression using negative binomial models. It uses data-based prior distributions to improve the estimates of variability and log fold changes.

---
## 🧰 Package installation

Please follow the provided instructions to install _"DESeq2", "EnhancedVolcano",_ and _"ashr"_ packages.

To install these packages, start R and enter:

      if (!require("BiocManager", quietly = TRUE))

        install.packages("BiocManager")

      BiocManager::install("DESeq2")
      BiocManager::install("EnhancedVolcano")

      options(repos = c(CRAN = "https://cran.r-project.org"))
      install.packages('ashr')

---

---
Go to https://github.com/abi-am/omicss-25/ and download the repository as a ZIP file using the following steps:
<img width="1066" height="664" alt="image" src="https://github.com/user-attachments/assets/b6a3a3a7-e417-40a7-82b1-66b60b33c2a7" />

---
Navigate to omicss-25-main/Functional genomics/Transcriptomics/Practice

## 🧰 Description of repository

**dataset/** - Input data folder

    STAR_counts.tsv - read counts matrix
  
    gencode.v42.genes.tsv - gene annotation
  
    metadata.tsv - sample metadata
  
**Transcriptomics_practice.md** - DESeq2 practice

**Functional_annotation_practice.md** - Functional annotation practice

---
