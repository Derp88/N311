--Drop tables if needed.
DROP TABLE ShippingReceiving;
DROP TABLE Purchase;
DROP TABLE TimeOff;
DROP TABLE WeeklySchedule;
DROP TABLE Employee;
DROP TABLE Manager;
DROP TABLE Expense;
DROP TABLE Item;
DROP TABLE Customer;
DROP TABLE WeeklyIncome;
DROP TABLE OwnerAdmin;

DROP VIEW low_stock;
DROP VIEW large_delivery;
DROP VIEW todays_deliveries;
DROP VIEW next_monday_deliveries;
DROP VIEW stockers;

--Create tables
CREATE TABLE Item (ItemID int NOT NULL PRIMARY KEY, ItemName varchar(255), Location varchar(255), Price int , Amount int);
CREATE TABLE ShippingReceiving(ShippingID int NOT NULL PRIMARY KEY, ItemID, CONSTRAINT fk_ItemID FOREIGN KEY (ItemID) REFERENCES Item(ItemID), ArrivalDate date, Amount int, ShippingCompany varchar(255));
CREATE TABLE Customer(CustomerID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date, Email varchar(255), Phone varchar(10));
CREATE TABLE Purchase(PurchaseID int NOT NULL PRIMARY KEY, CustomerID, CONSTRAINT fk_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), ItemID, CONSTRAINT fk_ItemIDPurchase FOREIGN KEY (ItemID) REFERENCES Item(ItemID), Time date); 
CREATE TABLE OwnerAdmin(OwnerAdminID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date, Phone varchar(10));
CREATE TABLE Expense(ExpenseID int NOT NULL PRIMARY KEY, Type varchar(255), Cost int, PaidOnDate date, OwnerAdminID, CONSTRAINT fk_OwnerAdminID FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID));
CREATE TABLE Manager(ManagerID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date, Phone varchar(10), Pay int, OwnerAdminID, CONSTRAINT fk_OwnerAdminIDManager FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID));
CREATE TABLE Employee(EmployeeID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date, Phone varchar(10), Pay int, Position varchar(255), ManagerID, CONSTRAINT fk_ManagerID FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID));
CREATE TABLE TimeOff(TimeOffID int NOT NULL PRIMARY KEY, EmployeeID, CONSTRAINT fk_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID), Reason varchar(255), StartingDate date, EndingDate date);
CREATE TABLE WeeklySchedule(ScheduleID int NOT NULL PRIMARY KEY, EmployeeID, CONSTRAINT fk_EmployeeIDSchedule FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID), ShiftStartTime date, ShiftEndTime date);
CREATE TABLE WeeklyIncome(IncomeID int NOT NULL PRIMARY KEY, Amount int, EntranceDate date, OwnerAdminID, CONSTRAINT fk_OwnerAdminIDIncome FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID));

--Insert some test data
INSERT INTO Item VALUES (1, 'Cheese', 'Aisle 2B', 500, 100);
INSERT INTO Item VALUES (2, 'Acorns', 'Aisle 9S', 200, 5);
INSERT INTO Item VALUES (3, 'Bread', 'Aisle A2', 300, 33);
INSERT INTO Item VALUES (4, 'Salsa', 'Aisle 6O', 250, 21);
INSERT INTO Item VALUES (5, 'Chips', 'Aisle 21O', 400, 47);
INSERT INTO Item VALUES (6, 'Bacon', 'Aisle 13B', 800, 9);

INSERT INTO ShippingReceiving VALUES (3, 1, '23-Feb-2024', 15, 'USPS');
INSERT INTO ShippingReceiving VALUES (1, 2, '27-Feb-2024', 20, 'FedEx');
INSERT INTO ShippingReceiving VALUES (2, 4, '29-Feb-2024', 10, 'UPS');
INSERT INTO ShippingReceiving VALUES (4, 5, '29-Feb-2024', 200, 'UPS');
INSERT INTO ShippingReceiving VALUES (5, 6, SYSDATE, 500, 'FedEx');
INSERT INTO ShippingReceiving VALUES (6, 3, NEXT_DAY(SYSDATE, 'Monday'), 197, 'FedEx');

