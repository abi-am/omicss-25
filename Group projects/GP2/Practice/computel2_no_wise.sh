#!/usr/bin/env bash

# A DAUGHTER SCRIPT TO RUN COMPUTEL (NO WISE)
#
# Required:
#  -1, --fastq       Path to input FASTQ (can be gzipped)
#  -2, --proc        Number of processors/threads to use
#  -3, --outdir      Output directory for Computel results
#      --verbose     Turn on verbose mode
#
# Usage: ./computel2_no_wise.sh <FASTQ> <PROC> <OUTDIR>


# Check for exactly four arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <FASTQ> <PROC> <OUTDIR>"
  exit 1
fi

# Assign positional parameters
FASTQ="$1"
PROC="$2"
OUTDIR="$3"

# Echo parameters
echo "FASTQ files:       $FASTQ"
echo "Processors:        $PROC"
echo "Output directory:  $OUTDIR"

# Create output directory
mkdir -p "$OUTDIR"

# Run Computel2 with WisecondorX and verbose
echo "Running Computel2 (no wise) --verbose..."
computel -fq "$FASTQ" \
         -proc "$PROC" \
         -o "$OUTDIR" \
         --verbose

echo "Computel2 run complete. Results available in $OUTDIR"


