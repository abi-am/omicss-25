# 🧬 VCF File Manipulation with PLINK

In this set of exercises, you will use **PLINK** to filter and explore genetic variants stored in VCF format. The data comes from two VCF files — one with SNPs (`filtered_snps.vcf`) and another with indels (`filtered_indels.vcf`), each containing two samples.

## 📂 VCF Files Used in These Exercises

The VCF files used in these exercises are located on the server at:
 > /path


- `filtered_snps.vcf` — contains only SNP (single nucleotide polymorphism) variants  
- `filtered_indels.vcf` — contains only indel (insertion and deletion) variants  

Both VCF files include genotype data for two samples and are used throughout the exercises for format conversion, filtering, and merging.


## 🧬 What is PLINK?

[PLINK](https://www.cog-genomics.org/plink/) is a widely used open-source toolset for genome-wide association studies (GWAS) and population-based genetic analyses.  
It enables efficient handling of large-scale genotype and phenotype data, supporting a variety of tasks such as data filtering, statistical summaries, and association testing.

---

## 📂 PLINK Binary Format: BED, BIM, FAM

PLINK stores genetic data in a compact binary format composed of three files:

- **BED** – Binary file containing genotype data for each SNP across all individuals.
- **BIM** – Text file listing SNP information: chromosome, variant ID, position, and alleles.
- **FAM** – Text file containing individual-level metadata: family ID, sample ID, sex, and phenotype.

Together, these files enable fast and scalable analysis of genome-wide variation data.



---

## 🔹 Exercise 1: Convert VCF to PLINK Format

**Description:**  
Convert the SNP VCF file into PLINK binary format (`.bed`, `.bim`, `.fam`). This step is essential for most downstream analysis in PLINK.

<!--
Command:
plink --vcf filtered_snps.vcf --make-bed --out snps

Explanation:
This command reads `filtered_snps.vcf` (with 2 samples) and writes the corresponding PLINK binary files to `snps.bed/.bim/.fam`.
-->

---

## 🔹 Exercise 2: Count Total SNPs in the Dataset

**Description:**  
Determine how many SNPs are present in the dataset before any filtering. This gives a baseline for comparison in later filtering steps.

<!--
Command:
plink --bfile snps --freq --out snp_counts

Explanation:
The `--freq` command computes allele frequencies and creates a `.frq` file where the total number of lines (minus the header) gives the number of SNPs.
-->

---

## 🔹 Exercise 3: Filter SNPs with Minor Allele Frequency (MAF) > 0.05

**Description:**  
Filter the SNP dataset to retain only variants with minor allele frequency (MAF) greater than 0.05. This removes rare variants that may not be informative.

<!--
Command:
plink --bfile snps --maf 0.05 --make-bed --out snps_maf05

Explanation:
This filters variants from the 2-sample SNP dataset based on a MAF threshold of 0.05 and outputs a new binary PLINK set.
-->

---

## 🔹 Exercise 4: How Many SNPs Were Filtered Out by MAF?

**Description:**  
Compare the number of SNPs before and after MAF filtering to determine how many were excluded. This helps quantify the effect of the filter.

<!--
Command:
# Before
plink --bfile snps --freq --out before_maf
# After
plink --bfile snps_maf05 --freq --out after_maf

# Then compare number of lines in before_maf.frq vs after_maf.frq (subtracting header)
-->

---

## 🔹 Exercise 5: Filter SNPs with Missing Rate < 5%

**Description:**  
Exclude SNPs with missing genotype data in more than 5% of samples. Although the dataset has only 2 samples, this introduces you to quality filtering by missingness.

<!--
Command:
plink --bfile snps --geno 0.05 --make-bed --out snps_geno05

Explanation:
The `--geno 0.05` flag filters out SNPs missing in more than 5% of samples (i.e., >1 call in a 2-sample dataset).
-->

---


## 🔹 Exercise 6: Extract SNPs from Chromosome 21

**Description:**  
Subset the dataset to include only SNPs located on chromosome 21. This is useful for region-specific analyses.

<!--
Command:
plink --bfile snps --chr 21 --make-bed --out snps_chr21

Explanation:
The `--chr 21` flag retains only chromosome 21 SNPs from the dataset.
-->

---

## 🔹 Exercise 7: Merge SNP and Indel Datasets

**Description:**  
Merge the SNP and indel datasets into a single dataset for joint analysis. This simulates working with mixed variant types.

<!--
Command:
# Convert indels
plink --vcf filtered_indels.vcf --make-bed --out indels

# Merge
plink --bfile snps --bmerge indels.bed indels.bim indels.fam --make-bed --out merged_variants
-->

---

## 🔹 Exercise 8: Generate Allele Frequency Table for Merged Data

**Description:**  
Compute allele frequencies for each variant in the merged SNP + indel dataset. This gives insight into variant distribution across the two samples.

<!--
Command:
plink --bfile merged_variants --freq --out merged_freq

Explanation:
This computes MAF for each variant in the merged dataset containing both SNPs and indels from 2 samples.
-->

---

## 🔹 Exercise 9: List All Variants with MAF = 0.5

**Description:**  
Find all variants where both samples have different genotypes, i.e., maximum heterozygosity. This is a way to identify informative variants in small datasets.

<!--
Command:
awk '$5 == 0.5' merged_freq.frq > maf_eq_05.txt
-->
---

## 🔹 Exercise 10: Perform Linkage Disequilibrium (LD) Pruning

**Description:**  
Filter out SNPs in strong linkage disequilibrium (LD) using PLINK's default pruning parameters. This helps retain a set of independent variants for unbiased downstream analyses like PCA or clustering.


<!--
Command:
plink --bfile snps --indep-pairwise 50 5 0.2 --out snps_pruned
plink --bfile snps --extract snps_pruned.prune.in --make-bed --out snps_ld_filtered

Explanation:
The first command identifies SNPs in approximate linkage equilibrium using a sliding window (50 SNPs, step size 5, r² threshold 0.2). The second command extracts only the pruned variants to create an LD-filtered dataset.
-->
