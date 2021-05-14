
# https://cloud.google.com/bigquery/docs/exporting-data#python

import os
import json
from google.cloud import bigquery, storage

# load your service account
key_path = "C:/Users/angelinat/Documents/GCP/service_account.json"
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = key_path


def export_to_bucket(project, dataset_id, table_id, export_bucket_name, file_format):
    '''
        Args:
            project = BigQuery project name
            dataset_id = BigQuery dataset name
            table_id = BigQuery table name
            export_bucket_name = GCP storage bucket within the specified project
            file_format = extension with twhich the exported file should be saved - e.g. csv, json
    '''

    client = bigquery.Client()
    filename_pattern = f"{table_id}_*.{file_format}"
    destination_uri = f"gs://{export_bucket_name}/{filename_pattern}"
    dataset_ref = client.dataset(dataset_id, project=project)
    table_ref = dataset_ref.table(table_id)

    print("Data Export from BigQuery to bucket has started...")
    extract_job = client.extract_table(
        table_ref,
        destination_uri,
        location="EU",    # Location must match that of the source table.
    )
    extract_job.result()  # Waits for job to complete.

    print(f"Exported {project}:{dataset_id}.{table_id} to {destination_uri}")


