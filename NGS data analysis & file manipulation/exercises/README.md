<!-- Introduction -->

This set of exercises will help you become comfortable with basic command‑line operations on FASTA and FASTQ files. You'll practice viewing, searching, counting, and manipulating sequence data using standard Unix tools like `grep`, `awk`, and `sed`, as well as common bioinformatics utilities.

## FASTA Practice Exercises

**EXERCISE 1: Display the first 10 reads of the FASTA file**  
*What needs to be done:* Show the first 10 sequence entries (header + sequence).  
*Why:* Quickly inspect your file’s format and content.  
*Suggested command:* use the `head` command

**EXERCISE 2: Count the total number of reads in the FASTA file**  
*What needs to be done:* Count how many sequence records (headers) there are.  
*Why:* Determine dataset size before analysis.  
*Suggested command:* use `grep -c`

**EXERCISE 3: Find reads containing the motif "GATTACA" and list their IDs**  
*What needs to be done:* Search sequence lines for "GATTACA" and print the preceding header.  
*Why:* Locate reads with a primer, restriction site, or other feature.  
*Suggested command:* use `grep` with the `-B` context option

**EXERCISE 4: Extract the record for a specific read (e.g. read42)**  
*What needs to be done:* Pull header and sequence for `read42`.  
*Why:* Examine an individual read of interest.  
*Suggested command:* use `grep` with the `-A` context option

**EXERCISE 5: Print only the sequence lines**  
*What needs to be done:* Remove all headers, leaving only DNA strings.  
*Why:* Feed pure sequence into downstream tools (e.g., k-mer counters).  
*Suggested command:* use `grep -v`

**EXERCISE 6: Print only the header lines**  
*What needs to be done:* List every read name (no sequences).  
*Why:* Get a quick inventory of identifiers.  
*Suggested command:* use `grep`

**EXERCISE 7: Count total nucleotides across all reads**  
*What needs to be done:* Sum the length of every sequence.  
*Why:* Compute total bases sequenced for coverage estimates.  
*Suggested command:* use `grep`, `tr`, and `wc`

**EXERCISE 8: Sort read headers alphabetically**  
*What needs to be done:* Order the list of read IDs.  
*Why:* Facilitate comparisons or prepare for set operations.  
*Suggested command:* use `grep` piped to `sort`

**EXERCISE 9: Reformat sequences to wrap at 50 chars/line**  
*What needs to be done:* Break long sequence lines for readability or tool compatibility.  
*Why:* Some tools require fixed‐width lines.  
*Suggested command:* use `awk`

**EXERCISE 10: Show the length of each read**  
*What needs to be done:* Print header plus its sequence length.  
*Why:* Confirm uniform read length or identify outliers.  
*Suggested command:* use `awk`

---

## FASTQ Practice Exercises

**EXERCISE 11: Display the first 10 reads of the FASTQ file**  
*What needs to be done:* Show the first 10 records (4 lines each).  
*Why:* Inspect both sequence and quality formatting.  
*Suggested command:* use the `head` command

**EXERCISE 12: Count the total number of reads in the FASTQ file**  
*What needs to be done:* Divide total lines by four.  
*Why:* Quickly get dataset size.  
*Suggested command:* use `wc -l` piped to `awk`

**EXERCISE 13: Find reads containing the motif "GATTACA" and list their IDs**  
*What needs to be done:* Search sequence lines for "GATTACA" and print the header.  
*Why:* Detect reads carrying a given feature.  
*Suggested command:* use `grep` with the `-B` context option

**EXERCISE 14: Extract the record for a specific read (e.g. read42)**  
*What needs to be done:* Pull the 4-line record starting at `@read42`.  
*Why:* Examine sequence and quality for one read.  
*Suggested command:* use `grep` with the `-A` context option

**EXERCISE 15: Print only the sequence lines**  
*What needs to be done:* Extract every 2nd line of each 4-line record.  
*Why:* Obtain raw sequences for sequence-only tools.  
*Suggested command:* use `sed`

**EXERCISE 16: Print only the quality-score lines**  
*What needs to be done:* Extract every 4th line of each record.  
*Why:* Analyze quality distribution separately.  
*Suggested command:* use `sed`

**EXERCISE 17: Count reads containing ambiguous bases (N)**  
*What needs to be done:* Find records whose sequence includes "N" and count them.  
*Why:* Assess overall data quality/content.  
*Suggested command:* use `grep`, `uniq`, and `wc`

**EXERCISE 18: Convert FASTQ to FASTA**  
*What needs to be done:* Strip quality lines and change “@” to “>”.  
*Why:* Some pipelines require FASTA input.  
*Suggested command:* use `seqtk`

**EXERCISE 19: Display the last 5 reads of the FASTQ file**  
*What needs to be done:* Show the final 5 records.  
*Why:* Verify proper file termination or inspect tail reads.  
*Suggested command:* use the `tail` command

**EXERCISE 20: Show read-length distribution**  
*What needs to be done:* Print length of each sequence line, then tally.  
*Why:* Confirm uniform read length or find variants.  
*Suggested command:* use `awk`, `sort`, and `uniq`

---

## Answers

```bash
# FASTA
1. head -n 20 sample_100_150.fasta
2. grep -c "^>" sample_100_150.fasta
3. grep -B1 "GATTACA" sample_100_150.fasta | grep "^>"
4. grep -A1 "^>read42" sample_100_150.fasta
5. grep -v "^>" sample_100_150.fasta
6. grep "^>" sample_100_150.fasta
7. grep -v "^>" sample_100_150.fasta | tr -d '\n' | wc -c
8. grep "^>" sample_100_150.fasta | sort
9. awk '/^>/{print;getline seq;for(i=1;i<=length(seq);i+=50)print substr(seq,i,50)}' sample_100_150.fasta > reformatted.fasta
10. awk '/^>/{header=$0;next}{print header, length($0)}' sample_100_150.fasta

# FASTQ
11. head -n 40 sample_100.fastq
12. wc -l sample_100.fastq | awk '{print $1/4}'
13. grep -B1 "GATTACA" sample_100.fastq | grep "^@"
14. grep -A3 "^@read42" sample_100.fastq
15. sed -n '2~4p' sample_100.fastq
16. sed -n '4~4p' sample_100.fastq
17. grep -B1 "N" sample_100.fastq | grep "^@" | uniq | wc -l
18. seqtk seq -A sample_100.fastq > sample_100_converted.fasta
19. tail -n 20 sample_100.fastq
20. awk 'NR%4==2{print length($0)}' sample_100.fastq | sort | uniq -c
````

```
```

