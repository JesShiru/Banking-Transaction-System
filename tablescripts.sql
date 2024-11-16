# Creating the relevant tables

-- Customer Table
CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY,            
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    NationalID VARCHAR(20),
    AccountCreationDate DATE,
    NextOfKin VARCHAR(100)
);

-- Account Table
CREATE TABLE IF NOT EXISTS Account (
    AccountNumber INT PRIMARY KEY,        
    CustomerID INT,                       
    AccountType VARCHAR(20),
    Balance DECIMAL(15, 2),
    CreationDate DATE,
    AccountStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);


-- Transaction Table
CREATE TABLE IF NOT EXISTS Transaction (
    TransactionID INT PRIMARY KEY,         
    AccountNumber INT,                     
    TransactionType VARCHAR(50),
    TransactionAmount DECIMAL(15, 2),
    TransactionFee DECIMAL(10, 2),
    DestinationAccount INT,
    Timestamp TIMESTAMP,
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);

-- Loan Table
CREATE TABLE IF NOT EXISTS Loan (
    LoanID INT PRIMARY KEY,                
    CustomerID INT,                        
    LoanAmount DECIMAL(15, 2),
    LoanType VARCHAR(50),
    InterestRate DECIMAL(5, 2),
    IssueDate DATE,
    LoanTerm INT,                          
    OutstandingBalance DECIMAL(15, 2),
    LoanStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);

-- Card Table
CREATE TABLE IF NOT EXISTS Card (
    CardNumber INT PRIMARY KEY,            
    Type VARCHAR(20),                      
    IssueDate DATE,
    ExpirationDate DATE,
    AccountNumber INT,                    
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);

-- Branch Table
CREATE TABLE IF NOT EXISTS Branch (
    BranchID INT PRIMARY KEY,             
    Location VARCHAR(100),
    ContactInformation VARCHAR(100),
    ManagerID INT                         
);

-- Employees Table
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,            
    BranchID INT,                          
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) 
);
-- Inserting data into Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, Email, NationalID, AccountCreationDate, NextOfKin)
VALUES
    (1, 'Martha', 'Muli', '0722546390', 'mmuli@gmail.com', 'A123456', '2023-01-01', 'Jane Muli'),
    (2, 'John', 'Otieno', '0787654321', 'john2@gmail.com', 'D654321', '2023-02-01', 'Bob Omondi'),
    (3, 'Michelle', 'Johnson', '0122334455', 'mjohnson@gmail.com', 'G987654', '2023-03-01', 'Sarah Johnson');

-- Inserting data into Account table
INSERT INTO Account (AccountNumber, CustomerID, AccountType, Balance, CreationDate, AccountStatus)
VALUES
    (1001, 1, 'Checking', 5000.00, '2023-01-01', 'Active'),
    (1002, 2, 'Savings', 10000.00, '2023-02-01', 'Active'),
    (1003, 3, 'Checking', 2500.00, '2023-03-01', 'Inactive');

-- Inserting data into Transaction table
INSERT INTO Transaction (TransactionID, AccountNumber, TransactionType, TransactionAmount, TransactionFee, DestinationAccount, Timestamp)
VALUES
    (1, 1001, 'Deposit', 500.00, 2.00, NULL, '2023-01-05 10:00:00'),
    (2, 1001, 'Withdrawal', 200.00, 1.00, NULL, '2023-01-10 14:00:00'),
    (3, 1002, 'Transfer', 300.00, 3.00, 1001, '2023-02-10 16:30:00');

-- Inserting data into Loan table
INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, InterestRate, IssueDate, LoanTerm, OutstandingBalance, LoanStatus)
VALUES
    (1, 1, 15000.00, 'Personal', 5.5, '2023-01-15', 60, 12000.00, 'Active'),
    (2, 2, 10000.00, 'AutoMobile', 4.0, '2023-02-20', 36, 8000.00, 'Active'),
    (3, 3, 20000.00, 'Mortgage', 3.75, '2023-03-05', 120, 19500.00, 'Inactive');

-- Inserting data into Card table
INSERT INTO Card (CardNumber, Type, IssueDate, ExpirationDate, AccountNumber)
VALUES
    (11112222, 'Credit', '2023-01-01', '2026-01-01', 1001),
    (33334444, 'Debit', '2023-02-01', '2026-02-01', 1002),
    (55556666, 'Credit', '2023-03-01', '2026-03-01', 1003);

-- Inserting data into Branch table
INSERT INTO Branch (BranchID, Location, ContactInformation, ManagerID)
VALUES
    (1, '123 Main St, City A', 'contactA@gmail.com', 101),
    (2, '456 Elm St, City B', 'contactB@gmail.com', 102),
    (3, '789 Maple St, City C', 'contactC@gmail.com', 103);

-- Inserting data into Employees table
INSERT INTO Employees (EmployeeID, BranchID, FirstName, LastName, Role, PhoneNumber, Email)
VALUES
    (101, 1, 'Emily', 'Nzioka', 'Manager', '3216549870', 'emilyn@gmail.com'),
    (102, 2, 'James', 'Boke', 'Manager', '6543217890', 'jboke@gmail.com'),
    (103, 3, 'Sophia', 'Mwikali', 'Manager', '7890123456', 'sophia1@gmail.com'),
    (104, 1, 'Robert', 'Njau', 'Teller', '1237894560', 'robertnjau@gmail.com'),
    (105, 2, 'Linda', 'Wilson', 'Loan Officer', '4569871230', 'lindawilson@gmail.com');
