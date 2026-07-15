**GATK (Genome Analysis Toolkit)** is an open-source software suite from the Broad Institute for identifying genomic variants in high-throughput sequencing data. It provides best-practice workflows for read pre-processing, variant discovery, and genotyping across germline and somatic applications. Its modular tools and active community support have made GATK a standard in research and clinical genomics.

During this practical session, you will perform alignment and variant calling on the **human genome**, and then make biological sense of the result. The work is split across two tutorials, to be followed in this order:

1. [**variant_calling_pipeline.md**](./variant_calling_pipeline.md) — **variant calling.** Align the reads of two samples to the reference with BWA, call their variants with GATK, genotype both samples jointly, and filter what comes out. You finish with a set of filtered SNPs and INDELs.

2. [**variant_calling_annotation.md**](./variant_calling_annotation.md) — **annotation.** Take those filtered variants and use ANNOVAR to work out which gene each one falls in and what it does to the protein. This is what lets you answer the question the practical opens with: which of the two samples carries the FMF-related mutation?

All the required files are already on the server, and every path is given in the tutorials. If you do not manage to finish the first one, ready-made copies of its output are waiting for you, so you can still start the second.

> **Important:** The reference genome has already been indexed for both BWA and GATK. Indexing takes a long time, so we have done it for you — use the reference as it is, and do not re-index it.
