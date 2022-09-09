
# https://cloud.google.com/storage/docs/reference/libraries#client-libraries-usage-python
# https://googleapis.dev/python/storage/latest/client.html
# https://cloud.google.com/storage/docs/downloading-objects#code-samples
# https://cloud.google.com/storage/docs/downloading-objects#gsutil

import os
import json
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