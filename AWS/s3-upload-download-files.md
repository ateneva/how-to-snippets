
# HOW TO: 

### download file from s3 bucket

```python
import boto3


# Create an S3 access object
s3 = boto3.client("s3")
s3.download_file(
    Bucket="sample-bucket", 
    Key="train.csv", 
    Filename="data/downloaded_from_s3.csv"
)
```

### upload files to a bucket

```python
import boto3
import logging

def upload_file_to_S3(full_file_path, file_names, bucket, prefix):
    """
    Saves the csv file to S3

    Args:
        full_file_path: (str) - the temporary path where the file was saved
        file_name: (list) - a list of strings with the file namea of the file
        bucket: (str) - the S3 bucket where the file is saved
        prefix: (str) - the s3 sub-folder
    """
    uploaded = []
    for file_name in file_names:
        s3_key = prefix + '/' + file_name
        s3 = boto3.client("s3")
        s3.upload_file(full_file_path, bucket, s3_key)
        logging.info(f'{file_name} uploaded to {bucket}/{prefix}')
        uploaded.append(file_name)
    return uploaded
```



### copy files from S3 to Redshift (airflow hook)

```python
import logging
import psycopg2

def copy_files_to_redshift(landing_table, s3_path, file_names,
                           iam_role, copy_options, **context):
    """copies a selection of multiple files to redshift
    Args: 
        file names: a list of files that need to be copied
    """

    conn = psycopg2.connect(
        host="host_name",
        port=5439,
        database="db_name",
        user="user_name",
        password="pass_string"
)
    with conn.cursor() as cursor:
        for file in sorted(file_names):
            options = '\n\t\t\t'.join(copy_options)
            copy_query = f"COPY {landing_table} " \
                         f"FROM 's3://{s3_path}/{file}' " \
                         f"IAM_ROLE '{iam_role}' " \
                         f"{options}"
    
            cursor.execute(copy_query)
            logging.info(f'COPY of {file} complete...')
```

### References
* https://towardsdatascience.com/how-to-upload-and-download-files-from-aws-s3-using-python-2022-4c9b787b15f2
