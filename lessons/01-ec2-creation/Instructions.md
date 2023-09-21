# Instructions

We will need to create an EC2 instance to host our on-premise database. We will choose the simplest option.

Open the AWS Web Console, search for the EC2 service, and select "**Launch instance**".

Set the name as you like (e.g., *MyOnPremDatabase*).

For the operating system, choose "**Ubuntu Server 22.04 LTS, SSD Volume Type**" (it should have a "**Free tier eligible**" label next to the title).

For the instance type, select "**t2.micro**".

Furthermore, I recommend creating a key pair for our task. You can name it whatever you like (e.g., *OnPremKey*).

Next, we're going to set up the network connection.

To ensure proper functionality of our instance and its hosted database, we need to allow access to it through the security group. In the "**Network settings**" section, click the "**Edit**" button.

VPC and subnet can be left as default values.

Set "**Auto-assign public IP**" to "**Enable**". Then, create a new security group with the following rules:

- SSH / TCP / 22 / Anywhere / 0.0.0.0/0 / SSH access
- PostgreSQL / TCP / 5432 / Anywhere / 0.0.0.0/0 / Database access

These rules will not only allow access to the instance itself but also enable direct database connections, which will be important in the future.

    Important! Do not allow access to ports 22 or 5432 from everywhere in a production environment.
    This example is for practice and development purposes and is very insecure.

For our database, 8 GiB of gp2 storage should be sufficient.

Finally, we need to configure our database itself.

You can choose one of two methods: either install it manually or use "**User data**" during instance creation to prepare it for you during the setup process. In either case, you can use the script [`user-data.sh`](./resources/user-data.sh), located in the resources directory.
