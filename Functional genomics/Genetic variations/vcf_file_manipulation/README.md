# 🧬 VCF File Manipulation with PLINK

In this set of exercises, you will use **PLINK** to filter and explore genetic variants stored in VCF format. The data comes from two VCF files — one with SNPs (`filtered_snps.vcf`) and another with indels (`filtered_indels.vcf`), each containing two samples.

## 📂 VCF Files Used in These Exercises

The VCF files used in these exercises are located on the server at:
 > `/mnt/nas1/proj/omicss26/ngs_data_analysis/variant_calling/data/vcf`

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
Convert the SNP VCF file into PLINK binary format (`.bed`, `.bim`, `.fam`). This step is essential for most downstream analyses using PLINK.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --vcf filtered_snps.vcf --make-bed --out snps
```

**Explanation:**  
This command reads the `filtered_snps.vcf` file (containing two samples) and converts it into PLINK binary format, producing the output files `snps.bed`, `snps.bim`, and `snps.fam`.

</details>

---

## 🔹 Exercise 2: Count Total SNPs in the Dataset

**Description:**  
Determine how many SNPs are present in the dataset before any filtering. This provides a baseline for comparison with later filtering steps.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile snps --freq --out snp_counts
```

**Explanation:**  
The `--freq` command calculates allele frequencies and creates a `.frq` file. The number of lines in this file (excluding the header) corresponds to the number of SNPs in the dataset.

</details>

---

## 🔹 Exercise 3: Filter SNPs with Minor Allele Frequency (MAF) > 0.05

**Description:**  
Filter the SNP dataset to retain only variants with a minor allele frequency (MAF) greater than 0.05. This removes rare variants that may not be informative for downstream analyses.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile snps --maf 0.05 --make-bed --out snps_maf05
```

**Explanation:**  
This filters variants from the two-sample SNP dataset using a MAF threshold of 0.05 and outputs a new binary PLINK dataset.

</details>

---

## 🔹 Exercise 4: How Many SNPs Were Filtered Out by MAF?

**Description:**  
Compare the number of SNPs before and after MAF filtering to determine how many variants were excluded. This helps quantify the effect of the filter.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
# Before filtering
plink --bfile snps --freq --out before_maf

# After filtering
plink --bfile snps_maf05 --freq --out after_maf
```

**Explanation:**  
Compare the number of variants in `before_maf.frq` and `after_maf.frq` (excluding the header line). The difference represents the number of SNPs removed by the MAF filter.

</details>

---

## 🔹 Exercise 5: Filter SNPs with Missing Rate < 5%

**Description:**  
Exclude SNPs with missing genotype data in more than 5% of samples. Although this dataset contains only two samples, this introduces quality filtering based on genotype missingness.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile snps --geno 0.05 --make-bed --out snps_geno05
```

**Explanation:**  
The `--geno 0.05` flag filters out SNPs missing in more than 5% of samples. In a two-sample dataset, this means SNPs with more than one missing genotype call are removed.

</details>

---

## 🔹 Exercise 6: Extract SNPs from Chromosome 21

**Description:**  
Subset the dataset to include only SNPs located on chromosome 21. This is useful for region-specific analyses.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile snps --chr 21 --make-bed --out snps_chr21
```

**Explanation:**  
The `--chr 21` flag retains only variants located on chromosome 21 and creates a new binary PLINK dataset.

</details>

---

## 🔹 Exercise 7: Merge SNP and Indel Datasets

**Description:**  
Merge the SNP and indel datasets into a single dataset for joint analysis. This simulates working with mixed variant types.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
# Convert indels to PLINK format
plink --vcf filtered_indels.vcf --make-bed --out indels

# Merge SNPs and indels
plink --bfile snps --bmerge indels.bed indels.bim indels.fam --make-bed --out merged_variants
```

**Explanation:**  
The first command converts the indel VCF file into PLINK binary format. The second command merges the SNP and indel datasets into a single PLINK dataset for joint analysis.

</details>

---

## 🔹 Exercise 8: Generate Allele Frequency Table for Merged Data

**Description:**  
Calculate allele frequencies for each variant in the merged SNP + indel dataset. This provides insight into variant distribution across the two samples.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile merged_variants --freq --out merged_freq
```

**Explanation:**  
This calculates allele frequencies for each variant in the merged dataset containing both SNPs and indels from two samples.

</details>

---

## 🔹 Exercise 9: List All Variants with MAF = 0.5

**Description:**  
Identify variants where both samples have different genotypes, resulting in the maximum possible heterozygosity for a two-sample dataset. These variants are informative for distinguishing between samples.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
awk '$5 == 0.5' merged_freq.frq > maf_eq_05.txt
```

**Explanation:**  
This command searches the PLINK frequency file and extracts variants with a minor allele frequency (MAF) of exactly 0.5.

</details>

---

## 🔹 Exercise 10: Perform Linkage Disequilibrium (LD) Pruning

**Description:**  
Filter out SNPs in strong linkage disequilibrium (LD) using PLINK's default pruning parameters. This helps retain a set of independent variants for unbiased downstream analyses such as PCA or clustering.

<details>
<summary>Help, I'm lost / Check solution</summary>

```bash
plink --bfile snps --indep-pairwise 50 5 0.2 --out snps_pruned

plink --bfile snps --extract snps_pruned.prune.in --make-bed --out snps_ld_filtered
```

**Explanation:**  
The first command identifies SNPs in approximate linkage equilibrium using a sliding window of 50 SNPs, a step size of 5 SNPs, and an r² threshold of 0.2. The second command extracts the retained variants to create an LD-filtered dataset.

</details>
