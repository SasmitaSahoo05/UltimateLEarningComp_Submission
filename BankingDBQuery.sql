-- Create a database for the banking system
CREATE DATABASE BankingDB1;
GO
USE BankingDB1;
GO

-- Customers Table: Stores customer personal details
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1000,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DOB DATE,
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(15) UNIQUE,
    Address NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Accounts Table: Stores account details linked to customers
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY(2000,1),
    CustomerID INT NOT NULL,
    AccountType NVARCHAR(50) CHECK (AccountType IN ('Savings', 'Checking', 'Loan', 'Credit Card', 'Fixed Deposit')),
    Balance DECIMAL(18,2) DEFAULT 0.00,
    InterestRate DECIMAL(5,2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Active', 'Inactive', 'Closed')),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions Table: Stores all banking transactions
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(3000,1),
    CustomerID INT NOT NULL,
    AccountID INT NOT NULL,
    TransactionType NVARCHAR(50) CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer', 'Payment', 'Fee')),
    Amount DECIMAL(18,2) CHECK (Amount > 0),
    TransactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Loans Table: Stores details of customer loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(4000,1),
    CustomerID INT NOT NULL,
    AccountID INT NOT NULL,
    LoanType NVARCHAR(50) CHECK (LoanType IN ('Personal', 'Home', 'Auto', 'Education', 'Business')),
    LoanAmount DECIMAL(18,2),
    InterestRate DECIMAL(5,2),
    LoanTerm INT, -- in months
    MonthlyPayment DECIMAL(18,2),
    StartDate DATE,
    EndDate DATE,
    Status NVARCHAR(20) CHECK (Status IN ('Active', 'Closed', 'Defaulted')),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Payments Table: Stores records of loan payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(5000,1),
    CustomerID INT NOT NULL,
    LoanID INT NOT NULL,
    AmountPaid DECIMAL(18,2),
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- Employees Table: Stores bank employee details
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(6000,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(15) UNIQUE,
    HireDate DATE,
    Salary DECIMAL(18,2)
);

-- Branches Table: Stores bank branch information
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY(7000,1),
    BranchName NVARCHAR(100),
    Address NVARCHAR(255),
    Phone NVARCHAR(15) UNIQUE,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- AccountServices Table: Links accounts with branches and employees
CREATE TABLE AccountServices (
    ServiceID INT PRIMARY KEY IDENTITY(8000,1),
    AccountID INT NOT NULL,
    BranchID INT NOT NULL,
    EmployeeID INT NOT NULL,
    ServiceDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Customers
SET IDENTITY_INSERT Customers ON;
INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Email, Phone, Address)
VALUES 
(1000, 'John', 'Doe', '1990-01-15', 'john.doe1@example.com', '1234567891', '123 Main St'),
(1001, 'Alice', 'Smith', '1985-07-22', 'alice.smith@example.com', '9876543211', '456 Elm St'),
(1002, 'Robert', 'Brown', '1978-03-10', 'robert.brown@example.com', '4561237891', '789 Pine St'),
(1003, 'Emily', 'Johnson', '1992-09-05', 'emily.johnson@example.com', '8529637411', '321 Oak St'),
(1004, 'Michael', 'Davis', '1987-11-23', 'michael.davis@example.com', '3217896541', '654 Cedar St'),
(1005, 'Olivia', 'Garcia', '1993-02-18', 'olivia.garcia@example.com', '1593578521', '987 Spruce St'),
(1006, 'William', 'Martinez', '1980-06-30', 'william.martinez@example.com', '7539514561', '741 Walnut St'),
(1007, 'Sophia', 'Miller', '1991-04-12', 'sophia.miller@example.com', '9517538521', '258 Maple St'),
(1008, 'James', 'Anderson', '1975-08-05', 'james.anderson@example.com', '1472583691', '369 Birch St'),
(1009, 'Ava', 'Taylor', '1984-12-20', 'ava.taylor@example.com', '2583691471', '159 Ash St'),
(1010, 'Benjamin', 'Thomas', '1989-03-14', 'benjamin.thomas@example.com', '7894561231', '753 Oak St'),
(1011, 'Isabella', 'Hernandez', '1994-07-28', 'isabella.hernandez@example.com', '4567891231', '951 Pine St'),
(1012, 'Jacob', 'Moore', '1979-09-16', 'jacob.moore@example.com', '8521479631', '357 Cedar St'),
(1013, 'Mia', 'White', '1995-05-09', 'mia.white@example.com', '1597534861', '654 Spruce St'),
(1014, 'Ethan', 'Clark', '1982-02-06', 'ethan.clark@example.com', '3571592581', '852 Walnut St'),
(1015, 'Charlotte', 'Lee', '1988-10-25', 'charlotte.lee@example.com', '9514567892', '159 Maple St'),
(1016, 'Daniel', 'King', '1990-08-19', 'daniel.king@example.com', '7893216542', '357 Birch St'),
(1017, 'Amelia', 'Wright', '1986-04-13', 'amelia.wright@example.com', '9514567893', '654 Ash St'),
(1018, 'Alexander', 'Lopez', '1977-05-27', 'alex.lopez@example.com', '7532581471', '258 Oak St'),
(1019, 'Harper', 'Hill', '1992-11-11', 'harper.hill@example.com', '1598527531', '951 Pine St');
SET IDENTITY_INSERT Customers OFF;

-- Insert data into Employees
SET IDENTITY_INSERT Employees ON;
INSERT INTO Employees (EmployeeID, FirstName, LastName, Position, Email, Phone, HireDate, Salary)
VALUES
(6000, 'Peter', 'Clark', 'Branch Manager', 'peter.clark@bankingdb.com', '1231231235', '2015-06-01', 80000.00),
(6001, 'Susan', 'Adams', 'Loan Officer', 'susan.adams@bankingdb.com', '2342342346', '2016-09-15', 60000.00),
(6002, 'Tom', 'Baker', 'Teller', 'tom.baker@bankingdb.com', '3453453457', '2018-11-20', 40000.00),
(6003, 'Jennifer', 'Gray', 'Customer Service', 'jennifer.gray@bankingdb.com', '4564564568', '2019-01-10', 42000.00),
(6004, 'David', 'Hill', 'Branch Manager', 'david.hill@bankingdb.com', '5675675679', '2014-04-25', 85000.00),
(6005, 'Laura', 'Scott', 'Accountant', 'laura.scott@bankingdb.com', '6786786780', '2017-08-30', 65000.00),
(6006, 'Mark', 'Young', 'IT Specialist', 'mark.young@bankingdb.com', '7897897891', '2016-12-05', 70000.00),
(6007, 'Angela', 'King', 'Compliance Officer', 'angela.king@bankingdb.com', '8908908902', '2018-03-17', 75000.00);
SET IDENTITY_INSERT Employees OFF;

-- Insert data into Branches
SET IDENTITY_INSERT Branches ON;
INSERT INTO Branches (BranchID, BranchName, Address, Phone, ManagerID)
VALUES
(7000, 'Downtown Branch', '100 Main St', '1112223334', 6000),
(7001, 'Uptown Branch', '200 Market St', '2223334445', 6004),
(7002, 'Westside Branch', '300 Elm St', '3334445556', 6005);
SET IDENTITY_INSERT Branches OFF;

-- Insert data into Accounts
SET IDENTITY_INSERT Accounts ON;
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, InterestRate, Status)
VALUES 
(2000, 1000, 'Savings', 5000.00, 2.5, 'Active'),
(2001, 1001, 'Checking', 1500.00, 0.0, 'Active'),
(2002, 1002, 'Savings', 10000.00, 3.0, 'Active'),
(2003, 1003, 'Credit Card', -2000.00, 15.0, 'Active'),
(2004, 1004, 'Fixed Deposit', 20000.00, 5.0, 'Active'),
(2005, 1005, 'Savings', 8000.00, 2.7, 'Active'),
(2006, 1006, 'Checking', 2500.00, 0.0, 'Active'),
(2007, 1007, 'Loan', -15000.00, 4.5, 'Active'),
(2008, 1008, 'Credit Card', -5000.00, 16.0, 'Active'),
(2009, 1009, 'Savings', 12000.00, 3.2, 'Active'),
(2010, 1010, 'Checking', 3000.00, 0.0, 'Active'),
(2011, 1011, 'Savings', 7000.00, 2.8, 'Active'),
(2012, 1012, 'Fixed Deposit', 25000.00, 5.5, 'Active'),
(2013, 1013, 'Credit Card', -3500.00, 14.5, 'Active'),
(2014, 1014, 'Savings', 6500.00, 2.6, 'Active'),
(2015, 1015, 'Checking', 4500.00, 0.0, 'Active'),
(2016, 1016, 'Loan', -20000.00, 5.0, 'Active'),
(2017, 1017, 'Savings', 9000.00, 3.0, 'Active'),
(2018, 1018, 'Checking', 2200.00, 0.0, 'Active'),
(2019, 1019, 'Savings', 11000.00, 3.1, 'Active');
SET IDENTITY_INSERT Accounts OFF;

