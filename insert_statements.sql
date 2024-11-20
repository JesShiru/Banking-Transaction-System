
-- insert into customer table
INSERT INTO customer (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Email`, `NationalID`, `AccountCreationDate`, `NextOfKin`) 
VALUES 
(1,'Patrice','Ida','281-304-3679','pida0@jigsy.com','410-65-2615','2023-02-09','Joshua Adams'),
(2,'Betsey','Bavage','339-392-4851','bbavage1@plala.or.jp','898-82-2019','2023-02-20','David Lee'),
(3,'Dode','Fleming','658-180-1596','dfleming2@google.com','108-12-0846','2023-01-16','Cassandra Torres'),
(4,'Grenville','Bothram','695-228-8158','gbothram3@guardian.co.uk','331-96-8658','2023-01-08','Katie Ward'),
(5,'Molli','Averies','292-328-3376','maveries4@about.com','142-38-8791','2023-02-16','Alex Ramirez'),
(6,'Wallie','Peebles','918-906-1662','wpeebles5@storify.com','843-26-9416','2023-02-20','Kimberly Scott'),
(7,'Darrell','Smoote','914-447-3323','dsmoote6@nature.com','213-56-9524','2023-02-23','John Doe'),
(8,'Louie','Stobbe','741-137-8238','lstobbe7@ycombinator.com','122-62-8914','2023-02-27','Angela Powell'),
(9,'Evania','Jermyn','881-330-3372','ejermyn8@utexas.edu','434-96-1015','2023-02-26','Katie Ward'),
(10,'Clywd','Muat','578-195-4241','cmuat9@yellowpages.com','490-43-4206','2023-02-09','Ryan Mitchell');

-- inserting into accounts table
INSERT INTO accounts (`AccountNumber`, `CustomerID`, `AccountType`, `Balance`, `CreationDate`, `AccountStatus`) 
VALUES 
(1255, 1, 'Savings', 28928.86, '2023-02-04', 'Inactive'),
(1369, 2, 'Fixed Deposit', 71405.54, '2024-09-01', 'Active'),
(1379, 3, 'Fixed Deposit', 58980.69, '2023-01-21', 'Inactive'),
(1416, 4, 'Savings', 72948.20, '2024-09-16', 'Inactive'),
(1460, 5, 'Savings', 94626.18, '2024-05-05', 'Inactive'),
(1510, 6, 'Fixed Deposit', 56344.39, '2024-09-27', 'Inactive'),
(1705, 7, 'Checking', 39228.18, '2023-10-11', 'Inactive'),
(1816, 8, 'Savings', 29807.29, '2024-04-30', 'Active'),
(2063, 9, 'Checking', 48572.21, '2023-12-26', 'Active'),
(2308, 10, 'Fixed Deposit', 13460.04, '2023-07-30', 'Active');

-- INSERT INTO CARDS TABLE
INSERT INTO card (`CardNumber`, `CardType`, `IssueDate`, `ExpirationDate`, `AccountNumber`) 
VALUES 
('1012345610123457', 'Credit', '2023-12-16', '2027-12-31', 1369), 
('1012345610123459', 'Credit', '2023-03-09', '2026-03-31', 1705), 
('1012345610234561', 'Credit', '2023-10-18', '2026-10-31', 1379), 
('1023456710345671', 'Debit', '2024-08-18', '2026-08-31', 1510), 
('1123456711234567', 'Debit', '2024-08-27', '2028-08-31', 2063), 
('1123456711234568', 'Debit', '2024-10-14', '2028-10-31', 1816), 
('1123456712345671', 'Debit', '2023-07-30', '2026-07-31', 2308), 
('1234567812345678', 'Debit', '2023-02-04', '2026-02-28', 1255);
('2123456721345672', 'Debit', '2024-09-15', '2027-09-30', 1416), 
('2134567821345672', 'Credit', '2023-03-24', '2026-03-31', 1460);

-- INSERT INTO LOANS TABLE
INSERT INTO loan (`LoanID`, `CustomerID`, `LoanAmount`, `LoanType`, `InterestRate`, `IssueDate`, `LoanTerm`, `OutstandingBalance`, `LoanStatus`) 
VALUES 
(1, 4, 3500.00, 'Auto', 4.90, '2023-02-15', 36, 3000.00, 'Active'),
(2, 7, 15000.00, 'Personal', 5.75, '2023-02-01', 24, 12000.00, 'Active'),
(3, 10, 250000.00, 'Mortgage', 3.25, '2023-01-10', 240, 240000.00, 'Active'),
(4, 2, 18000.00, 'Home', 4.50, '2023-02-07', 180, 17500.00, 'Active'),
(5, 6, 8000.00, 'Personal', 6.00, '2023-02-03', 12, 5000.00, 'Active'),
(6, 9, 12000.00, 'Student', 5.20, '2023-02-12', 48, 11000.00, 'Active'),
(7, 3, 35000.00, 'Auto', 4.90, '2023-01-19', 36, 33000.00, 'Active'),
(8, 1, 22000.00, 'Home', 3.85, '2023-02-01', 120, 21500.00, 'Active'),
(9, 5, 6000.00, 'Personal', 6.25, '2023-02-10', 24, 4500.00, 'Active'),
(10, 8, 15000.00, 'Home', 4.00, '2023-02-18', 120, 14500.00, 'Active');


-- INSERT INTO BRANCH TABLE
INSERT INTO branch (`BranchID`, `Location`, `ContactInformation`, `ManagerID`) 
VALUES 
(2, 'Meru', '+254736316296', 27),
(4, 'Nairobi', '+254797596320', 46),
(6, 'Nakuru', '+254773362468', 44),
(8, 'Kisumu', '+254772396049', 0),
(9, 'Kakamega', '+254770803367', 47),
(10, 'Embu', '+254772511394', 3),
(12, 'Mombasa', '+254779195800', 53);

-- INSERT INTO EMPLOYEES TABLE
INSERT INTO employees (`EmployeeID`, `BranchID`, `FirstName`, `LastName`, `Role`, `PhoneNumber`, `Email`) 
VALUES 
(1, 4, 'John', 'Doe', 'Manager', '+254700111222', 'johndoe@example.com'),
(2, 12, 'Jane', 'Smith', 'Cashier', '+254701222333', 'janesmith@example.com'),
(3, 8, 'Peter', 'Brown', 'Teller', '+254702333444', 'peterbrown@example.com'),
(4, 9, 'Mary', 'Johnson', 'Security', '+254703444555', 'maryjohnson@example.com'),
(5, 2, 'Alice', 'Davis', 'Loan Officer', '+254704555666', 'alicedavis@example.com'),
(6, 4, 'Robert', 'Martinez', 'Accountant', '+254705666777', 'robertmartinez@example.com'),
(7, 12, 'Emily', 'Garcia', 'HR', '+254706777888', 'emilygarcia@example.com'),
(8, 8, 'James', 'Harris', 'Teller', '+254707888999', 'jamesharris@example.com'),
(9, 9, 'Patricia', 'Clark', 'Manager', '+254708999000', 'patriciaclark@example.com'),
(10, 2, 'Michael', 'Lewis', 'Security', '+254709000111', 'michaellewis@example.com');

