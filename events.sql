-- An event that applies interest to the balance of the AccountType: Savings
CREATE EVENT IF NOT EXISTS apply_interest
ON SCHEDULE EVERY 1 MINUTE
DO
  UPDATE Accounts
  SET Balance = Balance + (Balance * 0.01)
  WHERE AccountType = 'Savings' AND AccountStatus = 'Active';

-- an event that applies interest to the Outstanding loan balance for LoanStatus: Active
CREATE EVENT IF NOT EXISTS update_outstanding_loan
ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE Loan
    SET OutstandingBalance = OutstandingBalance + (OutstandingBalance * (InterestRate / 100) / 12)
    WHERE LoanStatus = 'Active';
    
    
-- to delete accounts that are inactive
DELETE FROM accounts
WHERE AccountStatus = 'Inactive';