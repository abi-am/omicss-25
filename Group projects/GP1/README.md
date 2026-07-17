# Contributors

**Primary contributor:** Davit Hakobyan

**Contributing authors:** Nelli Vardazaryan, Razmik Sargsyan

**Short Description:** This project aims to classify biological sex (female/male) using microbial abundance data derived from whole-genome shotgun (WGS) sequencing of saliva samples from a healthy patient cohort. Students will independently download, quality check (QC), preprocess, and run taxonomic profiling (Kraken2/Bracken) on 5 publicly available datasets, before applying differential abundance analysis (ANCOM-BC2) and machine learning/ANN models to identify sex-associated bacterial biomarkers and build classification models.

# Contents



## Phase 1: Background & Methodology Planning

→ `[00_background/](00_background/)`

### Session 1 — Background & Conceptual Foundations

`📅 22/07/2026 | 🕒 16:00–17:00`

- Project presentation and team onboarding | [Slides](https://docs.google.com/presentation/d/15IefB4GflS0AuUV-2zN4wU6PjvJ4bbyI/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true)
- Intro to the microbiome, WGS metagenomics, and the biological rationale for sex-based microbiome differences
- Readings & shared glossary → `[00_background/readings/](00_background/readings/)`
  - [Intro to Microbiome and Term Glossary](https://docs.google.com/document/d/1ZtNl5lPHTRIUPUAoNY7RFSjA7JTCTko8gS1dTk8QU1Y/edit?usp=sharing) *Note: two tabs — introductory reading + term glossary*
  - [Microbiota in health and diseases](https://www.nature.com/articles/s41392-022-00974-4)
  - [Oral Microbiome: A Review of Its Impact on Oral and Systemic Health](https://www.mdpi.com/2076-2607/12/9/1797) | [Reader Guide](https://docs.google.com/document/d/1Dg6fC8XLRIjB1AudXjKiA4XBKfHIKkNdXDpN230H6j0/edit?usp=drive_link)
  - [Sex differences in the oral microbiome, host traits, and their causal relationships](https://doi.org/10.1016/j.isci.2022.105839) *(iScience — saliva/tongue metagenomes; sex-stratified associations)*
  - *BONUS READINGS | on methodologies in the context of oral microbiome research*
    - [The diagnostic potential and barriers of microbiome based therapeutics](https://www.degruyterbrill.com/document/doi/10.1515/dx-2022-0052/html) | [Reader Guide](https://docs.google.com/document/d/1zmJZv0iitOCD3cP-Apra3lrzDZ40_-DBjetkIfzWw7o/edit?usp=drive_link)
    - [Illuminating the oral microbiome and its host interactions](https://academic.oup.com/femsre/article/47/5/fuad051/7259894)
- *[TBD] Brief slides from the mentor — ANCOMBC2, metagenomic data quirks, and/or ML/ANN usage in metagenomics*



### Session 2 — Methodology Decision: ML/ANN & Differential Abundance Methods

`📅 24/07/2026 | 🕒 16:00–17:00`

- Team reviews candidate methodologies: ANCOMBC2, Random Forest, LR w/ LASSO, ANN, etc.
- Group discussion on which methods to adopt
- Output: documented methodology choices → `[00_background/discussion-notes/](00_background/discussion-notes/)`



### Session 3 — Methodology Decision: Training Procedures

`📅 27/07/2026 | 🕒 16:00–17:00`

- Review and decide on training/validation strategies: LODO, LOO, k-fold CV, Permutation testing, etc.
- Finalize analysis pipeline design
- Output: finalized pipeline plan → `[00_background/discussion-notes/](00_background/discussion-notes/)`

---



## Midterm Presentation

- **Preparation:** `📅 03/08/2026 | 🕒 11:00–13:00`
- **Presentation:** `📅 03/08/2026 | 🕔 14:00–16:00`
  - Cover: project objectives, chosen datasets, selected methods, training strategy, expected deliverables
  - Materials → `[04_presentations/midterm/](04_presentations/midterm/)`

---



## Phase 2: Data Acquisition & Processing

→ `[01_data-processing/](01_data-processing/)`

Each team member is responsible for **one dataset end-to-end**: download → QC → preprocessing → Kraken2/Bracken abundance estimation. This ensures everyone gains hands-on experience with the full pipeline before responsibilities are divided for downstream analyses.

**5 Datasets:** saliva / oral WGS from healthy (or healthy-control) cohorts with sex labels

| # | Dataset | Accession | Healthy samples (F:M) | Status |
|---|---------|-----------|------------------------|--------|
| 1 | S025 | [PRJEB60621](https://www.ncbi.nlm.nih.gov/bioproject/PRJEB60621) | 100 (50:50) | ✅ Approved |
| 2 | D001 | [PRJNA1057503](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1057503) | 64 (36:28) | ✅ Approved |
| 3 | S014 | [PRJNA832909](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA832909) | 234 (105:129) | ✅ Approved |
| 4–5 | TBD | — | — | ⬜ Pending |

- **Kraken2 and Bracken** for taxonomic classification and abundance estimation | [Slides](https://docs.google.com/document/d/1lzb_2Edl6AKSLbmNPpS5DOgQIEoxsRFL/edit) | [Exercises](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)
  - `📅 04/08/2026 | 🕔 14:00–17:00` — Dataset download & initial QC (FastQC, Trimmomatic/fastp)
  - `📅 05/08/2026 | 🕔 16:00–17:00` — QC review + Kraken2 classification
  - `📅 06/08/2026 | 🕔 16:00–17:00` — Bracken abundance estimation
  - `📅 07/08/2026 | 🕔 16:00–17:00` — Output QC, troubleshooting, merging abundance tables
  - `📅 10/08/2026 | 🕒 11:00–12:00` — Finalize & validate merged abundance tables

---



## Phase 3: Analysis & Visualization



### EDA & Diversity Analysis

→ `[02_eda-and-diversity/](02_eda-and-diversity/)`

- Introduction to **phyloseq** R package | [Slides](https://docs.google.com/presentation/d/10qHR00zO1d7nvvyZQ-w6jYAGz6wt9XPu/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true) | [Exercises](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)
- Microbial EDA and Diversity Analysis with phyloseq | [Slides](https://docs.google.com/presentation/d/1gS4rng_J9hBSfEwUe5LTIPt7hUSnX3uc/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true) | [Exercises](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)
  - `📅 10/08/2026 | 🕔 14:00–16:00`



### Differential Abundance & ML/ANN Analysis

→ `[03_ml-and-da/](03_ml-and-da/)`

- ANCOMBC-2 for differential abundance | [Guide](https://rpubs.com/mrgambero/lesson_20_ancom)
  - `📅 11/08/2026 | 🕒 11:00–12:00`
- ML/ANN methods for sex classification *(methods TBD — decided in Phase 1, Sessions 2 & 3)*
  - `📅 11/08/2026 | 🕔 14:00–17:00` — Model training & evaluation
- **Deliverable:** R Markdown / Jupyter report with EDA figures, diversity summaries, ANCOMBC2 results, and ML model metrics

---



## Phase 4: Project Execution & Bootcamp

`📅 12/08/2026 – 14/08/2026 | 🕒 Full Day`
→ `[03_ml-and-da/](03_ml-and-da/)` | `[04_presentations/](04_presentations/)`

- **Independent Project Work:**
  - Finalize all analyses, interpret key biomarkers, and visualize findings
  - Write up results and conclusions
- **Presentation Prep:**
  - Build final slide deck: objectives, methods, results, discussion
  - Peer review and rehearsal sessions
- **Final Deliverables:**
  - GitHub repository with analysis code
  - Presentation slides (PDF or PowerPoint)
  - Short written summary of results
