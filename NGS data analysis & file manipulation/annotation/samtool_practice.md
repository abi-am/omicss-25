# Contributors
    Primary contributor: Maria Nikoghosyan
    Contributing authors: Nate Zadirako

**Intended duration: 1.5 hours.**

# 🧬 SAMtools Practical Exercises

In this set of exercises, you will use **SAMtools** to explore and manipulate **SAM/BAM files**, which are standard formats for storing aligned sequencing reads. The tasks range from basic read counting to more advanced operations like extracting specific regions and identifying duplicate reads.

While solutions are available if you get stuck, we encourage you to try on your own!

---

## 🔹 Exercise 1: Count the Total Number of Aligned Reads

**Description:**  
Count how many reads in the BAM file are mapped to the reference genome. This gives you a quick overview of how many reads were successfully aligned.

<!--
Command:
samtools view -c -F 4 sample.bam

Explanation:

The `-F` flag filters out reads where the flag you give it is set (in this case, SAM flag 0x4 means unmapped reads). So the `-F 4` flag excludes unmapped reads, and `-c` counts the remaining ones.

If you wanted to include reads with this flag, you'd use `-f` instead.
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
The `-f 2` flag selects reads that are marked as properly paired in the BAM file. Properly paired means the read and its mate: are both mapped, are mapped to the same chromosome, are facing each other, and are the expected distance apart.
-->
---

## 🔹 Exercise 4: Calculate Average Read Depth Over a Region on Chromosome 16

**Description:**  
Calculate the average sequencing depth across a defined region on chromosome 16. This helps assess whether a region has sufficient coverage for variant calling.

<!--
Command:
samtools depth -r chr16:1000000-2000000 sample.bam | awk '{sum+=$3} END {print sum/NR}'

Explanation:
`samtools depth` reports per-base coverage in the defined region (`-r` is for region), and `awk` computes the average: column 3 is where depth values are, so you sum them up and divide by the number of lines/records.
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

Duplicates refer to reads that are copies of the same original DNA fragment, likely introduced during PCR amplification in library preparation. They are not true biological replicates and may be removed later.  

<!--
Commands:
samtools sort -o sorted.bam sample.bam
samtools fixmate -m sorted.bam fixmate.bam
samtools sort -o fixmate_sorted.bam fixmate.bam
samtools markdup fixmate_sorted.bam marked.bam
samtools view -c -f 1024 marked.bam

Explanation:
This pipeline first prepares the file for duplication marking by sorting by by genomic coordinates and adding mate information; `-m` only output reads that are properly paired. We sort by position again as markdup requires it. Then `markdup` identifies duplicates. Duplicates are not removed — just marked with SAM flag 0x400 (1024 in decimal). Then `-f 1024` counts them.
-->

---

That's it for now :) See you again at the variant calling practice. Thank you for your attention!