-- Insert data into Transactions
SET IDENTITY_INSERT Transactions ON;
INSERT INTO Transactions (TransactionID, CustomerID, AccountID, TransactionType, Amount)
VALUES 
(3000, 1000, 2000, 'Deposit', 1000.00),
(3001, 1001, 2001, 'Withdrawal', 200.00),
(3002, 1000, 2000, 'Transfer', 500.00),
(3003, 1002, 2002, 'Deposit', 2500.00),
(3004, 1003, 2003, 'Payment', 150.00),
(3005, 1004, 2004, 'Deposit', 3000.00),
(3006, 1005, 2005, 'Withdrawal', 400.00),
(3007, 1006, 2006, 'Deposit', 700.00),
(3008, 1007, 2007, 'Fee', 50.00),
(3009, 1008, 2008, 'Payment', 200.00),
(3010, 1009, 2009, 'Deposit', 3500.00),
(3011, 1010, 2010, 'Withdrawal', 500.00),
(3012, 1011, 2011, 'Deposit', 1500.00),
(3013, 1012, 2012, 'Deposit', 5000.00),
(3014, 1013, 2013, 'Payment', 250.00),
(3015, 1014, 2014, 'Deposit', 1200.00),
(3016, 1015, 2015, 'Withdrawal', 300.00),
(3017, 1016, 2016, 'Fee', 75.00),
(3018, 1017, 2017, 'Deposit', 1800.00),
(3019, 1018, 2018, 'Withdrawal', 250.00);
SET IDENTITY_INSERT Transactions OFF;

