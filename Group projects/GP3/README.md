
### The project goal
Get familiar with variant calling, ways to represent differences between a sample's genome and a reference genome, vcf file format, genetic variants analysis and population genetics concepts
### Data for analysis:
What is vcf file, why is it used \
The datapath to the vcf file:
```
/mnt/....
```
### Data mining (preparation of the compined vcf file)
The transition from gvcf to vcf, combining samples files (Nate's part)
### VCF filtering using PLINK 1.9 and vcftools hard filtering
GATK toolkit - https://gatk.broadinstitute.org/hc/en-us <br>
PLINK - https://www.cog-genomics.org/plink/ <br>
PLINK 1.9 path:
```
/mnt/proj/soft/...
```
What are minor allele frequency, missing genotypes, biallelic variants, monomorphic SNPs
### ADMIXTURE as a way to explore population genetic structure and clustering tool
Files preparation for ADMIXTURE: VCF annotation, PLINK filtration, Linkage Disequilibrium pruning with PLINK <br>
k-fold cross validation,cv error graphs, ADMIXTURE .Q, .P files <br>
ADMIXTURE documentation - https://speciationgenomics.github.io/ADMIXTURE/ <br>
path to ADMIXTURE:
```
/mnt/proj/soft/...
```
   #### &emsp;ADMIXTURE results ploting in R:
   - Cultivated, admixed, wild clusters distinction
   - Grouping samples in clusters by countries
   - Rscript in bash
     
### SOM 

### Phylogenetic analysis
Exploring the evolutionary relationships among different grape accessions based on SNPs variants <br>
Presumably SNPhylo tool


