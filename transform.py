import luigi
import logging
import pandas as pd
import time
import subprocess as sp
from datetime import datetime
from extract import Extract
from load import Load
from pipeline.utils.delete_temp_data import delete_temp
import os

# Define DIR
# DIR_ROOT_PROJECT = '/home/istywhyerlina/fp_datastorage/PacbookDWH/'
# DIR_TEMP_LOG = '/home/istywhyerlina/fp_datastorage/PacbookDWH/log/'
# DIR_TEMP_DATA = '/home/istywhyerlina/fp_datastorage/PacbookDWH/pipeline/temp/data'
# DIR_DBT_TRANSFORM = '/home/istywhyerlina/fp_datastorage/PacbookDWH/pacbook_transform'
# DIR_LOG = '/home/istywhyerlina/fp_datastorage/PacbookDWH/log'

DIR_ROOT_PROJECT =os.getenv("DIR_ROOT_PROJECT")
DIR_TEMP_LOG = os.getenv("DIR_TEMP_LOG")
DIR_TEMP_DATA = os.getenv("DIR_TEMP_DATA")
DIR_DBT_TRANSFORM = os.getenv("DIR_DBT_TRANSFORM")
DIR_LOG =os.getenv("DIR_LOG")

class Transform(luigi.Task):
    
    def requires(self):
        return Load()
    
    def run(self):
        
        #----------------------------------------------------------------------------------------------------------------------------------------
        # Record start time for transform tables
        start_time = time.time()
        logging.info("==================================STARTING TRANSFROM DATA=======================================")  
               
        # Transform to dimensions tables
        try:
            with open (file = f'{DIR_TEMP_LOG}/logs.log', mode = 'a') as f :
                sp.run(
                    f"cd {DIR_DBT_TRANSFORM} && dbt deps && dbt build && dbt snapshot",
                    stdout = f,
                    stderr = sp.PIPE,
                    text = True,
                    shell = True,
                    check = True
                )
        
            # Record end time for loading tables
            end_time = time.time()  
            execution_time = end_time - start_time  # Calculate execution time
            
            # Get summary
            summary_data = {
                'timestamp': [datetime.now()],
                'task': ['Transform'],
                'status' : ['Success'],
                'execution_time': [execution_time]
            }

            # Get summary dataframes
            summary = pd.DataFrame(summary_data)
            
            # Write Summary to CSV
            summary.to_csv(f"{DIR_TEMP_DATA}/transform-summary.csv", index = False)

            
        except Exception:
            logging.error(f"Transform to All Dimensions and Fact Tables - FAILED")
        
            # Get summary
            summary_data = {
                'timestamp': [datetime.now()],
                'task': ['Transform'],
                'status' : ['Failed'],
                'execution_time': [0]
            }

            # Get summary dataframes
            summary = pd.DataFrame(summary_data)
            
            # Write Summary to CSV
            summary.to_csv(f"{DIR_TEMP_DATA}/transform-summary.csv", index = False)
            
            logging.error("Transform Tables - FAILED")
            raise Exception('Failed Transforming Tables')   
        
        logging.info("==================================ENDING TRANSFROM DATA=======================================") 

    #----------------------------------------------------------------------------------------------------------------------------------------
    def output(self):
        return [luigi.LocalTarget(f'{DIR_TEMP_LOG}/logs.log'),
                luigi.LocalTarget(f'{DIR_TEMP_DATA}/transform-summary.csv')]

if __name__ == "__main__":
    # Build the task
    luigi.build([Extract(),
                 Load(),
                 Transform()])
        # Delete temp data
    delete_temp(
        directory = f'{DIR_TEMP_DATA}'
    )
    
        