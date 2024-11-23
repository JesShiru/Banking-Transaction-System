-- a view to show customer transactions
CREATE VIEW customer_transactions AS
SELECT
	t.TransactionID,
    a.CustomerID,
    t.AccountNumber,
    t.TransactionType,
    t.TransactionAmount,
    t.Timestamp AS TransactionDate
FROM transactions as t
JOIN accounts a ON t.AccountNumber = a.AccountNumber;

-- a view that shows the daily transactions
CREATE VIEW daily_transactions_summary AS
SELECT 
	a.AccountNumber,
    DATE(t.timestamp) AS TransactionDate, 
    COUNT(*) AS TotalTransactions, 
    SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.TransactionAmount ELSE 0 END) AS TotalDeposits, 
    SUM(CASE WHEN t.TransactionType = 'Withdrawal' THEN t.TransactionAmount ELSE 0 END) AS TotalWithdrawals
FROM transactions t
JOIN accounts a ON t.AccountNumber = a.AccountNumber
GROUP BY a.AccountNumber, DATE(t.timestamp);
