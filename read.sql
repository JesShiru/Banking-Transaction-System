SELECT * FROM accounts;
SELECT * FROM employees;
SELECT * FROM loan;
SELECT * FROM branch;
SELECT * FROM card;
SELECT * FROM customer;

-- To find accounts with higher balances than the average balance 
SELECT AccountNumber, CustomerID, Balance
FROM accounts
WHERE Balance > (SELECT AVG(Balance) FROM accounts);

--  Fetch Transactions Above the Average Amount for a Specific Customer
SELECT TransactionID, AccountNumber, TransactionAmount, Timestamp
FROM transactions
WHERE Amount > (
    SELECT AVG(Amount)
    FROM transactions
    WHERE AccountNumber = '1369'
);

-- List Customers with No Transactions in the Last 6 Months
SELECT CustomerID, FirstName, LastName
FROM customer
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM transactions
    WHERE Timestamp >= DATEADD(MONTH, -6, GETDATE())
);