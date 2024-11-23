USE banking_system;
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

INSERT INTO transactions (`AccountNumber`,`TransactionType`,`TransactionAmount`,`TransactionFee`) VALUES (1255,'Deposit',1500.00,15.00);

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

-- Event : On Insert or update, phone number length is checked
-- If digits less than 10; Replaced with 'Unknown'
DELIMITER $$
CREATE TRIGGER update_phone_number
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
    IF NEW.PhoneNumber IS NULL OR LENGTH(NEW.PhoneNumber) < 10 THEN
        SET NEW.PhoneNumber = 'Unknown';
    END IF;
END$$

DELIMITER ;


-- test out the trigger
INSERT INTO transactions (`AccountNumber`,`TransactionType`,`TransactionAmount`,`TransactionFee`) VALUES (1369,'Withdraw',2000.00,10.00);

-- display acc number, custid, acctype, balance, acc status, loan ammount, loan status, for user=8
SELECT  a.AccountNumber, a.CustomerID, a.AccountType, a.Balance, a.AccountStatus, l.LoanAmount, l.LoanStatus
FROM accounts AS a
LEFT JOIN loan l ON a.CustomerID = l.CustomerID
WHERE a.CustomerID=8;

