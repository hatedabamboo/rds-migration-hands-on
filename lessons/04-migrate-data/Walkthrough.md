# Instructions

This is where the fun begins.

For the successful completion of this task, we require the following elements:

1. Source database — check
2. Target database — check
3. Replication instance and
4. Database migration task

## Replication instance

A replication instance is essentially an EC2 instance with a special purpose: performing the actual migration. Look for AWS DMS, select the "**Replication instances**" menu on the left, and click "**Create replication instance**". The interface and logic are very similar to the previous step when we created the RDS instance.

1. You can name the instance as you like, and leave the "**Descriptive Amazon Resource Name**" and "**Description**" empty.
2. For instance class, "**dms.t3.micro**" will suffice; we don't need a powerful machine for this.
3. Engine version: choose the latest one, as it's almost always the best solution.
4. We won't need "**High Availability**".
5. Storage: keep it at 20 GiB, as we don't have that much data.
6. Connectivity and security: all options can be left as they are, except for security groups; deselect the default group and choose the one you have already created and used for all other databases.

## Endpoints

Endpoints serve as connections to the source and target databases. We will need them in the migration process as pointers to the actual databases.

### For the source database

Select "**Create endpoint**".

For the source endpoint:

- Endpoint identifier: "*MyOnPremDatabase*" (can be the same as you called your PostgreSQL on EC2).
- Source engine: "**PostgreSQL**".
- Access to the endpoint database: "**Provide access information manually**".
- Server name: paste the address of the source instance (as it's hosted on the EC2 instance).
- Port: `5432`.
- User name: `postgres` if you didn't choose another in [**Lesson 02**](../02-setup-psql/Instructions.md).
- Password: the password you set up for your user.
- SSL: It can be set to none.
- Database name: `postgres`.

After filling all the fields, test the connection to the database using the previously created replication instance.
This is crucial for the migration!

      Important! Don't disable SSL on a production workload!

### For the target database

For the target endpoint:

- Endpoint identifier: "*MyRDSDatabase*" (or something meaningful).
- Select "**RDS DB instance**" and choose your RDS instance from [**Lesson 03**](../03-prepare-rds/Instructions.md); all the necessary fields except for the password should fill automatically.

After filling all the fields, test the connection to the database using the previously created replication instance
This is crucial for the migration!

## Database migration task

Now we're approaching the most interesting step: the actual migration.

Navigate to the "**Database migration tasks**" menu and select "**Create task**".

- Task identifier: name the task as you want, for example, "*Test migration*".
- Replication instance: select the one you've created in [**Lesson 03**](../03-prepare-rds/Instructions.md).
- Source database endpoint: choose the one we created earlier.
- Target database endpoint: likewise, select the one we've created beforehand.
- Migration type: We will need "**Migrate existing data**". Other options are: "**Migrate existing data and replicate ongoing changes**" and "**Replicate data changes only**"m which effectively create a replica of the source database.

Task settings:

- Target table preparation mode: ss we're going to populate an empty database, we will choose "**Drop tables on target**".
- LOB column settings: select "**Limited LOB mode**" and set "**Maximum LOB size**" as 32 KB.
- Task logs: turn on CloudWatch logs, as it will be handy for debugging (if needed). Turning on this option will propose to select a log severity level. We won't need anything deeper than "**Default**", so you can leave it without changes.
- Migration task startup configuration: you can either start it right after creation or manually at some time later. Choose as you see fit.
- Finally, "**Table mappings**": this section is responsible for the migration of tables, including the selection of schemas (databases) to look for, the selection of tables in those schemas to migrate, and their schema transformation if necessary. To select all the tables in all the schemas (databases), enter "**%**" as a "**Source name**" for Schema and "**Source table name**", Action: "**Include**".

With the last step, we've provided all the necessary elements for a successful migration and can finally start the migration.
