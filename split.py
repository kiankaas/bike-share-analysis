# This python code splits files larger than 1000MB into two separate files

import pandas as pd
import os

# List of paths to the large CSV files
large_files = [
    '202305-divvy-tripdata.csv',
    '202306-divvy-tripdata.csv',
    '202307-divvy-tripdata.csv',
    '202308-divvy-tripdata.csv',
    '202309-divvy-tripdata.csv',
    '202310-divvy-tripdata.csv'
]

# Number of rows per file
rows_per_file = 400000  

for file in large_files:
    # Extract the base name of the file to use in output file names
    base_name = file.rsplit('.', 1)[0]

    # Read the large CSV file in chunks
    for i, chunk in enumerate(pd.read_csv(file, chunksize=rows_per_file)):
        output_file = f'{base_name}_p{i+1}.csv'
        chunk.to_csv(output_file, index=False)
        print(f'Saved {output_file}')

    # Delete the original file after processing
    os.remove(file)
    print(f'Deleted original file: {file}')

