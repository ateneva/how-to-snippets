
# Setting Up

You need to set up service account `json` that has sufficient permissions
https://cloud.google.com/iam/docs/creating-managing-service-accounts#iam-service-accounts-rename-python

```json
{
  "type": "service_account",
  "project_id": "api-project",
  "private_key_id": "",
  "private_key": "",
  "client_email": "app-report@api-project.iam.gserviceaccount.com",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/app-report%40api-project.iam.gserviceaccount.com"
}
```

## Using Python Cloud Storage API

```bash
pip install google-cloud-storage
```

### list buckets

```python
import os
from google.cloud import storage

key_path = "/Users/angelina.teneva/Documents/GCP/service_account.json"
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = key_path

def list_buckets():
    """Lists all buckets."""
    storage_client = storage.Client()
    buckets = storage_client.list_buckets()
    available_objects = [bucket.name for bucket in buckets]
    return available_objects
```

### list objects within a bucket
```python
import os
from google.cloud import storage

key_path = "/Users/angelina.teneva/Documents/GCP/service_account.json"
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = key_path

def list_blobs(bucket_name):
    """Lists all the blobs in the bucket."""
    storage_client = storage.Client()

    # Note: Client.list_blobs requires at least package version 1.17.0.
    blobs = storage_client.list_blobs(bucket_name)
    contents = [blob.name for blob in blobs]
    return contents
```

### download files from a bucket

```python
import os
from google.cloud import storage

key_path = "/Users/angelina.teneva/Documents/GCP/service_account.json"
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = key_path

def download_bucket_files(download_bucket_name, download_folder, download_file, file_format):

    '''
        Args:
            download_bucket_name = GCP storage bucket where the file is located
            download folder = path to where the file should be downloaded
            download_file = name of the file(s) to be downloaded
            file_format = file extension of the file(s) to be downloaded
    '''

    client = storage.Client()

    # ensure specified download folder exists
    if not os.path.exists(download_folder):
        os.makedirs(download_folder)

    # Retrieve all blobs with a prefix matching the folder
    bucket = client.get_bucket(download_bucket_name)
    print(bucket)

    blobs = list(bucket.list_blobs(prefix=download_file))

    # download files of the specified format only
    for blob in blobs:
        if blob.name.endswith(f".{file_format}"):
            destination_uri = f'{download_folder}/{blob.name}'

            blob.download_to_filename(destination_uri)

            print(f'{blob.name} downloaded successfully')
```

## Using Airflow GCS Hooks

### list objects in a bucket
```python
from airflow.contrib.hooks.gcs_hook import GoogleCloudStorageHook

def list_gcs_bucket_contents(gcs_connection, gcs_bucket):
    """list all files available in bucket"""
    gcs = GoogleCloudStorageHook(google_cloud_storage_conn_id=gcs_connection)
    blobs = gcs.list(gcs_bucket)
    return blobs
```

### download objects from a bucket
```python
from airflow.contrib.hooks.gcs_hook import GoogleCloudStorageHook

def download_files_from_gcs(gcs_connection, gcs_bucket, gcs_prefix, file_path, **context):
    """download files from last two months"""

    gcs = GoogleCloudStorageHook(google_cloud_storage_conn_id=gcs_connection)
    blobs = gcs.list(gcs_bucket, prefix=gcs_prefix, delimiter='/')
    print(f'available files: {blobs}')

    # download all identified files in temp directory
    downloads = []
    for file in blobs:
        file_object = gcs_prefix + file
        file_full_path = os.path.join(file_path, file)
        downloaded_file = gcs.download(gcs_bucket, file_object, file_full_path)
        downloads.append(downloaded_file)
    return downloads
```

NB! If you're using local airflow instance, you can just pass the json string as is in airflow credentials

If you need to add it as a connection to development and production airflow instances in `airflow-dags` repo, 
you'll need to pass it in the following format in `ssm`

```json

{
  "extra__jdbc__drv_path": "",
  "extra__jdbc__drv_clsname": "",
  "extra__google_cloud_platform__project": "api-project-875975307291",
  "extra__google_cloud_platform__key_path": "",
  "extra__google_cloud_platform__keyfile_dict": "{\"type\": \"service_account\", \"project_id\": \"api-project-875975307291\", \"private_key_id\": \"c1d5fe1b89ee0816a102d36fe7b15ba10f3f608a\", \"private_key\": \"\", \"client_email\": \"app-report@api-project.iam.gserviceaccount.com\", \"client_id\": \"\", \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\", \"token_uri\": \"https://oauth2.googleapis.com/token\", \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\", \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/app-reviews-report%40api-project.iam.gserviceaccount.com\"}",
  "extra__google_cloud_platform__scope":"https://www.googleapis.com/auth/cloud-platform"
}
```

You can do that by double json-dumping the contents of the credentials file

```python
import json

credentials ={
  "type": "service_account",
  "project_id": "api-project",
  "private_key_id": "",
  "private_key": "",
  "client_email": "app-report@api-project.iam.gserviceaccount.com",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/app-report%40api-project.iam.gserviceaccount.com"
}
read_json = json.dumps(credentials)

print(read_json)
print(type(read_json))

secure_string = json.dumps(read_json)
print(secure_string)
```


## References
* https://stackoverflow.com/questions/58840859/what-roles-are-needed-to-download-an-object-from-a-google-storage-bucket
* https://cloud.google.com/storage/docs/access-control/iam-roles
* https://stackoverflow.com/questions/25242262/dump-to-json-adds-additional-double-quotes-and-escaping-of-quotes