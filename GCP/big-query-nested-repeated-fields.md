# Querying a Bitcoin dataset in BigQuery with nested and repeated columns

[BQ nested and repeated columns](https://cloud.google.com/bigquery/docs/nested-repeated) 
allow you to achieve the performance benefits of denormalization while retaining the structure of the data.

To illustrate, consider [this query](https://console.cloud.google.com/bigquery?sq=663413318684:7240566ccfa946268400e57a3de6d2c1) against a Bitcoin dataset. The query joins the blocks and transactions tables to find the max transaction ID for each block.

```sql
SELECT 
  block_id, 
  MAX(i.input_sequence_number) AS max_seq_number,
  COUNT(t.transaction_id) as num_transactions_in_block
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  JOIN `cloud-training-demos.bitcoin_blockchain.transactions` AS t USING(block_id)
  , t.inputs as i 
GROUP BY block_id;
```
Run the query. Under Execution details, note the slot time consumed and bytes shuffled.


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611958413933_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611958430208_image.png)

**Most of the work was done by the JOIN operation**

Now let's run the same query using nested and repeated fields. 
It turns out that the `bitcoin_blockchain` table already includes the transactions for each block 
as a nested and repeated column. 
This query gives exactly the same results, but involves only one table:


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611958495874_image.png)


```sql
SELECT 
  block_id, 
  MAX(i.input_sequence_number) AS max_seq_number,
  COUNT(t.transaction_id) as num_transactions_in_block
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  , b.transactions AS t
  , t.inputs as i
GROUP BY block_id;
```

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611958544950_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611958608277_image.png)


Note that the total amount of data ingested is much smaller. 
The slot time consumed is minutes rather than hours, 
and there are many fewer bytes shuffled because no join was necessary. 


**Although both queries are small and complete in about the same time,** 
the reduction in slot time and data ingest will become increasingly noticeable with larger datasets.

### 📌 QUERYING ARRAYS and STRUCTS

```sql
--UNPACK STRUCTS with (implicit) CROSS JOIN

SELECT 
  block_id, 
  MAX(i.input_sequence_number) AS max_seq_number,
  COUNT(t.transaction_id) as num_transactions_in_block
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  , b.transactions AS t
  , t.inputs as i
GROUP BY block_id;
```

```sql
--UNPACK ARRAYS with (implicit) CROSS JOIN UNNEST()

SELECT
  block_id, 
  TIMESTAMP_MILLIS(timestamp) AS timestamp,
  t.transaction_id,
  t_outputs.output_satoshis AS satoshi_value,
  t_outputs.output_satoshis * 0.00000001 AS btc_value
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  , b.transactions AS t 
  , t.inputs as i
  , UNNEST(t.outputs) AS t_outputs
ORDER BY btc_value DESC
LIMIT 10;
```
