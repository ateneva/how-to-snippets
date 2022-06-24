
# 📚 Schema Design: Normalization vs. De-normalization

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954540013_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954594359_image.png)


De-normalizing is a strategy of allowing duplicate field values for a column in a table in the data to gain processing performance.

De-normalization is another increase in the orderliness of data. 

🌀 Data is repeated rather than being relational, flattened data takes more storage. But the flattened non-relational organization makes queries more efficient because they can be processed in parallel using columnar processing.

🆙 Specifically, de-normalizing data enables BigQuery to more efficiently distribute processing among slots. Resulting in more parallel processing and better query performance.

You would usually de-normalized data before loading it into BigQuery. However, there are cases where de-normalizing data is bad for performance. 

⚠️ Specifically, if you have to group by a column with a one too many relationships. 


In this example shown, OrderID is such a column.

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954636147_image.png)


In this example, to group the data, it must be shuffled. 
That often happens by transferring the data over a network between servers or systems. 

Shuffling is slow, fortunately BigQuery supports a method to improve the situation. 

BigQuery supports columns with nested and repeated data.


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954658800_image.png)


For this reason, nested and repeated fields is useful for working with data that originates in relational databases. 

In this example shown, OrderID is such a column.

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954636147_image.png)


In this example, to group the data, it must be shuffled. That often happens by transferring the data over a network between servers or systems. 

Shuffling is slow, fortunately BigQuery supports a method to improve the situation. 

BigQuery supports columns with nested and repeated data.


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611954658800_image.png)


For this reason, nested and repeated fields is useful for working with data that originates in relational databases. 


**Nested columns can be understood as a form of repeated field.** 

✅ It preserves the relationalism of the original data and the schema, 

        while enabling columnar and parallel processing of the repeated nested fields.

 ❇️ It's the best alternative for data that already has a relational pattern to it.


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611955960076_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611955978843_image.png)


🆘 For relational schemas, often the most intensive computational workloads are JOINs across very large tables. 
Remember, RDBMS systems are record based so they have to open each record entirely, and pull out the JOIN key from each table where a match exists. 🧐

And that's assuming you know all the tables and need to be joined together. 
Imagine for each new piece of information about an order like promotion codes are user information,
and you could be talking about a ten plus table JOIN   😭 




⚠️ The alternative has different drawbacks, pre-joining all your tables into one massive table makes reading data faster, but now you have to be really careful if you have data at different levels of granularity.


### 📌 ARRAYS and STRUCTS
![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611956312085_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611956338519_image.png)


Here you see it clearly, shown here are the screen are just four rows for four unique order IDs, notice all the gray space in between the rows, that's because the event status in event time is at a deeper level of granularity 

That means there are multiple repeated values for these events per each order, 

### an array is a
✳️ perfect data type to handle this repeated value and keep all the benefits of storing that data in a single row
![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611956369350_image.png)


Event pick up and destination are what are **called struct or structure type data fields in SQL**. 
This isn't BigQuery specific, structs are standard SQL and BigQuery just supports them really well.

🆎 **Structs you can think of as pre-join tables within a table.** 

💡 So instead of having a separate table **for events and pick up and destination**, 
you simply nest them together within your main table. 

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611956397704_image.png)


‼️ You can go deep into a single field and have it be more granular than the rest of your data by using an array data type, like you see here for status and time. 

🆑 And you can have a **really wide schemas by using struts, which allow you to have multiple fields** of the same or different data types within them, much like a separate table would

❇️ The major benefits of structs is that the data **is conceptually pre-joined already, so it's much faster to query.** 

People often ask, with really wide scheme has like 100 columns, how is it still so fast to query? Remember the BigQuery is column based storage not record based. 

If you did just a count order ID here to get your total order as BigQuery wouldn't even care that you have 99 other columns. 

    - Some of which are more granular with array and data types, it won't even look at them.


✅ That's what gives you the best of both worlds, lots of data all in one place and no issues with multiple granularity pitfalls when doing aggregations.

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611957087730_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611957103426_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611957121274_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611957137636_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611957171377_image.png)


⚠️ Arrays can be of any **single type like an array of floats or an array of strings.** 
Arrays can be part of a regular field or be part of a nested field, nested inside of a struct💡 

* **STRUCTS** are unpacked with **CROSS JOIN**

* **ARRAYS** are unpacked with **CROSS JOIN UNNEST()**

A single table can have zero to many struts and lastly, the real minds bending point is that 
**a struts can have other struts nested inside of it**

✅ use arrays and struts when your data naturally arrives in that format, 
and you'll benefit immediately from optimal performance.

