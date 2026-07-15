# Variant Annotation with ANNOVAR

This tutorial continues directly from [variant_calling_pipeline.md](./variant_calling_pipeline.md). There we aligned the reads of two samples from the **Armenian Genome Project**, called their variants jointly, and filtered them — ending with a set of SNPs and INDELs for both samples.

Here we will turn those variants into something we can actually interpret, and answer the question the pipeline started with: **which of the two samples carries the FMF-related mutation?**

---

## Why do we annotate?

At this point our filtered VCF files tell us **where** the variants are and **how confident** we are in them, but nothing about what they actually *do*. A line such as `chr16 3254690 A G` is only a coordinate and a pair of alleles — it does not say which gene is affected, whether the change alters a protein, or whether anyone has seen this variant before. Filtering removed the technical artifacts; it did not tell us which of the remaining variants are biologically interesting.

Annotation adds that missing biological layer by cross-referencing each variant against existing databases:

- **Gene and location** — which gene and transcript the variant falls in, and whether it is exonic, intronic, splice-site, or intergenic.
- **Functional consequence** — whether the change is synonymous, missense, nonsense, or a frameshift, i.e. how it affects the protein.
- **Population frequency** — how common the variant is in reference populations (e.g. gnomAD). A variant present in 30% of people is unlikely to cause a rare disease.
- **Known clinical significance** — whether the variant is already reported as pathogenic or benign (e.g. ClinVar).
- **In-silico predictions** — computational estimates of how damaging a novel variant is likely to be.

This is what makes the results interpretable. Joint genotyping leaves us with thousands of variants per sample, far too many to inspect by hand. Annotation lets us discard the common and functionally silent ones and narrow down to a short list of plausible candidates — which is exactly what we need to find **the FMF-related mutation in the *MEFV* gene on chromosome 16.**

We will use **ANNOVAR** for this. It annotates a VCF against many databases in one pass and returns a plain table, with one row per variant and one column per annotation, which is straightforward to sort and filter.

---

## Input Data

We start from the two filtered VCF files produced at the end of the variant calling pipeline:

- `data/vcf/filtered_snps.vcf` — the SNPs
- `data/vcf/filtered_indels.vcf` — the insertions and deletions

Both files contain the genotypes of both samples, `wes46` and `wes78`.

> If you did not get to the end of the previous tutorial, ready-made copies are waiting for you on the server:  
> `/mnt/nas1/proj/omicss26/ngs_data_analysis/variant_calling/data/vcf`  
> Copy them into your working directory and continue from here.

---

## Tools

- `annovar` — for variant annotation  
    Path to the tool **/mnt/nas1/proj/omicss26/soft/annovar**
- `bcftools` — for editing fields in the VCF

---

## Step-by-step Tutorial

### Step 1: Check the available databases

ANNOVAR does not download databases on the fly — it can only annotate against what is already present in its `humandb` folder. Have a look at what is installed before you choose your protocols:

```bash
annovar_dir="/mnt/nas1/proj/omicss26/soft/annovar"

ls ${annovar_dir}/humandb/hg38_*
```

In this tutorial we use two of them:

| Protocol | Operation | What it adds |
|---|---|---|
| `refGeneWithVer` | `g` (gene-based) | Gene name, region (exonic/intronic/splicing), and the effect on the protein |
| `avsnp150` | `f` (filter-based) | dbSNP rsID, if the variant is already known |

### Step 2: Run ANNOVAR

We annotate the filtered SNPs first, since the common FMF-causing *MEFV* mutations are single-nucleotide changes:

```bash
annovar_dir="/mnt/nas1/proj/omicss26/soft/annovar"
humandb="${annovar_dir}/humandb"

mkdir -p data/annotation

perl ${annovar_dir}/table_annovar.pl \
  data/vcf/filtered_snps.vcf \
  ${humandb} \
  -buildver hg38 \
  -out data/annotation/filtered_snps \
  -remove \
  -protocol refGeneWithVer,avsnp150 \
  -operation g,f \
  -nastring . \
  --vcfinput \
  -thread 4
```

A note on the options:

