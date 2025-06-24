# Contributors
**Primary contributor:** Davit Hakobyan

**Contributing authors:** Nelli Vardazaryan, Razmik Sargsyan, Lusine Adunts

# Content

## Week 1: Background & Conceptual Foundations
- **Time Slots:** 3 1-hour long slots (Tuesday, Wednesday, Thursday)
- **Readings (assign 1–3 articles):**
  - Overview of the power of oral microbiome for disease classification: (**TBD**)
    - [Unlocking the Potential of the Human Microbiome for Identifying Disease Diagnostic Biomarkers](https://www.mdpi.com/2075-4418/12/7/1742). *A bit long and biology heavy.* Does not only talk about Microbiome Signatures as Disease Biomarker but also Metagenomics-Derived Genes as Potential Disease Biomarkers, Microbiota-Derived Metabolites as Potential Disease Biomarkers and Microbiome Multi-omicss.
    - [Oral Microbiome: A Review of Its Impact on Oral and Systemic Health](https://www.mdpi.com/2076-2607/12/9/1797). *Bare but Concise Biolgy with high Altmetric score ~260.* Talks about the composition, disbiosis, and generally the importance of oral microbiome.
    - [The diagnostic potential and barriers of microbiome based therapeutics](https://www.degruyterbrill.com/document/doi/10.1515/dx-2022-0052/html). *Basically walks through every necessary background info very quickly + feature selection state of the art.* tells about the Emergent problems in microbiome datasets (compositionality, multilinearity etc.) and touches ML state of the art.
  - State of the art review: (**TBD**)
    - [Illuminating the oral microbiome and its host interactions: recent advancements in omics and bioinformatics technologies in the context of oral microbiome research](https://academic.oup.com/femsre/article/47/5/fuad051/7259894)
- **Activities:**  
  - Group discussion sessions for each paper
  - Maybe compiling a shared glossary of key terms and concepts (a google doc)

## Week 2: Taxonomic Processing & Intro to Phyloseq
**Time Slots:** 3 1-hour long slots (Monday, Wednesday, Thursday)
- **Tools & Methods:**  
  - Kraken2 for taxonomic classification  
  - Bracken for abundance estimation  
- **Activities:**
  - Hands-on Kraken2 → Bracken workflow on WGS test dataset  
  - Introduction to the **phyloseq** R package:  
    - Importing taxonomy, abundance, and metadata  
    - Exploring phyloseq object structures  
- **Deliverable:**  
  - Annotated R script (or R Markdown) demonstrating taxonomic profiling and data import  

## Week 3: Exploratory Data Analysis & Diversity Metrics
- **Time Slots:** 2-hour long Project Presentations + 4 1-hour long slots (Tuesday, Wednesday, Thursday, Friday)
- **Phyloseq EDA:**  
  - Composition plots (barplots, relative-abundance heatmaps)  
- **Diversity Analyses:**  
  - Alpha diversity (Shannon, Simpson, observed OTUs)  
  - Beta diversity (Bray–Curtis, UniFrac)  
- **Advanced Methods Overview:**  
  - ANCOMBC-2 for differential abundance  
  - ML methods for feature selection (e.g., random forest, LASSO)  
- **Activities:**  
  - EDA plotting workshop in R  
  - Diversity-metric computation exercises  
- **Deliverable:**  
  - R Markdown report with EDA figures and diversity summaries  

## Week 4: Project Execution & Presentation
- **Time Slots:** 8 1-hour long slots + Bootcamp
- **Independent Project Work:**  
  - Apply ANCOMBC-2 and selected ML methods to the assigned dataset  
  - Interpret key biomarkers and visualize findings  
- **Presentation Prep:**  
  - Build slide deck: objectives, methods, results, discussion  
  - Peer review and rehearsal sessions  
- **Final Deliverables:**  
  - GitHub repository with analysis code  
  - Presentation slides (PDF or PowerPoint)  
  - Short written summary of results  

# TODO
- **Davit Hakobyan (primary contributor):**  
  - Finalize & upload Week 1 readings on background and conceptual foundations
  - Upload "Intro to Phyloseq + EDA" slides for Week 2 - **Deadline: June 30**
  - Prepare *Group Project Intro Presentation* – **Deadline: July 7** 

- **Razmik Sargsyan:**  
  - Upload Kraken2 and Bracken tutorial scripts for Week 2 – **Deadline: Monday, June 27**

- **Nelli Vardazaryan:**  
  - Phyloseq Intro and Exercises – **Deadline: July 7**
