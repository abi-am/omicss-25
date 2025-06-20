  # Contributors
   Primary contributor: Nate Zadirako  
   Contributing authors: Mariia Arakelian, Nane Pivazyan  
  # Content  
    
## Project Overview
This project aims to explore the population structure of Caucasian varieties of grapevine using whole-genome sequencing data. The participants will become familiar with the VCF file format, the standard data preprocessing pipeline (variant calling, filtering) and the downstream population genomics analyses (ADMIXTURE, phylogenetic tree construction).

### Data

The data for this project comes from [this publication](). We will reanalyse a subset of Caucasian grapevine samples, both cultivated (*V. vinifera*) and wild (*V. sylvestris*), and attempt to uncover patterns of genetic diversity from populations of different geographic origin.   

You can familiarise yourself with the samples, their regions of origin, genetic background and phenotypes by studying the metadata table here:   

```
/mnt/proj/vine/shared_files/data/metadata/cauc_arm_grape.metadata.tsv
```

> NOTE: the actual dataset is large, so we need to select a few well-behaving samples.  

The data is provided to you as VCF files. These files were created from sequencing reads which were controlled for quality, aligned to the reference, and subjected to variant calling using the GATK toolkit.  

```
# path to the data
```

Learn more about the VCF file format and what each field represents [here](https://samtools.github.io/hts-specs/VCFv4.2.pdf).  

## Data preprocessing

### Merging gVCFs

For any scripts engaging the GATK tooks, refer to the path here:
```
/mnt/proj/vine/user_projects/shengchang/soft/gatk-4.1.8.1/gatk
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

### ADMIXTURE [in progress: Nane]
as a way to explore population genetic structure and clustering tool
Files preparation for ADMIXTURE: VCF annotation, PLINK filtration, Linkage Disequilibrium pruning with PLINK <br>
k-fold cross validation,cv error graphs, ADMIXTURE .Q, .P files <br>
ADMIXTURE documentation - https://speciationgenomics.github.io/ADMIXTURE/ <br>
path to ADMIXTURE:

  The **ADMIXTURE** is a computational program used in population genetics to estimate the ancestry composition of individuals based on their genetic data. Given genotype data from multiple individuals, the tool models each individual's genome as having originated from a predefined number of ancestral populations (often denoted as K). The program uses a statistical algorithm to estimate, for each individual, the proportion of their genome that comes from each of these ancestral populations. For example, if K = 3, an individual might have 70% ancestry from population 1, 25% from population 2, and 5% from population 3. This shows that their genetic background is mostly from the first population but also includes contributions from the others.

For any scripts engaging the ADMIXTURE tool, refer to the path here:
```
/mnt/proj/vine/shared_files/soft/admixture_linux-1.3.0/admixture
```
  ## Step 1 (Filtering)
  
   As an input we need to give filtered plink binary format files (.bed, .bim. fam). Filtering should include the following steps

   - **Anotation** - samples should have individual, unique ID's. So if the VCF file is not annotated firstly we need to annotate it usinf bcftools

**Then we can proceed with Filtering using [PLINK](https://www.cog-genomics.org/plink/1.9/filter) tool**

```
/mnt/proj/vine/user_projects/shengchang/soft/plink/plink
```
   - take only 1-19 autosomal chromosomes
   - **Biallelic SNPs** - we keep the SNPs that are either reference or alternative variant.
    
   - **Minor allele frequency (MAF)** - we will remove the rarest SNPs by keeping only those that are encountered with the frequency of >0.5%. MAF is the frequency of the second most common allele in the population. Extremely low MAF might be pointing to genotyping effors. More common SNPs are considered more reliable and are more likely to be true features of our populations.
     
   - **[LD pruning](https://www.cog-genomics.org/plink/1.9/ld)** - LD pruning is the process of removing genetic variants (SNPs) that are highly correlated (in linkage disequilibrium, LD) to keep only independent markers. This is done to reduce redundancy and avoid bias in the analysis. Paramets for LD pruning are **windiw size** (The genomic region size scanned), **Step size** (How much the window moves each step), **r² threshold** (Correlation cutoff above which SNPs are pruned). The comonly used parameters are (50, 5, 0.5).

As an output we will have plink finary format files (.bed, .bim, .fam)

- **.bim — Variant information file** : Contains SNP IDs, chromosome, genetic position, physical position, and alleles for each variant (one line per SNP).

- **.fam — Sample information file** : Contains family and individual IDs, paternal/maternal IDs, sex, and phenotype for each sample (one line per individual).

- **.bed — Binary genotype data file** : Contains the actual genotype calls in a compact binary format for all samples and SNP

 ## Step 2 (ADMIXTURE analysis)
 
Now that we have filtered plink binary format files, we can proceed with the ADMIXTURE analysis. The documentation can be found [here](https://speciationgenomics.github.io/ADMIXTURE/)

Input for the admixture should be filtered plink binary format files. ADMIXTURE scripts should look like thi, where --cv stands for cross validation.
```
admixture --cv=5 input.bed K
```

We do the admixture by **K-fold cross validation**. K-fold cross-validation is used to estimate how well the model fits the data for a given number of ancestral populations (K). Here is how it works

1. The program splits the data (SNPs) into K equal parts (folds). The defoult parameter is 5.
2. The the program randomely "hides" part of the data and treats it as missing data (if data is devided into K equal parts, 1 part will be "hidden").
3. The model is trained on the remaining data.
4. The model tries to predict the hidden part of the data.
5. The program calculates cv error by comparing the predicted data to the actual one that was hidden.

> NOTE: In general lower cv error means that the program works better but it is not always the case. In case of high K we might have lower cv error but it can lead to overfitting of the model. So when deciding an appropirate K to chose we must not consider only cv error rate but also the biological meaning and interpretation.

ADMIXTURE is usually run for some range of Ks, typically from K=2, to K = 10. This is done to compare different models with each other and chose the one that fits the most to our project.

 > NOTE: ADMIXTURE involves randomization (in cross-validation), so to ensure results are reproducible, you can set a random seed with the --seed option:

# STEP 3 (Visualization and interpretation) 

As an output of the ADMIXTURE we will get 3 types of files (/.log, /.Q, /.P)
- **/.log** file contains run infromation and cv error
- **/.Q** contains a matrix that contains information about ancestry proportions. Each row here is a sample (individual) and each column coressponts to one of the K ancestral populations (K=1, K=2....). Values of the matrix tell what proportion of the certain sample's ancestry comes from the population of coressponing column. 
- **/.P** file contains a matrix that contains information about allele frequencies. Each row eas a SNP, each column is ancestral population. It tells us what each ancestral population looks like genetically.

   #### &emsp;ADMIXTURE results ploting in R:
   - Cultivated, admixed, wild clusters distinction
   - Grouping samples in clusters by countries
   - Rscript in bash

### Phylogenetic analysis [in progress: Maria]
Exploring the evolutionary relationships among different grape accessions based on SNPs variants <br>
Presumably SNPhylo tool


