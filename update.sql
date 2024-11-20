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

-- trigger to prevent negative balance
DELIMITER //
CREATE TRIGGER PreventNegativeBalance
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(15, 2);

    IF NEW.TransactionType = 'Withdraw' THEN
        -- Get the current balance of the account
        SELECT Balance
        INTO current_balance
        FROM Accounts
        WHERE AccountNumber = NEW.AccountNumber;

        IF (current_balance - NEW.TransactionAmount - NEW.TransactionFee) < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient funds to complete the transaction.';
        END IF;
    END IF;
END //

DELIMITER ;

-- test trigger: PreventNegativeBalance
INSERT INTO transactions (`AccountNumber`,`TransactionType`,`TransactionAmount`,`TransactionFee`) VALUES (1379,'Withdraw',59000.00,20.00);

-- Trigger update the account balance incase of a withdrawal or deposit
DELIMITER $$
CREATE TRIGGER UpdateAccountBalance
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(15, 2);

    -- Get the current balance of the account
    SELECT Balance
    INTO current_balance
    FROM Accounts
    WHERE AccountNumber = NEW.AccountNumber;

    IF NEW.TransactionType = 'Withdraw' THEN
        UPDATE Accounts
        SET Balance = current_balance - NEW.TransactionAmount - NEW.TransactionFee
        WHERE AccountNumber = NEW.AccountNumber;
    ELSEIF NEW.TransactionType = 'Deposit' THEN
        UPDATE Accounts
        SET Balance = current_balance + NEW.TransactionAmount
        WHERE AccountNumber = NEW.AccountNumber;
    END IF;
END $$
DELIMITER ;

-- testing trigger:UpdateAccountBalance
INSERT INTO transactions (`AccountNumber`,`TransactionType`,`TransactionAmount`,`TransactionFee`) VALUES (1379,'Deposit',59000.00,20.00);


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

