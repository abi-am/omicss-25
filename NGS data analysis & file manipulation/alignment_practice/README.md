  # Contributors
    Primary contributor: Nate Zadirako
  # Contents  
  * adapter trimming
  * alignment to a reference
  * samtools commands

We will now practice using bwa-mem and samtools on a toy dataset composed of 2 human WES (Whole-Exome Sequencing) samples, each in turn composed of 2 files: with forward and reverse reads. These are fastq files derived from paired-end ILLUMINA sequencing.   

> NOTE: human genomes are huge! The haploid genome is 3.3 Gb in length. Since processing something so large would take too much time, we selected and kept two smaller chromosomes, 16 and 21.
>  
> Is there anything special about chr16?

First, navigate to the directory where your data is stored and create a directory for your alignment.     

```
# path to fastq files
cd /mnt/proj/vine/shared_files/omicss_25/
```

### ALIGNMENT TO A REFERENCE

Before we get to the alignment, we need to perform **adapter trimming**.

During sequencing, adapters (sequences—short artificial sequences used in library preparation) can sometimes be read into the output FASTQ files. These non-biological sequences can interfere with downstream analysis like alignment and variant calling, so we must remove them.  

Their presence is typically indicated by the FASTQC report.  

We will use the command line tool [cutadapt](https://cutadapt.readthedocs.io/en/stable/guide.html) for this.

> NOTE: when performing the same operation on multiple samples, you can loop over them in your script.

```
# cutadapt usage

cutadapt \
  -a ADAPTER_FWD \
  -A ADAPTER_REV \
  -o sample_trimmed_R1.fastq.gz \
  -p sample_trimmed_R2.fastq.gz \
sample_R1.fastq.gz sample_R2.fastq.gz
```
 
### ALIGNMENT TO A REFERENCE

Now we're ready to align our trimmed reads to the reference.  

Since the reads are relatively short, bwa-mem suits us best. It's a fast and efficient algorithm, but alignment is still a computationally expensive task, which is why we're limited to a small dataset for this practice. Real datasets may take days to run. 

> How would you find out how long these reads are?

```
# let's make a subdirectory for our alignment
mkdir bam
```

Both `samtools` and `bwa mem` can be called anywhere; type `samtools --help` and `bwa mem -help` to make sure: if the tool is available, this command will bring up its manual in the terminal.

You can write a script performing the alignment. The reference we're using is GRCh38.p14, the most recent assembly of the human genome.   

```
# path to the reference
/mnt/db/genomes/homo_sapiens/GRCh38.p14/bwa_mem_0.7.17-r1188/GCF_000001405.40_GRCh38.p14_genomic.fn
```

The script can be run through the task manager called `slurm` that allocates resources and maintains your jobs while you're away from the terminal.  

Since SAM files take up a lot of space, we can skip them and pipe straight to samtools to create a BAM file. The command you'll want is:  

```
# make sure that READ1 and READ2 are forward and reverse reads of the same sample
# define your sample, R1 and R2 as variables

bwa mem -t 4 -R "@RG\tID:${sample}\tLB:${sample}\tSM:${sample}\tPL:ILLUMINA" \
  $REF $READ1 $READ2 | \
  samtools view -Sb - > bam/${sample}.bam
```
> What are the `-t` and `-R` options for?  

Add the  slurm batch parameters on top of your script, make the script executable and run:  

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

We can also index the files. Indexing allows tools to rapidly access specific regions (e.g. chr16:10000-20000) without reading the entire file. It creates an additional smaller file that acts like a lookup table to retrieve parts without reading through the entire thing (files storing genonic data are very large!).  

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

> How do these samples compare to each other?  
> How many reads are there in total? How many reads have been mapped?  

Another thing we might want to know about our alignment is the sequencing depth across positions. Depth refers to the number of reads that cover each position in the genome. This helps us evaluate how evenly the genome was covered and whether certain regions are under- or over-represented.  

```
samtools depth sample.bam > sample.depth.txt
```
This command outputs a text file with 3 columns: chromosome, position and depth, which tells you how many reads cover this position. Positions with 0 coverage are excluded, but you can include the `-a` parameter to force them to appear. From here, you might calculate the average depth or plot genome-wide coverage.  

---
That's it for now :) See you again at the variant calling practice. Thank you for your attention!
