  # Contributors
   Primary contributor: Nate Zadirako  
   Contributing authors: Mariia Arakelian, Nane Pivazyan  
  # Content  
    
## Project Overview
This project aims to explore the population structure of Caucasian varieties of grapevine using whole-genome sequencing data. The participants will become familiar with the VCF file format, the standard data preprocessing pipeline (variant calling, filtering) and the downstream population genomics analyses (ADMIXTURE, phylogenetic tree construction).

### Data
What is vcf file, why is it used \
The datapath to the vcf file:
```
/mnt/....
```
## Data preprocessing

### Merging gVCFs

Path to GATK:
```
/mnt/proj/vine/user_projects/shengchang/soft/gatk-4.1.8.1/gatk
```

We started with sequencing data for individual samples and used GATK’s [HaplotypeCaller](https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller) to perform variant calling and identify reference and alternative alleles. The files it outputs are gVCF files (genomic VCF). This format includes not only the variant sites but contains information about non-variant regions as well, so the entire genome is covered. 

This later allows us to combine the individual samples and perform joint genotyping. We employ another GATK tool, [CombineGVCFs](https://gatk.broadinstitute.org/hc/en-us/articles/360037053272-CombineGVCFs), to create a multi-sample VCF file prepared for variant calling. [GenotypeGVCFs](https://gatk.broadinstitute.org/hc/en-us/articles/360037057852-GenotypeGVCFs) then performs the joint calling by comparing evidence across every position in the genome and across all samples to decide which variants (SNPs or INDELs) are present, and at what individuals.   Since we have a high number of samples and the genomes themselves are quite large, combining and joing calling is performed on chromosome-by-chromosome basis, and the chromosomes will later be merged together (this helps us save project memory).

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

### ADMIXTURE 
as a way to explore population genetic structure and clustering tool
Files preparation for ADMIXTURE: VCF annotation, PLINK filtration, Linkage Disequilibrium pruning with PLINK <br>
k-fold cross validation,cv error graphs, ADMIXTURE .Q, .P files <br>
ADMIXTURE documentation - https://speciationgenomics.github.io/ADMIXTURE/ <br>
path to ADMIXTURE:
```
/mnt/proj/soft/...
```
   #### &emsp;ADMIXTURE results ploting in R:
   - Cultivated, admixed, wild clusters distinction
   - Grouping samples in clusters by countries
   - Rscript in bash

### Phylogenetic analysis
Exploring the evolutionary relationships among different grape accessions based on SNPs variants <br>
Presumably SNPhylo tool


