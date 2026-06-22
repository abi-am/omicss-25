# Dissecting Lung Cancer Heterogeneity via Single-Cell Transcriptomic Profiling
Lung cancer is one of the most common and deadly cancers worldwide, yet its complexity at the cellular level remains poorly understood. Single-cell transcriptomics provides a powerful approach to uncover rare cell populations, tumor heterogeneity, and interactions within the tumor microenvironment, insights that are essential for improving diagnosis and treatment strategies. 
This 
[project](https://docs.google.com/presentation/d/1RhBNvitkHGf0XaU5YJIngZHS3ZJ6dw9B/edit?usp=sharing&ouid=108169334741774870734&rtpof=true&sd=true)
explores the cellular diversity of lung cancer using scRNA-seq data. 
By analyzing gene expression at the single-cell level, we aim to identify key cell types, genes, and molecular pathways involved in tumor development and progression. 

 ### Contributors
```
Project lead: Maria Nikoghosyan
Contributors: Melina Tamazyan, Ekaterina Kostiuk
```
  ___
  
### Biological Background
[What is cancer](https://www.cancer.gov/about-cancer/understanding/what-is-cancer) \
[About lung cancer](https://my.clevelandclinic.org/health/diseases/4375-lung-cancer) \
[Cancer microenvironment](https://pmc.ncbi.nlm.nih.gov/articles/PMC8194051/) \
[Paper including discussion about current understanding of lung cancer](https://pmc.ncbi.nlm.nih.gov/articles/PMC11116453/?utm_source=chatgpt.com)

___

### Data 
[Publication](https://www.nature.com/articles/s41467-020-16164-1) \
Path on the server
```
comp1:/mnt/nas0/proj/omicss26/gp4/data
```

### Analysis Pipeline

We will follow [Seurat Tutorial 1](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html) to:
- Create a Seurat object
- Do quality control
- Filter cells
- Perform dimensionality reduction ([PCA](https://builtin.com/data-science/step-step-explanation-principal-component-analysis), [UMAP](https://youtu.be/eN0wFzBA4Sc?si=_8XakIY9aeJzdntp))
- Perform cell clustering

In the abovementioned tutorial, you will find a brief description of these steps.

There is several normalisation methods try different versions and choose one.For example [Seurat Tutorial 2](https://satijalab.org/seurat/articles/sctransform_vignette.html) `SCTransform()`

For cell type annotation via label transfer, we will follow [Seurat Label Transfer Tutorial](https://satijalab.org/seurat/articles/integration_mapping.html) using `FindTransferAnchors()` and `TransferData()`

---

#### Phase 1: Rigorous Quality Control (QC)

**What to analyze:** Raw gene-expression matrices from heterogeneous clinical samples.

**How to do it:**
- Calculate QC metrics using `PercentageFeatureSet(object, pattern = "^MT-")`
- Apply adaptive thresholds to exclude low-quality droplets (potential cell fragments) and cells with high mitochondrial content (damaged/dying cells)
- Run log-normalization (`NormalizeData`) and find highly variable features (`FindVariableFeatures`) to prepare for dimensionality reduction
**Target Deliverables:**
  - Plots: Pre- and post-filtering *Violin Plots* showing the distribution of total RNA counts (nCount_RNA), detected genes (nFeature_RNA), and mitochondrial gene percentage (percent.mt); *Scatter Plot* correlating nCount_RNA vs. percent.mt to visualize filtering thresholds. *Variable Features Plot* highlighting the top highly variable genes (HVGs).

- (Optional): Auxillary tables reporting initial cell counts, filtered cell counts, and the number of cells discarded per sample, and the used filtering metrics.
---

#### Phase 2: Global Lineage Mapping

**What to analyze:** Major structural and immunological compartments of the tissue.

**How to do it:**
- Perform PCA (`RunPCA`) and build a shared nearest neighbor graph (`FindNeighbors`, `FindClusters`) at a conservative resolution (e.g., 0.3)
- Visualize the global layout using UMAP embeddings (`RunUMAP`)
- Validate broad identities via canonical markers:

| Compartment | Markers |
|-------------|---------|
| Epithelial | `EPCAM` |
| T / NK cells | `CD3D`, `NCAM1` |
| Myeloid | `CD14`, `LYZ` |
| B cells | `MS4A1` |
| Endothelial / Stromal | `VWF`, `COL1A1` |

**Target Deliverables:**

- Plots: *Elbow Plot* justifying the PC cutoff; *UMAP Plot* colored by seurat_cluster; *Expression Feature Plots* for canonical lineage markers location visualisation. 

---

#### Phase 3: Map TME Atlas via Seurat Label Transfer

**What to analyze:** High-resolution classification of the Tumor Microenvironment.

**How to do it:**
- Subset the non-epithelial compartments (immune and stromal cells)
- Load a public, annotated Lung TME reference atlas (e.g., from the paper or HLCA)
- Find integration transfer anchors between the student query dataset and the reference using `FindTransferAnchors()`
- Predict high-resolution immune cell types (e.g., Alveolar Macrophages vs. Monocyte-derived Macrophages, CD8+ Exhausted T-cells vs. Naive T-cells) using `TransferData()`

**Target Deliverables:**

- Plots: TME-Specific *UMAP Plot* colored by the newly transferred cell types.

---

#### Phase 4: Epithelial Clustering & Functional Naming

**What to analyze:** Malignant heterogeneity and functional state transitions within the epithelial compartment.

**Steps:**

1. **Subset** — isolate the epithelial compartment from the fully-labeled object (`broad_celltype == "Epi"`); re-run normalization and HVG selection on the subset alone so clustering is driven only by epithelial variation

2. **Normal vs Malignant classification** — score every cell with canonical signatures via `AddModuleScore()` and classify by comparing the highest normal-signature score vs the highest malignant-signature score:

   | Class | Signature | Key genes |
   |-------|-----------|-----------|
   | Normal AT2 | Alveolar Type II | `SFTPC`, `SFTPB`, `NAPSA` |
   | Normal AT1 | Alveolar Type I | `AGER`, `PDPN`, `CAV1` |
   | Normal Club | Secretory airway | `SCGB1A1`, `SCGB3A1` |
   | Normal Ciliated | Motile cilia | `FOXJ1`, `DNAI1` |
   | Malignant Squamous | SCC program | `S100A2`, `KRT17`, `TP63` |
   | Malignant Adeno | LUAD program | `IGFBP3`, `MUC5AC`, `AGR2` |
   | Malignant Prolif | Cycling tumor | `MKI67`, `TOP2A`, `CDK1` |

3. **Clustering with optimized parameters** — run PCA (30 PCs), auto-select dims from the elbow plot (last PC adding > 0.5 % variance), sweep resolutions 0.3 / 0.5 / 0.8 on the same UMAP embedding, and work with the resolution that produces biologically interpretable partitions

4. **Top genes** — `FindAllMarkers()` (positive only, `min.pct = 0.2`, `logfc.threshold = 0.4`); visualize top 3 per cluster as a DotPlot and top 5 as a heatmap

5. **GO enrichment** — run `enrichGO` (Biological Process, BH-adjusted *p* < 0.05) on the top 150 marker genes per cluster using `clusterProfiler`; save the full table and render dot-plots per cluster

6. **Naming** — assign each cluster a biologically interpretable label by comparing average cluster expression against the canonical signatures (AT2 / AT1 / Club / Ciliated / Malignant-Sq / Malignant-Adeno / Malignant-Prolif / Hypoxic / EMT); produce a final annotated UMAP with named clusters

**Target Deliverables:**

- Plots: *Module Score Plots* showing the separation of Normal (AT2, AT1, Club, Ciliated) vs. Malignant (Squamous, Adeno, Prolif) signature scores; Marker Gene *DotPlot* displaying the top 3 specific marker genes per epithelial cluster; Expression *Heatmap* displaying the top 5 DEGs per cluster; GO Enrichment *DotPlots* showing the top 10 significantly enriched terms per cluster.

- Tables: DEG Table containing log-fold changes, p-values, and percentage detection metrics, GO Enrichment Results Table containing pathways, gene ratios, and BH-adjusted p-values. Both best saved as .csv files.
---

#### Phase 5: Condition Shift Analysis

**What to analyze:** The architectural remodeling of both tumor and immune landscapes across the 7 specific microenvironments provided in the study metadata.

**How to do it:**

Group the clustered data by the 7 clinical origin states:

| Label | Description |
|-------|-------------|
| `nLung` | Normal lung tissue |
| `nLN` | Normal lymph node tissue |
| `tLung` | Primary lung tumor tissue |
| `tL/B` | Combined primary lung/bronchus samples |
| `mLN` | Lymph node metastasis |
| `mBrain` | Brain metastasis |
| `PE` | Pleural effusion fluid |

Generate fractional stacked bar charts showing how cell type proportions shift across these environments (e.g., the expansion of malignant cells and monocyte-derived macrophages in `mBrain` and `mLN` vs. `nLung`).

**Target Deliverables:**

- Plots: Fractional *Stacked Bar Charts* comparing the relative proportions of all cell types across the 7 clinical origin states.
- Tables: An *Abundance Table* reporting cell counts and percentages of each cell type across the 7 clinical environments.

