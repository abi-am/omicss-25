# Dissecting Lung Cancer Heterogeneity via Single-Cell Transcriptomic Profiling
Lung cancer is one of the most common and deadly cancers worldwide, yet its complexity at the cellular level remains poorly understood. Single-cell transcriptomics provides a powerful approach to uncover rare cell populations, tumor heterogeneity, and interactions within the tumor microenvironment, insights that are essential for improving diagnosis and treatment strategies. 
This 
[project](https://docs.google.com/presentation/d/1RhBNvitkHGf0XaU5YJIngZHS3ZJ6dw9B/edit?usp=sharing&ouid=108169334741774870734&rtpof=true&sd=true)
explores the cellular diversity of lung cancer using scRNA-seq data. 
By analyzing gene expression at the single-cell level, we aim to identify key cell types, genes, and molecular pathways involved in tumor development and progression. 

 ### Contributors
```
Project lead: Arpine Grigoryan
Contributors: Melina Tamazyan, Sveta Mnatsakanyan, Luiza Stepanyan
```
  ___
  
### Biological Background
[What is cancer](https://www.cancer.gov/about-cancer/understanding/what-is-cancer) \
[About lung cancer](https://my.clevelandclinic.org/health/diseases/4375-lung-cancer) \
[Cancer microenvironment](https://pmc.ncbi.nlm.nih.gov/articles/PMC8194051/) \
Current understanding of lung cancer [Sveta]

___

### Data 
[Publication](https://www.nature.com/articles/s41467-020-16164-1) \
Path in the server [Arpine]

### Processing, Dimensionality Reduction, Clustering
We will follow
[Seurat Tutorial 1](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html) 
to 
- Create a Seurat object
- Do quality control
- Filter cells
- Perform dimensionality reduction ([PCA](https://builtin.com/data-science/step-step-explanation-principal-component-analysis), [UMAP](https://youtu.be/eN0wFzBA4Sc?si=_8XakIY9aeJzdntp))
- Perform cell clustering
  
In the abovementioned tutorial, you will find a brief description of these steps.

BUT for data processing, we will follow
[Seurat Tutorial 2](https://satijalab.org/seurat/articles/sctransform_vignette.html)
as we are going to use SCTransform()

### Cell Type Identification
There are a lot of methods and tools for cell type identification. In our analysis
we will have multi-step cell type identification. 
* Construct a celltype-marker based on the literature ([Human Protein Atlas](https://www.proteinatlas.org) or papers)
* Compare outputs from multiple tools ([Seurat Label Transfer](https://satijalab.org/seurat/articles/integration_mapping.html),
[sc-type](https://www.nature.com/articles/s41467-022-28803-w), [scSorter](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02281-7))
* Validate cell types based on cluster marker genes

### Differential Gene Expression 
[Reminder on differential gene expression](https://www.cd-genomics.com/resource-differential-gene-expression-analysis.html) \
For identifying differentially expressed genes, we will use the FindMarkers() function implemented in Seurat 

### Gene Set Enrichment
[GO Enrichment](https://yulab-smu.top/biomedical-knowledge-mining-book/clusterprofiler-go.html), [fGSEA](https://biostatsquid.com/fgsea-tutorial-gsea/)

### Hypothesis testing
