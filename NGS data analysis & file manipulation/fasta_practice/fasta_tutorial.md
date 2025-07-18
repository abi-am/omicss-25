<!-- Introduction -->
This practical workbook uses two sample files stored locally:		This practical workbook uses two sample files stored locally:
- **FASTA data:** `sample2_100.fasta`, containing 100 reads of fixed length (150 bp).		- **FASTA data:** `sample2_100.fasta`, containing 100 reads of fixed length (150 bp).
- **FASTQ data:** `sample_100.fq`, containing 100 reads with associated quality scores covering the same sequences.		- **FASTQ data:** `sample_100.fq`, containing 100 reads with associated quality scores covering the same sequences.


In the **FASTA** section, you will learn to:		**Key terms:**
- Inspect the beginning of your dataset to verify file integrity and format consistency.		
- Search for specific motifs (short nucleotide patterns) or sequence features across all reads.		
- Quantify both the number of reads and the total bases to estimate dataset size and sequencing depth.		
- Extract, filter, and reformat sequences for use in downstream analyses, such as alignment or variant calling.		


In the **FASTQ** section, you will practice:		
- Viewing paired sequence and quality-score entries to validate data quality formats.		
- Counting reads and isolating only the nucleotides or the quality scores for separate analyses.		
- Detecting ambiguous bases (e.g., “N”) or specific motifs to assess sequencing accuracy.		
- Converting between FASTQ and FASTA formats, as well as examining file tails for completeness.		
  

 ### Key terms   
- **Read:** A single sequenced fragment of DNA.
- **Header line:** In FASTA, starts with `>` followed by the read identifier; in FASTQ, starts with `@`.
- **Sequence line:** The nucleotide letters (A, C, G, T) representing the read.
- **Plus line (FASTQ):** A line beginning with `+` that separates sequence from quality.
- **Quality-score line (FASTQ):** ASCII-encoded symbols representing the confidence of each base call.
- **Motif:** A short, biologically meaningful nucleotide pattern (e.g., a primer site) that you might search within sequences.
---		---


## FASTA Practice Exercises	


### **EXERCISE 1: Display the first 10 reads of the FASTA file**  		    
*What needs to be done:* Show the first ten complete entries (header lines beginning with `>` plus their subsequent sequences).  		Merge of viewing data and format check: show the first ten complete FASTA entries (header + sequence) using the `head` command. This quickly validates file structure and confirms that sequencing records start correctly with `>` headers and full sequences.  
*Why:* This gives a quick overview of file structure, confirming headers follow the correct naming convention and sequences are present without truncation.  		  
*Suggested command:* use the `head` command		


### **EXERCISE 2: Count the total number of reads in the FASTA file**  		  
*What needs to be done:* Count how many header lines (each starting with `>`) exist to determine the number of sequence records.  		Combine record counting and dataset sizing: use `grep -c` to count header lines (`>`), giving the total number of reads. Knowing read count is vital for gauging dataset completeness before analysis.  
*Why:* Knowing the total read count is critical before running analyses that assume a fixed dataset size or when splitting data for training/testing.  		   
*Suggested command:* use `grep -c`	


### **EXERCISE 3: Find reads containing the motif "GATTACA" and list their IDs**  	 	
*What needs to be done:* Define a motif as any short DNA pattern (here “GATTACA”) and scan all sequence lines for its occurrence. Then print the corresponding read headers.  		**EXERCISE 4: Extract a specific read record (e.g., read42)**    
*Why:* Motif searching is fundamental for locating primer-binding sites, restriction enzyme targets, or conserved domains within a dataset.  		Pull the header and sequence for a designated read ID (`>read42`) using `grep -A`. Isolating individual reads allows troubleshooting of alignment issues or examination of sequences of special interest.  
*Suggested command:* use `grep` with the `-B` context option		


### **EXERCISE 4: Extract the record for a specific read (e.g., read42)**  		
Filter out headers so that only raw nucleotide strings remain, with `grep -v`. Sequence-only output is often required by k‑mer counters, GC-content calculators, or other sequence‑based tools.  
*What needs to be done:* Identify the header line matching a given identifier (`>read42`) and extract that header plus its sequence.  		
*Why:* Pulling single reads allows you to inspect anomalies, troubleshoot alignment failures, or spotlight reads of special interest.  		


### **EXERCISE 5: Print only the header lines**  		
*What needs to be done:* Extract just the lines that begin with `>`, listing all read identifiers.   		
*Why:* Generating a list of read IDs can help cross-reference with other files, prepare index lists, or verify naming schemes.  		
*Suggested command:* use `grep`		


### **EXERCISE 6: Count total nucleotides across all reads**  (Optional)  
*What needs to be done:* Concatenate all sequence lines into one continuous string, then count its characters to get the total base count.  		
*Why:* Total base count helps estimate genome coverage or sequencing depth when mapped to a reference.  		
*Suggested command:* use `grep`, `tr`, and `wc`		


### **EXERCISE 7: Sort read headers alphabetically**  	
*What needs to be done:* List and then sort all header lines in lexicographic order. Pipe header extraction (`grep`) into `sort` to order read IDs lexicographically. Sorted headers facilitate merging datasets, detecting duplicates, and performing set-based operations.   
*Why:* Alphabetical ordering can aid in merging datasets, detecting duplicates, or preparing for comparative set operations.     		
*Suggested command:* use `grep` piped to `sort`		


### **EXERCISE 8: Show the length of each read**  		
*What needs to be done:* For each sequence record, calculate and print the number of bases alongside its header.  		Leverage `awk` to calculate and print the sequence length for each record next to its header. This check confirms uniform read length or flags outliers for quality control.    
*Why:* Verifies read length uniformity (important for certain analyses) and helps identify outliers or partial reads.  		
*Suggested command:* use `awk`		


---		---


## FASTQ Practice Exercises		


### **EXERCISE 9: Display the first 10 reads of the FASTQ file**  	
*What needs to be done:* Show the first ten four-line records (header, sequence, plus line, and quality).  
*Why:* Confirms both sequence and quality score formatting, ensuring no misalignment between these paired lines.  		
*Suggested command:* use the `head` command		


### **EXERCISE 10: Count the total number of reads in the FASTQ file**  		
*What needs to be done:* Divide the total number of lines by four (each read spans four lines).  		
*Why:* Provides a fast way to verify dataset size before intensive processing or splitting.  		
*Suggested command:* use `wc -l` piped to `awk`	


### **EXERCISE 11: Find reads containing the motif "GATTACA" and list their IDs**  		
*What needs to be done:* Scan only the sequence lines (every second line) for the motif, then extract the preceding header lines.   
*Why:* Identifying reads that contain a specific motif like "GATTACA" helps locate biologically relevant patterns (e.g., adapters, barcodes, conserved regions). It also aids in diagnostics, primer matching, or filtering steps.  
*Suggested command:* `awk`	  


### **EXERCISE 12: Extract a specific FASTQ record (e.g., read42)**  (optional)   
**What needs to be done:** Locate the header line beginning with `@read42`, and extract that line along with the following three lines (sequence, plus-line, and quality). This constitutes one complete `FASTQ` record.    
**Why:** Useful for identifying reads with [adapters](https://en.wikipedia.org/wiki/Adapter_(genetics)), barcodes, or biologically relevant patterns. Examining both sequence and corresponding quality scores helps diagnose read-specific issues.
**Suggested command:** Use `grep` with the -A context option.   



