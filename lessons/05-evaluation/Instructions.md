# Instructions

Remember we ran a query to get some data in [**Lesson 02**](../02-setup-psql/Instructions.md)? Yeah, me neither. Well, you'll have to find the resulting table from that query to check the success of the migration. As per aforementioned lesson, the query result has been saved to file `query-result.sql`.

Run the same query on the target database and save it to a different file:

```bash
cat test-query.sql | psql -U postgres --host <YOUR-RDS-ADDRESS> --db postgres> -W > migrated-query-result.sql 
```

The simplest way to check consistency would be to compare the number of rows in both result sets.

Here are some more ways to compare both results:

```bash
diff query-result.sql migrated-query-result.sql
```

```bash
md5sum query-result.sql migrated-query-result.sql
```

In the resources directory nearby I will provide both examples, so you can verify if your data is correct, and everything went smoothly.
