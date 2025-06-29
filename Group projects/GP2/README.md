# Contributors
Primary contributor: Tatevik Jalatyan  
Contributing authors: Anahit Yeghiazaryan, Davit Tareverdyan, Mher Kurghinyan  

# Contents  

## Project description  

This project explores telomeric sequences in plasma cell-free DNA (cfDNA) to discover novel biomarkers for early cancer detection and monitoring. Students will process raw cfDNA sequencing data, identify telomeric repeat variants, derive gene expression signals from cfDNA, and analyze telomere maintenance mechanism pathway activity. Statistical tests will be used to compare cancer and healthy samples across public datasets.

## Week 1
## 7/29/2025 - 5PM-6PM  
### Molecular Biology Recap [Anahit]  
- Telomeres and telomeric repeat variants (TRVs):   
[Telomeres](https://www.ncbi.nlm.nih.gov/books/NBK576429/)  
[TRVs (only Background section up to Fig. 1)](https://doi.org/10.1186/s12859-024-05807-5)  
- [Gene isoforms](https://rna.cd-genomics.com/resource/gene-isoforms.html)  
- Gene regulatory elements (e.g. promoters)  
  *Select a section from Alberts or Campbell. You can also just give a short text excerpt.*  
- [DNA Packaging: Nucleosomes and Chromatin](https://www.nature.com/scitable/topicpage/dna-packaging-nucleosomes-and-chromatin-310/)  
- Cell-free DNA (cfDNA) (e.g. origins, fragmentation patterns, clinical applications)    
  [A hitchhiker’s guide to cell-free DNA biology](https://pmc.ncbi.nlm.nih.gov/articles/PMC9650475/)  
  
## 7/30/2025 - 5PM-6PM  
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

### 7/31/2025 - 5PM-6PM  

#### Tutorials [Mher]
- Cytoscape  
  [Cytoscape tutorial for networks](https://cytoscape.org/cytoscape-tutorials/presentations/network-analysis-ebi-2021.html#/)
- Pathway Signal Flow (PSF) basic usage

#### Practice / Toy Examples (Part 1) [Tatevik]
- Run PSF with an example gene count matrix for Telomere Maintenance Mechanism (TMM) pathways  
  - Follow the steps of [TMM package user guide](https://big.sci.am/software/tmm/#userguide)    
    Data: [TMM pathway (Data Sheet 4.ZIP)](https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2021.662464/full#supplementary-material)  

### Extra Reading
- Telomere biology and cancer (e.g. telomere structure, maintenance, dysfunction in cancer)  
  [Telomeres: history, health, and hallmarks of aging](https://www.sciencedirect.com/science/article/pii/S0092867420317505)  
- [Genetics, DNA Packaging](https://www.ncbi.nlm.nih.gov/books/NBK534207/)  
- [Composition and Diversity of Telomeric Repeats (Section 1.1)](https://www.mdpi.com/2073-4425/10/2/118)  
- Nucleosome depleted regions (NDRs) and usage for gene expression inference  
  [Inferring gene expression from cell-free DNA fragmentation profiles](https://www.nature.com/articles/s41587-022-01222-4)  
  [Tissue-specific cell-free DNA degradation quantifies circulating tumor DNA burden](https://www.nature.com/articles/s41467-021-22463-y)  

## Week 2
### 8/4/2025 - 4PM-5PM  


### 8/6/2025 - 5PM-6PM  
#### Practice / Toy Examples (Part 2) [Tatevik]
R plotting practice on synthetic TRV data
 - See Practive/R_plotting.docx file for instructions

### 8/7/2025 - 5PM-6PM  
Prepare project presentation. 

## Week 3
### 8/11/2025 - 4PM-6PM  
Project presentation by students

### 8/12/2025 - 4PM-5PM
#### Dataset Description 

One of the datasets for this project comes from [this paper](https://doi.org/10.1016/j.xcrm.2023.101281). We will use cfDNA data from 10 samples (5 colorectal cancer patients and 5 healthy donors) to perform raw NGS data processing steps including quality control, trimming and alignment.   

Raw FASTQ files with sequencing reads are located here: `/mnt/proj/cfdna/cancer/ds-23_gastrointestinal/common/fq_renamed`  
Sample metadata table is located [here](https://docs.google.com/spreadsheets/d/1mgSEbhlcq2JeOBCpB2Ksu-gm89gW8pmp4pD4jkiMh9g/edit?usp=sharing)  

#### Initial quality check
Create script		`src/fastqc.sh` to run FASTQC on files in `fq_renamed` directory storing outputs in `fastqc` directory.  
Create script `src/multiqc.sh` to run MULTIQC on files in `fastqc` directory storing outputs in `multiqc` directory.  

Check the results of quality check. If you identify any quality issues proceed to quality and adapter trimming.   


### 8/13/2025 - 5PM-6PM  
#### Quality and adapter trimming 
Create script `src/trim.sh` to remove adapters and low quality bases from files in `fq_renamed` directory if needed storing outputs in `fq_trimmed` directory. Use [cutadapt](https://cutadapt.readthedocs.io/en/stable/guide.html) or (fastp)[https://github.com/OpenGene/fastp?tab=readme-ov-file#adapters] tools for trimming.  

##### What to trim  
- Adapters  
 If your FASTQC report shows adapter contamination, remove adapters. There are three common adapters, frequently used in NGS:
 Illumina universal adapter (most common): AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC  
 Illumina Nextera adapter: CTGTCTCTTATACACATCT  
 TruSeq adapter: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT  
 Adapters are usually found at the 3' end of your reads. In rare cases, you'll also need to remove barcodes or adapters from the 5' end.  

- Low quality bases
  The 3' ends of the reads usually have lower quality (FASTQC Report section: “Per base sequence quality”). If those are too low, you may want to trim all the reads by a certain number of bases from the 3' end.
  The 5' end may also have issues. You can check the “Per base sequence content” section of FASTQC. If the bases are not uniformly distributed at the 5' end (should be close to a straight line for each base), then there may be barcodes or quality issues. You can choose to remove the first few bases until the distribution becomes uniform.  

- Short reads  
 After adapter and quality trimming, some reads may end up being too short. You can remove short reads entirely from the FASTQ file. As a rule of thumb, reads shorter than 20 bp should be removed.  

### 8/14/2025 - 4PM-5PM
#### Post-trimming quality check  
Create script `src/fastqc_trimmed.sh` to run FASTQC on files in `fq_trimmed` directory storing outputs in `fastqc_trimmed` directory.  
Create script `src/multiqc_trimmed.sh` to run MULTIQC on files in the `fastqc_trimmed` directory storing outputs in	`multiqc_trimmed` directory.  

Check if any quality issues persist to perform trimming again if needed.   


### 8/15/2025 - 4PM-5PM

#### Alignment to reference genome
Create script `src/align.sh` to align trimmed FASTQ files on human reference genome. Use (bwa mem)[https://bio-bwa.sourceforge.net/bwa.shtml] program for alignment. 
Log to:			`log/align.log`  
Store output to directory:	`bam`  

##### Reference genome index  
You'll need a reference genome index to align your reads in FASTQ files. Use prebuilt index for telomere-to-telomere assembly version of human genome (T2T-CHM13v2.0) located here: `/mnt/db/genomes/homo_sapiens/T2T-CHM13v2.0/bwa_mem_0.7.17-r1188/GCF_009914755.1_T2T-CHM13v2.0_genomic.fna`. 
 
Check log files for alignment status, % of reads aligned and other stats. 

#### Journal Club [Tatevik] (*WHEN?*)
- Read and discuss this paper:  
  [Telomere Maintenance Pathway Activity Analysis Enables Tissue- and Gene-Level Inferences (Nersisyan et al., 2021)](https://doi.org/10.3389/fgene.2021.662464)
     
## Week 4: ...
### 8/18/2025 - 11AM-12PM
### 8/18/2025 - 12PM-1PM
### 8/18/2025 - 4PM-5PM

### 8/19/2025 - 12PM-1PM
### 8/19/2025 - 2PM-3PM
### 8/19/2025 - 3PM-4PM
### 8/19/2025 - 4PM-5PM

### 8/20/2025 - 12PM-1PM
### 8/20/2025 - 2PM-3PM
### 8/20/2025 - 4PM-5PM

## Bootcamp
### 8/21/2025
### 8/22/2025
### 8/23/2025
### 8/24/2025







