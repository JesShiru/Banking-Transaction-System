# Banking Transaction System

Welcome to the **Banking Transaction System**! This repository contains SQL scripts to set up and manage a banking database, including tables, stored procedures, and example data.


## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Step-by-Step Procedure to Run Scripts](#step-by-step-procedure-to-run-scripts)
6. [Contributing](#contributing)

---

## Overview

The **Banking Transaction System** is designed to to manage and process banking transactions efficiently and reliably. It ensures accurate, real-time updates and provides robust error handling.  

## Features

- Customer account creation and management
- Secure transaction processing
- Detailed transaction logs
- Account balance summaries
- Scalable and modular codebase

## Prerequisites

Ensure the following tools and dependencies are installed:

- **MySQL Server**: Version 8.0 or higher
- **MySQL Workbench**: For managing the database
- **Git**: For cloning the repository  

## Installation

### 1. Install MySQL Server and MySQL Workbench
1. **Download MySQL**:
   - Visit the [MySQL Community Downloads](https://dev.mysql.com/downloads/mysql/) page.
   - Choose your operating system and download the installer.
2. **Install MySQL Server**:
   - During installation, set up a root password for your MySQL server.
   - Note the port (default: 3306) and authentication method used.
3. **Install MySQL Workbench**:
   - Download and install the [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) to manage your database visually.

### 2. Clone the Repository
   Clone the GitHub repository to your local machine:
   ```bash
   git clone https://github.com/JesShiru/Banking-Transaction-System.git
   cd Banking-Transaction-System
   ```
### 3. Set Up the Database
- **Open MySQL Workbench** and connect to your MySQL server using the root credentials.
- **Run the SQL script** located in the database/ folder to set up the required database and tables:
    SOURCE path/to/database_script.sql;
- **Update the config.py or config.json file** (if available) with the following details:
  Database name
  Host (e.g., localhost)
  Port (default: 3306)
  Username and password for the database connection
  
### Accessing MySQL Workbench
Use MySQL Workbench to view, query, and manage the database. 
Connect using the credentials provided during installation.

## Step-by-Step Procedure to Run Scripts

Follow these steps to execute the scripts in the correct order:

### Step 1: Open `tablescripts.sql`
- Open **MySQL Workbench** and connect to your MySQL Server.
- In the **Navigator**, ensure you are connected to the correct MySQL instance.
- Open the file `tablescripts.sql` located in the repository's `sql/` folder.
  - Use the menu: **File > Open SQL Script**.
- Execute the script to create the database and tables:
  ```sql
  SOURCE path/to/tablescripts.sql;
- Verify the database and tables are created:
   ```sql
   SHOW DATABASES;
   USE your_database_name;
   SHOW TABLES;

### Step 2: Run `insert_statements.sql`
 - Open the **insert_statements.sql** script in MySQL Workbench.
 - Execute the script to **insert sample data** into the database:
   ```sql
   SOURCE path/to/insertstatements.sql;
 - Verify the data was inserted successfully:
   ```sql
   SELECT * FROM customers;
   SELECT * FROM accounts;

### Step 3: Run `storedprocedures.sql` 
- Defines the stored procedures used for various database operations like adding, updating, or managing customers, accounts, loans, transactions, branches, and employees.

- Open the **storedprocedures.sql** file in MySQL Workbench.
- Execute the script to **create stored procedures**:
   ```sql
   SOURCE path/to/storedprocedures.sql;
- Verify the stored procedures are created:
   ```sql
   SHOW PROCEDURE STATUS WHERE Db = 'your_database_name';

### Step 4: Run `triggers.sql`
- This script creates triggers to enforce business rules and maintain database integrity.
- Open the **triggers.sql** file in MySQL Workbench.
- Execute the script to **create triggers**:
    ```sql
   SOURCE path/to/triggers.sql;

### Step 5: Run `events.sql`
- Defines scheduled events for periodic actions, such as applying interest to savings accounts and updating outstanding loan balances.
- **To be run after triggers and stored procedures**: Events depend on stored procedures or the integrity rules set by triggers.
- Open the **events.sql** file in MySQL Workbench.
- Execute the script to **define events**:
    ```sql
   SOURCE path/to/events.sql;

### Step 6: Run Additional Scripts (`transaction.sql`, `read.sql`)
-`transaction.sql` populates the database with sample transaction data to test triggers, procedures, and events in a realistic context.
- `read.sql` contains SELECT statements to retrieve and verify data from the database for **testing** or **reporting**.

- To run the two scripts, follow the same process:
- Open the script in MySQL Workbench.
- Execute it using the Run Script button or the SOURCE command.

## Contributing
We welcome contributions! Please follow these steps:
1. Fork the repository and create your branch:
git checkout -b feature/YourFeatureName
2. Commit your changes and push to your fork.
3. Submit a pull request.
