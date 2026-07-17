# Contributors
   Primary contributor: Nate Zadirako  
   Contributing authors: Nane Pivazyan, Lusine Gevorgyan
  # Contents  
  * Overview
  * Background
  * Data preprocessing
  * Principal Component Analysis
  * ADMIXTURE
  * Population Differentiation Analysis with FST

    
## Project Overview
[This project](https://docs.google.com/presentation/d/1CmQuFbCy7I7oiA7GijIu8XGbgM3nY-9d/edit?usp=sharing&ouid=106664732077456500866&rtpof=true&sd=true) aims to explore the population structure of Caucasian varieties of grapevine using whole-genome sequencing data. The participants will become familiar with the VCF file format, the standard data preprocessing pipeline (variant calling, filtering) and the downstream population genomics analyses (ADMIXTURE, population differentiation analysis).  

## Background
Now that whole-genome sequencing (WGS) is relatively cheap and accessible, it has become possible to collect WGS data from hundreds or even thousands of individuals. This enables us to explore large-scale patterns of genetic variation across entire populations.   

**Population genetics** is the study of the genetic makeup of biological populations and changes in this makeup over time. It provides insights into evolutionary processes such as natural selection, genetic drift, mutation, and migration.   

> NOTE: new to mechanisms of evolution? You can learn more about them [here](https://evolution.berkeley.edu/evolution-101/mechanisms-the-processes-of-evolution/).

**Population genomics** extends these principles to genome-wide data, allowing us to look at variation across the entire genome, rather than focusing on a few selected markers.  

In practical terms, we might want to understand where a given sample came from, how it relates to others, or whether distinct groups of individuals share common ancestry. 

In this project, we will apply these concepts to real WGS data and perform two downsteam analyses: **ADMIXTURE** and **Population Differentiation Analysis using FST**.  

**ADMIXTURE** is a model-based clustering method that estimates the proportion of ancestry each individual inherits from a predefined number of ancestral populations. It is used to detect population structure and infer historical admixture events. For our grapevine dataset, ADMIXTURE will help us understand whether different varieties share ancestry and to what extent they may represent mixtures of multiple ancestral gene pools.  

**Population differentiation analysis**, on the other hand, focuses on measuring how genetically different the ADMIXTURE-defined groups are from each other. After ADMIXTURE identifies population structure, pairwise **FST** is used to quantify differentiation between groups. Low FST values suggest genetic similarity or shared ancestry, while higher FST values suggest stronger separation, possibly due to geography, domestication history, or reduced gene flow. This provides a complementary view to ADMIXTURE by showing how strongly the inferred groups differ from one another.  

Together, these two analyses give us a nice interpretable overview of both shared ancestry and evolutionary relationships in our dataset.  

> You might be curious what other people are doing with this kind of data and tools! [This review](https://academic.oup.com/gbe/article/15/4/evad054/7092825) describes the application of ADMIXTURE and related population-genomic methods to human populations. For a grapevine-specific example, [this study](https://www.pnas.org/doi/10.1073/pnas.1009363108) uses genome-wide SNP data to study grapevine population structure and domestication history. Another useful example is [this Armenian grapevine population genomics study](https://pmc.ncbi.nlm.nih.gov/articles/PMC12998295/), where genome-wide **FST** and nucleotide diversity ratio were used to identify candidate regions of differentiation between wild and cultivated grapevines. 

### Data

The data for this project comes from [this publication](https://www.science.org/doi/10.1126/science.add8655). We will reanalyse a subset of Caucasian grapevine samples, both cultivated (*V. vinifera*) and wild (*V. sylvestris*), and attempt to uncover patterns of genetic diversity from populations of different geographic origin.   

You can familiarise yourself with the samples, their regions of origin, genetic background and phenotypes by studying the metadata table here:   

```
/mnt/nas1/proj/omicss26/gp3/data/metadata/cauc_grape_metadata.csv
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
/mnt/nas1/proj/omicss26/gp3/data/vcf
```

Learn more about the VCF file format and what each field represents [here](https://samtools.github.io/hts-specs/VCFv4.2.pdf).  

## Data preprocessing

### Merging gVCFs

> NOTE: as this part is computationally demanding, it was pre-computed for you. From the filtering section onwards, you will be running commands yourself.

For any scripts engaging the GATK tooks, refer to the path here:
```
/mnt/nas1/proj/omicss26/soft/gatk-4.2.6.1/gatk
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
/mnt/nas1/proj/omicss26/soft/admixture_linux-1.3.0/admixture
```

> NOTE: all the relavant scripts will be provided to you in the following directory
> ```
> /mnt/nas1/proj/omicss26/admixture/scripts
> ```
> Try to wirte scripts yourselves before refering to the provided scripts. In case of using already given scripts carefully go over them, check the input and output directories and variables. 

  ## Step 1 - FILTERING
  
   *You will be given annotated row vcf file*

   - For the filtering, we need to filter vcf file and output vfiltered data into plink binary format files.

Let's get familiar with plink binary format files at first. 

PLINK binary format files are a set of files used to store genetic data in a compact and efficient way. They contain information about the DNA variants, the individuals in the study, and the genotype of each individual at each variant. This format makes genetic analyses much faster and requires less storage space than text files. Note, that admixture analysis requires plink binary format files as an input.

There are 3 type of files that together make plink finary format files. 

- **.bed** – stores the genotype data (the genetic information).
- **.bim** – stores information about each genetic variant, such as its chromosome and position.
- **.fam** – stores information about the individuals in the dataset.

   
**Now, we can proceed with Filtering using [PLINK](https://www.cog-genomics.org/plink/1.9/filter) tool. Read this to get familiar with how do we use it**.

```
/mnt/proj/vine/user_projects/shengchang/soft/plink/plink
```
For the filtering part, from vcf file you need to extract`

   - only 1-19 autosomal chromosomes
   - **Biallelic SNPs** - we keep the SNPs that are either reference or alternative variant.
    
   - **Minor allele frequency (MAF)** - we will remove the rarest SNPs by keeping only those that are encountered with the frequency of >0.5%. MAF is the frequency of the second most common allele in the population. Extremely low MAF might be pointing to genotyping effors. More common SNPs are considered more reliable and are more likely to be true features of our populations.
     
   - **[LD pruning](https://www.cog-genomics.org/plink/1.9/ld)** - LD pruning is the process of removing genetic variants (SNPs) that are highly correlated (in linkage disequilibrium, LD) to keep only independent markers. This is done to reduce redundancy and avoid bias in the analysis. Paramets for LD pruning are **windiw size** (The genomic region size scanned), **Step size** (How much the window moves each step), **r² threshold** (Correlation cutoff above which SNPs are pruned). The comonly used parameters are (50, 5, 0.5).

As an output we will have plink finary format files (/.bed, /.bim, /.fam).

- **/.bed — Binary genotype data file** : Contains the actual genotype calls in a compact binary format for all samples and SNP

- **/.bim — Variant information file** : Contains SNP IDs, chromosome, genetic position, physical position, and alleles for each variant (one line per SNP).

- **/.fam — Sample information file** : Contains family and individual IDs, paternal/maternal IDs, sex, and phenotype for each sample (one line per individual).

> Note: the filtering script is the following. Carefully go over it before running.
> ```
> /mnt/nas1/proj/omicss26/gp3/admixture/script/filtering.sh
> ```

 ## Step 2 - ADMIXTURE analysys
 
Now that we have filtered plink binary format files, we can proceed with the ADMIXTURE analysis. The documentation can be found [here](https://speciationgenomics.github.io/ADMIXTURE/). To get familiar to how the algorithm of the admixture works refer to this [slide](https://docs.google.com/presentation/d/17UleVOYSMbGvSviu_jEw6VkmNgJNbKmJxHD5nz11Css/edit?usp=sharing)

We do the ADMIXTURE by **K-fold cross validation**. K-fold cross-validation is used to estimate how well the model fits the data for a given number of ancestral populations (K). Here is how it works

1. The program splits the data (SNPs) into K equal parts (folds). The defoult parameter is 5.
2. The the program randomely "hides" part of the data and treats it as missing data (if data is devided into K equal parts, 1 part will be "hidden").
3. The model is trained on the remaining data.
4. The model tries to predict the hidden part of the data.
5. The program calculates cv error by comparing the predicted data to the actual one that was hidden.

> NOTE: In general lower cv error means that the model fits better better but it is not always the case. In case of high K we might have lower cv error but it can lead to overfitting of the model. So when deciding an appropirate K to chose we must not consider only cv error rate but also the biological meaning and interpretation.  

ADMIXTURE is usually run for some range of Ks, typically from K=2, to K = 10. This is done to compare different models with each other and chose the one that fits the most to our project.  

 > NOTE: ADMIXTURE involves randomization (in cross-validation), so to ensure results are reproducible, you can set a random seed with the *--seed* option:

## STEP 3 - Visualization and interpretation 

As an output of the ADMIXTURE we will get 3 types of files (/.log, /.Q, /.P).  

- **/.log** file contains run infromation and cv errors.
- **/.Q** contains a matrix that contains information about ancestry proportions. Each row here is a sample (individual) and each column coressponts to one of the K ancestral populations (K=1, K=2....). Values of the matrix tell what proportion of the certain sample's ancestry comes from the population of coressponing column. 
- **/.P** file contains a matrix that contains information about allele frequencies. Each row is a SNP, each column is ancestral population. It tells us what each ancestral population looks like genetically. For our analysis we won't need those. 

Now we can proceed with the visualization in R.  

As the aim of this project is to understand population genetics of grapevine, we are going to analyze Q matrices. For that, we need to visualize them by constructiog  a barplot. In Q matrix each row is an indivisual sample, each column is an estimated population. The valuse of the matrix represents the proportion of one population. We need to represent this by barplot, where each bar is an individual, colored by the ancestral population proportions.  

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

## STEP 4. Population Differentiation Analysis with FST

After identifying population structure with **ADMIXTURE**, the next question is:

**How genetically different are the inferred groups from each other?**

ADMIXTURE tells us how much ancestry each sample has from each genetic cluster. However, ADMIXTURE alone does not directly tell us how strongly separated those clusters are. For that, we calculate **FST**.

---

### Important note on folder organization

Before running any analysis, please make sure that your files and outputs are clearly organized. Bioinformatics analyses usually generate many intermediate files, logs, tables, and plots. If all files are saved in the same folder, it quickly becomes difficult to understand which files are inputs, which files are scripts, and which files are final results.

For this project, please follow the folder structure below when working with the FST analysis:

```text
fst/
├── scripts/
│   ├── 01_make_admixture_sample_lists.sh
│   ├── 02_run_fst.sh
│   ├── 03_summarize_pairwise_fst.sh
│   └── 04_plot_pairwise_fst_heatmap.R
└── results/
    └── K3/
        ├── sample_lists/
        ├── pairwise_fst/
        └── plots/
```

If you run the analysis for another ADMIXTURE K value, for example `K=7`, your output should be organized like this:

```text
fst/
├── scripts/
└── results/
    ├── K3/
    │   ├── sample_lists/
    │   ├── pairwise_fst/
    │   └── plots/
    └── K7/
        ├── sample_lists/
        ├── pairwise_fst/
        └── plots/
```

Please do not save result files directly inside the main `fst/` folder. The main `fst/` folder should contain only the reusable scripts and the organized results folder.

In this structure:

```text
fst/scripts/       = scripts used to run the FST workflow
fst/results/K*/    = outputs for a specific ADMIXTURE K value
sample_lists/      = sample group files created from ADMIXTURE Q values
pairwise_fst/      = raw FST result files and summary tables
plots/             = final heatmap and matrix files
```

Keeping the folder structure organized makes it easier to repeat the analysis, compare different K values, debug errors, and understand which files are final outputs.

---

### What is FST?

**FST** is a statistic used in population genetics to measure genetic differentiation between populations.

In simple terms:

- **Low FST** means two populations are genetically similar.
- **High FST** means two populations are genetically more different from each other.

FST is useful when we want to compare groups such as:

- wild vs cultivated grapevines,
- Armenian vs Georgian grapevines,
- different ADMIXTURE clusters,
- geographically separated groups.

The basic idea behind FST is to compare genetic variation **within populations** to genetic variation **between populations**.

A simplified formula is:

```text
FST = (HT - HS) / HT
```

where:

```text
HT = total expected heterozygosity if all samples are treated as one population
HS = average expected heterozygosity within subpopulations
```

If two populations are very similar, then the genetic diversity within each population is similar to the total genetic diversity, so FST is low.

If two populations are strongly different, then the total genetic diversity is much higher than the diversity within each population, so FST is high.

In this project, FST is calculated using **VCFtools**, which estimates pairwise FST between two groups of samples using SNP data.

---

### Why do we calculate FST after ADMIXTURE?

ADMIXTURE groups samples based on their genetic ancestry components. For example, if we run ADMIXTURE with `K=3`, each sample receives ancestry proportions for three inferred groups: K1, K2, and K3.

However, after ADMIXTURE, we may still want to ask:

- Are K1 and K2 very different from each other?
- Is K1 closer to K3 or to K2?
- Which ADMIXTURE groups are the most genetically separated?
- Do wild and cultivated grapevines show strong differentiation?
- Do geographically close groups show lower FST?

FST helps answer these questions quantitatively.

So the logic of the workflow is:

```text
ADMIXTURE
   ↓
Assign samples to groups based on ancestry proportion
   ↓
Create sample lists for each group
   ↓
Calculate pairwise FST between groups
   ↓
Summarize and visualize the results
```

---

### Input files needed for FST analysis

This FST workflow needs three main types of input files.

#### 1. VCF file

The VCF file contains the SNP genotypes for all samples.

Current VCF path:

```text
/mnt/nas1/proj/omicss26/gp3/data/vcf/cauc_filtered.final.vcf.gz
```

The indexed VCF file is also required:

```text
/mnt/nas1/proj/omicss26/gp3/data/vcf/cauc_filtered.final.vcf.gz.tbi
```

The `.tbi` file is the tabix index. It allows programs such as VCFtools to access the compressed VCF efficiently.

#### 2. PLINK FAM file

The `.fam` file contains the sample IDs in the same order as the genotype data.

Current FAM file path:

```text
/mnt/nas1/proj/omicss26/gp3/data/plink/cauc_filtered.final.fam
```

This file is used to connect the ADMIXTURE Q values to sample names.

#### 3. ADMIXTURE Q file

The `.Q` file is generated after running ADMIXTURE.

For example, after running ADMIXTURE with `K=3`, the expected Q file is:

```text
/mnt/nas1/proj/omicss26/gp3/admixture/results/cauc_filtered.final.3.Q
```

For `K=7`, the expected Q file would be:

```text
/mnt/nas1/proj/omicss26/gp3/admixture/results/cauc_filtered.final.7.Q
```

Each row in the `.Q` file corresponds to one sample. Each column corresponds to one ADMIXTURE ancestry component.

For example, for `K=3`, a row may look like this:

```text
0.982 0.011 0.007
```

This means the sample has:

```text
98.2% ancestry from K1
1.1% ancestry from K2
0.7% ancestry from K3
```

In this workflow, a sample is assigned to the ADMIXTURE group where it has the highest ancestry proportion, but only if that value is at least **0.75**. Samples below this threshold are treated as admixed and are written to a separate file.

---

### FST folder structure

The FST workflow is organized here:

```text
/mnt/nas1/proj/omicss26/gp3/fst
```

The folder contains:

```text
fst/
├── scripts/
└── results/
```

The scripts are stored in:

```text
/mnt/nas1/proj/omicss26/gp3/fst/scripts
```

The output results are stored by ADMIXTURE K value:

```text
/mnt/nas1/proj/omicss26/gp3/fst/results/K3
/mnt/nas1/proj/omicss26/gp3/fst/results/K7
```

For example, the current `K3` folder is an example/test run. It shows what the output structure should look like after the workflow is completed.

The structure is:

```text
fst/results/K3/
├── sample_lists/
├── pairwise_fst/
└── plots/
```

where:

```text
sample_lists/   = sample lists created from ADMIXTURE Q values
pairwise_fst/   = raw pairwise FST results and summary table
plots/          = heatmap and matrix files
```

---

### Step 4.1. Create sample lists from ADMIXTURE results

Before calculating FST, we need to decide which samples belong to each ADMIXTURE group.

This is done using the script:

```text
fst/scripts/01_make_admixture_sample_lists.sh
```

The script needs one argument: the ADMIXTURE K value.

For example, to create sample lists for `K=3`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/01_make_admixture_sample_lists.sh 3
```

For `K=7`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/01_make_admixture_sample_lists.sh 7
```

This script uses:

```text
data/plink/cauc_filtered.final.fam
admixture/results/cauc_filtered.final.${K}.Q
```

and creates output files in:

```text
fst/results/K${K}/sample_lists/
```

For `K=3`, the output files are:

```text
fst/results/K3/sample_lists/K1_samples.txt
fst/results/K3/sample_lists/K2_samples.txt
fst/results/K3/sample_lists/K3_samples.txt
fst/results/K3/sample_lists/admixed_samples.txt
fst/results/K3/sample_lists/sample_q_values_K3.tsv
```

The files `K1_samples.txt`, `K2_samples.txt`, and `K3_samples.txt` contain sample names assigned to each ADMIXTURE group.

The file `admixed_samples.txt` contains samples that did not pass the ancestry threshold.

The file `sample_q_values_K3.tsv` contains each sample together with its ADMIXTURE ancestry values.

---

### Step 4.2. Calculate pairwise FST between ADMIXTURE groups

After creating sample lists, we calculate pairwise FST between groups.

This is done using the script:

```text
fst/scripts/02_run_fst.sh
```

This script uses:

```text
data/vcf/cauc_filtered.final.vcf.gz
fst/results/K${K}/sample_lists/
```

and saves the output in:

```text
fst/results/K${K}/pairwise_fst/
```

There are two ways to run this script.

---

#### Option A. Compare all ADMIXTURE groups

To calculate all pairwise FST comparisons for `K=3`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/02_run_fst.sh 3 all
```

For `K=7`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/02_run_fst.sh 7 all
```

For `K=3`, this will calculate:

```text
K1 vs K2
K1 vs K3
K2 vs K3
```

For `K=7`, this will calculate all pairwise comparisons between K1, K2, K3, K4, K5, K6, and K7.

---

#### Option B. Compare only two selected groups

Sometimes we may be interested in only one comparison.

For example, to compare K1 and K2 for `K=3`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/02_run_fst.sh 3 K1 K2
```

For `K=7`, if we want to compare K1 and K5, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/02_run_fst.sh 7 K1 K5
```

This option is useful when you want to focus on a specific biological comparison, such as cultivated vs wild grapevines.

---

### Step 4.3. Understand the raw FST output

VCFtools produces one `.weir.fst` file for each pairwise comparison.

For example:

```text
fst/results/K3/pairwise_fst/K1_vs_K2.weir.fst
fst/results/K3/pairwise_fst/K1_vs_K3.weir.fst
fst/results/K3/pairwise_fst/K2_vs_K3.weir.fst
```

Each `.weir.fst` file contains site-by-site FST values.

A simplified example looks like this:

```text
CHROM    POS      WEIR_AND_COCKERHAM_FST
1        10532    0.012
1        10891    0.045
1        20344    0.000
```

Each row represents one SNP position.

The FST value tells us how differentiated the two groups are at that SNP.

Some values may be close to zero, meaning little differentiation at that position. Some values may be higher, meaning stronger differentiation at that position.

---

### Step 4.4. Summarize pairwise FST values

The raw `.weir.fst` files contain many SNP-level values, so we summarize them into one table.

This is done using:

```text
fst/scripts/03_summarize_pairwise_fst.sh
```

For `K=3`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/03_summarize_pairwise_fst.sh 3
```

For `K=7`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/03_summarize_pairwise_fst.sh 7
```

The output is saved here:

```text
fst/results/K${K}/pairwise_fst/pairwise_fst_summary_K${K}.tsv
```

For example:

```text
fst/results/K3/pairwise_fst/pairwise_fst_summary_K3.tsv
```

The summary table looks like this:

```text
comparison    mean_fst
K1_vs_K2      0.0449
K1_vs_K3      0.0523
K2_vs_K3      0.0559
```

This table gives one mean FST value for each pair of groups.

---

### Step 4.5. Plot the pairwise FST heatmap

To make the results easier to interpret, we visualize the pairwise FST table as a heatmap.

This is done using the R script:

```text
fst/scripts/04_plot_pairwise_fst_heatmap.R
```

For `K=3`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R 3
```

For `K=7`, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R 7
```

The script produces:

```text
fst/results/K${K}/plots/pairwise_fst_heatmap_K${K}.pdf
fst/results/K${K}/plots/pairwise_fst_matrix_K${K}.csv
```

For example, for `K=3`:

```text
fst/results/K3/plots/pairwise_fst_heatmap_K3.pdf
fst/results/K3/plots/pairwise_fst_matrix_K3.csv
```

The PDF file is the heatmap.

The CSV file is the pairwise FST matrix used to generate the heatmap.

---

### Full workflow example

For `K=3`, the full workflow is:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/01_make_admixture_sample_lists.sh 3
bash fst/scripts/02_run_fst.sh 3 all
bash fst/scripts/03_summarize_pairwise_fst.sh 3
Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R 3
```

For `K=7`, after the corresponding ADMIXTURE Q file is available, the workflow is:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/01_make_admixture_sample_lists.sh 7
bash fst/scripts/02_run_fst.sh 7 all
bash fst/scripts/03_summarize_pairwise_fst.sh 7
Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R 7
```

---

### How to interpret the FST heatmap

The heatmap shows pairwise mean FST values between ADMIXTURE-defined groups.

Each cell represents one comparison.

For example:

```text
K1 vs K2
K1 vs K3
K2 vs K3
```

Lower values mean the groups are genetically more similar.

Higher values mean the groups are genetically more differentiated.

A general interpretation guide is:

```text
FST close to 0       very little differentiation
FST around 0.05      low to moderate differentiation
FST around 0.15      moderate differentiation
FST above 0.25       strong differentiation
```

These thresholds are only rough guidelines. The biological interpretation depends on the organism, sampling strategy, SNP filtering, geography, domestication history, and population structure.

When interpreting your heatmap, ask:

- Which two groups have the lowest FST?
- Which two groups have the highest FST?
- Are cultivated groups closer to each other than to wild groups?
- Are wild grapevine groups strongly differentiated from cultivated grapevine groups?
- Do the FST results agree with ADMIXTURE?
- Do the results make sense based on geography and sample metadata?

---

### Important notes

The folder:

```text
fst/results/K3/
```

currently contains an example/test run for `K=3`.

This example is kept to show the expected output structure and to confirm that the workflow runs correctly.

For the final biological analysis, students can repeat the same workflow with another K value, such as `K=7`, after the corresponding ADMIXTURE result file is available:

```text
admixture/results/cauc_filtered.final.7.Q
```

If the `.Q` file for a selected K value does not exist yet, run ADMIXTURE first.

The FST workflow depends on ADMIXTURE output, so the correct order is:

```text
1. Run ADMIXTURE
2. Generate the .Q file
3. Create sample lists from the .Q file
4. Calculate pairwise FST
5. Summarize FST values
6. Plot the heatmap
```

Please keep your final outputs organized inside the appropriate K-specific folder under:

```text
fst/results/
```

For example:

```text
fst/results/K3/
fst/results/K7/
fst/results/K10/
```

This will allow different ADMIXTURE K values to be compared without overwriting or mixing results.

