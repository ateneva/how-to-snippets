
## How can I compare values?

### Vertica
```sql
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue,
    LEAST(5.5, 8.2, -8.2)     as LowestValue
```

### MySQL
```sql
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue, 
    LEAST(5.5, 8.2, -8.2)     as LowestValue
```

### PostgreSQL
```sql
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue, 
    LEAST(5.5, 8.2, -8.2)     as LowestValue
```

### SQL Server
```sql
    SELECT
    MAX(MyValue)              as HighestValue,
    MIN(MyValue)              as LowestValue
    FROM (values (5.5), (8.2), (-8.2)) as a(MyValue)
```

### Big Query

### Python

### Tableau