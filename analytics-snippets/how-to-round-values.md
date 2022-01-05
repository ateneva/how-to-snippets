
## How can I round numbers?

### Vertica
```sql
    SELECT
    CEILING(285.32)     as ceiling,
    FLOOR(285.82)       as floor,
    
    285.253             as number1,
    ROUND(285.253,0)    as roundless5to0,
    ROUND(285.253,1)    as roundless5to1,
    ROUND(285.253,2)    as roundless5to2,
    
    285.753             as number2,
    ROUND(285.753,0)    as roundmore5to0,
    ROUND(285.753,1)    as roundmore5to1,
    ROUND(285.753,2)    as roundmore5to2
```

### MySQL
```sql
    SELECT
    CEILING(285.32)     as ceiling,
    FLOOR(285.82)       as floor,
    
    285.253             as number1,
    ROUND(285.253,0)    as roundless5to0,
    ROUND(285.253,1)    as roundless5to1,
    ROUND(285.253,2)    as roundless5to2,
    
    285.753             as number2,
    ROUND(285.753,0)    as roundmore5to0,
    ROUND(285.753,1)    as roundmore5to1,
    ROUND(285.753,2)    as roundmore5to2
```

### PostgreSQL
```sql
    SELECT
    CEILING(285.32)     as ceiling,
    FLOOR(285.82)       as floor,
    
    285.253             as number1,
    ROUND(285.253,0)    as roundless5to0,
    ROUND(285.253,1)    as roundless5to1,
    ROUND(285.253,2)    as roundless5to2,
    
    285.753             as number2,
    ROUND(285.753,0)    as roundmore5to0,
    ROUND(285.753,1)    as roundmore5to1,
    ROUND(285.753,2)    as roundmore5to2
```

### SQL Server
```sql 
    SELECT
    CEILING(285.32)     as ceiling,
    FLOOR(285.82)       as floor,
    
    285.253             as number1,
    ROUND(285.253,0)    as roundless5to0,
    ROUND(285.253,1)    as roundless5to1,
    ROUND(285.253,2)    as roundless5to2,
    
    285.753             as number2,
    ROUND(285.753,0)    as roundmore5to0,
    ROUND(285.753,1)    as roundmore5to1,
    ROUND(285.753,2)    as roundmore5to2
```

### BigQuery

### Python

### Tableau