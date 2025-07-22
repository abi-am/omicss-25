After you perform the alignment and variant calling it is preferable to check the found variants and validate them.

Create index .bai files for your bam files, if they are not present in the folder with bam files. Use following command:


samtools index wes46_dedup.bam.bai


Download your  .bam and .vcf files, wes46_dedup.bam and wes78_dedup.bam.  Note that one sample was obtained from a healthy individual, while the other was collected from a person diagnosed with Familial Mediterranean Fever (FMF).  Do not forget that .bam file requires index file in the same directory. It is recommended to name your index file like .bam.bai, in that way it is guaranteed that IGV browser would open your file correctly.    

Below presented some practical exercises

## Step 1
Open files wes46_dedup.bam and wes78_dedup.bam in the IGV browser, they should appear one under another. Do not worry if your working field would be empty, this is not whole genome sequencing, so it is better to navigate right to the gene of interest.

## Step 2
Use navigation box to choose gene MEFV that is responsible for Familial Mediterranean Fever (FMF). Double-click on the variant to zoom it in.

## Step 3
Describe what kind of variants are there? Do you see SNPs, deletions, insertions or structural variants?

## Step 4
Answer why are there variants in intron regions, when it is WES?

## Step 5
Try to find homozygous somatic mutations. If there are several of them, find one with the highest coverage for every sample.

## Step 6 
Are the common variants among two sample? What can it mean?

## Step 7
What do you think about coverage of variants? Are there true or false variants?

## Step 8
Try to find variants that are not present in the corresponding VCF file. Why are they absent?

## Step 9
For variants in exome regions present in both .bam and .vcf files write the variant coordinates, describe the variant, specify reference sequence, variant coverage and variant quality.

## Step 10
Try to assume what variant/variants drive the FMF disease and in what sample.


After you complete your practice, the list of variants coordinates would be shared with you. Good luck!

