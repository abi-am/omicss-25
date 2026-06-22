# 03_ml-and-da — ML/ANN & Differential Abundance Analysis

This directory contains code, notebooks, and results for differential abundance analysis (ANCOMBC2) and machine learning/ANN-based sex classification models.

**Input:** merged Bracken abundance table from [`01_data-processing/merged/`](../01_data-processing/merged/)  
**Target variable:** biological sex (female / male)

> Methods and training strategy to be finalized during Phase 1, Sessions 2 & 3.  
> See [`00_background/discussion-notes/`](../00_background/discussion-notes/) for the documented decisions.

## Contents

### `ancombc2/`
_Placeholder — add ANCOMBC2 R scripts and results here_

Suggested files:
- `ancombc2_analysis.Rmd` — full ANCOMBC2 workflow (normalization, model, result extraction)
- `results_table.tsv` — differentially abundant taxa by sex (log-fold changes, q-values)
- `volcano_plot.png` / `barplot_da_taxa.png`

### `ml-models/`
_Placeholder — add ML/ANN training scripts, saved models, and evaluation outputs here_

Suggested structure (adapt based on team's chosen methods from Phase 1):
- `train_model.R` / `train_model.py` — training script with CV/LODO/LOO logic
- `model_evaluation.Rmd` / `.ipynb` — performance metrics (AUC, accuracy, F1, confusion matrix)
- `feature_importance.tsv` — top taxa contributing to classification
- `saved_models/` — serialized model objects

### `results/`
_Placeholder — consolidated tables and figures summarizing biomarker findings and model performance_

Suggested files:
- `top_biomarkers.tsv` — combined list of sex-associated taxa (from ANCOMBC2 + ML feature importance)
- `model_performance_summary.tsv` — metrics across CV folds / datasets
- `final_figures/` — publication-quality plots for the presentation

## Analysis Overview

### Differential Abundance (ANCOMBC2)
- Identify taxa with significantly different abundances between male and female samples
- Controls for compositional bias and multiple testing
- Reference: [ANCOMBC2 Guide](https://rpubs.com/mrgambero/lesson_20_ancom)

### ML/ANN Classification
| Parameter | Decision |
|-----------|----------|
| Methods | TBD (Phase 1, Session 2) — candidates: Random Forest, LASSO, SVM, ANN |
| Training strategy | TBD (Phase 1, Session 3) — candidates: LODO, LOO, k-fold CV, Permutation |
| Input features | Species/genus-level relative abundances from merged Bracken table |
| Target | Biological sex (female / male) |
| Evaluation metrics | AUC-ROC, Accuracy, F1, Precision, Recall |

## Deliverable
- R Markdown / Jupyter report with ANCOMBC2 results and ML model evaluation
- Annotated list of top sex-associated microbial biomarkers
- Figures and tables ready for the final presentation → [`04_presentations/final/`](../04_presentations/final/)