- `-buildver hg38` — must match the reference genome we aligned against.
- `-remove` — deletes the intermediate per-protocol files and keeps only the merged table.
- `-nastring .` — what to print when a database has no entry for a variant.
- `--vcfinput` — tells ANNOVAR the input is a VCF, and carries the original VCF fields (including **both samples' genotypes**) into the output.

⚠️ **NOTE:** ANNOVAR will not create the output folder for you. If `data/annotation` does not exist, the run stops immediately with `Directory nonexistent` — which is why we create it above.

⚠️ **NOTE:** With `--vcfinput`, ANNOVAR often ends with an error like  
`Error: the last column in header row should start with 'Otherinfo'`.  
This happens **after** the useful table has already been written, so do not panic — check whether the output file exists before assuming the run failed.

The result we want is:

```
data/annotation/filtered_snps.hg38_multianno.txt
```

Now repeat the same command for `data/vcf/filtered_indels.vcf` (changing `-out` to `data/annotation/filtered_indels`), so that you do not miss an insertion or deletion.

### Step 3: Inspect the annotation table

The multianno file is a plain tab-separated table — one row per variant, one column per annotation. Start by looking at the column names. The first line holds them all, so we split it on tabs and number them with `nl`:

```bash
head -1 data/annotation/filtered_snps.hg38_multianno.txt | tr '\t' '\n' | nl
```

```
     1  Chr
     2  Start
     3  End
     4  Ref
     5  Alt
     6  Func.refGeneWithVer
     7  Gene.refGeneWithVer
     8  GeneDetail.refGeneWithVer
     9  ExonicFunc.refGeneWithVer
    10  AAChange.refGeneWithVer
    11  avsnp150
    12  Otherinfo1
    ...
    25  Otherinfo14
```

There are 25 of them, in three groups. Columns **1–5** describe the variant itself. Columns **6–11** are the annotations we asked for — five from `refGeneWithVer`, one from `avsnp150`. Everything from **12** onwards is `Otherinfo`: the original VCF record, carried over by `--vcfinput`.

Those numbers matter, because they are what you hand to `cut`.

#### Reading the table

Do not simply `head` this file. Every column is separated by a single tab, so as soon as one value is longer than a tab stop everything after it shifts, and each line is several hundred characters wide — the output looks like noise. Cut out the columns you want, and let `column` line them up:

```bash
cut -f1-11 data/annotation/filtered_snps.hg38_multianno.txt | head -5 | column -t -s $'\t'
```

Now the same rows are readable:

```
Chr    Start  End    Ref  Alt  Func.refGeneWithVer  Gene.refGeneWithVer  GeneDetail.refGeneWithVer  ExonicFunc.refGeneWithVer  AAChange.refGeneWithVer  avsnp150
chr16  14458  14458  G    A    downstream           DDX11L10             dist=368                   .                          .                        rs12444477
chr16  14497  14497  C    T    downstream           DDX11L10             dist=407                   .                          .                        rs4620958
chr16  15561  15561  G    C    intergenic           DDX11L10,MIR6859-1   dist=1471;dist=1491        .                          .                        rs79542548
```

- `cut -f1-11` — keep the variant and annotation columns, drop the fourteen Otherinfo ones
- `column -t` — pad each column so that they line up
- `-s $'\t'` — tell `column` the input is tab-separated; without it, values containing a space (`nonsynonymous SNV`) would be split in two

Even so, a table can be wider than your terminal. Pipe it into `less -S`, which cuts long lines off at the edge instead of wrapping them — use the arrow keys to scroll sideways, and `q` to quit:

```bash
cut -f1-11 data/annotation/filtered_snps.hg38_multianno.txt | column -t -s $'\t' | less -S
```

The columns that matter most for our question are:

- `Gene.refGeneWithVer` (7) — the affected gene
- `Func.refGeneWithVer` (6) — where the variant falls (`exonic`, `intronic`, `splicing`, …)
- `ExonicFunc.refGeneWithVer` (9) — the consequence (`nonsynonymous SNV`, `stopgain`, `synonymous SNV`, …)
- `AAChange.refGeneWithVer` (10) — the resulting amino acid change
- `avsnp150` (11) — the rsID

#### Where did our samples go?

Notice that the three rows above never mention `wes46` or `wes78`. The genotypes are still there — they are just hidden among the `Otherinfo` columns, which ANNOVAR numbers rather than names. Those fourteen columns are the original VCF record, in its usual order:

| Column | Header | Really contains |
|---|---|---|
| 15 | `Otherinfo4` | CHROM |
| 16 | `Otherinfo5` | POS |
| 17 | `Otherinfo6` | ID |
| 18 | `Otherinfo7` | REF |
| 19 | `Otherinfo8` | ALT |
| 20 | `Otherinfo9` | QUAL |
| 21 | `Otherinfo10` | FILTER |
| 22 | `Otherinfo11` | INFO |
| 23 | `Otherinfo12` | FORMAT |
| **24** | `Otherinfo13` | **the genotype of `wes46`** |
| **25** | `Otherinfo14` | **the genotype of `wes78`** |

The last two are the ones we need — they are our two samples, in the order they appear in the VCF. So to see the annotation *and* who carries what, add columns 24 and 25 to the `cut`:

```bash
cut -f1,2,4,5,7,9,10,11,24,25 data/annotation/filtered_snps.hg38_multianno.txt | head -5 | column -t -s $'\t'
```

```
Chr    Start  Ref  Alt  Gene.refGeneWithVer  ExonicFunc.refGeneWithVer  AAChange.refGeneWithVer  avsnp150    Otherinfo13         Otherinfo14
chr16  14458  G    A    DDX11L10             .                          .                        rs12444477  1/1:0,2:2:6:49,6,0  0/1:1,2:3:36:40,0,36
chr16  14497  C    T    DDX11L10             .                          .                        rs4620958   0/0:2,0:2:6:0,6,41  1/1:0,2:2:6:54,6,0
chr16  15561  G    C    DDX11L10,MIR6859-1   .                          .                        rs79542548  1/1:0,2:2:6:49,6,0  ./.:0,0:0:0:0,0,0
```

Read the last two columns as `GT:AD:DP:GQ:PL` — the genotype comes first. At `chr16:14458`, `wes46` is `1/1` (homozygous for the alternative allele) while `wes78` is `0/1` (heterozygous). At `chr16:15561`, `wes78` is `./.` — not called at all, because it had no coverage there.

> ⚠️ Do not rely on `Otherinfo13` always meaning `wes46`. The number simply reflects the order of the sample columns in the VCF, so it depends on how many columns your file has. If you annotate a different VCF, check with `nl` first.

Since we already know FMF is caused by *MEFV*, we can go straight to it:

```bash
multianno="data/annotation/filtered_snps.hg38_multianno.txt"

{ head -1 "${multianno}"; grep MEFV "${multianno}"; } | cut -f1,2,4,5,7,9,10,11,24,25 | column -t -s $'\t'
```

> The `{ head -1 ...; grep ...; }` keeps the header line on top — on its own, `grep` would print the matching rows without it, leaving you to count columns by hand.

Ask yourself, for each hit: is it **exonic**? Is it **nonsynonymous** (i.e. does it change the protein)? And — looking at the genotype columns carried over from the VCF — **which of the two samples carries it?**

Not every *MEFV* variant causes FMF, though. Most of what you find will be intronic, synonymous, or simply common. So the question becomes: is any of them a **known** FMF-causing mutation?

### Step 4: Match against the known FMF variants

Fortunately, the disease-causing variants of *MEFV* are well characterised, and there are not many of them. The table below lists the most frequent ones — together, they account for essentially all FMF cases:

| Protein | cDNA | rsID | Genomic (hg38, chr16) | Share |
|---|---|---|---|---|
| **M694V** | c.2080A>G | rs61752717 | 3243407 T>C | 31.0% |
| **V726A** | c.2177T>C | rs28940579 | 3243310 A>G | 27.6% |
| **M680I** | c.2040G>C | rs28940580 | 3243448 C>G/T | 13.8% |
| **E148Q** | c.442G>C | rs3743930 | 3254626 C>G | 11.5% |
| **R408Q** | c.1223G>A | rs11466024 | 3249468 C>T | 4.6% |
| **I591T** | c.1772T>C | rs11466045 | 3243880 A>G | 3.4% |
| **P365S** | c.1105C>T | rs11466023 | 3249586 G>A | 3.4% |
| **A744S** | c.2230G>T | rs61732874 | 3243257 C>A | 1.1% |
| **R761H** | c.2282G>A | rs104895097 | 3243205 C>T | 1.1% |
| **F479L** | c.1437C>G | rs104895083 | 3247166 C>G | 1.1% |

Each column gives you a different way to match the table against your own results:

- **Protein** — compare with `AAChange.refGeneWithVer`, which reports changes in this same form (e.g. `p.M694V`).
- **cDNA** — the position within the transcript; this is the notation you will most often meet in the literature.
- **rsID** — compare with the `avsnp150` field (and, after Step 6, with the `ID` column directly).
- **Genomic** — compare with the `POS`, `REF`, and `ALT` of your VCF.

⚠️ **Careful — the same variant is written in several different ways.** Take V726A, which you will meet in your own results. All three of these describe *one* variant:

| Where you see it | How it is written |
|---|---|
| The table above (cDNA) | `c.2177T>C` |
| The `Ref` and `Alt` columns of your table (genome) | `A>G` at `chr16:3243310` |
| ANNOVAR's `AAChange.refGeneWithVer` column | `MEFV:NM_000243.3:exon10:c.T2177C:p.V726A` |

Two separate things are going on, and both are easy to mistake for a wrong answer:

- ***MEFV* is on the minus strand.** The cDNA is read along the transcript, which for *MEFV* runs against the genome, so the cDNA bases appear in the genome as their complements (A↔T, G↔C): `c.2177T>C` becomes `A>G`. Your VCF always reports the **genomic** strand. You can confirm the strand yourself in the very database ANNOVAR used — the fourth column here is it:
  ```bash
  awk -F'\t' '$13=="MEFV" {print $2, $3, $4}' ${humandb}/hg38_refGeneWithVer.txt | sort -u
  ```
- **ANNOVAR uses its own notation.** It writes `c.T2177C` — base, position, base — where the literature writes `c.2177T>C` — position, base>base. The same change, spelled differently.

So a variant that at first sight matches nothing in the table may match it perfectly. Compare by **rsID** when in doubt: that one is unambiguous.

Since we have both rsIDs and positions, we can look for these variants directly:

```bash
multianno="data/annotation/filtered_snps.hg38_multianno.txt"

{ head -1 "${multianno}"
  grep -E "rs61752717|rs28940579|rs28940580|rs3743930" "${multianno}"
} | cut -f1,2,4,5,7,9,10,11,24,25 | column -t -s $'\t'
```

You will notice that most of them return nothing at all — M694V, the most common mutation of the lot, is not in your results.

⚠️ **This does not mean the variant is absent.** The multianno file only contains variants that were **called**. A mutation missing from it can mean either of two very different things:

- both samples really are homozygous reference at that position, or
- there were not enough reads there to call anything.

In this file the two are indistinguishable. The same applies to a `./.` genotype, which you will see in several rows above: it does not mean "reference", it means **no data** — look at the `AD` and `DP` fields next to it and you will find `0,0` and `0`.

This matters for your conclusion. Finding no mutation in a sample is not the same as showing that the sample is healthy. The only way to tell the two apart is to look at the reads themselves — which is exactly what we will do with [IGV](../Integrative_Genomics_Viewer_(IGV)/README.md).

Which of the two samples carries a known FMF mutation? Is it heterozygous or homozygous? And knowing that FMF is a recessive disease — is what you found enough to explain the patient's diagnosis?

> Note that this shortcut works only because we already knew which gene to suspect. Without that prior knowledge, you would instead filter the whole table: keep the exonic and nonsynonymous variants, drop the ones that are common in the population, and inspect what remains.

### Step 5: The annotated VCF

The table is convenient to read, but ANNOVAR also wrote a second output:

```
data/annotation/filtered_snps.hg38_multianno.vcf
```

This is our original VCF with the annotations added — the same variants, the same samples, but each record now also carries its annotation. Have a look at a record (here reformatted, and with some of the GATK fields left out):

```
#CHROM  POS    ID  REF  ALT  QUAL   FILTER  INFO                       FORMAT          wes46               wes78
chr16   14458  .   G    A    76.29  PASS    AC=3;AF=0.750;AN=4;...;    GT:AD:DP:GQ:PL  1/1:0,2:2:6:49,6,0  0/1:1,2:3:36:40,0,36
```

The important thing is **where the annotation went: into the INFO column**. Rather than adding new columns — a VCF has a fixed set of them — ANNOVAR appends its results to INFO as `key=value` pairs. Reading the INFO field of that record from left to right:

```
AC=3;AF=0.750;AN=4;BaseQRankSum=-0.967;DP=5;...;QD=15.26;SOR=0.223;   <- GATK put these here
ANNOVAR_DATE=2022-08-02;                                              <- ANNOVAR's block starts
Func.refGeneWithVer=downstream;
Gene.refGeneWithVer=DDX11L10;
GeneDetail.refGeneWithVer=dist\x3d368;
ExonicFunc.refGeneWithVer=.;
AAChange.refGeneWithVer=.;
avsnp150=rs12444477;
ALLELE_END                                                            <- ANNOVAR's block ends
```

So everything between `ANNOVAR_DATE` and `ALLELE_END` is what the annotation step added, and the keys are exactly the columns we saw in the `.txt` table:

| INFO key | Value in this record | Interpretation |
|---|---|---|
| `Func.refGeneWithVer` | `downstream` | The variant is not inside a gene, but just after one |
| `Gene.refGeneWithVer` | `DDX11L10` | The gene in question |
| `GeneDetail.refGeneWithVer` | `dist\x3d368` | It sits 368 bp away from it |
| `ExonicFunc.refGeneWithVer` | `.` | Not exonic, so there is no protein consequence to report |
| `AAChange.refGeneWithVer` | `.` | Likewise, no amino acid change |
| `avsnp150` | `rs12444477` | It is a known variant, already in dbSNP |

This particular variant is therefore of no interest to us: it lies outside any coding sequence, and it is a common known SNP. Most of the file looks like this — which is exactly why we annotate rather than read the VCF by hand.

> **What is `\x3d`?** Inside INFO, `=` and `;` already have a job: they separate keys from values and one field from the next. A value that contained them would break the format, so ANNOVAR escapes them as their hex codes — `\x3d` is `=` and `\x3b` is `;`. So `dist\x3d368` should be read as *dist=368*, and the `dist\x3d1471\x3bdist\x3d1491` you will see at `chr16:15561` as *dist=1471;dist=1491* — an intergenic variant reporting its distance to the gene on either side.

Note that this file keeps the `FORMAT` column and both sample columns (`wes46`, `wes78`), so each variant still shows the genotype of both samples side by side. That is what lets us answer *which sample* — and, unlike the `.txt` table, this file can be loaded straight into IGV.

### Step 6: Add the rsIDs

Look back at the third column of that record — the **ID** column. It is still `.`, even though we can see `avsnp150=rs12444477` sitting in INFO. ANNOVAR reports the rsID as just another annotation; it does not fill in the ID field.

That is worth fixing, because the ID column is where other tools look for a variant's name. PLINK, which we use in the [VCF manipulation exercises](../vcf_file_manipulation/README.md), identifies variants by it — and IGV displays it. With every ID set to `.`, our variants are effectively nameless.

Since the rsID is already in the file, we do not need a new database — we only need to copy it from INFO into ID. `bcftools` does this in one step:

```bash
bcftools annotate \
  --set-id +'%INFO/avsnp150' \
  data/annotation/filtered_snps.hg38_multianno.vcf \
  -o data/annotation/filtered_snps.rsid.vcf
```

- `--set-id` fills the ID column from the value that follows
- `%INFO/avsnp150` — take it from the `avsnp150` INFO field
- the leading `+` — only fill IDs that are currently missing, never overwrite an existing one

Check the first few variants:

```bash
grep -v "^##" data/annotation/filtered_snps.rsid.vcf | cut -f1-5 | head
```

The ID column should now be populated:

```
#CHROM  POS    ID           REF  ALT
chr16   14458  rs12444477   G    A
chr16   14497  rs4620958    C    T
chr16   15561  rs79542548   G    C
```

Variants that dbSNP has never seen keep their `.` — those are the novel ones, and in a disease study they are often the interesting ones.

---

## What next

You now have an annotated, named set of variants and — hopefully — a candidate mutation for FMF. Two of the following sessions build directly on this:

- [**VCF file manipulation**](../vcf_file_manipulation/README.md) — filtering and exploring these variants with PLINK.
- [**IGV**](../Integrative_Genomics_Viewer_(IGV)/README.md) — looking at the reads underneath your candidate variant, to check whether it is real.

#### End of Tutorial ####
