# Instructions

Database migration requires not only a source database but also a target one. Therefore, we should create our first RDS (Relational Database Service) instance.

1. Inside the AWS web console, navigate to RDS and select "**Create database**".
2. To perform a homogeneous migration, we will need the PostgreSQL engine. The engine version can be either **15.2-R2** or **15.3-R2**.
3. In the "**Templates**" section, choose "**Free tier**" since we don't want to incur any costs for this lab.

Now, let's discuss the settings:

- **DB instance identifier:** It can be anything you like, such as *TargetDatabase*.
- **Master username:** For convenience, you can leave it as *postgres*.
- I wouldn't recommend using AWS Secrets Manager for the password, as it will incur additional costs and may complicate connecting to the target database. Therefore, create a **Master password** that you find more convenient.
- **Instance configuration:** It has already been chosen for us. "**db.t3.micro**" should be sufficient.
- Default **20 GiB of gp2** storage is okay.
- Turn off **Storage Autoscaling** since we won't need it.

Now, let's address connectivity:

- We won't need a connection to an EC2 compute resource.
- The VPC can be left as the default, especially if you haven't created a specific one for this task.
- The DB subnet group can also be left as is.
- For **Public access**, I would recommend enabling it since this is only a test scenario and there's no sensitive data involved. However, do not enable it on a production workload.
- **VPC security group:** We can use the one we already created in **[Lesson 01](../01-ec2-creation/Instructions.md)**.
- **Availability Zone:** No preference (if you have none).
- We won't need an **RDS Proxy**.
- For the **Certificate authority**, you can choose the default, but note that it has an upcoming End of Life (EOL) in August 2024.
- For Database authentication, we will use the previously created **Master password**.
- Monitoring is optional and can be turned off without any harm done to the task.

This should cover all the necessary settings. If you'd like, you can explore additional options.

    Important! Don't enable Public access and customize your Security groups accordingly to the actual needs for the production workload.

Hit that "**Create database**" button and wait for a few minutes until it's up and running.
