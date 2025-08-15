# Contributors
Primary contributor: Tatevik Jalatyan  
Contributing authors: Anahit Yeghiazaryan, Davit Tarverdyan, Mher Kurghinyan  

# Contents  
- [Project description](#project-description)
- [Week 1](#week-1)
  - [7/28/2025 - 3PM-5PM](#7282025---3pm-5pm)
    - [Project presentation](#project-presentation)
  - [7/29/2025 - 5PM-6PM](#7292025---5pm-6pm)
    - [Molecular biology recap](#molecular-biology-recap)
  - [7/30/2025 - 5PM-6PM](#7302025---5pm-6pm)
    - [Statistics recap](#statistics-recap)
  - [7/31/2025 - 5:30PM-6:30PM](#7312025---530pm-630pm)
    - [HOMEWORK - TMM paper](#homework---tmm-paper)
  - [Extra reading (optional)](#extra-reading-optional)
- [Week 2](#week-2)
  - [8/4/2025 - 4PM-5PM](#8042025---4pm-5pm)
    - [Journal club](#journal-club)
  - [8/6/2025 - 5PM-6PM](#8062025---5pm-6pm)
    - [R plotting practice](#r-plotting-practice)
  - [8/7/2025 - 5PM-6PM](#8072025---5pm-6pm)
    - [Prepare project presentation](#prepare-project-presentation)
- [Week 3](#week-3)
  - [8/11/2025 - 4PM-6PM](#8112025---4pm-6pm)
    - [Project presentation by students](#project-presentation-by-students)
  - [8/12/2025 - 4PM-5PM](#8122025---4pm-5pm)
    - [Dataset description](#dataset-description)
    - [Initial quality check](#initial-quality-check)
  - [8/13/2025 - 5PM-6PM](#8132025---5pm-6pm)
    - [Quality and adapter trimming](#quality-and-adapter-trimming)
  - [8/14/2025 - 4PM-5PM](#8142025---4pm-5pm)
    - [Post-trimming quality check](#post-trimming-quality-check)
  - [8/15/2025 - 4PM-5PM](#8152025---4pm-5pm)
    - [Run Computel for TRVs](#run-computel-for-trvs)
    - [TRV analysis on pre-generated table: within dataset comparisons](#trv-analysis-on-pre-generated-table-within-dataset-comparisons)
- [Week 4](#week-4)
  - [8/18/2025 - 11AM-12PM](#8182025---11am-12pm)
    - TBD
  - [8/18/2025 - 12PM-1PM](#8182025---12pm-1pm)
    - TBD
  - [8/18/2025 - 4PM-5PM](#8182025---4pm-5pm)
    - TBD
  - [8/19/2025 - 12PM-1PM](#8192025---12pm-1pm)
    - [Alignment on reference genome](#alignment-on-reference-genome)
    - [Reference genome index for alignment](#reference-genome-index-for-alignment)
  - [8/19/2025 - 2PM-3PM](#8192025---2pm-3pm)
    - [Gene expression estimation using NDR](#gene-expression-estimation-using-ndr)
  - [8/19/2025 - 3PM-4PM](#8192025---3pm-4pm)
    - [Run PSF using gene expression estimates for TMM genes](#run-psf-using-gene-expression-estimates-for-tmm-genes)
  - [8/19/2025 - 4PM-5PM](#8192025---4pm-5pm)
    - [Cluster samples by gene expression](#cluster-samples-by-gene-expression)
  - [8/20/2025 - 12PM-1PM](#8202025---12pm-1pm)
    - [Run PSF using cluster mean gene expression estimates for TMM genes](#run-psf-using-cluster-mean-gene-expression-estimates-for-tmm-genes)
  - [8/20/2025 - 2PM-3PM](#8202025---2pm-3pm)
    - [Perform combined analysis of ALT, TEL pathway activities and TRV abundances across samples](#perform-combined-analysis-of-alt-tel-pathway-activities-and-trv-abundances-across-samples)
  - [8/20/2025 - 4PM-5PM](#8202025---4pm-5pm)
    - [Perform combined analysis of ALT, TEL pathway activities and TRV abundances across samples (continued)](#perform-combined-analysis-of-alt-tel-pathway-activities-and-trv-abundances-across-samples-continued)
- [Bootcamp](#bootcamp)
  - [8/21/2025](#8212025)
  - [8/22/2025](#8222025)


## Project description  

This project explores telomeric sequences in plasma cell-free DNA (cfDNA) to discover novel biomarkers for early cancer detection and monitoring. Students will process raw cfDNA sequencing data, identify telomeric repeat variants, derive gene expression signals from cfDNA, and analyze telomere maintenance mechanism pathway activity. Statistical tests will be used to compare cancer and healthy samples across public datasets.

## Week 1
## 7/28/2025 - 3PM-5PM  
### Project presentation  
- [Slides](https://docs.google.com/presentation/d/1g2G7LY51qzxKn596i--rHjXK6IBzhMlYm-RCr64h5LE/edit?usp=sharing)

## 7/29/2025 - 5PM-6PM  
### Molecular biology recap  
- Telomeres and telomeric repeat variants (TRVs):   
[Telomeres](https://www.ncbi.nlm.nih.gov/books/NBK576429/)  
[TRVs (only Background section up to Fig. 1)](https://doi.org/10.1186/s12859-024-05807-5)  
- [Gene isoforms](https://rna.cd-genomics.com/resource/gene-isoforms.html)  
- [Gene regulatory elements (e.g. promoters)](https://www.addgene.org/mol-bio-reference/promoters/)  
Promoters are fundamental DNA sequences located just upstream of genes that serve as the launchpad for transcription, directing RNA polymerase and transcription factors to the correct site. These regions typically span ~100–1000 bp and contain core elements like the TATA box, and initiators, which help position the polymerase precisely at the transcription start site. Their essential roles include:  
  -  Initiation: Promoters enable RNA polymerase binding and the assembly of transcription machinery to kickstart RNA synthesis  
  -  Regulation: They integrate signals via bound transcription factors—including activators and repressors—to control when, where, and how much a gene is expressed  
- [DNA Packaging: Nucleosomes and Chromatin](https://www.nature.com/scitable/topicpage/dna-packaging-nucleosomes-and-chromatin-310/)  
- Cell-free DNA (cfDNA) (e.g. origins, fragmentation patterns, clinical applications)    
  [A hitchhiker’s guide to cell-free DNA biology](https://pmc.ncbi.nlm.nih.gov/articles/PMC9650475/)


  
## 7/30/2025 - 5PM-6PM  
### Statistics recap  
- Non-parametric tests (e.g. Mann–Whitney U)
    * [what are non-parametric tests](https://corporatefinanceinstitute.com/resources/data-science/nonparametric-tests/) - 3 min read
    * [Mann–Whitney U test, with medical data example](https://datatab.net/tutorial/mann-whitney-u-test) - 7 min read
- Multiple testing correction (e.g. FDR)
    * [Intro on what is Multiple testing correction](https://geneviatechnologies.com/blog/what-is-multiple-testing-correction/) - 5 min read
    * [FDR](https://www.publichealth.columbia.edu/research/population-health-methods/false-discovery-rate) -5 min read
- Correlation (e.g. Pearson, Spearman)
    * [Explainer Video](https://www.youtube.com/watch?v=GtV-VYdNt_g) - 10 min watch
- Clustering methods (e.g. hierarchical)
    * [Youtube video: Intuitive intro to unsupervised ML and clustering](https://www.youtube.com/watch?v=IUn8k5zSI6g) - 10 min watch
    * [Youtube video: K-means](https://www.youtube.com/watch?v=4b5d3muPQmA&t=304s) - 8 min watch
    * [Youtube video: Hierarchical Clustering](https://www.youtube.com/watch?v=7xHsRkOdVwo) - 11 min watch  
- Dimensionality reduction (PCA)
  * [PCA step by step](https://www.youtube.com/watch?v=FgakZw6K1QQ&t=5s) - 20 min watch

## 7/31/2025 - 5:30PM-6:30PM  
Finish the molecular biology and statistics recap tasks.

### HOMEWORK - TMM paper  
Read this paper and prepare a 45 min (+ 15 min Q&A) journal club presentation summarizing the aim of the research, methods and key findings to present on **8/4/2025 - 4PM-5PM**: 
- [Telomere Maintenance Pathway Activity Analysis Enables Tissue- and Gene-Level Inferences (Nersisyan et al., 2021)](https://pmc.ncbi.nlm.nih.gov/articles/PMC8058386/)  


## Extra reading (optional)
- Telomere biology and cancer (e.g. telomere structure, maintenance, dysfunction in cancer)  
  [Telomeres: history, health, and hallmarks of aging](https://www.sciencedirect.com/science/article/pii/S0092867420317505)  
- [Genetics, DNA Packaging](https://www.ncbi.nlm.nih.gov/books/NBK534207/)  
- [Composition and Diversity of Telomeric Repeats (Section 1.1)](https://www.mdpi.com/2073-4425/10/2/118)  
- Nucleosome depleted regions (NDRs) and usage for gene expression inference  
  [Inferring gene expression from cell-free DNA fragmentation profiles](https://www.nature.com/articles/s41587-022-01222-4)  
  [Tissue-specific cell-free DNA degradation quantifies circulating tumor DNA burden](https://www.nature.com/articles/s41467-021-22463-y)
- [Youtube video on non-parametric tests - Sign test, Wilcoxon signed rank, Mann-Whitney](https://www.youtube.com/watch?v=IcLSKko2tsg)
- [Correlation (Hardcore math)](https://en.wikipedia.org/wiki/Correlation)
- [Person correlation vs Spearman correlation](https://www.surveymonkey.com/market-research/resources/pearson-correlation-vs-spearman-correlation/)
- [Youtube video: DBSCAN (advanced)](https://www.youtube.com/watch?v=RDZUdRSDOok)
- [Cluster analysis (hardcore math)](https://en.wikipedia.org/wiki/Cluster_analysis)
- [blogpost on the Math of clustering](https://medium.com/@rohit_batra/the-math-behind-the-k-means-and-hierarchical-clustering-algorithm-1d9a36a56c08)  
 

## Week 2
## 8/4/2025 - 4PM-5PM  
### Journal club  
- Journal club presentation by students on this paper:  
  [Telomere Maintenance Pathway Activity Analysis Enables Tissue- and Gene-Level Inferences (Nersisyan et al., 2021)](https://doi.org/10.3389/fgene.2021.662464)

## 8/6/2025 - 5PM-6PM  
### R plotting practice  
R plotting practice on synthetic TRV data
 - See [R_plotting.docx](https://docs.google.com/document/d/1CqiE7FmCI2azC8rbFXeCmdmtHB6TxT0w/edit) file for instructions  

## 8/7/2025 - 5PM-6PM  
Prepare a 10-12 min project presentation for 8/11/2025 - 4PM-6PM.

## Week 3
## 8/11/2025 - 4PM-6PM  
Project presentation by students.

## 8/12/2025 - 4PM-5PM
### Dataset description 

One of the datasets for this project comes from [this paper](https://doi.org/10.1016/j.xcrm.2023.101281). We will use cfDNA data from 10 samples (5 colorectal cancer (CRC) patients and 5 healthy donors) to perform raw NGS data processing steps including quality control, trimming and alignment.   

Raw FASTQ files with sequencing reads are located here: `/mnt/proj/omicss25/gp2/ds-23_gastrointestinal/common/fq_renamed`  
Sample metadata table is located [here](https://docs.google.com/spreadsheets/d/1USKgJ9OnbJ2-ICiB7btrKTYcY18Twn-FVCnDWzCoq_8/edit?gid=0#gid=0)   

### Initial quality check
Use `/mnt/proj/omicss25/gp2/ds-23_gastrointestinal/common` as the working directory.

Create script		`src/fastqc.sh` to run FASTQC on files in `fq_renamed` directory storing outputs in `fastqc` directory.  
Create script `src/multiqc.sh` to run MULTIQC on files in `fastqc` directory storing outputs in `multiqc` directory.  

Check the results of quality check. If you identify any quality issues proceed to quality and adapter trimming.   


## 8/13/2025 - 5PM-6PM  
### Quality and adapter trimming 
Create script `src/trim.sh` to remove adapters and low quality bases from files in `fq_renamed` directory if needed storing outputs in `fq_trimmed` directory. Use [cutadapt](https://cutadapt.readthedocs.io/en/stable/guide.html) or [fastp](https://github.com/OpenGene/fastp?tab=readme-ov-file#adapters) tools for trimming.  

#### What to trim  
- Adapters  
 If your FASTQC report shows adapter contamination, remove adapters. There are three common adapters, frequently used in NGS:
 Illumina universal adapter (most common): AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC  
 Illumina Nextera adapter: CTGTCTCTTATACACATCT  
 TruSeq adapter: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT  
 Adapters are [usually found at the 3' end of your reads](https://knowledge.illumina.com/software/general/software-general-reference_material-list/000002905). In rare cases, you'll also need to remove barcodes or adapters from the 5' end.  

- Low quality bases  
  The 3' ends of the reads usually have lower quality (FASTQC Report section: “Per base sequence quality”). If those are too low, you may want to trim all the reads by a certain number of bases from the 3' end.  
  The 5' end may also have issues. You can check the “Per base sequence content” section of FASTQC. If the bases are not uniformly distributed at the 5' end (should be close to a straight line for each base), then there may be barcodes or quality issues. You can choose to remove the first few bases until the distribution becomes uniform.  

- Short reads  
 After adapter and quality trimming, some reads may end up being too short. You can remove short reads entirely from the FASTQ file. As a rule of thumb, reads shorter than 20 bp should be removed.  

## 8/14/2025 - 4PM-5PM
### Post-trimming quality check  
Create script `src/fastqc_trimmed.sh` to run FASTQC on files in `fq_trimmed` directory storing outputs in `fastqc_trimmed` directory.  
Create script `src/multiqc_trimmed.sh` to run MULTIQC on files in the `fastqc_trimmed` directory storing outputs in	`multiqc_trimmed` directory.  

Check if any quality issues persist to perform trimming again if needed.   


## 8/15/2025 - 4PM-5PM

### Run Computel for TRVs 
- Refer to [this poster](https://drive.google.com/file/d/1Nx1q5BNtwkDBcpADz-lfZoG5fjlWiUZm/view?usp=sharing) for background informaton.
- Refer to [Computel 2.0 SOP](https://docs.google.com/document/d/1gVZ7xYtBPW7v71oetAQkewMflmmAz8q_ja0ot0ISxG8/edit?tab=t.0) for detaied instructions on installing, running and extracting results by Computel
- Run Computel on trimmed FASTQ files to generate CSV files with TRV counts/proportions


### TRV analysis on pre-generated table: within dataset comparisons (Try to have some results by 8/18/2025)
Use the file `/mnt/proj/omicss25/gp2/trv_analysis/csv/trv_abs.csv` for TRV counts and `/mnt/proj/omicss25/gp2/trv_analysis/csv/trv_compositional.csv` for TRV percentages across samples derived from multiple datasets. Both files include sample metadata in the first 8 columns: `origin`, `timepoint`, `tissue-type`, `gender`, `age`, `patient_name`, `state`, and `full_name`. The remaining columns correspond to TRVs. Each row represents one sample, uniquely identified by the `full_name` column.  

#### Filter TRVs  
Use these files to obtain a filtered list of TRVs with the following filtering criteria:  
- For each sample keep only TRVs with TRV count >= 10  
- For each sample take top 20 TRVs with TRV percentage > 0.5% including the canonical variant  
- Take union of TRVs from all samples and reduce to unique values 

#### Within dataset comparisons
For each dataset։  
- Perform non-parametric Mann–Whitney U tests comparing percentages of filtered TRVs in cancer (or other disease) vs healthy samples, correct for multiple testing with FDR. Exclude the canonical variant from this analysis.   
- Prepare visualizations (e.g. boxplot, heatmap, scatter plot) as performed during the R plotting practice session. Note, you can use Python as well.  

## Week 4
## 8/18/2025 - 11AM-12PM
### TRV analysis on pre-generated table: within dataset comparisons (Finalise results)

## 8/18/2025 - 12PM-1PM
TBD


## 8/18/2025 - 4PM-5PM
TBD

## 8/19/2025 - 12PM-1PM
### Alignment on reference genome
Create script `src/align.sh` to align trimmed FASTQ files on human reference genome. Use [bwa mem](https://bio-bwa.sourceforge.net/bwa.shtml) program for alignment. 
Log to:			`log/align.log`  
Store output to directory:	`bam`  

#### Reference genome index for alignment  
You'll need a reference genome index to align your reads in FASTQ files. Use prebuilt index for telomere-to-telomere assembly version of human genome (T2T-CHM13v2.0) located here: `/mnt/db/genomes/homo_sapiens/T2T-CHM13v2.0/bwa_mem_0.7.17-r1188/GCF_009914755.1_T2T-CHM13v2.0_genomic.fna`. 

#### Process the alignment output SAM file  
Include these steps in `src/align.sh` script to obtain a final sorted, deduplicated BAM file using the specified [samtools](http://www.htslib.org/doc/samtools.html) command for each step:  
- Convert the alignment output SAM file to BAM file (`samtools view -bS`)  
- Sort the obtained BAM file by genomic coordinates (`samtools sort`)  
- Remove duplicated reads from the sorted BAM file
  - Prepare paired-end reads for duplicate marking by adding necessary tags to the BAM file (`samtools fixmate -m`)  
  - Sort again by genomic coordinates (`samtools sort`)
  - Identify and remove duplicates (`samtools markdup -r`)
- Index the deduplicated and sorted BAM file (`samtools index`)
- Clean up intermediate files

Check log files for alignment status, % of reads aligned and other stats.  

## 8/19/2025 - 2PM-3PM
### Gene expression estimation using NDR 
- Refer to [this poster](https://drive.google.com/file/d/1TmkcANuG47_UXITqIjzOVJx4npqvzBsf/view?usp=sharing) for background informaton.

In order to estimate gene expression from cell-free DNA data a number of inputs are required, which are located in ```meta``` folder:  
- gene position bed file (standard for all samples) - reference.bed 
- promoter positions file - promoter_positions.tsv 
- transcript expression matrix with TPM values obtained from GTEx (standard for all samples) - gtex_tpm.pkl.gz 
- annotation file for transcript expression matrix (standard for all samples) - gtex_attributes.txt 
- healthy tissue contribution file (standard for all samples) - healthy_contributions.tsv 
- tumor fraction file (calculated for each bam file) - ds-23_tumor-fractions.txt 
- gene list - tmm_gene_list.txt 
- tumor tissue of origin (specify in the script)

You will be using ```weighted_coverage_calculation.py``` script. The script utilizes [samtools depth](http://www.htslib.org/doc/samtools-depth.html) function to calculate the coverage of a given position. Make a parent script where you will call it and give all the inputs. 
Tumor fractions are obtained with [ichorCNA](https://github.com/broadinstitute/ichorCNA/wiki) tool and usually are calculated for each bam file. You will be provided with ready tumor fractions and do not need to calculate them with ichorCNA.
NB: The script uses Ensembl gene and transcript IDs to perform all the calculations.

## 8/19/2025 - 3PM-4PM
### Run PSF using gene expression estimates for TMM genes  
Now that you have an expression estimate for each TMM gene, you can use them in Cytoscape to run PSF. 

#### Use following tutorials to run PSF  
- Cytoscape
  * [Cytoscape installation link](https://cytoscape.org/download.html)
  * [Cytoscape installation tutorial](https://www.youtube.com/watch?v=YH-XXHhrv58)  
  * [Cytoscape tutorial for networks](https://cytoscape.org/cytoscape-tutorials/presentations/network-analysis-ebi-2021.html#/)  
    This tutotial will guide you through basic usage of cytoscape, network visualization and a hands-on experience. Just follow the arrows.  
- Pathway Signal Flow (PSF) basic usage  
  * [PSFC user manual](https://big.sci.am/apps/psfc/PSFC_User_Manual_1.1.3.pdf)  
- PSF for Telomere Maintenance Mechanism (TMM) pathways basic usage 
  * [TMM package user guide](https://big.sci.am/software/tmm/#userguide)
  
NB: Entrez IDs are required for TMM analysis, so make sure to replace Ensembl IDs in coverage matrix to Entrez IDs. You can use the ncbi_to_ensembl_mapping.tsv file, which contains Ensembl IDs and their corresponding Entrez IDs. Examine the ALT and TEL pathways for each sample and compare their activity in healthy vs cancer samples.  

Generate a scatter plot with TEL score on x-axis and ALT score on y-axis, with points showing samples and colored by group (cancer, healthy) to check how well the groups separate based on TEL, ALT pathway activity.  

## 8/19/2025 - 4PM-5PM
### Cluster samples by gene expression  
Use the expression estimates of the TMM genes for each sample (5 crc, 5 healthy) to perform hierarchical clustering and plot heatmap with dendograms to see how well the estimated gene expression values separate crc patients from healthy donors. If you identify clusters, use the samples of each cluster for cluster-level pathway scoring of ALT, TEL pathways.  

## 8/20/2025 - 12PM-1PM
### Run PSF using cluster mean gene expression estimates for TMM genes  
Perform the same operations as above (see "Run PSF using gene expression estimates for TMM genes" section), only use cluster mean gene expression estimates as input to Cytoscape. See how well mean expression estimates represent the cancer biology and whether individual samples differ.  

## 8/20/2025 - 2PM-3PM
### Perform combined analysis of ALT, TEL pathway activities and TRV abundances across samples  
Use PSF scores for the ALT and TEL pathways, along with the abundances of identified CRC-specific TRVs per sample, to perform an integrated analysis of telomere maintenance mechanisms and telomeric repeat variants.  

Create a scatter plot with TEL scores on the x-axis and ALT scores on the y-axis, where each point represents a sample and is colored by group (cancer, healthy). For each point, either overlay a radar plot to depict the abundance of CRC-specific TRVs or vary the point size based on the abundance of a CRC-specific TRV. This visualization will help explore TRV abundance patterns across TEL- and ALT-active samples, and healthy and cancer samples.  

## 8/20/2025 - 4PM-5PM
### Perform combined analysis of ALT, TEL pathway activities and TRV abundances across samples (continued) 
Think creatively and explore additional types of visualizations that can illustrate the combined patterns of ALT and TEL pathway activity with TRV abundances across samples.  

## Bootcamp 
## 8/21/2025
Finalise the results.
## 8/22/2025
Finalise the results.  
 

