  # Contributors 
    Primary contributor: Nane Pivazyan
    Contributing authors: Maria Nikoghosyan
    
  # Contents  
  * Annotation Overview 
  * Practical exersices

  Annotation is the process of identifying and marking functional elements within a DNA sequence, such as genes, exons, introns, regulatory regions, and more. It transforms raw genomic sequences into biologically meaningful information, essential for research in genetics, molecular biology, evolution, and medicine.

To represent annotated data in a structured, standardized format, several file types are commonly used.

### BED (Browser Extensible Data)
A lightweight format used to define genomic regions. It contains coordinates (chromosome, start, end) and optional fields like name, score, and strand. It's primarily used for visualization and genomic intervals.

### GTF (Gene Transfer Format)
A tab-delimited format that describes gene structure, including exons, transcripts, and other features. It’s commonly used with Ensembl and genome annotation tools. GTF is a simplified and stricter version of GFF.

### GFF3 (General Feature Format version 3)
A more flexible and standardized format compared to GTF. It supports a rich set of annotations and hierarchical relationships (e.g., gene → transcript → exon), with attributes in a structured key=value format. GFF3 is often used for complex genome annotations and is compatible with many bioinformatics tools.

Together, these formats enable accurate annotation, sharing, and analysis of genomic features across tools and platforms.

 **Now lets try to  solve some practical exercises**
 All the files for the practice are located in the following directory 
 ```
    /mnt/proj/omicss25/ngs_data_analysis/annotation_practice/data/
```
Before starting the exersices you can play a little with those files, see how they are structured and what each column means.

### Exercise 1
Extract only "exon" regions from .gtf file and save them in seperate .gtf file. How many exons are there ?

<!--
Command:
zcat gencode.v38.annotation.gtf.gz | grep "exon" > exons.gtf
wc -l exons.gtf

Answer:
2853214 .

Explonation:
This command 1st unzips .gz file, then searches lines that have the word "exon" in them and stores them in the seperate .gtf file. In the end it just counts the number of lines, as each lines is one reagion (in this case one exon).
-->

---
### Exercise 2
What kind of genetic regions you have in .gff3 file ? Optionally also find out how many from each 

<!--
Command:
zcat gencode.v38.annotation.gff3.gz| grep -v "#" | cut -f3 | sort | uniq -c

Answer:
- 825914 CDS
-  1499012 exon
-  163360 five_prime_UTR
-  60649 gene
-  92997 start_codon
-  86205 stop_codon
-  119 stop_codon_redefined_as_selenocysteine
-  182868 three_prime_UTR
-  237012 transcript

Explonation:
This command 1st unzips .gz file. Then we get rid of lines that start with "#" as those are metadata headers and we dont need them in this task. Then we cut only 3rd column as it stores names of the genomic regions, we sort them and keep unique ones. The command uniq -c not only print out unique genomic regions but also counts how many from each we have. Sorting ot essential here because uniq -c command can work only on consecutive dublicate lines. Sorting ensures that all different genetic regions are grouped together.
-->

---
### Exercise 3
Find a gene with ID=ENSG00000210196.2 in .gff3 file. On what chromosome it is located?

<!--
Command:
zcat gencode.v38.annotation.gff3.gz | grep "ID=ENSG00000210196.2" | cut -f1

Answer:
- chrM (mitochondrial chromosome)

Explonation:
This command 1st unzips .gz file. Then it searches and keeps the line that has "ID=ENSG00000210196.2" in it. In the end it print just 1st column as it contains chromosome information. 
-->

---
### Exercise 4
For this exercise you are going to work with .gtf file. First take exons and genes and store them in seperate .gtf files. Sort those files. Find out how they overlap. Redirect the output to the seperate gtf file so it would be easier to analyze it.

>NOTE: Bedtools intersect works faster of you give as an input sorted files

>NOTE: running bedtools intersect might take a coumple of minutes

<!--
Command:
zcat gencode.v38.annotation.gtf.gz | grep "gene" > genes.gtf
zcat gencode.v38.annotation.gtf.gz | grep "exon" > genes.gtf
bedtools sort -i genes.gtf > genes.sorted.gtf  
bedtools sort -i =exons.gtf > exons.sorted.gtf
bedtools intersect -a exons.sorted.gtf -b genes.sorted.gtf > overlaps.gtf


Explonation:
These commands extract gene and exon entries from a GTF file, sort them, and then find where exons overlap with genes. First, gene and exon lines are saved into separate files, then both files are sorted using bedtools sort. Finally, bedtools intersect finds overlapping regions between exons and genes. This helps identify which exons are located within genes.

-->

---
### Exercise 5
See how many genomic regions are located on forward and how many on reverese strand in .bed file.

<!--
Command:
zcat hg38.knownGene.bed.gz | grep "+" | wc -l
zcat hg38.knownGene.bed.gz | grep "-" | wc -l

Answer:
- forward - 206825; reverse - 205219

Explonation:
This command 1st unzips .gz file. Then it searches and keeps the lines that have "+" in them and counts how many are there. Same with "-". 
-->

---
### Exercise 6
How many unique chromosomes you have in .bed file?

<!--
Command:
zcat hg38.knownGene.bed.gz | cut -f1 | sort | uniq | wc -l

Answer:
 - 528

Explonation:
This command 1st uncomprasses .gz file. Then it extracts the first column (which usually contains chromosome names), sorts them, removes duplicates, and then counts how many unique entries there are. 
-->

---
### Exercise 7
Find on what strand the genomic region with name "ENST00000615165.1" in .bed file is located. 

<!--
Command:
zcat hg38.knownGene.bed.gz | grep "ENST00000615165.1" | cut -f6

Answer:
 - reverse (-)

Explonation:
This command 1st uncomprasses .gz file. Then it searches the line that contains given genomic region name. In the end keeps only 6th column, as it contains on which strand the genomic region is located. 
-->






