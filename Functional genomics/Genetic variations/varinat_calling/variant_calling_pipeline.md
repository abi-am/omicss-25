# Variant Calling Pipeline with GATK

In this tutorial, we will perform variant calling for two samples from the **Armenian Genome Project**. One sample is from a healthy individual, and the other from a patient diagnosed with **Familial Mediterranean Fever (FMF)**. Your goal is to follow the pipeline steps and identify which sample carries the FMF-related mutation.

We will demonstrate the full pipeline using one sample as an example. You are expected to repeat the same steps for the second sample. At the end, you will compare their variants to draw your conclusions.

---

## Input Data

You are given **paired-end FASTQ files** for two samples, the files are located in the folloing folder on the server:
**/mnt/proj/omicss25/ngs_data_analysis/alignment_samtools/data**

- `wes46_chr21_chr16_R1.fastq`, `wes46_chr21_chr16_R2.fastq` — *Sample 1*
- `wes78_chr21_chr16_R1.fastq`, `wes78_chr21_chr16_R2.fastq` — *Sample 2*

> The reads are from chromosomes **21** and **16** only, extracted for faster testing and analysis.

---
## Directory Setup

Before starting, create the following directory structure to organize your output files:

```bash
mkdir -p data/bam data/bam_clean data/gvcf data/vcf
```
--- 
## Reference Genome

We will use the GRCh38 reference genome, already prepared with the required index files for both BWA and GATK:

> **Reference indexed for BWA and GATK:**  
> `/mnt/proj/omicss25/ngs_data_analysis/alignment_samtools/ref_genome`  


---

## Tools

You will use the following tools throughout this tutorial:

- `bwa` — for sequence alignment  
- `samtools` — for sorting BAM files  
- `gatk` — for post-processing, variant calling, and genotyping  
    Path to the tool **/mnt/proj/omicss25/soft/gatk-4.2.6.1/gatk**

---

## Pipeline Overview

You will go through the following steps for **each sample**:

1. Align reads to the reference genome  
2. Sort and prepare BAM files for GATK  
3. Mark duplicates  
4. Call variants in GVCF mode  
5. Combine GVCFs  
6. Jointly genotype both samples  
7. Filter variants (SNPs and INDELs)

Below is the **example pipeline using `{sample}` as a placeholder** for your sample name (e.g., `wes46` or `wes78`). Replace `{sample}` with the actual name as needed.

---

## Step-by-step Tutorial

### Step 1: BWA Alignment

Align paired-end reads using BWA-MEM with read group information (`@RG`), and sort the output BAM with `samtools`.

```bash
data_dir='/mnt/proj/omicss25/ngs_data_analysis/alignment_samtools/data' 
ref='/mnt/proj/omicss25/ngs_data_analysis/alignment_samtools/ref_genome/hg38.fa'

bwa mem -t 4 -R "@RG\tID:${sample}\tLB:${sample}\tSM:${sample}\tPL:ILLUMINA" \
${ref} \
${data_dir}/${sample}_chr21_chr16_R1.fastq \
${data_dir}/${sample}_chr21_chr16_R2.fastq | \
samtools sort -o data/bam/${sample}_sorted.bam -

```

### Step 2: Sort BAM File (for GATK)
Although we used samtools sort above, it's recommended to re-sort the BAM using GATK’s SortSam to ensure metadata compatibility.

```bash
gatk_bin="/mnt/proj/omicss25/soft/gatk-4.2.6.1/gatk"

${gatk_bin} SortSam \
  -I data/bam/${sample}_sorted.bam \
  -O data/bam_clean/${sample}_sorted.bam \
  --SORT_ORDER coordinate
```

### Step 3: Mark Duplicates
Use GATK's MarkDuplicates to identify and flag duplicate reads. This step is essential for accurate variant calling.


```bash
${gatk_bin} MarkDuplicates \
  -I data/bam_clean/${sample}_sorted.bam \
  -O data/bam_clean/${sample}_dedup.bam \
  -M data/bam_clean/${sample}_dedup_metrics.txt \
  --CREATE_INDEX true
```

### Step 4: Variant Calling (HaplotypeCaller in GVCF mode)
Generate a GVCF file for each sample using HaplotypeCaller. This mode enables joint genotyping in the next steps.

