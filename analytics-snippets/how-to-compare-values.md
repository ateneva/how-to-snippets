
## How can I compare values?

### Vertica
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue,
    LEAST(5.5, 8.2, -8.2)     as LowestValue

### MySQL
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue, 
    LEAST(5.5, 8.2, -8.2)     as LowestValue

### PostgreSQL
    SELECT
    GREATEST(5.5, 8.2, -8.2)  as HighestValue, 
    LEAST(5.5, 8.2, -8.2)     as LowestValue


### SQL Server
    SELECT
    MAX(MyValue)              as HighestValue,
    MIN(MyValue)              as LowestValue
    FROM (values (5.5), (8.2), (-8.2)) as a(MyValue)

### Big Query

### Python

### Tableau