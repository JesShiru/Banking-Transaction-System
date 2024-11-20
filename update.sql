-- customer updates

UPDATE: Update phone numbers of customers with missing or invalid entries
UPDATE Customer
SET PhoneNumber = 'Unknown'
WHERE PhoneNumber IS NULL OR LENGTH(PhoneNumber) < 10;

-- UPDATE: Correct email domain for all customers using the old domain
UPDATE Customer
SET Email = REPLACE(Email, '@oldmail.com', '@newmail.com')
WHERE Email LIKE '%@oldmail.com';

-- UPDATE: Add next-of-kin entry for all customers who don’t have one
UPDATE Customer
SET NextOfKin = 'Not Provided'
WHERE NextOfKin IS NULL;

-- Accounts

-- UPDATE: Convert all "Fixed Deposit" accounts to "Standard"
UPDATE Accounts
SET AccountType = 'Standard'
WHERE AccountType = 'Fixed Deposit';

-- UPDATE: Add a 1% interest to all active savings accounts
UPDATE Accounts
SET Balance = Balance + (Balance * 0.01)
WHERE AccountType = 'Savings' AND AccountStatus = 'Active';



--test for triggering an insert to transaction after a deposit

-- withdrawal trigger
DELIMITER $$
CREATE TRIGGER after_withdrawal
AFTER UPDATE ON Accounts
FOR EACH ROW
BEGIN
    IF NEW.Balance < OLD.Balance THEN
        INSERT INTO Transaction (AccountNumber, TransactionType, TransactionAmount, TransactionFee)
        VALUES (NEW.AccountNumber, 'Withdrawal', OLD.Balance - NEW.Balance);
    END IF;
END$$

DELIMITER ;

-- testing it
UPDATE Accounts
SET balance = 60000.00 
WHERE AccountNumber = 1369;

--loanpayment
DELIMITER $$

CREATE TRIGGER after_loan_payment
AFTER UPDATE ON Loan
FOR EACH ROW
BEGIN
    -- Log the loan payment in the Transaction table
    IF NEW.OutstandingBalance = 0 THEN
        INSERT INTO Transactions (
            AccountNumber,
            TransactionType,
            TransactionAmount,
            TransactionFee
        )
        VALUES (
            (SELECT AccountNumber FROM Account WHERE CustomerID = NEW.CustomerID), -- Fetch AccountNumber from Customer
            'Loan Payment',
            OLD.OutstandingBalance, -- Payment amount is the old balance
            0.00
        );
    END IF;
END$$

DELIMITER ;

-- loanstatus
UPDATE Loan
SET LoanStatus = 'Inactive'
WHERE OutstandingBalance = 0.00 AND LoanStatus != 'Inactive';
-- test
UPDATE Loan
SET OutstandingBalance = 0.00
WHERE LoanID = 1;
--event to change it to inactive
CREATE EVENT IF NOT EXISTS update_loan_status
ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE Loan
    SET LoanStatus = 'Inactive'
    WHERE OutstandingBalance = 0.00 AND LoanStatus != 'Inactive';

