#!/bin/bash
#SBATCH --mem=40gb
#SBATCH --cpus-per-task=35
#SBATCH --output=log/computel2_no_wise_control.log
#SBATCH --job-name=computel

# A parent script to run computel2_no_wise.sh.
# Run from synthetic (where log, fq and computel2 are located)

input_dir="fq/control/*"
threads=35
output_base="computel2/control/no_wise"

./src/computel2_no_wise.sh "${input_dir}" "$threads" "$output_base" >> log/computel2_no_wise_control.log 

