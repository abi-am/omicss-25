  # Contributors
    Primary contributor: Nate Zadirako
  # Contents  
  * alignment to a reference
  * samtools commands

We will now practice using bwa-mem and samtools on a toy dataset composed of 3 grapevine samples, each in turn composed of 2 files: with forward and reverse reads. These are fastq files derived from paired-end ILLUMINA sequencing.  

First, navigate to the directory where your data is stored.   

```
# path to fastq files
cd path
```
When calling the tools, you will be using these paths to access them:   

```
# path to bwa-mem2
# path to samtools if needed
```
### ALIGNMENT TO A REFERENCE

Since the reads are [this length], bwa-mem2 suits us best. It's a fast and efficient algorithm, but alignment is still a computationally expensive task, which is why we're limited to a small dataset for this practice. Real datasets may take days to run.

You can write a script performing the alignment. The reference we're using is [what it is]. The script can be run through the task manager called `slurm` that allocates resources and maintains your jobs while you're away from the terminal.
```
cd top-level directory
mkdir bam

either the script or the commands?

# path to reference
```

### SAMTOOLS COMMANDS

We now have the files describing our alignments to the reference.    

First, let us sort our BAM file. Sorting is necessary to arrange reads by genomic position, which is required before indexing or viewing by region.  

```
cd bam
samtools sort input.bam -o input.sorted.bam
```

We can also index the files. Indexing allows tools to rapidly access specific regions (e.g. chr1:10000-20000) without reading the entire file. It creates an additional smaller file that acts like a lookup table to retrieve parts without reading through the entire thing (files storing genonic data are very large!).

> Note: different tools require different indexes and may have their own indexing commands, such as `bwa index` for the reference sequence and `tabix` for VCF files.  

```
samtools index input
```

Indexes are binary files, so we can't peek inside. We can, however, inspect your BAM file itself. Let us convert one of the files to SAM and inspect it directly.  

```
samtools view -Sb
```

You can also view the reads from a particular region without conversion:  

```
samtools view input region
```

Let's also explore the quality of our alignment with `samtools flagstat`.

```
# if you don't specify an output, fragstat will print to your console
samtools flagstat input > output
```

This command outputs some statistics for each sample. If you have many samples, you can write a script that collects the values of interest into a single table. You can revise what the fields mean [here](https://www.biostars.org/p/12475/).

Another thing we might want to know about our alignment is the sequencing depth across positions. Depth is…

```
samtools depth input > output
```
That's it for now :) See you again at the variant calling practice. Thank you for your attention!
