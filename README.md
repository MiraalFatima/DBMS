

# MySQL Project README

## Project Overview
This project involves working with a MySQL database. The provided schema needs to be set up and queries run to achieve desired outputs.

## Prerequisites
- MySQL Server (download from [MySQL official website](https://dev.mysql.com/downloads/installer/))
- MySQL Workbench (optional but recommended for easier management and query execution)

## Installation Instructions

### Step 1: Download and Install MySQL Server
1. Go to the [MySQL official download page](https://dev.mysql.com/downloads/installer/).
2. Download the MySQL Installer for Windows.
3. Run the installer and follow the installation instructions.
    - Select the "Server Only" option during installation.
    - Choose the default server configuration or customize it according to your requirements.
    - Set a strong root password and remember it as you will need it later.

### Step 2: Configure MySQL Server
1. After installation, open MySQL Workbench.
2. Click on `+` to add a new connection.
3. Set the connection name (e.g., "MySQL Localhost").
4. Enter the hostname (`localhost`) and the port (`3306` by default).
5. Enter the username (`root`) and the password you set during installation.
6. Test the connection to ensure everything is set up correctly, then click "OK".

### Step 3: Set Up the Database
1. Open MySQL Workbench and connect to your MySQL server.
2. Click on the `SQL` button to open a new query tab.
3. Copy the provided schema (see below) and paste it into the query editor.
4. Run the query to create and populate the database.

### Provided Schema
```sql
-- Sample schema provided
CREATE DATABASE my_database;

USE my_database;

CREATE TABLE my_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO my_table (name) VALUES ('Sample Name 1'), ('Sample Name 2');
```

## Running Queries
1. Open MySQL Workbench and connect to your database.
2. Click on the `SQL` button to open a new query tab.
3. Write or paste the query you need to run.
4. Execute the query by clicking on the lightning bolt icon or pressing `Ctrl+Enter`.

## Example Query
```sql
SELECT * FROM my_table;
```

## Output
After running the queries, you should see the expected output in the result grid below the query editor.

## Troubleshooting
- Ensure MySQL Server is running if you encounter connection issues.
- Verify the root password and other connection details if you cannot connect.
- Check for syntax errors in your SQL queries.

 Additional Resources
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [MySQL Workbench Documentation](https://dev.mysql.com/doc/workbench/en/)

