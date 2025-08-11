# Contributors
   Primary contributor: Nate Zadirako  
   Contributing authors: Mariia Arakelian, Nane Pivazyan  
  # Contents  
  * Overview
  * Background
  * Data preprocessing
  * Principal Component Analysis
  * ADMIXTURE
  * Phylogenetic analysis
    
## Project Overview
[This project](https://docs.google.com/presentation/d/1DHRvp5NNiV4ECnvonUFlFQRDzW8pGVzK/edit?usp=sharing&ouid=115394168503379180010&rtpof=true&sd=true) aims to explore the population structure of Caucasian varieties of grapevine using whole-genome sequencing data. The participants will become familiar with the VCF file format, the standard data preprocessing pipeline (variant calling, filtering) and the downstream population genomics analyses (ADMIXTURE, phylogenetic tree construction).  

## Background
Now that whole-genome sequencing (WGS) is relatively cheap and accessible, it has become possible to collect WGS data from hundreds or even thousands of individuals. This enables us to explore large-scale patterns of genetic variation across entire populations.   

**Population genetics** is the study of the genetic makeup of biological populations and changes in this makeup over time. It provides insights into evolutionary processes such as natural selection, genetic drift, mutation, and migration.   

> NOTE: new to mechanisms of evolution? You can learn more about them [here](https://evolution.berkeley.edu/evolution-101/mechanisms-the-processes-of-evolution/).

**Population genomics** extends these principles to genome-wide data, allowing us to look at variation across the entire genome, rather than focusing on a few selected markers.  

In practical terms, we might want to understand where a given sample came from, how it relates to others, or whether distinct groups of individuals share common ancestry. 

In this project, we will apply these concepts to real WGS data and perform two downsteam analyses: **ADMIXTURE** and **phylogenetic tree construction**.  

**ADMIXTURE** is a model-based clustering method that estimates the proportion of ancestry each individual inherits from a predefined number of ancestral populations. It is used to detect population structure and infer historical admixture events. For our grapevine dataset, ADMIXTURE will help us understand whether different varieties share ancestry and to what extent they may represent mixtures of multiple ancestral gene pools.  

**Phylogenetic tree construction**, on the other hand, focuses on the evolutionary relationships between individuals or groups. By building a tree, we can visualize how closely related different grapevine samples are and potentially infer patterns of divergence and descent. This can reveal clades of related varieties and provide a complementary view to the ADMIXTURE results.  

Together, these two analyses give us a nice interpretable overview of both shared ancestry and evolutionary relationships in our dataset.  

> You might be curious what other people are doing with this kind of data and tools! [This review](https://academic.oup.com/gbe/article/15/4/evad054/7092825) describes the application of admixture to human populations, and [this report](https://www.journalofinfection.com/article/S0163-4453(20)30159-6/fulltext) describes shows how phylogenetic analysis can be used to track the infection source of a COVID-19 patient.  

### Data

The data for this project comes from [this publication](https://www.science.org/doi/10.1126/science.add8655). We will reanalyse a subset of Caucasian grapevine samples, both cultivated (*V. vinifera*) and wild (*V. sylvestris*), and attempt to uncover patterns of genetic diversity from populations of different geographic origin.   

You can familiarise yourself with the samples, their regions of origin, genetic background and phenotypes by studying the metadata table here:   

```
/mnt/proj/omicss25/gp3/metadata/cauc_arm_grape.metadata.tsv
```

| **Field**                      | **Description**                                                                                                                               |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **Sample code**               | A unique identifier assigned to each accession. This code is also used in the filenames.                                                     |
| **Variety ID**                | The name of the accession.                                                                          |
| **Genetic background**        | Indicates whether the sample is *V. vinifera* ssp. *vinifera* (cultivated), *V. vinifera* ssp. *sylvestris* (wild), or a hybrid/cross.      |
| **Utilization**               | Describes the intended use of the grapes: table consumption, wine production, raisin making, or multiple uses.                              |
| **Berry skin color**          | The observed skin color of the grape berries.                                                                                                |
| **Flower phenotype**          | Indicates the flower type: male, female, or hermaphrodite.                                                                                   |
| **Geographic origin (region)**| For Armenian samples, the origin is further specified by region within the country.                                                           |
| **Bunch density**             | Describes the compactness of the grape bunches, ranging from loose to dense.                                                                  |
| **Geographic origin (country)**| The country where the sample was collected.                                                                                                 |
| **Muscat taste**              | Indicates whether the characteristic muscat flavor is present or absent.                                                                     |

> NOTE: the actual dataset is large, so we need to select a few well-behaving samples.  

The data is provided to you as VCF files. These files were created from sequencing reads which were controlled for quality, aligned to the reference, and subjected to variant calling using the GATK toolkit.  

```
# path to the data

/mnt/proj/omicss25/gp3/data
```

Learn more about the VCF file format and what each field represents [here](https://samtools.github.io/hts-specs/VCFv4.2.pdf).  

## Data preprocessing

### Merging gVCFs

> NOTE: as this part is computationally demanding, it was pre-computed for you. From the filtering section onwards, you will be running commands yourself.

For any scripts engaging the GATK tooks, refer to the path here:
```
/mnt/proj/omicss25/soft/gatk-4.1.8.1/gatk
```

We started with sequencing data for individual samples and used GATK’s [HaplotypeCaller](https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller) to perform variant calling and identify reference and alternative alleles. The files it outputs are gVCF files (genomic VCF). This format includes not only the variant sites but contains information about non-variant regions as well, so the entire genome is covered. 

This later allows us to combine the individual samples and perform joint genotyping. We employ another GATK tool, [CombineGVCFs](https://gatk.broadinstitute.org/hc/en-us/articles/360037053272-CombineGVCFs), to create a multi-sample VCF file prepared for variant calling. [GenotypeGVCFs](https://gatk.broadinstitute.org/hc/en-us/articles/360037057852-GenotypeGVCFs) then performs the joint calling by comparing evidence across every position in the genome and across all samples to decide which variants (SNPs or INDELs) are present, and at what individuals.   

Since we have a high number of samples and the genomes themselves are quite large, combining and joing calling is performed on chromosome-by-chromosome basis, and the chromosomes will later be merged together (this helps us save project memory).  

Finally, we separate different types of variants into their own files. SNPs and INDELs have distinct filtering criteria, so they're usually analysed separately. The output of this sequence of steps is two raw VCF files.

### VCF filtering

The combined VCFs must be filtered to prepare the data for downstream analysis.  

First, we will apply GATK hard-filtering ([VariantFiltration](https://gatk.broadinstitute.org/hc/en-us/articles/360037434691-VariantFiltration)) to remove low-quality variants that fail to pass the thesholds based on the metrics we define, such as overall quality score, strand bias and mapping quality. For SNPs, we will apply the following criteria:  

(The INDELs will not be analysed in this project, so we will leave them alone.)   

GATK does not directly remove the non-passing variants but tags them, and they have to be filtered out using [vcftools](https://vcftools.sourceforge.net/man_0112b.html). 

We will also apply additional biological filters to make sure our SNP set is suitable for population genetic analysis.  

**Biallelic SNPs**: we will keep the SNPs that can either be reference or a single alternate variant. This is done for symplicity, as they are easier to analyse and interpret downstream.   
**Missingness**: we will only retain SNPs for which at least 60% of samples in the dataset have information available. Missing data arises from sites that had low coverage during sequencing or alignment issues during assembly. By filtering for missingness, we retrain only reliable, generally well-covered sites in the genome.  
**Minor allele frequency (MAF)**: we will remove the rarest SNPs by keeping only those that are encountered with the frequency of >0.5%. MAF is the frequency of the second most common allele in the population. Extremely low MAF might be pointing to genotyping effors. More common SNPs are considered more reliable and are more likely to be true features of our populations.   

After filtering is complete, the resulting VCF file needs to be indexed.   

## Population Genomics

### Principal Component Analysis  

This is a preliminary step that will help us explore our data and might be useful for defining sample groupings down the line. **PCA** is a dimensionality reduction method. Our data contains many thousands of SNPs, which makes it high-dimentional – we wouldn't be able to make sense of the similarities and differences between our samples just by looking at the VCF file. Instead, we will perform clustering using PCA, and then visualise it to get a nice, inetrpretable representation of our dataset.  

If you're new to PCA, consider watching these videos: an [explanation](https://youtu.be/HMOI_lkzW08?si=gRvIc-k7yNK6HDH1) of the concept and a more detailed [tutorial](https://youtu.be/FgakZw6K1QQ?si=YCuLSSm8LHvFYzix) on how it is performed.   

We will perform PCA using plink (see the dimensionality reduction section of the [plink manual](https://www.cog-genomics.org/plink/1.9/strat)).  

> Remember that plink has its own preferred formats and will not run directly on your VCF file.  

> The data used for PCA needs to be quality-controlled, and outliers and missingness need to be handled before you start.  

```
# N tells plink how many PCs to calculate
# omit this parameter to get the default 20 

plink --bfile caucasian_grape --pca [N] --out caucasian_grape_pca
```

This command will output `.eigenval` (eigenvalues, variance explained by each PC), `.eigenvec` (eigenvectors, principal component scores for each individual; in this file, each row is a sample with its projected coordinates on each principal component) and a `log` file.  

 Visualize the PCA results with your favourite plotting tools by plotting PCs against each other – it's nothing more complicated than a scatter plot. You can also use PCs as covariates in association tests to correct for stratification.   
 
> What can you tell from looking at the clustering? Can the principal components themselves be interpreted?

### ADMIXTURE 

  The **ADMIXTURE** is a computational program used in population genetics to estimate the ancestry composition of individuals based on their genetic data. Given genotype data from multiple individuals, the tool models each individual's genome as having originated from a predefined number of ancestral populations (often denoted as K). The program uses a statistical algorithm to estimate, for each individual, the proportion of their genome that comes from each of these ancestral populations. For example, if K = 3, an individual might have 70% ancestry from population 1, 25% from population 2, and 5% from population 3. This shows that their genetic background is mostly from the first population but also includes contributions from the others.

For any scripts engaging the ADMIXTURE tool, refer to the path here:
```
/mnt/proj/omicss25/soft/admixture_linux-1.3.0/admixture
```
  ## Step 1 (Filtering)
  
   As an input we need to give filtered plink binary format files (.bed, .bim. fam). Filtering should include the following steps:

   - **Anotation** - samples should have individual, unique ID's. So if the VCF file that we need to analyze is not annotated, firstly we need to annotate it using bcftools. 

**Then we can proceed with Filtering using [PLINK](https://www.cog-genomics.org/plink/1.9/filter) tool**.

```
/mnt/proj/vine/user_projects/shengchang/soft/plink/plink
```
   - take only 1-19 autosomal chromosomes
   - **Biallelic SNPs** - we keep the SNPs that are either reference or alternative variant.
    
   - **Minor allele frequency (MAF)** - we will remove the rarest SNPs by keeping only those that are encountered with the frequency of >0.5%. MAF is the frequency of the second most common allele in the population. Extremely low MAF might be pointing to genotyping effors. More common SNPs are considered more reliable and are more likely to be true features of our populations.
     
   - **[LD pruning](https://www.cog-genomics.org/plink/1.9/ld)** - LD pruning is the process of removing genetic variants (SNPs) that are highly correlated (in linkage disequilibrium, LD) to keep only independent markers. This is done to reduce redundancy and avoid bias in the analysis. Paramets for LD pruning are **windiw size** (The genomic region size scanned), **Step size** (How much the window moves each step), **r² threshold** (Correlation cutoff above which SNPs are pruned). The comonly used parameters are (50, 5, 0.5).

As an output we will have plink finary format files (/.bed, /.bim, /.fam).

- **/.bed — Binary genotype data file** : Contains the actual genotype calls in a compact binary format for all samples and SNP

- **/.bim — Variant information file** : Contains SNP IDs, chromosome, genetic position, physical position, and alleles for each variant (one line per SNP).

- **/.fam — Sample information file** : Contains family and individual IDs, paternal/maternal IDs, sex, and phenotype for each sample (one line per individual).

 ## Step 2 (ADMIXTURE analysis)
 
Now that we have filtered plink binary format files, we can proceed with the ADMIXTURE analysis. The documentation can be found [here](https://speciationgenomics.github.io/ADMIXTURE/).

We do the ADMIXTURE by **K-fold cross validation**. K-fold cross-validation is used to estimate how well the model fits the data for a given number of ancestral populations (K). Here is how it works

1. The program splits the data (SNPs) into K equal parts (folds). The defoult parameter is 5.
2. The the program randomely "hides" part of the data and treats it as missing data (if data is devided into K equal parts, 1 part will be "hidden").
3. The model is trained on the remaining data.
4. The model tries to predict the hidden part of the data.
5. The program calculates cv error by comparing the predicted data to the actual one that was hidden.

> NOTE: In general lower cv error means that the model fits better better but it is not always the case. In case of high K we might have lower cv error but it can lead to overfitting of the model. So when deciding an appropirate K to chose we must not consider only cv error rate but also the biological meaning and interpretation.  

ADMIXTURE is usually run for some range of Ks, typically from K=2, to K = 10. This is done to compare different models with each other and chose the one that fits the most to our project.  

 > NOTE: ADMIXTURE involves randomization (in cross-validation), so to ensure results are reproducible, you can set a random seed with the *--seed* option:

## STEP 3 (Visualization and interpretation) 

As an output of the ADMIXTURE we will get 3 types of files (/.log, /.Q, /.P).  

- **/.log** file contains run infromation and cv errors.
- **/.Q** contains a matrix that contains information about ancestry proportions. Each row here is a sample (individual) and each column coressponts to one of the K ancestral populations (K=1, K=2....). Values of the matrix tell what proportion of the certain sample's ancestry comes from the population of coressponing column. 
- **/.P** file contains a matrix that contains information about allele frequencies. Each row eas a SNP, each column is ancestral population. It tells us what each ancestral population looks like genetically.

Now we can proceed with the visualization in R.  

As the aim of this project is to understand population genetics of grapevine, we are going to analyze Q matrices. For that, we need to visualize them by constructiog  a barplot. In Q matrix is row is an indivisual each column is an estimated population. The valuse of the matrix represents the proportion of one population. We need to represent this by barplot, where each bar is an individual, colored by the ancestral population proportions.  

> NOTE: Make a .txt file with sample names, that are ordered in the same way as in Q matrices, to use them in the graphs. You can take them from /.fam file. 

At K = 2, the Q matrix plot typically reveals the broadest split in the dataset, usually it splits the samples into three categories.  

 **1st category - cultivated**     
 
  - Samples with K = 1 component >= 0.75
  - Represent domesticated populations that have undergone selection.
   
 **2nd category - wild**
    
  - Samples with K = 2 component >= 0.75
  - Represent natural, undomesticated populations — often genetically distinct.

**3rd category - admixed**

   - The rest
   - These are individuals whose genomes are a mix of cultivated and wild lineages.

   
> Note: In  the analysis it does not neceserly mean that K=1 represents cultivated grapevine and K=2 wild grapevine. It can be visa versa. To understant which K rersednts what cluster, check the metadata.

For the visualizaton, group samples by their countries of origin. Then in each country, organize by major one of the Ks e.g. 4,5, or 6 component and list in increasing or decreasing order.  

> Note: For all Q matrices, the order of the samples must be the same!  

   #### &emsp;ADMIXTURE results ploting in R:
   - Cultivated, admixed, wild clusters distinction
   - Grouping samples in clusters by countries
   - Rscript in bash

## STEP 4 Phylogenetic analysis

Phylogeny is the representation of the evolutionary history and relationships between groups of organisms.  

Phylogenetic analysis is employed to infer the evolutionary relationships among genes or species and to represent these relationships through a branching diagram called a phylogenetic tree. Phylogenetic analysis is essential because the entities under study—commonly referred to as taxa, whether they are genes, species, or other biological units—are not statistically independent, but are linked by shared evolutionary history. To draw meaningful statistical conclusions about patterns of biological variation among taxa, it is necessary to first estimate these historical relationships. Some introductory material you can find [here](https://www.sciencedirect.com/science/article/pii/S0960982297700708).  


One of the project trajectories is to explore the evolutionary relationships and structure among Caucasian grape accessions based on SNPs variants. To achieve this goal, the phylogenetic tree should be constructed using Maximum Likelihood phylogenetic analysis algorithm.  

Preliminary SNPs data filtering is required:  

- Minor allele frequency should be more than 10 % (MAF > 0.1)  
- Missing genotype rate should be less than 10 % (geno < 0.1)  

The essential component for tree construction is genetic SNPs data of outgroup sample. Outgroups are species that branched off from the ingroup taxa (species of interes) before those taxa diverged from one another, and they are commonly used to establish the root of a phylogenetic tree. It has been proposed that, among all outgroups with similar sequencing quality, the one most closely related to the ingroup is the most suitable choice for accurate tree rooting. It is known that the accuracy of phylogenetic reconstruction decreases when more distant outgroups are used. For our project we are going to use  Vitis rotundifolia, the muscadine grape as an outgroup sample.  

The construction of the ML phylogenetic tree can be cunstructed using SNPhylo tool. Official pipeline you can find [here](https://github.com/thlee/SNPhylo). Tool description is provided in this [paper](https://pubmed.ncbi.nlm.nih.gov/24571581/). Tool path is presented below:  

```
/mnt/proj/vine/user_projects/shengchang/soft
```

The tree should be constructed using 100 bootstrap replicates. Suppose we have m sequences, each consisting of n nucleotides (or codons or amino acids). A phylogenetic tree can be built from these sequences using a chosen tree-building method.  
To assess how reliable the structure of the tree, bootstrapping technique is applied.  

Here’s how it works:  

- From each original sequence, n positions are randomly selected with replacement (meaning the same position can be picked more than once).
- This creates a new set of sequences — they have the same length as the originals but contain a shuffled combination of the original sites.
- A new phylogenetic tree is built using this resampled dataset and the same tree-building method as before.
- The topology (structure) of this new tree is then compared to the original tree.
- Each internal branch of the original tree (which separates groups of sequences) is evaluated. If that branch is not present in the new tree, it gets a score of 0. If it matches, it gets a score of 1.

This process — resampling the sites, rebuilding the tree, and scoring — is repeated hundreds of times (often 100–1000).  
For each internal branch, wpercentage of trees in which it received a score of 1 is calculated. This percentage is called the bootstrap value. As a general guideline, if a branch has a bootstrap value of **95% or higher**, it is considered reliable, and the tree structure at that point is regarded as statistically supported.  

Visualization of custructed tree can be performed using [iTOL](http://itol.embl.de/). It is general advice to introduce color palette for each region, e.g. Armenian samples of different clusters should be of the red shades and so on. Later this palette should be applied for both ADMIXTURE ploting and Phylogenetic tree construction.  

Path to the tool:

```
/mnt/proj/omicss25/soft/snphylo/
```

What you should do:
- go to your personal directory and created snphylo_results folder and log folder inside the snphylo_log. Copy the folder with tool into snphylo_results directory
  ```
  cp -a /mnt/proj/omicss25/soft/snphylo/ your_directory/snphylo_results
  ```
- open file snphylo.sh. In the SBATCH section change paths for log files
```
#SBATCH -o your_directory/snphylo_results/log/snphylo.out
#SBATCH -e your_directory/snphylo_results/log/snphylo.err
```
- set the directory snphylo_results as your working directory and launch snphylo.sh file from there
