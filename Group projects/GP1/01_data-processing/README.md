# 01_data-processing — Data Acquisition & Processing

This directory contains all scripts, logs, QC reports, and outputs related to dataset downloading, quality control, preprocessing, and taxonomic profiling (Kraken2/Bracken).

Each team member is responsible for **one dataset end-to-end** to ensure everyone gains hands-on experience with the full bioinformatics pipeline.

## Pipeline Overview

```
Raw FASTQ (SRA/ENA)
        │
        ▼
    FastQC / MultiQC   (initial QC)
        │
        ▼
    fastp  (adapter trimming & quality filtering)
        │
        ▼
    FastQC / MultiQC   (post-trim QC)
        │
        ▼
      Kraken2          (taxonomic classification)
        │
        ▼
      Bracken          (abundance re-estimation at desired rank)
        │
        ▼
  Merge all 5 tables [TBD]   (combined abundance matrix → 02_eda-and-diversity/)
```

## Contents

### `datasets/`
_Placeholder — create one subfolder per dataset, e.g. `dataset_01/`, `dataset_02/`, ..._

Each dataset subfolder should contain:
- `accession_info.txt` — SRA/ENA accession IDs and sample metadata
- `download.sh` — download script (prefetch + fasterq-dump, or wget/curl)
- `qc/` — FastQC and MultiQC reports (pre- and post-trimming)
- `trimmed/` — trimmed FASTQ files (or symlinks)
- `kraken2_output/` — Kraken2 classification output files
- `bracken_output/` — Bracken re-estimated abundance files

### `scripts/`
_Placeholder — add shared pipeline scripts here_

Suggested scripts:
- `01_download.sh` — template for downloading SRA data
- `02_qc.sh` — FastQC + MultiQC wrapper
- `03_trim.sh` — Trimmomatic/fastp trimming wrapper
- `04_kraken2.sh` — Kraken2 classification wrapper
- `05_bracken.sh` — Bracken abundance estimation wrapper
- `06_merge_tables.py` or `06_merge_tables.R` — merge all 5 Bracken outputs into one matrix

### `merged/`
_Placeholder — the final merged Bracken abundance table(s) used for downstream analysis_
- `merged_bracken_species.tsv` (or genus-level, depending on team decision)

## Dataset Registry

| # | Dataset Name | Source (SRA/ENA) | Accession | Sex Labels? | Assigned To | Status |
|---|-------------|-----------------|-----------|-------------|-------------|--------|
| 1 | TBD | TBD | TBD | TBD | TBD | ⬜ Not started |
| 2 | TBD | TBD | TBD | TBD | TBD | ⬜ Not started |
| 3 | TBD | TBD | TBD | TBD | TBD | ⬜ Not started |
| 4 | TBD | TBD | TBD | TBD | TBD | ⬜ Not started |
| 5 | TBD | TBD | TBD | TBD | TBD | ⬜ Not started |

## Reference Materials
- Kraken2/Bracken Slides: [link](https://docs.google.com/presentation/d/1VVVUJF-MHUnwJs6QUgIrOI6gI5qSQfd5l3i2ynaeTBs/edit?usp=sharing)
- Hands-on Exercises: [link](https://docs.google.com/document/d/1lt99SpV4PNsKcypB8sQjApN3YFj6s2o3CpQMoS0dNHY/edit?usp=drive_link)
- Tutorial (from last year): [`../Kraken_Bracken_tutorial/`](../Kraken_Bracken_tutorial/)
