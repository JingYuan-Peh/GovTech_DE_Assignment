# import necesssary lib

import schedule
import time
import math
import pandas as pd
import numpy as np
import os

import warnings
warnings.filterwarnings('ignore')

# function to read files into dataframes
def read_rawfiles_into_df(path, filename):
    filepath = os.path.join(path, filename)
    df = pd.read_csv(filepath)
    return df

# function to write file into csv
def write_df_to_csv(path, filename, df):
    filepath = os.path.join(path, filename)
    df.to_csv(filepath, index=False)

# Processing tasks:
# 
# - Split the name field into first_name, and last_name
# - Remove any zeros prepended to the price field
# - Delete any rows which do not have a name
# - Create a new field named above_100, which is true if the price is strictly greater than 100

# function to process dataframe to delete any rows which do not have a name
def drop_missing_names(df):
    df.dropna(subset=['name'], inplace=True)

# function to process dataframe to split the name field into first_name, and last_name
def split_names(df):
    
    # define a list of salutations
    salutation_list = ['Mr. ', 'Mrs. ', 'Ms. ', 'Miss ', 'Dr. ']
    
    # remove salutations from the name
    df['name_without_salutation'] = df['name'].replace(salutation_list, '', regex=True)
    
    # split cleaned name into first_name and last_name
    df[['first_name', 'last_name']] = df['name_without_salutation'].str.split(' ', 1, expand = True)
    
    # drop temp columns
    df.drop(columns=['name_without_salutation','name'], inplace=True)


# function to process dataframe to remove any zeros prepended to the price field
def remove_prepended_zeroes(df):
    
    # convert price column from int datatype to str type
    df['price'] = df['price'].astype(str)
    
    # drop all prices that cannot be convert to numeric (may be due to data entry errors)
    df = df[pd.to_numeric(df['price'], errors='coerce').notnull()]
    
    # remove appending zeroes but not for prices that are less than 1
    # We should not remove zeroes from prices less than 1 because it is valid
    df[['firsthalf_price', 'secondhalf_price']] = df['price'].str.split('.', 1, expand = True)
    df['firsthalf_price'] = df['firsthalf_price'].apply(lambda x: x.lstrip('0'))
    # if firsthalf_price is empty, means it is less than 1, and should append a zero infront of the decimal point
    df['firsthalf_price'].replace('', 0, inplace=True)
    df['price_cleaned'] = df['firsthalf_price'].astype(str) + '.' + df['secondhalf_price'].astype(str)
    df['price'] = pd.to_numeric(df['price_cleaned'])
    
    # drop temp columns
    df.drop(columns=['firsthalf_price','secondhalf_price','price_cleaned'], inplace=True)
    df = df[['first_name', 'last_name', 'price']]
    
    return df

# function to process dataframe to create a new field named above_100, which is true if the price is strictly greater than 100
def create_above_100(df):
    df['above_100'] = df['price'].apply(lambda x: 1 if x > 100 else 0)

# Pipeline to load and process data
def run_pipeline():
    print('test')
    df1 = read_rawfiles_into_df('data','dataset1.csv')
    df2 = read_rawfiles_into_df('data','dataset2.csv')
    drop_missing_names(df1)
    drop_missing_names(df2)
    split_names(df1)
    split_names(df2)
    df1 = remove_prepended_zeroes(df1)
    df2 = remove_prepended_zeroes(df2)
    create_above_100(df1)
    create_above_100(df2)
    write_df_to_csv('data/Section_5_Processed_Data','dataset1_processed.csv', df1)
    write_df_to_csv('data/Section_5_Processed_Data','dataset2_processed.csv', df2)

# Create a scheduler to run this code at 1am everyday
schedule.every().day.at("01:00").do(run_pipeline)
while True:
    schedule.run_pending()
    time.sleep(1)