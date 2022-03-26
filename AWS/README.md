
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

### upload file to a bucket

```python
import boto3

def upload_file_to_S3(full_file_path, file_name, bucket, prefix):
    """
    Saves the csv file to S3

    Args:
        full_file_path: (str) - the temporary path where the file was saved
        file_name: (str) - the name of the file
        bucket: (str) - the S3 bucket where the file is saved
        prefix: (str) - the s3 sub-folder
    """
    s3_key = prefix + '/' + file_name
    s3 = boto3.client("s3")
    s3.upload_file(full_file_path, bucket, s3_key)
    return f'{file_name} uploaded to {bucket}/{prefix}'
```

### References
* https://towardsdatascience.com/how-to-upload-and-download-files-from-aws-s3-using-python-2022-4c9b787b15f2
