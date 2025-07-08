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

### Now lets try to  solve some practical exercises
To solve those you may use samtools combined with Unix commands 

#  ! path to bed / gtf/ gff3 files !
```

