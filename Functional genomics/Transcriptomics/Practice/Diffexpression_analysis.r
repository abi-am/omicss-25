library(DESeq2)
library(EnhancedVolcano)
library(pcaExplorer)


# Read the read counts matrix
counts_path <- "dataset/STAR_counts.tsv"
counts <- read.csv(
  counts_path, header = TRUE, sep = "\t", row.names = 1
)

# Read the sample metadata
metadata_path <- "dataset/metadata.tsv"
metadata <- read.csv(
  metadata_path, header = TRUE, sep = "\t", row.names = 1
)

# Read gene annotation
gene_ann_path <- "dataset/gencode.v42.genes.tsv"
gene_ann <- read.csv(
  gene_ann_path, header = TRUE, sep = "\t", row.names = 1
)

# Initialize DESeq2 object
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ Subtype
)

# DESeq2 normalization (median of ratios)
dds <- estimateSizeFactors(dds)
sizeFactors(dds)
norm_counts <- counts(dds, normalized = TRUE)

# Use normalized counts to plot expression of gene ESR1 across subtypes
gene_name <- "ESR1"
gene_id <- rownames(gene_ann)[gene_ann$gene_name == gene_name]
boxplot(
  norm_counts[gene_id, ] ~ metadata[, "Subtype"],
  xlab = "Subtype", ylab = "Normalized counts",
  main = gene_name
)

# Do differential expression analysis
dds <- DESeq(dds)

# "Subtype" is a factor with multiple levels
# We can do pairwise comparisons (contrasts)
res_raw <- results(dds, contrast = c("Subtype", "LuminalA", "TNBC"))
res_raw <- res_raw[order(res_raw$padj), ]
# Fold change shrinkage
res_shrink <- lfcShrink(dds, res = res_raw, type = "ashr")

# Add gene annotation to results
res_raw <- cbind(res_raw, gene_ann[rownames(res_raw), ])
res_shrink <- cbind(res_shrink, gene_ann[rownames(res_shrink), ])

# TODO: at this point, make a couple of box plots (using normalized counts)
# for a couple of the strongest DEGs

# Volcano plots (before & after shrinkage)
EnhancedVolcano(
  res_raw, x = "log2FoldChange", y = "padj",
  lab = res_raw$gene_name,
  pCutoff = 0.05, FCcutoff = 1,
  xlim = c(-10, 10), ylim = c(0, 30)
)

EnhancedVolcano(
  res_shrink, x = "log2FoldChange", y = "padj",
  lab = res_shrink$gene_name,
  pCutoff = 0.05, FCcutoff = 1,
  xlim = c(-10, 10), ylim = c(0, 30)
)

# Typical filters
res_signif <- na.omit(res_shrink)
res_signif <- res_signif[
  (res_signif$padj < 0.05) &
  (abs(res_signif$log2FoldChange) >= 1) &
  (res_signif$baseMean >= 100) &
  (res_signif$gene_type == "protein_coding"),
]
res_signif_up <- res_signif[res_signif$log2FoldChange > 0, ]
res_signif_down <- res_signif[res_signif$log2FoldChange < 0, ]

# Lecture/practice 1 assignment ideas

# Assignment idea 1: make a scatter plot with X-axis as raw fold change 
# and Y-axis as shrunken fold change. Color the points by baseMean

# Assignment idea 2: repeat the analysis for a different contrast
# For example, luminal A vs luminal B yields drastically less DEGs

# I don't have simple codes for enrichment analysis
# But there is code for PCA (for practice 2, Siras)

# PCA works best with variance stabilizing transformation
# It's just a fancy way of taking logarithm
dst <- vst(dds)
pcaExplorer(dds = dds, dst = dst, annotation = gene_ann)
