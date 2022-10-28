# SET up `psql` tool [on mac](https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)

```bash
brew doctor             # check if brew is already on your system
brew update             # update brew
brew install libpq      # install pgql

# symlink psql (and other libpq tools) into /usr/local/bin
brew link --force  --overwrite libpq

psql --version          # check if installed
```

* launch `psql`

```bash
psql
```

If you're getting this error: 

```
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: No such file or directory
        Is the server running locally and accepting connections on that socket?
```

check if postgresql is running with `pgrep -l postgres`

If you get no output, that means it's not running. 
Running command below should fix it: 

```bash
brew services start postgresql
pgrep -l postgres
```

[You should then be able to run terminal with](https://www.reddit.com/r/PostgreSQL/comments/s0f6f3/error_when_running_psql/)

```bash
psql postgres
```

## [list available databases](https://www.postgresqltutorial.com/postgresql-administration/postgresql-show-databases/) 

```bash
postgres=# \l
```

```sql
SELECT datname FROM pg_database;
```

## [List available sql server users](https://www.postgresqltutorial.com/postgresql-administration/postgresql-list-users/)

```bash
postgres=# \du
```

or

```sql
SELECT usename AS role_name,
  CASE 
     WHEN usesuper AND usecreatedb 
     THEN CAST('superuser, create database' AS pg_catalog.text)
     
     WHEN usesuper 
     THEN CAST('superuser' AS pg_catalog.text)
     
     WHEN usecreatedb 
     THEN CAST('create database' AS pg_catalog.text)
     
     ELSE CAST('' AS pg_catalog.text)
  END role_attributes
FROM pg_catalog.pg_user
ORDER BY role_name desc;
```