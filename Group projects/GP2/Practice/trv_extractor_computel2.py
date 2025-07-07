#!/usr/bin/env python3

import os
import argparse
import pandas as pd
from functools import reduce
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Constants for Computel2
DEFAULT_MIN_SAMPLES = 3
DEFAULT_MIN_PERCENTAGE = 0.03
COLUMN_TYPE = "% of All Patterns"
FILE_NAME = "tel_variants.txt"


def read_from_files(main_dirs: list[str], column_type: str) -> list[pd.DataFrame]:
    """Iterate through directories and extract tel_variants.txt files for Computel2.

    Args:
        main_dirs (list[str]): List of directories to search for files.
        column_type (str): The column type to read from the files.

    Returns:
        list[pd.DataFrame]: List of DataFrames read from the files.
    """
    dfs = []
    for d in main_dirs:
        for root, _, files in os.walk(d):
            if FILE_NAME not in files:
                continue
            path = os.path.join(root, FILE_NAME)
            # skip empty files
            try:
                if os.path.getsize(path) == 0:
                    logging.warning(f"Skipping empty file {path}")
                    continue
            except OSError as e:
                logging.warning(f"Cannot access {path}: {e}")
                continue

            try:
                df = pd.read_csv(
                    path,
                    sep='\t',
                    index_col=0,
                    header=0,
                    usecols=["Pattern", column_type]
                )
            except pd.errors.EmptyDataError:
                logging.warning(f"No data in {path}, skipping.")
                continue
            except ValueError as e:
                logging.warning(f"Skipping {path} (missing columns): {e}")
                continue

            sample_name = os.path.basename(root)
            df.rename(columns={column_type: sample_name}, inplace=True)
            dfs.append(df)
    return dfs


def process_dataframes(dfs: list[pd.DataFrame], min_samples: int, min_percentage: float) -> pd.DataFrame:
    """Merge dataframes and apply filtering based on min_samples and min_percentage.

    Args:
        dfs (list[pd.DataFrame]): List of DataFrames to process.
        min_samples (int): Minimum number of samples for inclusion.
        min_percentage (float): Minimum pattern percentage for inclusion.

    Returns:
        pd.DataFrame: Processed DataFrame after filtering.
    """
    if not dfs:
        logging.warning("No data frames to process.")
        return pd.DataFrame()

    merged_df = reduce(
        lambda left, right: pd.merge(
            left, right,
            left_index=True,
            right_index=True,
            how='outer'
        ),
        dfs
    )

    filtered_df = (
        merged_df
        .drop(index=['GTTAGG', 'GGTTAG', 'GGGTTA', 'AGGGTT', 'TAGGGT'], errors='ignore')
        .fillna(0)
        .loc[lambda x: (x > min_percentage).sum(axis=1) >= min_samples]
        .assign(row_sum=lambda x: x.sum(axis=1))
        .sort_values(by='row_sum', ascending=False)
        .drop(columns='row_sum')
    )

    return filtered_df


def main(min_samples: int, min_percentage: float, column_type: str, output_file: str, dirs: list[str]):
    """Main function to orchestrate reading, processing, and saving the DataFrames.

    Args:
        min_samples (int): Minimum number of samples for inclusion.
        min_percentage (float): Minimum pattern percentage for inclusion.
        column_type (str): The column type to read from the files.
        output_file (str): Output CSV file path.
        dirs (list[str]): List of directories to search for files.
    """
    logging.info("Reading files from directories...")
    dfs = read_from_files(dirs, column_type)
    df = process_dataframes(dfs, min_samples, min_percentage)

    if not df.empty:
        df.to_csv(output_file, index=True)
        logging.info(f"DataFrame saved to {output_file}")
    else:
        logging.warning("No data to save. DataFrame is empty.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Process tel_variants.txt files from Computel2 and save the results as a CSV.'
    )
    parser.add_argument(
        '--dirs', type=str, nargs='+', required=True,
        help='List of directories to search for files.'
    )
    parser.add_argument(
        '--min_samples', type=int, default=DEFAULT_MIN_SAMPLES,
        help='Minimum number of samples for inclusion.'
    )
    parser.add_argument(
        '--min_percentage', type=float, default=DEFAULT_MIN_PERCENTAGE,
        help='Minimum pattern percentage for inclusion.'
    )
    parser.add_argument(
        '--column_type', type=str, default=COLUMN_TYPE,
        choices=["Abs Num", "% of All Patterns", "% of Variants"],
        help='Column type to read from the files.'
    )
    parser.add_argument(
        '--output_file', type=str, required=True,
        help='Output CSV file path.'
    )

    args = parser.parse_args()
    main(
        args.min_samples,
        args.min_percentage,
        args.column_type,
        args.output_file,
        args.dirs
    )

