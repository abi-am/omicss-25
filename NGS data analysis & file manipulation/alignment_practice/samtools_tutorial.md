# Contributors
    Primary contributor: Maria Nikoghosyan
    Contributing authors: Nate Zadirako

**Intended duration: 1.5 hours.**

# 🧬 SAMtools Practical Exercises

In this set of exercises, you will use **SAMtools** to explore and manipulate **SAM/BAM files**, which are standard formats for storing aligned sequencing reads. The tasks range from basic read counting to more advanced operations like extracting specific regions and identifying duplicate reads.

We'll be working with the same samples as in the [tutorial](https://github.com/abi-am/omicss-25/blob/main/NGS%20data%20analysis%20%26%20file%20manipulation/alignment_practice/README.md):  

`wes46_chr21_chr16_R1.fastq`, `wes46_chr21_chr16_R2.fastq` — Sample 1  
`wes78_chr21_chr16_R1.fastq`, `wes78_chr21_chr16_R2.fastq` — Sample 2  

While going through the tutorial, you have already performed the alignment and generated your BAM files, which you can use to answer the following questions.

While solutions are available if you get stuck, we encourage you to try on your own!

---

## 🔹 Exercise 1: Count the Total Number of Aligned Reads

**Description:**  
Count how many reads in the BAM file are mapped to the reference genome. This gives you a quick overview of how many reads were successfully aligned.

<!--
Command:
samtools view -c -F 4 sample.bam

Explanation:
The `-F 4` flag excludes unmapped reads, and `-c` counts the remaining ones.
-->

---

## 🔹 Exercise 2: Count Reads Mapped to Chromosome 1

**Description:**  
Determine how many reads are mapped specifically to chromosome 1. This is useful for examining chromosome-level coverage.

<!--
Command:
samtools view -c sample.bam chr1

Explanation:
This command filters reads by region (chromosome 1) and counts them with `-c`.
-->

---

## 🔹 Exercise 3: Count Properly Paired Reads

**Description:**  
Identify how many reads are properly paired in the alignment (i.e., both mates mapped correctly). Proper pairing is a good indicator of library preparation and mapping quality.

<!--
Command:
samtools view -c -f 2 sample.bam

Explanation:
The `-f 2` flag selects reads that are marked as properly paired in the BAM file.
-->

---
---

## 🔹 Exercise 4: Calculate Average Read Depth Over a Region on Chromosome 16

**Description:**  
Calculate the average sequencing depth across a defined region on chromosome 16. This helps assess whether a region has sufficient coverage for variant calling.

<!--
Command:
samtools depth -r chr16:1000000-2000000 sample.bam | awk '{sum+=$3} END {print sum/NR}'

Explanation:
`samtools depth` reports per-base coverage, and `awk` computes the average.
-->

---

## 🔹 Exercise 5: Count Reads with Mapping Quality ≥ 30 on Chromosome 21

**Description:**  
Count how many reads are mapped to chromosome 21 with a mapping quality (MAPQ) score of at least 30. This helps assess the number of confidently aligned reads in a high-quality region.

<!--
Command:
samtools view -q 30 -c sample.bam chr21

Explanation:
The `-q 30` option filters reads with MAPQ ≥ 30; `-c` counts them on chr21.
-->

---


## 🔹 Exercise 6 (Advanced): Extract and Sort Reads Mapped to a Specific Region

**Description:**  
Extract all reads mapped to a defined genomic region (e.g., chr2:1,000,000–2,000,000) and sort them by coordinate. This is helpful when focusing on a gene or region of interest.

<!--
Command:
samtools view -b sample.bam chr2:1000000-2000000 | samtools sort -o chr2_region_sorted.bam

Explanation:
The `view` command with region filters and `-b` outputs BAM format; `sort` arranges reads by position.
-->

---

## 🔹 Exercise 7 (Advanced): Identify Duplicate Reads and Count Them

**Description:**  
Mark duplicate reads in the BAM file and calculate how many are present. This helps assess library complexity and potential PCR amplification bias.

<!--
Commands:
# 1. Sort by read name
samtools sort -n -o sorted_name.bam sample.bam

# 2. Add mate information
samtools fixmate -m sorted_name.bam fixmate.bam

# 3. Sort back by coordinate
samtools sort -o fixmate_sorted.bam fixmate.bam

# 4. Mark duplicates
samtools markdup fixmate_sorted.bam marked.bam

# 5. Count duplicates
samtools view -c -f 1024 marked.bam

Explanation:
This pipeline first prepares the file for duplication marking, then `markdup` identifies duplicates, and `-f 1024` counts them.
-->

---

That's it for now :) See you again at the variant calling practice. Thank you for your attention!