⚠️ **NOTE:** Step 4 and 5 command may take quite a long time to run.  
You can start it to make sure your code works correctly, but you don't need to let it finish.  
The final output files are already available at:  
`/mnt/proj/omicss25/ngs_data_analysis/variant_calling/data/gvcf and /vcf`  
You can copy them into your working directory if needed.

> If you're using slurm, make sure the memory you allocate there matches the memory you allocate within the script.

```bash
${gatk_bin} --java-options "-Xmx16g" HaplotypeCaller \
  -R ${ref} \
  -I data/bam_clean/${sample}_dedup.bam \
  -O data/gvcf/${sample}.g.vcf.gz \
  -ERC GVCF
```

### Step 5: Combine GVCFs
Once you have GVCF files for both samples, combine them into a single file for joint genotyping:



``` bash
${gatk_bin} CombineGVCFs \
  -R ${ref} \
  --variant data/gvcf/wes46.g.vcf.gz \
  --variant data/gvcf/wes78.g.vcf.gz \
  -O data/gvcf/combined.g.vcf.gz
```

### Step 6: GenotypeGVCFs (Joint Genotyping)
Perform joint genotyping to produce the final multi-sample VCF file:

```bash
${gatk_bin} GenotypeGVCFs \
  -R ${ref} \
  -V data/gvcf/combined.g.vcf.gz \
  -O data/vcf/genotyped_variants.vcf.gz

```


### Step 7: Filter variants

#### Separating SNPs and INDELs
The raw VCF file (genotyped_variants.vcf.gz) contains both SNPs and INDELs. These should be separated before applying different filtering criteria.

For SNPs:
```bash
${gatk_bin} SelectVariants \
  -R ${ref} \
  -V data/vcf/genotyped_variants.vcf.gz \
  --select-type-to-include SNP \
  -O data/vcf/snp_variants.vcf
```

For INDELs:
```bash
${gatk_bin} SelectVariants \
  -R ${ref} \
  -V data/vcf/genotyped_variants.vcf.gz \
  --select-type-to-include INDEL \
  -O data/vcf/indel_variants.vcf

```

#### Filtering Variants
GATK recommends using different filters for SNPs and INDELs. Below are commonly used thresholds.

In the default parameters, the most commonly used filters for SNPs and INDELs are as follows:

- **QD (Variant Confidence/Quality by Depth):** The Variant Confidence/Quality by Depth (QD) annotation in GATK is a metric used to estimate the confidence of a variant call. It quantifies the quality of a variant by normalizing it with respect to the depth of sequencing coverage at that position.
- **QUAL (Quality):** This field in the Variant Call Format (VCF) file represents the Phred-scaled quality score of a variant call.
- **SOR (Strand Odds Ratio):** SOR is an annotation that quantifies the strand bias observed in the reads supporting a variant call. It measures the imbalance in the distribution of reads across the forward and reverse strands at a variant site.
- **FS (FisherStrand):** FS is an annotation that quantifies strand bias using Fisher's exact test. It measures the probability of observing the distribution of reads supporting the variant call across the forward and reverse strands under the assumption of no strand bias.
- **MQ (Mapping Quality):** MQ is assigned to each variant based on the mapping qualities of the reads aligned to the variant position.
- **MQRankSum:** MQRankSum is calculated by ranking the mapping qualities of the reads that support each allele and then calculating the difference in ranks between the alternate and reference alleles.
- **ReadPosRankSum:** ReadPosRankSum is calculated by ranking the positions of the reads that support each allele and then calculating the difference in ranks between the alternate and reference alleles.


SNPs:
```bash
${gatk_bin} VariantFiltration \
  -R ${ref} \
  -V data/vcf/snp_variants.vcf \
  -filter "QD < 2.0" --filter-name "QD2" \
  -filter "QUAL < 30.0" --filter-name "QUAL30" \
  -filter "SOR > 10.0" --filter-name "SOR10" \
  -filter "FS > 60.0" --filter-name "FS60" \
  -O data/vcf/filtered_snps.vcf
```
INDELs:
```bash
${gatk_bin} VariantFiltration \
  -R ${ref} \
  -V data/vcf/indel_variants.vcf \
  -filter "QD < 2.0" --filter-name "QD2" \
  -filter "QUAL < 30.0" --filter-name "QUAL30" \
  -filter "SOR > 10.0" --filter-name "SOR10" \
  -filter "FS > 100.0" --filter-name "FS100" \
  -O data/vcf/filtered_indels.vcf

```

#### End of Pipeline ####