INSERT INTO Customer VALUES (1, 'Steve', 'Jobs', '1-Dec-1965', 'stevejobs25@apple.com', '3042142332');
INSERT INTO Customer VALUES (2, '9S', 'YoRHa', '30-Jan-1942', 'nines@yorha.net', '9999999999');
INSERT INTO Customer VALUES (3, 'Steve', 'Jobs', '7-Jan-1942', 'tubes@yorha.net', '2222222222');

INSERT INTO Purchase VALUES (1, 2, 2, to_date('25-Feb-2024 9:56 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (2, 2, 3, to_date('25-Feb-2024 9:57 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (3, 1, 4, to_date('21-Feb-2024 6:56 A.M.', 'dd-mon-yyyy hh:mi A.M.'));

INSERT INTO OwnerAdmin VALUES (1, 'Gronald', 'Bingus', '31-Oct-1969', '7981251457');

INSERT INTO Expense VALUES (1, 'Water Bill', 23245, '11-Feb-2024', '1');
INSERT INTO Expense VALUES (2, 'Power Bill', 90485, '12-Feb-2024', '1');
INSERT INTO Expense VALUES (3, 'Payroll', 129240, '15-Feb-2024', '1');

INSERT INTO Manager VALUES (1, 'Joe', 'Biden', '30-Nov-1942', '8745212514', 6300043, 1);
INSERT INTO Manager VALUES (2, 'Donald', 'Trump', '14-Jun-1946', '8749872512', 8300043, 1);

INSERT INTO Employee VALUES (1, 'Lewis', 'Brindley', '22-Oct-1983', '7652221010', 2500058, 'Stocker', 1);
INSERT INTO Employee VALUES (2, 'Simon', 'Lane', '14-Mar-1978', '7652221975', 2200058, 'Stocker', 1);
INSERT INTO Employee VALUES (3, 'Chris', 'Lovasz', '5-Jun-1980', '1113548747', 4500058, 'Janitor', 2);
INSERT INTO Employee VALUES (4, 'Duncan', 'Jones', '1-Mar-1987', '7652229922', 2700058, 'Maintenance', 2);
INSERT INTO Employee VALUES (5, 'Ben', 'Edgar', '2-Feb-1983', '5415789855', 1200058, 'Cashier', 1); 

INSERT INTO TimeOff VALUES (1, 1, 'Vacation', '1-Mar-2024', '30-Mar-2024');
INSERT INTO TimeOff VALUES (2, 5, 'Family', '27-Feb-2024', '28-Feb-2024');

--First date is starting week day and daily hour. Last date is ending week day and daily hour.
INSERT INTO WeeklySchedule VALUES (1, 2, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('29-Feb-2024 10:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO WeeklySchedule VALUES (2, 3, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('1-Mar-2024 3:30 P.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO WeeklySchedule VALUES (3, 4, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('28-Feb-2024 10:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'));

INSERT INTO WeeklyIncome VALUES (1, 6000000, '5-Feb-2024', 1);
INSERT INTO WeeklyIncome VALUES (2, 7000000, '12-Feb-2024', 1);
INSERT INTO WeeklyIncome VALUES (3, 5000000, '19-Feb-2024', 1);

----------------------------------------------------
-----------END-OF-CREATION-SCRIPT-START-ACTUAL------
----------------------------------------------------

--4. VIEWS
CREATE VIEW low_stock AS SELECT * FROM Item WHERE Amount < 10;
CREATE VIEW large_delivery AS SELECT * FROM ShippingReceiving WHERE Amount > 100;
------7. Date function (1/2)
CREATE VIEW todays_deliveries AS SELECT * FROM ShippingReceiving WHERE to_char(SYSDATE, 'DD-MM') = to_char(ArrivalDate, 'DD-MM');
------7. Date function (2/2)
CREATE VIEW next_monday_deliveries AS SELECT * FROM ShippingReceiving WHERE to_char(NEXT_DAY(SYSDATE, 'Monday'), 'DD-MM') = to_char(ArrivalDate, 'DD-MM');
CREATE VIEW stockers AS SELECT * FROM Employee WHERE Position = 'Stocker';
SELECT * FROM low_stock; 
SELECT * FROM large_delivery;
SELECT * FROM todays_deliveries;
SELECT * FROM next_monday_deliveries;
SELECT * FROM stockers;
--5. STRING FUNCTIONS
SELECT SUBSTR(Phone,0,3) FROM Customer; --gets area code
SELECT LPAD(FirstName, 10, '*') AS FIRSTNAME, LastName FROM Customer; --aligns names




