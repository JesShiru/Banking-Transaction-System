DELIMITER $$

CREATE PROCEDURE AddCustomer(
    IN p_CustomerID INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_PhoneNumber VARCHAR(15),
    IN p_Email VARCHAR(100),
    IN p_NationalID VARCHAR(20),
    IN p_AccountCreationDate DATE,
    IN p_NextOfKin VARCHAR(100)
)
BEGIN
    INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, Email, NationalID, AccountCreationDate, NextOfKin)
    VALUES (p_CustomerID, p_FirstName, p_LastName, p_PhoneNumber, p_Email, p_NationalID, p_AccountCreationDate, p_NextOfKin);
END$$

DELIMITER ;
-- CALL AddCustomer(1, 'John', 'Doe', '123-456-7890', 'john.doe@example.com', 'A123456789', '2024-11-20', 'Jane Doe');


-- updating customer info
DELIMITER $$

CREATE PROCEDURE UpdateCustomer(
    IN p_CustomerID INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_PhoneNumber VARCHAR(15),
    IN p_Email VARCHAR(100),
    IN p_NationalID VARCHAR(20),
    IN p_NextOfKin VARCHAR(100)
)
BEGIN
    UPDATE Customer
    SET FirstName = p_FirstName, 
        LastName = p_LastName, 
        PhoneNumber = p_PhoneNumber, 
        Email = p_Email, 
        NationalID = p_NationalID, 
        NextOfKin = p_NextOfKin
    WHERE CustomerID = p_CustomerID;
END$$

DELIMITER ;
-- CALL UpdateCustomer(1, 'Savings', 1000.00, '2024-01-01', 'Active');

--add new account
DELIMITER $$

CREATE PROCEDURE AddAccount(
    IN p_AccountNumber INT,
    IN p_CustomerID INT,
    IN p_AccountType VARCHAR(20),
    IN p_Balance DECIMAL(15, 2),
    IN p_CreationDate DATE,
    IN p_AccountStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Account (AccountNumber, CustomerID, AccountType, Balance, CreationDate, AccountStatus)
    VALUES (p_AccountNumber, p_CustomerID, p_AccountType, p_Balance, p_CreationDate, p_AccountStatus);
END$$

DELIMITER ;
-- CALL AddAccount(1001, 1, 'Savings', 1000.00, '2024-01-01', 'Active');


-- update accountbalance
DELIMITER $$

CREATE PROCEDURE UpdateAccountBalance(
    IN p_AccountNumber INT,
    IN p_NewBalance DECIMAL(15, 2)
)
BEGIN
    UPDATE Accounts
    SET Balance = p_NewBalance
    WHERE AccountNumber = p_AccountNumber;
END$$

DELIMITER ;
-- CALL UpdateAccountBalance(1001, 1500.00);


-- add transaction
DELIMITER $$

CREATE PROCEDURE AddTransactions(
    IN p_TransactionID INT,
    IN p_AccountNumber INT,
    IN p_TransactionType VARCHAR(50),
    IN p_TransactionAmount DECIMAL(15, 2),
    IN p_TransactionFee DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Transactions (TransactionID, AccountNumber, TransactionType, TransactionAmount, TransactionFee)
    VALUES (p_TransactionID, p_AccountNumber, p_TransactionType, p_TransactionAmount, p_TransactionFee);
END$$

DELIMITER ;
-- CALL AddTransaction(10001, 1001, 'Deposit', 500.00, 0.00, NULL, NOW());


-- add loan
DELIMITER $$

CREATE PROCEDURE AddLoan(
    IN p_LoanID INT,
    IN p_CustomerID INT,
    IN p_LoanAmount DECIMAL(15, 2),
    IN p_LoanType VARCHAR(50),
    IN p_InterestRate DECIMAL(5, 2),
    IN p_IssueDate DATE,
    IN p_LoanTerm INT,
    IN p_OutstandingBalance DECIMAL(15, 2),
    IN p_LoanStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, InterestRate, IssueDate, LoanTerm, OutstandingBalance, LoanStatus)
    VALUES (p_LoanID, p_CustomerID, p_LoanAmount, p_LoanType, p_InterestRate, p_IssueDate, p_LoanTerm, p_OutstandingBalance, p_LoanStatus);
END$$

DELIMITER ;
-- CALL AddLoan(1, 1, 5000.00, 'Personal', 5.00, '2024-01-01', 12, 1000.00, 'Active');


--update loan status
DELIMITER $$

CREATE PROCEDURE UpdateLoanStatus(
    IN p_LoanID INT,
    IN p_LoanStatus VARCHAR(20)
)
BEGIN
    UPDATE Loan
    SET LoanStatus = p_LoanStatus
    WHERE LoanID = p_LoanID;
END$$

DELIMITER ;
-- CALL UpdateLoanStatus(1, 'Paid Off');


-- add card
DELIMITER $$

CREATE PROCEDURE AddCard(
    IN p_CardNumber VARCHAR(16),
    IN p_CardType VARCHAR(20),
    IN p_IssueDate DATE,
    IN p_ExpirationDate DATE,
    IN p_AccountNumber INT
)
BEGIN
    INSERT INTO Card (CardNumber, Type, IssueDate, ExpirationDate, AccountNumber)
    VALUES (p_CardNumber, p_CardType, p_IssueDate, p_ExpirationDate, p_AccountNumber);
END$$

DELIMITER ;
-- CALL AddCard('1234567812345678', 'Credit', '2024-01-01', '2026-01-01', 1001);


-- update card status
DELIMITER $$

CREATE PROCEDURE UpdateCardExpiration(
    IN p_CardNumber VARCHAR(16),
    IN p_ExpirationDate DATE
)
BEGIN
    UPDATE Card
    SET ExpirationDate = p_ExpirationDate
    WHERE CardNumber = p_CardNumber;
END$$

DELIMITER ;
-- CALL UpdateCardExpiration()

-- add branch
DELIMITER $$

CREATE PROCEDURE AddBranch(
    IN p_BranchID INT,
    IN p_Location VARCHAR(100),
    IN p_ContactInformation VARCHAR(100),
    IN p_ManagerID INT
)
BEGIN
    INSERT INTO Branch (BranchID, Location, ContactInformation, ManagerID)
    VALUES (p_BranchID, p_Location, p_ContactInformation, p_ManagerID);
END$$

DELIMITER ;
-- CALL AddBranch('Downtown', '123-456-7890', 1);


-- add employee
DELIMITER $$

CREATE PROCEDURE AddEmployee(
    IN p_EmployeeID INT,
    IN p_BranchID INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Role VARCHAR(50),
    IN p_PhoneNumber VARCHAR(15),
    IN p_Email VARCHAR(100)
)
BEGIN
    INSERT INTO Employees (EmployeeID, BranchID, FirstName, LastName, Role, PhoneNumber, Email)
    VALUES (p_EmployeeID, p_BranchID, p_FirstName, p_LastName, p_Role, p_PhoneNumber, p_Email);
END$$

DELIMITER ;
-- CALL AddEmployee(1, 'Alice', 'Smith', 'Manager', '9876543210', 'alice.smith@email.com');
