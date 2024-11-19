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
UPDATE Account
SET AccountType = 'Standard'
WHERE AccountType = 'Fixed Deposit';

-- UPDATE: Add a 1% interest to all active savings accounts
UPDATE Account
SET Balance = Balance + (Balance * 0.01)
WHERE AccountType = 'Savings' AND AccountStatus = 'Active';
