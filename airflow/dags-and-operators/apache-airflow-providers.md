
## GCP operators

### BigQueryExecuteQueryOperator

```python
execute_query = BigQueryExecuteQueryOperator(
    task_id="execute_query_save",
    sql="SELECT * FROM MY_DATASET.TABLE_IN",
    use_legacy_sql=False,
    destination_dataset_table="MY_DATASET.TABLE_OUT"
)
```


## References 
* https://airflow.apache.org/docs/apache-airflow-providers-google/stable/index.html
* https://registry.astronomer.io/providers/google/modules/bigqueryexecutequeryoperator