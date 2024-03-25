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

--19 Sequence for ID
DROP SEQUENCE ItemID;
DROP SEQUENCE ShippingID;
DROP SEQUENCE CustomerID;
DROP SEQUENCE PurchaseID;
DROP SEQUENCE OwnerAdminID;
DROP SEQUENCE ExpenseID;
DROP SEQUENCE ManagerID;
DROP SEQUENCE EmployeeID;
DROP SEQUENCE TimeOffID;
DROP SEQUENCE ScheduleID;
DROP SEQUENCE IncomeID;
CREATE SEQUENCE ItemID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE ShippingID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE CustomerID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE PurchaseID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE OwnerAdminID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE ExpenseID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE ManagerID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE EmployeeID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE TimeOffID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE ScheduleID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE IncomeID INCREMENT BY 1 START WITH 1;

--3. CREATE TABLES AND EXAMPLE DATA
--Create tables
CREATE TABLE Item (ItemID int NOT NULL PRIMARY KEY, ItemName varchar(255), Location varchar(255), Price number(10,2) , Amount int);
CREATE TABLE ShippingReceiving(ShippingID int NOT NULL PRIMARY KEY, ItemID, CONSTRAINT fk_ItemID FOREIGN KEY (ItemID) REFERENCES Item(ItemID), ArrivalDate date, Amount int, ShippingCompany varchar(255));
CREATE TABLE Customer(CustomerID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date NOT NULL, Email varchar(255) NOT NULL UNIQUE, Phone varchar(10) NOT NULL UNIQUE); --Item 17
CREATE TABLE Purchase(PurchaseID int NOT NULL PRIMARY KEY, CustomerID, CONSTRAINT fk_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), ItemID, CONSTRAINT fk_ItemIDPurchase FOREIGN KEY (ItemID) REFERENCES Item(ItemID), Time date); 
CREATE TABLE OwnerAdmin(OwnerAdminID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date, Phone varchar(10));
CREATE TABLE Expense(ExpenseID int NOT NULL PRIMARY KEY, Type varchar(255), Cost number(10,2), PaidOnDate date, OwnerAdminID, CONSTRAINT fk_OwnerAdminID FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID));
CREATE TABLE Manager(ManagerID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date NOT NULL, Phone varchar(10), Pay number(10,2), OwnerAdminID, CONSTRAINT fk_OwnerAdminIDManager FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID)); --17
CREATE TABLE Employee(EmployeeID int NOT NULL PRIMARY KEY, FirstName varchar(255), LastName varchar(255), DOB date NOT NULL, Phone varchar(10), Pay number(10,2), Position varchar(255), ManagerID, CONSTRAINT fk_ManagerID FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)); --17
CREATE TABLE TimeOff(TimeOffID int NOT NULL PRIMARY KEY, EmployeeID, CONSTRAINT fk_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID), Reason varchar(255), StartingDate date, EndingDate date);
CREATE TABLE WeeklySchedule(ScheduleID int NOT NULL PRIMARY KEY, EmployeeID, CONSTRAINT fk_EmployeeIDSchedule FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID), ShiftStartTime date, ShiftEndTime date);
CREATE TABLE WeeklyIncome(IncomeID int NOT NULL PRIMARY KEY, Income number(10,2), EntranceDate date, OwnerAdminID, CONSTRAINT fk_OwnerAdminIDIncome FOREIGN KEY (OwnerAdminID) REFERENCES OwnerAdmin(OwnerAdminID));

--Insert some test data
INSERT INTO Item VALUES (ItemID.NextVal, 'Cheese', 'Aisle 2B', 5.25, 100);
INSERT INTO Item VALUES (ItemID.NextVal, 'Acorns', 'Aisle 9S', 2.00, 5);
INSERT INTO Item VALUES (ItemID.NextVal, 'Bread', 'Aisle A2', 3.00, 33);
INSERT INTO Item VALUES (ItemID.NextVal, 'Salsa', 'Aisle 6O', 2.50, 21);
INSERT INTO Item VALUES (ItemID.NextVal, 'Chips', 'Aisle 21O', 4.00, 47);
INSERT INTO Item VALUES (ItemID.NextVal, 'Bacon', 'Aisle 13B', 8.75, 9);

INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 2, '27-Feb-2024', 20, 'FedEx');
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 4, '29-Feb-2024', 10, 'UPS');
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 1, '23-Feb-2024', 15, 'USPS');
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 5, '29-Feb-2024', 200, 'UPS');
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 6, SYSDATE, 500, 'FedEx');
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 3, NEXT_DAY(SYSDATE, 'Monday'), 197, 'FedEx');

INSERT INTO Customer VALUES (CustomerID.NextVal, 'Steve', 'Jobs', '1-Dec-1965', 'stevejobs25@apple.com', '3042142332');
INSERT INTO Customer VALUES (CustomerID.NextVal, '9S', 'YoRHa', '30-Jan-1942', 'nines@yorha.net', '9999999999');
INSERT INTO Customer VALUES (CustomerID.NextVal, 'Steve', 'Jobs', '7-Jan-1942', 'tubes@yorha.net', '2222222222');

INSERT INTO Purchase VALUES (PurchaseID.NextVal, 2, 2, to_date('25-Feb-2024 9:56 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (PurchaseID.NextVal, 2, 3, to_date('25-Feb-2024 9:57 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (PurchaseID.NextVal, 1, 4, to_date('21-Feb-2024 6:56 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (PurchaseID.NextVal, 1, 4, to_date('21-Feb-2024 6:58 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (PurchaseID.NextVal, 2, 3, to_date('27-Feb-2024 9:57 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO Purchase VALUES (PurchaseID.NextVal, 2, 3, to_date('27-Feb-2024 9:58 A.M.', 'dd-mon-yyyy hh:mi A.M.'));

INSERT INTO OwnerAdmin VALUES (OwnerAdminID.NextVal, 'Gronald', 'Bingus', '31-Oct-1969', '7981251457');

INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Water Bill', 232.45, '11-Feb-2024', '1');
INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Power Bill', 904.85, '12-Feb-2024', '1');
INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Payroll', 1292.40, '15-Feb-2024', '1');

INSERT INTO Manager VALUES (ManagerID.NextVal, 'Joe', 'Biden', '30-Nov-1942', '8745212514', 63000.43, 1);
INSERT INTO Manager VALUES (ManagerID.NextVal, 'Donald', 'Trump', '14-Jun-1946', '8749872512', 83000.43, 1);

INSERT INTO Employee VALUES (EmployeeID.NextVal, 'Lewis', 'Brindley', '22-Oct-1983', '7652221010', 25000.58, 'Stocker', 1);
INSERT INTO Employee VALUES (EmployeeID.NextVal, 'Simon', 'Lane', '14-Mar-1978', '7652221975', 22000.58, 'Stocker', 1);
INSERT INTO Employee VALUES (EmployeeID.NextVal, 'Chris', 'Lovasz', '5-Jun-1980', '1113548747', 45000.58, 'Janitor', 2);
INSERT INTO Employee VALUES (EmployeeID.NextVal, 'Duncan', 'Jones', '1-Mar-1987', '7652229922', 27000.58, 'Maintenance', 2);
INSERT INTO Employee VALUES (EmployeeID.NextVal, 'Ben', 'Edgar', '2-Feb-1983', '5415789855', 12000.58, 'Cashier', 1); 

INSERT INTO TimeOff VALUES (TimeOffID.NextVal, 1, 'Vacation', '1-Mar-2024', '30-Mar-2024');
INSERT INTO TimeOff VALUES (TimeOffID.NextVal, 5, 'Family', '27-Feb-2024', '28-Feb-2024');

--First date is starting week day and daily hour. Last date is ending week day and daily hour.
INSERT INTO WeeklySchedule VALUES (ScheduleID.NextVal, 2, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('29-Feb-2024 10:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO WeeklySchedule VALUES (ScheduleID.NextVal, 3, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('1-Mar-2024 3:30 P.M.', 'dd-mon-yyyy hh:mi A.M.'));
INSERT INTO WeeklySchedule VALUES (ScheduleID.NextVal, 4, to_date('26-Feb-2024 6:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'), to_date('28-Feb-2024 10:30 A.M.', 'dd-mon-yyyy hh:mi A.M.'));

INSERT INTO WeeklyIncome VALUES (IncomeID.NextVal, 60000.00, '5-Feb-2024', 1);
INSERT INTO WeeklyIncome VALUES (IncomeID.NextVal, 70000.00, '12-Feb-2024', 1);
INSERT INTO WeeklyIncome VALUES (IncomeID.NextVal, 50000.00, '19-Feb-2024', 1);

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
--6. NUMBER FNUCTIONS
SELECT ItemName, TRUNC(PRICE) AS PRICE FROM ITEM; --get price without decimals
SELECT ItemName, ABS(PRICE) AS PRICE FROM ITEM; --get price, with confirming the value is positive
--7. DATE FUNCTIONS (COMPLETED IN 4. VIEWS)

--8. DECODE (Gets job type)
SELECT FirstName, LastName, Position, DECODE(Position, 'Cashier', 'Service', 'Stocker', 'Service', 'Upkeep') AS TYPE FROM EMPLOYEE;

--9. GROUP BY & HAVING (Show items bought more than once)
SELECT COUNT(PurchaseID) AS AMOUNT, ItemID FROM PURCHASE GROUP BY ItemID HAVING COUNT(ItemID) > 1;

--10. Sub query (Selects only items that have been purchased)
SELECT ItemName FROM Item WHERE ItemID IN (SELECT ItemID FROM Purchase);

--11. Inner Join and Ouuter Join
--11. Inner Join (show name of what was bought)
SELECT PurchaseID, Item.ItemID, ItemName FROM Item INNER JOIN Purchase ON Item.ItemID = Purchase.ItemID;
--11. Outer left join, shows purchased items, then items that were not purchased as null
SELECT PurchaseID, Item.ItemID, ItemName FROM Item LEFT JOIN Purchase ON Item.ItemID = Purchase.ItemID;

--12 Save points (use for temp sale, can roleback price)
SELECT * FROM Item WHERE ItemName = 'Cheese';
SAVEPOINT before_discount_cheese;
UPDATE Item SET Price = 1.00 WHERE ItemName = 'Cheese';
SELECT * FROM Item WHERE ItemName = 'Cheese';
ROLLBACK TO SAVEPOINT before_discount_cheese;
SELECT * FROM Item WHERE ItemName = 'Cheese';

--13 Insert & Delete through a view. Insert some new delivieres for today, remove a mistake.
INSERT INTO todays_deliveries VALUES (ShippingID.NextVal, 6, SYSDATE, 25, 'DHL');
INSERT INTO todays_deliveries VALUES (ShippingID.NextVal, 6, SYSDATE, 9, 'DHLLLLL'); --mistake made
DELETE FROM todays_deliveries WHERE ShippingID = 8;

--14 Update with embedded select. Set price of corn from price of cheese
INSERT INTO Item VALUES (ItemID.NextVal, 'Corn', 'Aisle 2B', 2, 7); --data to update
SELECT * FROM Item WHERE ItemName = 'Corn';
UPDATE Item set Price = (SELECT Price FROM Item where ItemName = 'Cheese') WHERE ItemName = 'Corn';
SELECT * FROM Item WHERE ItemName = 'Corn';

--15 Delte rows using more than one condition in where clause
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 4, '27-Feb-2024', 10, 'FedExxxx'); --data to delete
INSERT INTO ShippingReceiving VALUES (ShippingID.NextVal, 5, '27-Feb-2024', -10, 'FedEx'); --data to delete
SELECT * FROM ShippingReceiving;
DELETE FROM ShippingReceiving WHERE (ShippingCompany = 'FedExxxx' or Amount < 0);
SELECT * FROM ShippingReceiving;

--16 Create a table from another table (Create a backup of items)
DROP TABLE ItemBackup;
CREATE TABLE ItemBackup(ItemID int NOT NULL PRIMARY KEY, ItemName varchar(255), Location varchar(255), Price number(10,2) , Amount int);
INSERT INTO ItemBackup SELECT * FROM Item;
SELECT * FROM ItemBackup;

--17 Constraints added in creation section

--18 Create index. We will create one for item names, as they will be often searched by customers and staff
CREATE INDEX Item_Index ON Item (ItemName);

--19 sequences created at top
--Example script that show auto incrementation worked
SELECT ItemID FROM ITEM;





