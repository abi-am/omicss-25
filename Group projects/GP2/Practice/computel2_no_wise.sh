#!/usr/bin/env bash

# OMICSS-25 
# A DAUGHTER SCRIPT TO RUN COMPUTEL FOR TRVs
# 
# Required:
#  -1, --fastq       Path to input FASTQ (gzipped)
#  -2, --proc        Number of processors/threads to use
#  -3, --outdir      Output directory for Computel results
#      --verbose     Turn on verbose mode for detailed logging
#
# Usage: ./computel2.sh <FASTQ> <PROC> <OUTDIR>


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

# Run Computel2 with verbose to get detailed outputs
echo "Running Computel2 --verbose..."
computel -fq "$FASTQ" \
         -proc "$PROC" \
         -o "$OUTDIR" \
         --verbose

echo "Computel2 run complete. Results available in $OUTDIR"


