# Contributors
   Primary contributor: Nane Pivazyan
   Contributing authors: Nate Zadirako,Lusine Gevorgyan  
  # Contents  
  * Overview
  * Background
  * Data preprocessing
  * Principal Component Analysis
  * ADMIXTURE
  * Population Differentiation Analysis with FST

    
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

> You might be curious what other people are doing with this kind of data and tools! [This review](https://academic.oup.com/gbe/article/15/4/evad054/7092825) describes the application of admixture to human populations.  

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

## STEP 4 ## Population Differentiation Analysis with FST

After exploring the population structure of Caucasian grapevine accessions using PCA and ADMIXTURE, we now move one step further. ADMIXTURE helps us understand **how samples are grouped based on ancestry proportions**, but it does not directly tell us **how genetically different these groups are from each other**.

For example, in the ADMIXTURE plot, we may see that some samples mostly belong to K1, others to K2, K3, and so on. However, the plot itself does not answer questions like:

* Are K1 and K2 very similar or strongly differentiated?
* Which ADMIXTURE groups are the most genetically distant from each other?
* Which groups are genetically closer and may share more ancestry?
* Do the relationships suggested by ADMIXTURE agree with a quantitative population-genetic statistic?
* Which group comparisons should we investigate further using nucleotide diversity, π ratio, or selection scans?

To answer these questions, we calculate **FST** between the ADMIXTURE-defined groups.

---

### What is FST?

**FST** is a population-genetic statistic used to measure **genetic differentiation between populations**.

In simple terms, FST asks:

> How different are two populations in terms of allele frequencies?

If two populations have very similar allele frequencies, their FST will be low.
If two populations have very different allele frequencies, their FST will be higher.

A simplified interpretation is:

| FST value     | Interpretation                                  |
| ------------- | ----------------------------------------------- |
| Close to 0    | The two groups are genetically very similar     |
| Intermediate  | The two groups show moderate differentiation    |
| Higher values | The two groups are more strongly differentiated |

FST does **not** directly tell us that one group is “better” or “older” than another. It simply measures how different two groups are genetically.

---

### Why do we calculate FST after ADMIXTURE?

ADMIXTURE and FST answer related but different questions.

**ADMIXTURE answers:**

> What proportion of each sample’s genome comes from each inferred ancestry component?

For example, a sample may be:

```text
90% K1, 5% K2, 5% K3
```

This tells us that the sample mostly belongs to the K1 ancestry component.

**FST answers:**

> How genetically differentiated are the groups from each other?

For example, after assigning samples to ADMIXTURE groups, we can compare:

```text
K1 vs K2
K1 vs K3
K2 vs K3
```

and calculate a numerical FST value for each comparison.

So the logic of this part is:

```text
ADMIXTURE defines groups
        ↓
FST compares those groups quantitatively
        ↓
Heatmap visualizes which groups are most different
```

This creates a bridge from visual population structure to quantitative population differentiation.

---

### How is FST computed?

FST is calculated from allele frequency differences between populations.

At each SNP, the method compares how allele frequencies vary:

* within each population
* between populations

If two populations have similar allele frequencies at many SNPs, the average FST will be low.
If they have different allele frequencies at many SNPs, the average FST will be higher.

In this project, we use **VCFtools** to calculate Weir and Cockerham FST estimates between pairs of ADMIXTURE-defined groups.

For example, if we compare K1 and K2, VCFtools uses:

```text
K1 sample list
K2 sample list
filtered VCF file
```

and outputs an FST value for each SNP, together with an overall mean and weighted FST estimate.

---

### Main biological question

The main question of this analysis is:

> Which ADMIXTURE-defined grapevine groups are most genetically differentiated from each other?

More specifically, we ask:

1. Which pair of ADMIXTURE groups has the highest FST?
2. Which pair has the lowest FST?
3. Do the FST results agree with the ADMIXTURE plot?
4. Are some ADMIXTURE groups clearly more separated than others?
5. Which group comparisons should be prioritized for later analyses such as nucleotide diversity π, π ratio, or selective sweep scans?

---

### Input files

For this analysis, we use the filtered VCF file, the corresponding VCF index, the `.fam` file, and the ADMIXTURE `.Q` files.

The project directory is:

```bash
/mnt/nas1/proj/omicss26/gp3
```

The filtered VCF file is:

```bash
/mnt/nas1/proj/omicss26/gp3/data/cauc_filtered.final.vcf.gz
```

The VCF index file is:

```bash
/mnt/nas1/proj/omicss26/gp3/data/cauc_filtered.final.vcf.gz.tbi
```

The `.fam` file is:

```bash
/mnt/nas1/proj/omicss26/gp3/data/cauc_filtered.final.fam
```

The ADMIXTURE `.Q` files are located in:

```bash
/mnt/nas1/proj/omicss26/gp3/admixture/script/
```

For example:

```bash
/mnt/nas1/proj/omicss26/gp3/admixture/script/cauc_filtered.final.3.Q
```

If ADMIXTURE has been run for K=5 or K=7, the corresponding files would be:

```bash
/mnt/nas1/proj/omicss26/gp3/admixture/script/cauc_filtered.final.5.Q
/mnt/nas1/proj/omicss26/gp3/admixture/script/cauc_filtered.final.7.Q
```

Before starting, you can check which ADMIXTURE results are available:

```bash
ls /mnt/nas1/proj/omicss26/gp3/admixture/script/*.Q
```

---

### Output folders

The FST scripts are located in:

```bash
/mnt/nas1/proj/omicss26/gp3/fst/scripts/
```

For each selected K value, the scripts will automatically create a separate output folder.

For example, if we choose:

```bash
K=3
```

then the outputs will be saved in:

```bash
/mnt/nas1/proj/omicss26/gp3/fst/K3/
```

This folder will contain:

```text
fst/K3/
├── sample_lists/
├── results/
└── plots/
```

The `sample_lists` folder contains the ADMIXTURE group sample lists.

The `results` folder contains the pairwise FST output files.

The `plots` folder contains the final FST heatmap and matrix.

This K-specific structure is useful because students may choose different ADMIXTURE K values. For example, one group may work with K=3, while another may work with K=5 or K=7. Their results will be kept separate.

---

### Step 1: Choose the ADMIXTURE K value

First, choose the ADMIXTURE K value you want to analyze.

For example:

```bash
K=3
```

If the corresponding `.Q` file exists, you can also choose:

```bash
K=5
```

or:

```bash
K=7
```

The selected K value determines which ADMIXTURE file will be used.

For example, if:

```bash
K=3
```

the script uses:

```bash
admixture/script/cauc_filtered.final.3.Q
```

If:

```bash
K=7
```

the script uses:

```bash
admixture/script/cauc_filtered.final.7.Q
```

---

### Step 2: Create sample lists from ADMIXTURE results

VCFtools needs one sample list for each population being compared.

ADMIXTURE outputs a `.Q` file, where:

* each row is a sample
* each column is an ancestry component
* each value is the ancestry proportion of that sample from that component

For example, for K=3:

```text
0.90  0.05  0.05
0.10  0.80  0.10
0.20  0.15  0.65
```

A sample is assigned to the ADMIXTURE group where it has the highest ancestry proportion.

In this exercise, we use a threshold of:

```text
0.75
```

This means:

* if a sample has at least 75% ancestry from one component, it is assigned to that K group
* if no ancestry component is at least 75%, the sample is labeled as admixed

For example:

| Sample   |   K1 |   K2 |   K3 | Assigned group |
| -------- | ---: | ---: | ---: | -------------- |
| sample_1 | 0.90 | 0.05 | 0.05 | K1             |
| sample_2 | 0.10 | 0.80 | 0.10 | K2             |
| sample_3 | 0.40 | 0.35 | 0.25 | admixed        |

To create sample lists, run:

```bash
cd /mnt/nas1/proj/omicss26/gp3

bash fst/scripts/01_make_admixture_sample_lists.sh $K
```

For K=3, this creates files such as:

```bash
fst/K3/sample_lists/K1_samples.txt
fst/K3/sample_lists/K2_samples.txt
fst/K3/sample_lists/K3_samples.txt
fst/K3/sample_lists/admixed_samples.txt
fst/K3/sample_lists/sample_q_values_K3.tsv
```

The `K1_samples.txt`, `K2_samples.txt`, etc. files are used for FST calculation.
The `admixed_samples.txt` file is created for reference, but admixed samples are not included in the main pairwise FST heatmap because they may blur the comparison between core ADMIXTURE groups.

You can check the number of samples in each group using:

```bash
wc -l fst/K${K}/sample_lists/*_samples.txt
```

---

### Step 3: Calculate pairwise FST

There are two options for calculating FST.

---

#### Option A: Compare all ADMIXTURE groups

To calculate FST for all pairs of ADMIXTURE groups, run:

```bash
bash fst/scripts/02_run_fst.sh $K all
```

For example, if:

```bash
K=3
```

this calculates:

```text
K1 vs K2
K1 vs K3
K2 vs K3
```

If:

```bash
K=7
```

this calculates all pairwise comparisons between K1–K7:

```text
K1 vs K2
K1 vs K3
K1 vs K4
...
K6 vs K7
```

For K=7, there are 21 pairwise comparisons.

This option is useful when the goal is to create a full pairwise FST heatmap.

---

#### Option B: Compare only two selected groups

If you want to focus on one specific comparison, you can choose two groups manually.

For example:

```bash
bash fst/scripts/02_run_fst.sh $K K1 K2
```

or:

```bash
bash fst/scripts/02_run_fst.sh $K K1 K5
```

This option is useful when you already know which groups are biologically interesting and want to investigate only that pair.

For example, if K1 represents a cultivated group and K5 represents a wild group, then:

```bash
bash fst/scripts/02_run_fst.sh $K K1 K5
```

would calculate FST only between those two groups.

---

### Step 4: Summarize pairwise FST values

VCFtools produces one FST file for each pairwise comparison.

For example:

```bash
fst/K3/results/K1_vs_K2.weir.fst
fst/K3/results/K1_vs_K3.weir.fst
fst/K3/results/K2_vs_K3.weir.fst
```

Each file contains SNP-level FST values.

To create a summary table with the mean FST value for each comparison, run:

```bash
bash fst/scripts/03_summarize_pairwise_fst.sh $K
```

For K=3, this creates:

```bash
fst/K3/results/pairwise_fst_summary_K3.tsv
```

Example output:

```text
comparison    mean_fst
K1_vs_K2      0.0448631
K1_vs_K3      0.0522745
K2_vs_K3      0.0558792
```

Negative FST values can occur because of statistical estimation noise. In the summary script, negative FST values are set to 0 before calculating the mean.

---

### Step 5: Plot the pairwise FST heatmap

After summarizing the FST values, create the heatmap:

```bash
Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R $K
```

The heatmap is saved as a PDF because PDF output works reliably on the server.

For K=3, the output files are:

```bash
fst/K3/plots/pairwise_fst_heatmap_K3.pdf
fst/K3/plots/pairwise_fst_matrix_K3.csv
```

The `.pdf` file is the heatmap.
The `.csv` file is the numerical FST matrix used to create the heatmap.

---

### Full workflow

The full workflow is:

```bash
cd /mnt/nas1/proj/omicss26/gp3

# Choose the ADMIXTURE K value you want to analyze.
K=3

# Step 1: Create sample lists from the ADMIXTURE Q file.
bash fst/scripts/01_make_admixture_sample_lists.sh $K

# Step 2A: Calculate FST for all ADMIXTURE group pairs.
bash fst/scripts/02_run_fst.sh $K all

# Step 2B: Alternatively, calculate FST for only one selected pair.
# bash fst/scripts/02_run_fst.sh $K K1 K2

# Step 3: Summarize pairwise FST values.
bash fst/scripts/03_summarize_pairwise_fst.sh $K

# Step 4: Plot the pairwise FST heatmap.
Rscript fst/scripts/04_plot_pairwise_fst_heatmap.R $K
```

---

### How to interpret the heatmap

The heatmap shows the mean FST value between each pair of ADMIXTURE groups.

Each row and column represents an ADMIXTURE group.

Each cell represents the mean FST between two groups.

For example, if the heatmap contains:

```text
K1 vs K2 = 0.045
K1 vs K3 = 0.052
K2 vs K3 = 0.056
```

then K2 and K3 are the most differentiated pair among these three groups, while K1 and K2 are the least differentiated pair.

When interpreting the heatmap, ask:

1. Which pair has the highest FST?
2. Which pair has the lowest FST?
3. Do these results match the ADMIXTURE plot?
4. Do closely related-looking groups in ADMIXTURE also show low FST?
5. Do clearly separated groups in ADMIXTURE show higher FST?
6. Which pair should be selected for deeper analysis using nucleotide diversity π or selection scans?

---

### Important notes

The FST heatmap summarizes average differentiation across the SNPs included in the filtered VCF. It is useful for identifying interesting group comparisons, but it does not show where in the genome the differentiation is located.

A high mean FST between two groups means that the groups are genetically differentiated overall. However, it does not by itself prove selection. Differentiation can be caused by several evolutionary processes, including:

* genetic drift
* population structure
* reduced gene flow
* demographic history
* domestication
* selection

Therefore, FST should be interpreted together with ADMIXTURE, PCA, metadata, nucleotide diversity π, and later selection-scan results.

The next step after the pairwise FST heatmap is to investigate selected comparisons in more detail using genome-wide windowed statistics such as nucleotide diversity π, π ratio, and selection scans.
