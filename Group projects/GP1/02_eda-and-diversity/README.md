# 02_eda-and-diversity — EDA & Diversity Analysis

This directory contains R scripts, R Markdown notebooks, output figures, and reports from exploratory data analysis (EDA) and diversity metric computation, performed on the merged Bracken abundance table from [`01_data-processing/merged/`](../01_data-processing/merged/).

## Analysis Steps

1. Import merged Bracken abundance table into **phyloseq**
2. Exploratory Data Analysis
   - Taxa composition barplots (phylum / genus level)
   - Rarefaction curves
   - Prevalence/abundance filtering
3. Alpha diversity
   - Metrics: Shannon, Chao1, Observed taxa, Simpson
   - Statistical testing of alpha diversity differences by sex (Wilcoxon / Kruskal-Wallis)
4. Beta diversity
   - Bray-Curtis dissimilarity, (un)weighted UniFrac
   - Ordination: PCoA, NMDS
   - Statistical testing: PERMANOVA (adonis2)
5. Visualizations and summary figures for the final report

## Contents

### `scripts/`
_Placeholder — add R scripts and R Markdown notebooks here_

Suggested files:
- `01_import_phyloseq.R` — load Bracken output, build phyloseq object
- `02_eda.Rmd` — taxonomic composition plots, prevalence filtering
- `03_alpha_diversity.Rmd` — alpha diversity metrics and plots
- `04_beta_diversity.Rmd` — ordination plots and PERMANOVA

### `figures/`
_Placeholder — add all output plots here (PNG/PDF)_
- Composition barplots
- Alpha diversity boxplots
- PCoA / NMDS ordination plots

### `reports/`
_Placeholder — add knitted R Markdown HTML/PDF reports here_

## Reference Materials
Practice materials for in-session exercises (then applied to project data over the weekend): [Practice folder](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)

- Intro to phyloseq: [Slides](https://docs.google.com/presentation/d/10qHR00zO1d7nvvyZQ-w6jYAGz6wt9XPu/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true) | [Exercises](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)
- Microbial EDA and Diversity Analysis: [Slides](https://docs.google.com/presentation/d/1gS4rng_J9hBSfEwUe5LTIPt7hUSnX3uc/edit?usp=sharing&ouid=103773938036529959456&rtpof=true&sd=true) | [Exercises](https://drive.google.com/drive/folders/1WQBS9mqfdEpRzpkya0jTgdMs1GkOtrLK?usp=sharing)
