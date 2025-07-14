#!/bin/bash
#SBATCH --job-name="kraken"
#SBATCH --output=log/%x.log
#SBATCH --mem=300GB
#SBATCH --cpus-per-task=64
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=youremail.com 

# The parameters above are the SLURM parameters. You just need to change the last one and write your emails.

# These are the inputs for the script. You need to type in the kraken database path (you can check how it looks like in the path that we have provided, but do not change anything:)),the output directory wherethe report and output files (these are kraken outputs) are going to be stored for each fastq file, the reports and outputs subdirectories that will contain the report and output files respectively, and the fastq directory where your trimmed (we have already trimmed the fastq files) fastq files are stored.

kraken_db="/mnt/kraken_db/k2_standard_20231009/"
out_dir="kraken"
report_dir="$out_dir/reports"
output_dir="$out_dir/outputs"
fq_dir="fastq_trimmed"

# This part checks if the output directory with its two subdirectories (reports and outputs) exists, if not, creates it. If it exists, it gives a warning as the contents of the files may be overwritten if it is not empty.

if [ ! -d $out_dir ]; then
    echo "Creating kraken output directory $out_dir"
    mkdir -p $report_dir
    mkdir -p $output_dir
    wait
else
    echo "WARNING: The output directory $out_dir already exists. Its content may be overwritten."
    mkdir -p $report_dir
    mkdir -p $output_dir
fi

echo ""

# This part loops over all the fastq files and runs the kraken2 tool on all of them. The parameters for the tool are 1.the kraken database path (which we have already defined above), the confidence score (it reflects how confident Kraken is that a sequence belongs to a specific taxon, based on the proportion of k-mers (substrings of length k)) that you should just leave at 0.1, the use-names (an option that outputs the taxonomic names instead of taxonomic IDs in the classification results) that you should not change as well, gzip-compressed just speciefies that the input fastq files are gzipped, and the report and output files are the outputs that we want to get after running the script.

for f in $fq_dir/*.fq.gz
do
    filename=$(basename "$f")
    fname="${filename%.fq.gz}" 
    echo ""
    echo "$fname: classifying"
    kraken2 \
      --db $kraken_db \
      --confidence 0.1 \
      --use-names \
      --gzip-compressed \
      --report $report_dir/${fname}_report.txt \
      --output $output_dir/${fname}_output.txt \
      $f
done

