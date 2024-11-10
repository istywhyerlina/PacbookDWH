import luigi
from datetime import datetime
import logging
import time
import pandas as pd
from pipeline.utils.db_conn import db_connection
from pipeline.utils.read_sql import read_sql_file
import os
from dotenv import load_dotenv

load_dotenv()

# Define DIR
DIR_ROOT_PROJECT = os.getenv("DIR_ROOT_PROJECT")
DIR_TEMP_LOG = os.getenv("DIR_TEMP_LOG")
DIR_TEMP_DATA = os.getenv("DIR_TEMP_DATA")
DIR_EXTRACT_QUERY = '/home/istywhyerlina/fp_datastorage/PacbookDWH/pipeline/src_query/extract'
DIR_LOG = os.getenv("DIR_LOG")
print(DIR_EXTRACT_QUERY)


tables_to_extract = ['public.address', 
                    'public.address_status', 
                    'public.author', 
                    'public.book', 
                    'public.book_author', 
                    'public.book_language',
                    'public.country',
                    'public.cust_order',
                    'public.customer',
                    'public.customer_address',
                    'public.order_history',
                    'public.order_line',
                    'public.order_status',
                    'public.publisher',
                    'public.shipping_method']
# Define db connection engine
src_engine, _ = db_connection()

print(src_engine)
table_name=tables_to_extract[0]
# Define the query using the SQL content
extract_query = read_sql_file(
    file_path = f'{DIR_EXTRACT_QUERY}/all-tables.sql'
)
df = pd.read_sql_query(extract_query.format(table_name = table_name), src_engine)
print(df.head())






