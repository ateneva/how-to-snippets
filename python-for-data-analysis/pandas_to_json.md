
# Export Dataframe to Files

```python
import pandas as pd
import datetime as dt

# load dataframe from dictionary
df = pd.DataFrame.from_dict(data)

# add column to a data frame
df['inserted_timestamp'] = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# remove commas from pandas dataframe
df['x']=df['x'].str.replace(',','')
    
print(f'Created dataframe {df}')

# export dataframe to json file
df.to_json(full_file_path)

# export dataframe to csv file

```

## TO JSON

```python
from pandas import DataFrame

data = {'Product': ['Desktop Computer','Tablet','iPhone','Laptop'],
        'Price': [700,250,800,1200]
        }

df = DataFrame(data, columns= ['Product', 'Price'])

print (df)
```

```python
from pandas import DataFrame

data = {'Product': ['Desktop Computer','Tablet','iPhone','Laptop'],
        'Price': [700,250,800,1200]
        }

df = DataFrame(data, columns= ['Product', 'Price'])

df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json')
```

```json
{
  "Product": {
    "0": "Desktop Computer",
    "1": "Tablet",
    "2": "iPhone",
    "3": "Laptop"
  },
  "Price": {
    "0": 700,
    "1": 250,
    "2": 800,
    "3": 1200
  }
}

```

### JSON FORMATS

- `split`
- `records`
- `index`
- `values`
- `table`
- `columns` (the default format)

- `split`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='split')
```

```json
{
  "columns": [
    "Product",
    "Price"
  ],
  "index": [
    0,
    1,
    2,
    3
  ],
  "data": [
    [
      "Desktop Computer",
      700
    ],
    [
      "Tablet",
      250
    ],
    [
      "iPhone",
      800
    ],
    [
      "Laptop",
      1200
    ]
  ]
}
```

----------------------------

- `records`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='records')
```

### can't be prettified

```json
[{"Product":"Desktop Computer","Price":700},{"Product":"Tablet","Price":250},{"Product":"iPhone","Price":800},{"Product":"Laptop","Price":1200}]
```

----------------------------

- `index`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='index')
```

```json
{
  "0": {
    "Product": "Desktop Computer",
    "Price": 700
  },
  "1": {
    "Product": "Tablet",
    "Price": 250
  },
  "2": {
    "Product": "iPhone",
    "Price": 800
  },
  "3": {
    "Product": "Laptop",
    "Price": 1200
  }
}

```

----------------------------

- `values`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='values')
```

```json
[
  [
    "Desktop Computer",
    700
  ],
  [
    "Tablet",
    250
  ],
  [
    "iPhone",
    800
  ],
  [
    "Laptop",
    1200
  ]
]
```

----------------------------

- `table`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='table')
```

```json
{
  "schema": {
    "fields": [
      {
        "name": "index",
        "type": "integer"
      },
      {
        "name": "Product",
        "type": "string"
      },
      {
        "name": "Price",
        "type": "integer"
      }
    ],
    "primaryKey": [
      "index"
    ],
    "pandas_version": "0.20.0"
  },
  "data": [
    {
      "index": 0,
      "Product": "Desktop Computer",
      "Price": 700
    },
    {
      "index": 1,
      "Product": "Tablet",
      "Price": 250
    },
    {
      "index": 2,
      "Product": "iPhone",
      "Price": 800
    },
    {
      "index": 3,
      "Product": "Laptop",
      "Price": 1200
    }
  ]
}
```

----------------------------

- `columns`

```python
df.to_json (r'/Users/angelina.teneva/Downloads/export_dataFrame.json', orient='columns')
```

```json
{
  "Product": {
    "0": "Desktop Computer",
    "1": "Tablet",
    "2": "iPhone",
    "3": "Laptop"
  },
  "Price": {
    "0": 700,
    "1": 250,
    "2": 800,
    "3": 1200
  }
}
```

## References

- <https://datatofish.com/export-pandas-dataframe-json/>
- <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_json.html>
- <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_dict.html>
- <https://www.geeksforgeeks.org/adding-new-column-to-existing-dataframe-in-pandas/>
- <https://towardsdatascience.com/how-to-add-a-new-column-to-an-existing-pandas-dataframe-310a8e7baf8f>

- <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_sql.html>
- <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_csv.html>
- <https://stackoverflow.com/questions/52781750/pandas-and-doubled-double-quote-escaping-in-csv>
