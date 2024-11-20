DELIMITER $$

CREATE PROCEDURE DepositMoney (
    IN p_AccountNumber INT,
    IN p_Amount DECIMAL(15, 2)
)
BEGIN
    DECLARE current_balance DECIMAL(15, 2);

    -- Fetch the current balance of the account
    SELECT Balance INTO current_balance
    FROM Account
    WHERE AccountNumber = p_AccountNumber;

    -- Ensure the account exists and is active
    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Account does not exist.';
    ELSEIF (SELECT AccountStatus FROM Account WHERE AccountNumber = p_AccountNumber) != 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Account is not active.';
    ELSE
        -- Update the account balance
        UPDATE Account
        SET Balance = current_balance + p_Amount
        WHERE AccountNumber = p_AccountNumber;

        -- Log the transaction
        INSERT INTO Transaction (AccountNumber, TransactionType, TransactionAmount, TransactionFee, DestinationAccount, Timestamp)
        VALUES (p_AccountNumber, 'Deposit', p_Amount, 0.00, NULL, NOW());
    END IF;
END$$

DELIMITER ;

DELIMITER $$

-- withdrawal
CREATE PROCEDURE WithdrawMoney (
    IN p_AccountNumber INT,
    IN p_Amount DECIMAL(15, 2),
    IN p_TransactionFee DECIMAL(10, 2)
)
BEGIN
    DECLARE current_balance DECIMAL(15, 2);

    -- Fetch the current balance of the account
    SELECT Balance INTO current_balance
    FROM Account
    WHERE AccountNumber = p_AccountNumber;

    -- Ensure the account exists, is active, and has sufficient funds
    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Account does not exist.';
    ELSEIF (SELECT AccountStatus FROM Account WHERE AccountNumber = p_AccountNumber) != 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Account is not active.';
    ELSEIF current_balance < (p_Amount + p_TransactionFee) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient funds.';
    ELSE
        -- Deduct the amount and transaction fee
        UPDATE Account
        SET Balance = current_balance - (p_Amount + p_TransactionFee)
        WHERE AccountNumber = p_AccountNumber;

        -- Log the transaction
        INSERT INTO Transaction (AccountNumber, TransactionType, TransactionAmount, TransactionFee, DestinationAccount, Timestamp)
        VALUES (p_AccountNumber, 'Withdrawal', p_Amount, p_TransactionFee, NULL, NOW());
    END IF;
END$$

DELIMITER ;

-- transfer money
DELIMITER $$

CREATE PROCEDURE TransferMoney (
    IN p_SourceAccount INT,
    IN p_DestinationAccount INT,
    IN p_Amount DECIMAL(15, 2),
    IN p_TransactionFee DECIMAL(10, 2)
)
BEGIN
    DECLARE source_balance DECIMAL(15, 2);

    -- Fetch the balance of the source account
    SELECT Balance INTO source_balance
    FROM Account
    WHERE AccountNumber = p_SourceAccount;

    -- Validate both accounts and ensure sufficient funds
    IF source_balance IS NULL OR
       (SELECT AccountStatus FROM Account WHERE AccountNumber = p_SourceAccount) != 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Source account does not exist or is not active.';
    ELSEIF (SELECT AccountStatus FROM Account WHERE AccountNumber = p_DestinationAccount) != 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Destination account is not active.';
    ELSEIF source_balance < (p_Amount + p_TransactionFee) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient funds in source account.';
    ELSE
        -- Deduct from source account
        UPDATE Account
        SET Balance = source_balance - (p_Amount + p_TransactionFee)
        WHERE AccountNumber = p_SourceAccount;

        -- Add to destination account
        UPDATE Account
        SET Balance = Balance + p_Amount
        WHERE AccountNumber = p_DestinationAccount;

        -- Log the transaction
        INSERT INTO Transaction (AccountNumber, TransactionType, TransactionAmount, TransactionFee, DestinationAccount, Timestamp)
        VALUES (p_SourceAccount, 'Transfer', p_Amount, p_TransactionFee, p_DestinationAccount, NOW());
    END IF;
END$$

DELIMITER ;

-- viewing account details
DELIMITER $$

CREATE PROCEDURE ViewAccountDetails (
    IN p_AccountNumber INT
)
BEGIN
    SELECT AccountNumber, CustomerID, AccountType, Balance, CreationDate, AccountStatus
    FROM Account
    WHERE AccountNumber = p_AccountNumber;
END$$

DELIMITER ;

-- managing loan payments
DELIMITER $$

CREATE PROCEDURE PayLoan (
    IN p_LoanID INT,
    IN p_Amount DECIMAL(15, 2)
)
BEGIN
    DECLARE current_balance DECIMAL(15, 2);

    -- Fetch the current outstanding balance
    SELECT OutstandingBalance INTO current_balance
    FROM Loan
    WHERE LoanID = p_LoanID;

    -- Validate loan and payment
    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Loan does not exist.';
    ELSEIF current_balance < p_Amount THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment exceeds outstanding balance.';
    ELSE
        -- Deduct payment from outstanding balance
        UPDATE Loan
        SET OutstandingBalance = current_balance - p_Amount,
            LoanStatus = CASE WHEN current_balance - p_Amount = 0 THEN 'Inactive' ELSE LoanStatus END
        WHERE LoanID = p_LoanID;

        -- Log payment in the Transaction table
        INSERT INTO Transaction (AccountNumber, TransactionType, TransactionAmount, TransactionFee, DestinationAccount, Timestamp)
        VALUES (NULL, 'Loan Payment', p_Amount, 0.00, NULL, NOW());
    END IF;
END$$

DELIMITER ;

-- testing procedures
-- deposit
CALL DepositMoney(101, 500.00);

-- withdrawal
CALL WithdrawMoney(101, 200.00, 2.50);

-- tranferring
CALL TransferMoney(101, 102, 300.00, 5.00);

-- viewing account
CALL ViewAccountDetails(101);

-- pay loan
CALL PayLoan(201, 1000.00);
