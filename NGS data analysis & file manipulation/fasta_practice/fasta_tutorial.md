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


**EXERCISE 1: Display the first 10 reads of the FASTA file**  		**EXERCISE 1: Display the first 10 reads of the FASTA file**  
*What needs to be done:* Show the first ten complete entries (header lines beginning with `>` plus their subsequent sequences).  		Merge of viewing data and format check: show the first ten complete FASTA entries (header + sequence) using the `head` command. This quickly validates file structure and confirms that sequencing records start correctly with `>` headers and full sequences.
*Why:* This gives a quick overview of file structure, confirming headers follow the correct naming convention and sequences are present without truncation.  		
*Suggested command:* use the `head` command		


**EXERCISE 2: Count the total number of reads in the FASTA file**  		**EXERCISE 2: Count the total number of reads in the FASTA file**  
*What needs to be done:* Count how many header lines (each starting with `>`) exist to determine the number of sequence records.  		Combine record counting and dataset sizing: use `grep -c` to count header lines (`>`), giving the total number of reads. Knowing read count is vital for gauging dataset completeness before analysis.
*Why:* Knowing the total read count is critical before running analyses that assume a fixed dataset size or when splitting data for training/testing.  		
*Suggested command:* use `grep -c`		**EXERCISE 3: Identify reads containing a specific motif (e.g., “GATTACA”)**  

Search for a motif—a short DNA pattern—within sequence lines and list matching read IDs. Using `grep -B` returns the header plus context. Motif searches help locate primer binding sites, restriction enzyme targets, or conserved functional elements.
**EXERCISE 3: Find reads containing the motif "GATTACA" and list their IDs**  		
*What needs to be done:* Define a motif as any short DNA pattern (here “GATTACA”) and scan all sequence lines for its occurrence. Then print the corresponding read headers.  		**EXERCISE 4: Extract a specific read record (e.g., read42)**  
*Why:* Motif searching is fundamental for locating primer-binding sites, restriction enzyme targets, or conserved domains within a dataset.  		Pull the header and sequence for a designated read ID (`>read42`) using `grep -A`. Isolating individual reads allows troubleshooting of alignment issues or examination of sequences of special interest.
*Suggested command:* use `grep` with the `-B` context option		

**EXERCISE 5: Show only sequence lines**  
**EXERCISE 4: Extract the record for a specific read (e.g., read42)**  		Filter out headers so that only raw nucleotide strings remain, with `grep -v`. Sequence-only output is often required by k‑mer counters, GC-content calculators, or other sequence‑based tools.
*What needs to be done:* Identify the header line matching a given identifier (`>read42`) and extract that header plus its sequence.  		
*Why:* Pulling single reads allows you to inspect anomalies, troubleshoot alignment failures, or spotlight reads of special interest.  		**EXERCISE 6: Show only header lines**  
*Suggested command:* use `grep` with the `-A` context option		List all read identifiers by extracting lines that begin with `>` using `grep`. A header list can be used to cross‑reference read IDs, build indices, or verify naming conventions.


**EXERCISE 5: Print only the sequence lines**  		**EXERCISE 7: Calculate total nucleotide count across all reads**  
*What needs to be done:* Remove all header lines so that only raw nucleotide strings remain.  		Combine `grep`, `tr`, and `wc` to remove header lines, concatenate sequences, and count characters. This yields the total number of bases sequenced, useful for coverage and depth estimations.
*Why:* Some downstream tools (e.g., k-mer counters or GC-content calculators) require purely sequence input without header metadata.  		
*Suggested command:* use `grep -v`		

**EXERCISE 6: Print only the header lines**  		
*What needs to be done:* Extract just the lines that begin with `>`, listing all read identifiers.  		
*Why:* Generating a list of read IDs can help cross-reference with other files, prepare index lists, or verify naming schemes.  		
*Suggested command:* use `grep`		

**EXERCISE 7: Count total nucleotides across all reads**  		
*What needs to be done:* Concatenate all sequence lines into one continuous string, then count its characters to get the total base count.  		
*Why:* Total base count helps estimate genome coverage or sequencing depth when mapped to a reference.  		
*Suggested command:* use `grep`, `tr`, and `wc`		


**EXERCISE 8: Sort read headers alphabetically**  		**EXERCISE 8: Sort read headers alphabetically**  
*What needs to be done:* List and then sort all header lines in lexicographic order.  		Pipe header extraction (`grep`) into `sort` to order read IDs lexicographically. Sorted headers facilitate merging datasets, detecting duplicates, and performing set-based operations.
*Why:* Alphabetical ordering can aid in merging datasets, detecting duplicates, or preparing for comparative set operations.  		
*Suggested command:* use `grep` piped to `sort`		


**EXERCISE 9: Reformat sequences to wrap at 50 chars/line**  		**EXERCISE 9: Reformat sequences to wrap at 50 characters per line**  
*What needs to be done:* Read each sequence and output it in fixed-width chunks of 50 characters, preserving header lines.  		Use `awk` to read each sequence and output it in fixed-width chunks of 50 chars, preserving headers. Many legacy tools and publication formats require fixed-line widths for readability.
*Why:* Many legacy tools or publishing formats expect sequences wrapped at a certain column width for readability and compatibility.  		
*Suggested command:* use `awk`		


