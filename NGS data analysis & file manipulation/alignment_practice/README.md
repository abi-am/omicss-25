  # Contributors
    Primary contributor: Nate Zadirako
  # Contents  
  * alignment to a reference
  * samtools commands

> Note: I'll change the paths etc around a bit when we actually get to the server and I'll set it up and run through it myself.

---
We will now practice using bwa-mem and samtools on a toy dataset composed of 3 grapevine samples, each in turn composed of 2 files: with forward and reverse reads. These are fastq files derived from paired-end ILLUMINA sequencing.   

First, navigate to the directory where your data is stored and create a directory for your alignment.     

```
# path to fastq files
cd path

mkdir bam
cd bam
```
When calling the tools, you will be using these paths to access them:    

```
# path to bwa-mem2
# path to samtools if needed
```
### ALIGNMENT TO A REFERENCE

Since the reads are [this length], bwa-mem2 suits us best. It's a fast and efficient algorithm, but alignment is still a computationally expensive task, which is why we're limited to a small dataset for this practice. Real datasets may take days to run.  

You can write a script performing the alignment. The reference we're using is [what it is].   

```
# path to the reference

```

The script can be run through the task manager called `slurm` that allocates resources and maintains your jobs while you're away from the terminal.  

Since SAM files take up a lot of space, we can skip them and pipe straight to samtools to create a BAM file. The command you'll want is:  

```
# make sure that R1 and R2 are forward and reverse reads of the same sample

bwa-mem2 mem $REF $READ1 $READ2 | samtools view -Sb - > $OUT
```
You can loop through the samples or run each separately. Add the  slurm batch parameters on top of your script, make the script executable and run:  

```
chmod +x alignment.sh
sbatch alignment.sh (+ any parameters your script takes off the command line, eg a sample list)
```

### SAMTOOLS COMMANDS

We now have the files describing our alignments to the reference.     

First, let us sort our BAM file. Sorting is necessary to arrange reads by genomic position, which is required before indexing or viewing by region.   

```
cd bam
samtools sort sample.bam -o sample.sorted.bam
```

We can also index the files. Indexing allows tools to rapidly access specific regions (e.g. chr1:10000-20000) without reading the entire file. It creates an additional smaller file that acts like a lookup table to retrieve parts without reading through the entire thing (files storing genonic data are very large!).  

> Note: different tools require different indexes and may have their own indexing commands, such as `bwa index` for the reference sequence and `tabix` for VCF files.   

```
samtools index sample.sorted.bam
```

Indexes are binary files, so we can't peek inside. We can, however, inspect a BAM file by converting it into SAM, which is a plain text format that we can view directly. Let's convert one of the BAM files and take a look at the first 50 lines.  

```
# -h option tells samtools to include a header

samtools view -h sample.sorted.bam > sample.sam
head -n 50 sample.sam
```

You can also view the alignments directly in the terminal, either the whole file (not recommended for large datasets) or for a specific genomic region:  

```
samtools view sample.sorted.bam chr1:10000-20000
```

Let's also explore the quality of our alignment with `samtools flagstat`.  

```
# if you don't specify an output, fragstat will print to your console

samtools flagstat sample.bam > sample.flagstat.txt
```

This command outputs some statistics for each sample. If you have many samples, you can write a script that collects the values of interest into a single table. You can revise what the fields mean [here](https://www.biostars.org/p/12475/).  

Another thing we might want to know about our alignment is the sequencing depth across positions. Depth refers to the number of reads that cover each position in the genome. This helps us evaluate how evenly the genome was covered and whether certain regions are under- or over-represented.  

```
samtools depth sample.bam > sample.depth.txt
```
This command outputs a text file with 3 columns: chromosome, position and depth, which tells you how many reads cover this position. Positions with 0 coverage are excluded, but you can include the `-a` parameter to force them to appear. From here, you might calculate the average depth or plot genome-wide coverage.  

---
That's it for now :) See you again at the variant calling practice. Thank you for your attention!
