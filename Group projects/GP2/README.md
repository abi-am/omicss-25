# Contributors
Primary contributor: Tatevik Jalatyan  
Contributing authors: Anahit Yeghiazaryan, Davit Tareverdyan, Mher Kurghinyan  

# Table of Contents  

# Contents  

## Project description  

This project explores telomeric sequences in plasma cell-free DNA (cfDNA) to discover novel biomarkers for early cancer detection and monitoring. Students will process raw cfDNA sequencing data, identify telomeric repeat variants, derive gene expression signals from cfDNA, and analyze telomere maintenance mechanism pathway activity. Statistical tests will be used to compare cancer and healthy samples across public datasets.

## Week 1: Background  

### Molecular Biology Recap [Anahit]
- Telomeres and telomeric repeat variants: 
Telomeres
https://www.ncbi.nlm.nih.gov/books/NBK576429/
https://www.mdpi.com/2073-4425/10/2/118 section 1.1 
TRVs
https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-024-05807-5#:~:text=Telomeres%20are%20regions%20of%20repetitive%20DNA%20at,system%20for%20protecting%20chromosome%20ends%20from%20degradation.&text=From%20targeted%20studies%20of%20telomeres%2012q%20and,arms%2C%20but%20also%20subject%20to%20Mendelian%20inheritance. (Background section partially)
  
- Transcript isoforms
  https://rna.cd-genomics.com/resource/gene-isoforms.html
- Gene regulatory elements (e.g. promoters)
  https://www.researchgate.net/publication/286551059_Gene_Regulatory_Elements
- DNA packaging (nucleosomes and chromatin)
  https://www.nature.com/scitable/topicpage/dna-packaging-nucleosomes-and-chromatin-310/
  https://www.ncbi.nlm.nih.gov/books/NBK534207/
  
### Review Papers [Mher]
- Telomere biology and cancer (e.g. telomere structure, maintenance, dysfunction in cancer)  
  [Telomeres: history, health, and hallmarks of aging](https://www.sciencedirect.com/science/article/pii/S0092867420317505)  
- Cell-free DNA (cfDNA) (e.g. origins, fragmentation patterns, clinical applications)  
  [A hitchhiker’s guide to cell-free DNA biology](https://pmc.ncbi.nlm.nih.gov/articles/PMC9650475/)  
- Nucleosome depleted regions (NDRs) and usage for gene expression inference (not review)  
  [Inferring gene expression from cell-free DNA fragmentation profiles](https://www.nature.com/articles/s41587-022-01222-4)  
  [Tissue-specific cell-free DNA degradation quantifies circulating tumor DNA burden](https://www.nature.com/articles/s41467-021-22463-y)

### Statistics Recap [Davit T.]
- Non-parametric tests (e.g. Mann–Whitney U)
    * [what are non-parametric tests](https://corporatefinanceinstitute.com/resources/data-science/nonparametric-tests/)
    * [Mann–Whitney U test, with medical data example](https://datatab.net/tutorial/mann-whitney-u-test)
    * [Youtube video on non-parametric tests - Sign test, Wilcoxon signed rank, Mann-Whitney](https://www.youtube.com/watch?v=IcLSKko2tsg)
- Multiple testing correction (e.g. FDR)
    * [Intro on what is Multiple testing correction](https://geneviatechnologies.com/blog/what-is-multiple-testing-correction/)
    * [FDR](https://www.publichealth.columbia.edu/research/population-health-methods/false-discovery-rate)
- Correlation (e.g. Pearson, Spearman)
    * [Correlation (Hardcore math)](https://en.wikipedia.org/wiki/Correlation)
    * [Explainer Video](https://www.youtube.com/watch?v=GtV-VYdNt_g)
    * [Person correlation vs Spearman correlation](https://www.surveymonkey.com/market-research/resources/pearson-correlation-vs-spearman-correlation/)
- Clustering methods (e.g. hierarchical)
    * [Youtube video: Intuitive intro to unsupervised ML and clustering](https://www.youtube.com/watch?v=IUn8k5zSI6g)
    * [Youtube video: K-means](https://www.youtube.com/watch?v=4b5d3muPQmA&t=304s)
    * [Youtube video: Hierarchy](https://www.youtube.com/watch?v=7xHsRkOdVwo)
    * [Youtube video: DBSCAN (advanced)](https://www.youtube.com/watch?v=RDZUdRSDOok)
    * [scikit-learn Documentation on Clustering](https://scikit-learn.org/stable/modules/clustering.html)
    * [Cluster analysis (hardcore math)](https://en.wikipedia.org/wiki/Cluster_analysis)
    * [blogpost on the Math of clustering](https://medium.com/@rohit_batra/the-math-behind-the-k-means-and-hierarchical-clustering-algorithm-1d9a36a56c08)
- Dimensionality Reduction (PCA)
  * [What is Dim. Reduction, why we care about it. INTRO](https://www.ibm.com/think/topics/dimensionality-reduction)
  * [PCA step by step](https://www.youtube.com/watch?v=FgakZw6K1QQ&t=5s)

### Tutorials [Mher]
- Cytoscape  
  [Cytoscape tutorial for networks](https://cytoscape.org/cytoscape-tutorials/presentations/network-analysis-ebi-2021.html#/)
- Pathway Signal Flow (PSF) basic usage

### Practice / Toy Examples [Tatevik]
- Run PSF with an example gene count matrix for Telomere Maintenance Mechanism (TMM) pathways  
  - Follow the steps of [TMM package user guide](https://big.sci.am/software/tmm/#userguide)    
    Data: [TMM pathway (Data Sheet 4.ZIP)](https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2021.662464/full#supplementary-material)  
- R plotting practice on synthetic TRV data
  - See Practive/R_plotting.docx file for instructions

## Week 2: Data Preprocessing

### Dataset Description [Everyone]
- *need to choose data and samples*

### Project Presentation (Thu)

## Week 3: ...

### Journal Club [Tatevik]
- Read and discuss this paper:
  [Telomere Maintenance Pathway Activity Analysis Enables Tissue- and Gene-Level Inferences (Nersisyan et al., 2021)](https://doi.org/10.3389/fgene.2021.662464)
     
## Week 4 (Bootcamp): ...