**EXERCISE 10: Show the length of each read**  		**EXERCISE 10: Report the length of each read**  
*What needs to be done:* For each sequence record, calculate and print the number of bases alongside its header.  		Leverage `awk` to calculate and print the sequence length for each record next to its header. This check confirms uniform read length or flags outliers for quality control.
*Why:* Verifies read length uniformity (important for certain analyses) and helps identify outliers or partial reads.  		
*Suggested command:* use `awk`		


---		---


## FASTQ Practice Exercises		## FASTQ Practice Exercises


**EXERCISE 11: Display the first 10 reads of the FASTQ file**  		**EXERCISE 11: Display the first 10 reads of the FASTQ file**  
*What needs to be done:* Show the first ten four-line records (header, sequence, plus line, and quality).  		Use `head` to show the first ten 4‑line records (header, sequence, plus line, quality). Verifying both sequence and quality formatting early ensures proper pairing and encoding.
*Why:* Confirms both sequence and quality score formatting, ensuring no misalignment between these paired lines.  		
*Suggested command:* use the `head` command		


**EXERCISE 12: Count the total number of reads in the FASTQ file**  		**EXERCISE 12: Count the total number of reads in the FASTQ file**  
*What needs to be done:* Divide the total number of lines by four (each read spans four lines).  		Divide total line count by four (each read spans four lines) with `wc -l` piped to `awk`. This provides a quick read count without requiring specialized tools.
*Why:* Provides a fast way to verify dataset size before intensive processing or splitting.  		
*Suggested command:* use `wc -l` piped to `awk`		**EXERCISE 13: Identify reads containing a motif in FASTQ sequences**  

Search only sequence lines (every second line) for a motif and list preceding headers using `grep -B`. Detecting motifs in reads can inform adapter trimming or barcode demultiplexing.
**EXERCISE 13: Find reads containing the motif "GATTACA" and list their IDs**  		
*What needs to be done:* Scan only the sequence lines (every second line) for the motif, then extract the preceding header lines.  		**EXERCISE 14: Extract a specific FASTQ record (e.g., read42)**  
*Why:* Useful for identifying reads with adapters, barcodes, or biologically relevant patterns.  		Use `grep -A` to pull the entire 4‑line block for `@read42`. Examining both sequence and corresponding quality scores helps diagnose read‑specific issues.
*Suggested command:* use `grep` with the `-B` context option		

**EXERCISE 15: Show only FASTQ sequence lines**  
**EXERCISE 14: Extract the record for a specific read (e.g., read42)**  		Extract every 2nd line of the file with `sed '2~4p'` to isolate nucleotide strings. Sequence‑only output is useful for analyses that ignore quality information.
*What needs to be done:* Locate `@read42` in the headers and output that header plus its sequence, plus-line, and quality line.  		
*Why:* Enables in-depth examination of a single read’s sequence and quality metrics.  		**EXERCISE 16: Show only FASTQ quality-score lines**  
*Suggested command:* use `grep` with the `-A` context option		Extract every 4th line with `sed '4~4p'` to isolate quality strings. Quality-only views help in plotting score distributions or applying quality-based filters.


**EXERCISE 15: Print only the sequence lines**  		**EXERCISE 17: Count reads with ambiguous bases (N)**  
*What needs to be done:* Extract every second line (the actual nucleotide strings) from each four-line record.  		Use `grep` to find sequences containing “N”, then count unique headers with `uniq` and `wc`. Reads with ambiguous bases may require trimming or filtering to ensure data accuracy.
*Why:* Allows sequence-only analyses like motif searches or GC-content calculation without quality data.  		
*Suggested command:* use `sed`		**EXERCISE 18: Convert FASTQ to FASTA format**  

Apply `seqtk seq -A` to strip quality lines and change headers from `@` to `>`. Conversion is often needed for tools that accept only FASTA inputs.
**EXERCISE 16: Print only the quality-score lines**  		
*What needs to be done:* Extract every fourth line of the file (the quality strings).  		
*Why:* Facilitates separate quality score analysis, such as plotting score distributions or trimming low-quality regions.  		
*Suggested command:* use `sed`		

**EXERCISE 17: Count reads containing ambiguous bases (N)**  		
*What needs to be done:* Identify any reads where the sequence contains the letter “N” (ambiguous base) and count unique headers.  		
*Why:* High N counts can indicate low-quality reads or sequencing errors, guiding filtering decisions.  		
*Suggested command:* use `grep`, `uniq`, and `wc`		

**EXERCISE 18: Convert FASTQ to FASTA**  		
*What needs to be done:* Remove plus and quality lines, change headers from `@` to `>`, and output a FASTA-formatted file.  		
*Why:* Some aligners or downstream tools accept only FASTA, so conversion is essential.  		
*Suggested command:* use `seqtk`		


**EXERCISE 19: Display the last 5 reads of the FASTQ file**  		**EXERCISE 19: Display the last 5 reads of the FASTQ file**  
*What needs to be done:* Output the final five four-line records at the end of the file.  		Use `tail` to show the final five 4‑line records. Checking file tail ensures no records are truncated or missing at the end of large datasets.
*Why:* Ensures the file ends cleanly without truncated reads or dangling lines.  		
*Suggested command:* use the `tail` command		**EXERCISE 20: Show read-length distribution in FASTQ**  

Extract sequence lengths with `awk`, sort them, and count unique values with `uniq`. Verifying all reads are the expected length can highlight sequencing or trimming inconsistencies.