-- Insert data into Loans
SET IDENTITY_INSERT Loans ON;
INSERT INTO Loans (LoanID, CustomerID, AccountID, LoanType, LoanAmount, InterestRate, LoanTerm, MonthlyPayment, StartDate, EndDate, Status)
VALUES 
(4000, 1000, 2000, 'Home', 200000.00, 3.5, 240, 1200.00, '2024-01-01', '2044-01-01', 'Active'),
(4001, 1001, 2001, 'Auto', 30000.00, 4.0, 60, 600.00, '2023-06-01', '2028-06-01', 'Active'),
(4002, 1002, 2002, 'Personal', 15000.00, 5.0, 36, 450.00, '2022-05-15', '2025-05-15', 'Active'),
(4003, 1003, 2003, 'Education', 50000.00, 4.5, 120, 550.00, '2021-09-01', '2031-09-01', 'Active'),
(4004, 1004, 2004, 'Business', 100000.00, 5.5, 180, 950.00, '2023-03-01', '2038-03-01', 'Active'),
(4005, 1005, 2005, 'Home', 250000.00, 3.2, 360, 1100.00, '2025-07-01', '2055-07-01', 'Active'),
(4006, 1006, 2006, 'Auto', 28000.00, 4.2, 60, 580.00, '2022-11-15', '2027-11-15', 'Active'),
(4007, 1007, 2007, 'Personal', 20000.00, 5.8, 48, 470.00, '2023-08-20', '2027-08-20', 'Active'),
(4008, 1008, 2008, 'Education', 45000.00, 4.3, 120, 500.00, '2021-05-10', '2031-05-10', 'Active'),
(4009, 1009, 2009, 'Business', 150000.00, 5.0, 240, 1300.00, '2024-12-01', '2044-12-01', 'Active'),
(4010, 1010, 2010, 'Home', 180000.00, 3.6, 240, 1150.00, '2023-09-01', '2043-09-01', 'Active'),
(4011, 1011, 2011, 'Auto', 25000.00, 4.1, 60, 520.00, '2022-04-15', '2027-04-15', 'Active'),
(4012, 1012, 2012, 'Personal', 12000.00, 5.5, 36, 360.00, '2024-02-20', '2027-02-20', 'Active'),
(4013, 1013, 2013, 'Education', 60000.00, 4.2, 120, 600.00, '2023-08-01', '2033-08-01', 'Active'),
(4014, 1014, 2014, 'Business', 90000.00, 5.3, 180, 800.00, '2021-06-10', '2036-06-10', 'Active'),
(4015, 1015, 2015, 'Home', 220000.00, 3.4, 360, 1050.00, '2022-12-01', '2052-12-01', 'Active'),
(4016, 1016, 2016, 'Auto', 35000.00, 4.6, 60, 650.00, '2025-05-05', '2030-05-05', 'Active'),
(4017, 1017, 2017, 'Personal', 18000.00, 5.7, 48, 400.00, '2021-11-15', '2025-11-15', 'Active'),
(4018, 1018, 2018, 'Education', 55000.00, 4.4, 120, 570.00, '2023-03-25', '2033-03-25', 'Active'),
(4019, 1019, 2019, 'Business', 130000.00, 5.1, 240, 1200.00, '2024-07-01', '2044-07-01', 'Active');
SET IDENTITY_INSERT Loans OFF;

