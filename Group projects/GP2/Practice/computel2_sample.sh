#!/bin/bash
#SBATCH --mem=40gb
#SBATCH --cpus-per-task=15
#SBATCH --output=log/computel2_sample.log
#SBATCH --job-name=computel

# A parent script to run computel2.sh.
# Above are mentioned details on allocated resources and log file location
# Below are mentioned detailed on inputs 
# NOTE!!!: Run from where log, fq and computel2 directories are located

input_dir="fq/*"
threads=15
output_base="computel2/sample_output"

./src/computel2.sh "${input_dir}" "$threads" "$output_base" >> log/computel2_no_wise_control.log 

