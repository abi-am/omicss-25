# Contributors
    Primary contributor: Maria Nikoghosyan
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
    /mnt/proj/vine/shared_files/omicss_25/annotation/data/
```
Before starting the exersices you can play a little with those files, see how they are structured and what each column means.

### Exercise 1
Extract only "exon" regions from .gtf file and save them in seperate .gtf file. How many exons are there ?

### Exercise 2
What kind of genetic regions you have in .gff3 file ? Optionally also find out how many from each 

### Exercise 3
Find a gene with ID=ENSG00000210196.2 in .gff3 file. On what chromosome it is located?

### Exercise 4
For this exercise you are going to work with .gtf file. First take exons and genes and store them in seperate .gtf files. Sort those files. Find out how they overlap. Redirect the output to the seperate gtf file so it would be easier to analyze it.

>NOTE: Bedtools intersect works faster of you give as an input sorted files

>NOTE: running bedtools intersect might take a coumple of minutes

### Exercise 5
See how many genomic regions are located on forward and how many on reverese strand in .bed file.

### Exercise 6
How many unique chromosomes you have in .bed file?

### Exercise 7
Fine on what strand the genomic region with name "ENST00000615165.1" in .bed file is located. 







