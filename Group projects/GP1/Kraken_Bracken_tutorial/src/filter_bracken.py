#!/usr/bin/env python3

import os
import argparse
import pandas as pd
import re

# input arguments
parser = argparse.ArgumentParser(
    description='Convert Bracken combined output to OTU and TAX tables')
parser.add_argument('--bracken_out', default='bracken/combined/abundance_species_mpa.txt', 
                    help='Bracken combined output')
parser.add_argument('--output_dir', default='meta', help='Output directory')
# parse arguments
args = parser.parse_args()

# Ensure output directory exists
os.makedirs(args.output_dir, exist_ok=True)

# Load input file
df = pd.read_csv(args.bracken_out, sep='\t')

tax_levels = ['Superkingdom', 'Kingdom', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species']

# Extract OTUs
filt_df = df[df.iloc[:, 0].str.contains(r"\|s__", na=False)].copy()

# Expand taxonomy column into its taxonomy levels
filt_df[tax_levels] = filt_df.iloc[:, 0].str.extract(
    r'(?:k__([^|]+))?'
    r'\|?(?:k__([^|]+))?'
    r'\|?(?:p__([^|]+))?'
    r'\|?(?:c__([^|]+))?'
    r'\|?(?:o__([^|]+))?'
    r'\|?(?:f__([^|]+))?'
    r'\|?(?:g__([^|]+))?'
    r'\|?(?:s__([^|]+))?'
)

# Samples' columns
samples = list(filt_df.columns[~filt_df.columns.isin(['#Classification'] + tax_levels)])

# Dict with renamed samples' columns
renamed_cols = {col: re.sub(r'_report_.*$', '', col) for col in samples}

# Create final df (merged df between OTU and TAX tables)
final_df = filt_df[tax_levels + samples].set_index(filt_df['Species'], drop=False, inplace=False)
final_df.index.name = None
final_df.rename(columns=renamed_cols, inplace=True)

print(f'Both otu.txt and taxonomy.txt are located in {args.output_dir}')

# Export taxonomy table
final_df[tax_levels].to_csv(f'{args.output_dir}/taxonomy.txt', sep="\t", index=True, na_rep="N/A")

# Export OTU table
final_df[list(set(final_df.columns) - set(tax_levels))].to_csv(f'{args.output_dir}/otu.txt', sep="\t", index=True, na_rep="N/A")
