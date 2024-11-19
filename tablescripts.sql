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
    CardNumber VARCHHAR(16) PRIMARY KEY,            
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

