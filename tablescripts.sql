#Creating the database
DROP DATABASE IF EXISTS banking_system;
CREATE DATABASE IF NOT EXISTS banking_system;
USE banking_system;

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
CREATE TABLE IF NOT EXISTS Accounts (
    AccountNumber INT PRIMARY KEY,        
    CustomerID INT,                       
    AccountType VARCHAR(20),
    Balance DECIMAL(15, 2),
    CreationDate DATE,
    AccountStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);


-- Transaction Table
CREATE TABLE IF NOT EXISTS Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,         
    AccountNumber INT,                     
    TransactionType VARCHAR(50),
    TransactionAmount DECIMAL(15, 2),
    TransactionFee DECIMAL(10, 2),
    Timestamp TIMESTAMP default CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountNumber) REFERENCES Accounts(AccountNumber)
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
    CardNumber VARCHAR(16) PRIMARY KEY,            
    CardType VARCHAR(20),                      
    IssueDate DATE,
    ExpirationDate DATE,
    AccountNumber INT,                    
    FOREIGN KEY (AccountNumber) REFERENCES Accounts(AccountNumber)
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
