# Instructions

## Part 1

We have our instance set up; now it's time to configure the database and import the data. For convenient usage, let's change the PostgreSQL password:

```bash
sudo -i -u postgres psql "ALTER USER postgres PASSWORD '<your-new-password>'"
```

This command will allow you to connect to the database right after logging into the instance using `psql -U postgres -W` and entering the new password when prompted.

As this task is directed towards database migrations, we should configure our database accordingly. Find the main configuration file (it should be in `/etc/postgresql/<version>/main/postgresql.conf`) and adjust the following settings:

- Set `wal_level` setting to `logical`.
- Set `max_replication_slots` parameter to a value greater than 1; for the purpose of this lesson, set it to 10.
- Set `max_wal_senders` parameter to a value greater than 1; for the purpose of this lesson, set this parameter to 10.
- The `wal_sender_timeout` parameter ends replication connections that are inactive longer than the specified number of milliseconds. The default is 60000 milliseconds (60 seconds), which is suitable for this lesson.
- And the most important change: locate the setting `listen_addresses` and change it to `'*'` to allow external connections to the database.

Now that all the settings are configured, we need to allow external users to access our database. Find the `pg_hba.conf` file in the same directory and add the following line to the end of the file:

```text
host    all             all             0.0.0.0/0            md5
```

After editing and saving the file, restart the database server:

```bash
systemctl restart postgresql
```

and check if it's running:

```bash
systemctl status postgresql
```

## Part 2

To make our database more realistic, we will populate it with mock data. You can find the `mock_data.sql` file in the resources directory nearby. Copy it to the server and fill the database with this data. Provide your password when prompted:

```bash
cat mock_data.sql | psql -U postgres -W
```

This sql file will create the table inside the default database (`postgres` by default) and fill it with data. Upon successful execution, you should see lots of strings containing `INSERT 0 1`. To check if the data was imported correctly, use the following command:

```sql
SELECT COUNT(*) FROM mock_data;
```

The answer should be:

```sql
 count
-------
 1000
(1 row)
```

If the number of rows equals 1000, then everything is fine!

Now, for the most important part: after the migration, we need to ensure that our data is consistent. We will execute the same query both before and after migration and compare the results. The query will look like this:

```sql
SELECT first_name, last_name, email
FROM mock_data
WHERE email LIKE '%com'
AND SUBSTRING(first_name, 1, 1) = SUBSTRING(last_name, 1, 1)
ORDER BY last_name ASC, first_name ASC;
```

This query will search for people whose email addresses are within the `.com` domain zone and display only those whose first and last names start with the same letter.

After executing the query, save the results to the file:

```bash
cat test-query.sql | psql -U postgres -W > query-result.sql
```

Save file `query-result.sql` somewhere safe, where you can find it later.
