import pandas as pd
from pandas_profiling import ProfileReport
# read the file
df = pd.read_csv('asteroid-dataset.csv')

# simplified report will be generated with less information than the full one
prof = ProfileReport(df, minimal=True)
prof.to_file(output_file='output.html')

low_memory=False