-- Insert data into Payments
SET IDENTITY_INSERT Payments ON;
INSERT INTO Payments (PaymentID, CustomerID, LoanID, AmountPaid)
VALUES 
(5000, 1000, 4000, 1200.00),
(5001, 1001, 4001, 600.00),
(5002, 1002, 4002, 450.00),
(5003, 1003, 4003, 550.00),
(5004, 1004, 4004, 950.00),
(5005, 1005, 4005, 1100.00),
(5006, 1006, 4006, 580.00),
(5007, 1007, 4007, 470.00),
(5008, 1008, 4008, 500.00),
(5009, 1009, 4009, 1300.00),
(5010, 1010, 4010, 1150.00),
(5011, 1011, 4011, 520.00),
(5012, 1012, 4012, 360.00),
(5013, 1013, 4013, 600.00),
(5014, 1014, 4014, 800.00),
(5015, 1015, 4015, 1050.00),
(5016, 1016, 4016, 650.00),
(5017, 1017, 4017, 400.00),
(5018, 1018, 4018, 570.00),
(5019, 1019, 4019, 1200.00);
SET IDENTITY_INSERT Payments OFF;

-- Insert data into AccountServices
SET IDENTITY_INSERT AccountServices ON;
INSERT INTO AccountServices (ServiceID, AccountID, BranchID, EmployeeID)
VALUES
(8000, 2000, 7000, 6001),
(8001, 2001, 7001, 6002),
(8002, 2002, 7000, 6003),
(8003, 2003, 7002, 6004),
(8004, 2004, 7001, 6001),
(8005, 2005, 7002, 6005),
(8006, 2006, 7000, 6006),
(8007, 2007, 7002, 6007),
(8008, 2008, 7001, 6004),
(8009, 2009, 7000, 6002);
SET IDENTITY_INSERT AccountServices OFF;

-- Retrieve data for reporting
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Payments;
SELECT * FROM Employees;
SELECT * FROM Branches;
SELECT * FROM AccountServices;
