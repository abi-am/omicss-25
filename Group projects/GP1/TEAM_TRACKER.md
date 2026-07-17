# GP1 Team Tracker
**Project:** Machine Learning-Based Identification of Bacterial Biomarkers for Biological Sex Classification  
**Mentor:** Davit Hakobyan  
**Last updated:** _[fill in date]_

---

## Team Members

| Name | Role | Primary Responsibility | Dataset # |
|------|------|----------------------|-----------|
| TBD | Team Leader | Coordinate, ANCOMBC2 | TBD |
| TBD | Member | ML/ANN pipeline | TBD |
| TBD | Member | Data processing | TBD |
| TBD | Member | Data processing | TBD |
| TBD | Member | EDA & diversity | TBD |

---

## Dataset Registry

| # | Dataset Name / Description | Source | Accession | # Samples | Sex Labels? | Assigned To |
|---|---------------------------|--------|-----------|-----------|-------------|-------------|
| 1 | S025 — healthy saliva WGS | ENA / NCBI | PRJEB60621 | 100 (50:50) | Yes | TBD |
| 2 | D001 — healthy saliva (multi-site cohort) | NCBI SRA | PRJNA1057503 | 64 (36:28) | Yes | TBD |
| 3 | S014 — stimulated mouthwash controls | NCBI SRA | PRJNA832909 | 234 (105:129) | Yes | TBD |
| 4 | TBD | TBD | TBD | TBD | TBD | TBD |
| 5 | TBD | TBD | TBD | TBD | TBD | TBD |

---

## Methodology Decisions
_To be filled during Phase 1 Sessions 2 & 3 (24/07 and 27/07/2026)_

### Differential Abundance
- **Method chosen:** TBD
- **Rationale:** TBD

### ML/ANN Classification
- **Method(s) chosen:** TBD
- **Rationale:** TBD

### Training / Validation Strategy
- **Strategy chosen:** TBD  _(LODO / LOO / k-fold CV / Permutation / other)_
- **Rationale:** TBD

---

## Progress Tracker

### Phase 1 — Background & Methodology Planning

| Task | Assigned To | Due | Status | Notes |
|------|-------------|-----|--------|-------|
| Read Intro to Microbiome & Glossary | All | 22/07 | ⬜ | |
| Read Microbiota in health and diseases | All | 22/07 | ⬜ | |
| Session 1 — Background notes written up | All | 22/07 | ⬜ | |
| Session 2 — Methods decision doc | All | 24/07 | ⬜ | |
| Session 3 — Training procedures decision doc | All | 27/07 | ⬜ | |
| Dataset selection finalized | All + Mentor | 27/07 | ⬜ | |
| Midterm slides drafted | All | 03/08 | ⬜ | |

### Phase 2 — Data Acquisition & Processing

| Task | Dataset | Assigned To | Download | QC (pre) | Trim | QC (post) | Kraken2 | Bracken | Status |
|------|---------|-------------|----------|----------|------|-----------|---------|---------|--------|
| Dataset 1 | S025 | TBD | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Dataset 2 | D001 | TBD | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Dataset 3 | S014 | TBD | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Dataset 4 | TBD | TBD | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Dataset 5 | TBD | TBD | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Merge all 5 Bracken tables | — | TBD | — | — | — | — | — | — | ⬜ |

### Phase 3 — Analysis & Visualization

| Task | Assigned To | Status | Notes |
|------|-------------|--------|-------|
| Build phyloseq object | TBD | ⬜ | |
| EDA — composition plots | TBD | ⬜ | |
| Alpha diversity analysis | TBD | ⬜ | |
| Beta diversity + PERMANOVA | TBD | ⬜ | |
| ANCOMBC2 differential abundance | TBD | ⬜ | |
| ML/ANN model training | TBD | ⬜ | |
| ML/ANN model evaluation | TBD | ⬜ | |
| Feature importance / biomarker list | TBD | ⬜ | |

### Phase 4 — Bootcamp & Final Presentation

| Task | Assigned To | Status | Notes |
|------|-------------|--------|-------|
| Compile final figures | TBD | ⬜ | |
| Final slide deck | All | ⬜ | |
| Written summary | TBD | ⬜ | |
| Code repo cleanup | TBD | ⬜ | |
| Rehearsal | All | ⬜ | |

---

## Session Log
_Brief notes after each session — what was done, what's pending_

| Date | Session | Summary | Action Items |
|------|---------|---------|--------------|
| 22/07/2026 | Phase 1 — Session 1 | | |
| 24/07/2026 | Phase 1 — Session 2 | | |
| 27/07/2026 | Phase 1 — Session 3 | | |
| 03/08/2026 | Midterm | | |
| 04/08/2026 | Phase 2 — Day 1 | | |
| 05/08/2026 | Phase 2 — Day 2 | | |
| 06/08/2026 | Phase 2 — Day 3 | | |
| 07/08/2026 | Phase 2 — Day 4 | | |
| 10/08/2026 | Phase 2/3 | | |
| 11/08/2026 | Phase 3 | | |
| 12/08/2026 | Bootcamp Day 1 | | |
| 13/08/2026 | Bootcamp Day 2 | | |
| 14/08/2026 | Bootcamp Day 3 | | |

---

## Shared Scratchpad
_Quick notes, links, issues, ideas — anything the team wants to share_

```
[Add notes here freely]
```

---

## Quick Links

| Resource | Link |
|----------|------|
| Main README | [README.md](README.md) |
| Background & readings | [00_background/](00_background/) |
| Data processing | [01_data-processing/](01_data-processing/) |
| EDA & Diversity | [02_eda-and-diversity/](02_eda-and-diversity/) |
| ML & DA analysis | [03_ml-and-da/](03_ml-and-da/) |
| Presentations | [04_presentations/](04_presentations/) |
| Kraken2/Bracken Slides | [Google Slides](https://docs.google.com/presentation/d/1VVVUJF-MHUnwJs6QUgIrOI6gI5qSQfd5l3i2ynaeTBs/edit?usp=sharing) |
| Kraken2/Bracken Exercises | [Google Doc](https://docs.google.com/document/d/1lt99SpV4PNsKcypB8sQjApN3YFj6s2o3CpQMoS0dNHY/edit?usp=drive_link) |
| Intro to Microbiome & Glossary | [Google Doc](https://docs.google.com/document/d/1ZtNl5lPHTRIUPUAoNY7RFSjA7JTCTko8gS1dTk8QU1Y/edit?usp=sharing) |
| ANCOMBC2 Guide | [RPubs](https://rpubs.com/mrgambero/lesson_20_ancom) |
