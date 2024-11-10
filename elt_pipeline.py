import luigi
import sentry_sdk
import pandas as pd
import os

from extract import Extract
from load import Load
from transform import Transform
from pipeline.utils.concat_dataframe import concat_dataframes
from pipeline.utils.copy_log import copy_log
from pipeline.utils.delete_temp_data import delete_temp

# Read env variables
DIR_ROOT_PROJECT = os.getenv("DIR_ROOT_PROJECT")
DIR_TEMP_LOG = os.getenv("DIR_TEMP_LOG")
DIR_TEMP_DATA = os.getenv("DIR_TEMP_DATA")
DIR_LOG = os.getenv("DIR_LOG")
SENTRY_DSN = os.getenv("SENTRY_DSN")

# # Track the error using sentry
# sentry_sdk.init(
#     dsn = f"{SENTRY_DSN}"
# )


# Execute the functions when the script is run
if __name__ == "__main__":
    # Build the task
    luigi.build([Extract(),
                 Load(),
                 Transform()])
    
    # Concat temp extract summary to final summary
    concat_dataframes(
        df1 = pd.read_csv(f'{DIR_ROOT_PROJECT}/pipeline_summary.csv'),
        df2 = pd.read_csv(f'{DIR_TEMP_DATA}/extract-summary.csv')
    )
    
    # Concat temp load summary to final summary
    concat_dataframes(
        df1 = pd.read_csv(f'{DIR_ROOT_PROJECT}/pipeline_summary.csv'),
        df2 = pd.read_csv(f'{DIR_TEMP_DATA}/load-summary.csv')
    )
    
    # Concat temp load summary to final summary
    concat_dataframes(
        df1 = pd.read_csv(f'{DIR_ROOT_PROJECT}/pipeline_summary.csv'),
        df2 = pd.read_csv(f'{DIR_TEMP_DATA}/transform-summary.csv')
    )
    

    
    # Delete temp data
    delete_temp(
        directory = f'{DIR_TEMP_DATA}'
    )
    
