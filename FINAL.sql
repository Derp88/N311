-- Create tables, dropsm and sequences used for DB
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
DROP TABLE ItemLog;
DROP TABLE ItemDeleteLog;
DROP TABLE ITEM_OBJECTS;
CREATE TABLE Item (ItemID int NOT NULL PRIMARY KEY, ItemName varchar(255), Location varchar(255), Price number(10,2) , Amount int);
CREATE TABLE ItemLog (ItemID int NOT NULL, ItemName varchar(255), OldPrice number(10,2), NewPrice number(10,2));
CREATE TABLE ItemDeleteLog (ItemID int NOT NULL, ItemName varchar(255), Location varchar(255), Price number(10,2));
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
INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Water Bill', 432.45, '11-Mar-2024', '1');
INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Power Bill', 704.85, '12-Mar-2024', '1');
INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Payroll', 1592.40, '15-Mar-2024', '1');

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

-- Requirements: 2 (if/else), 6 (defined function), 4 (user exception handler)
-- Purpose: Calculate discount for item based on item price.
-- Significance: The store might want an easy way to calculate discount prices for all items consistently
CREATE OR REPLACE FUNCTION CALC_DISCOUNT(price number)
RETURN number is discountPrice number; negative_error EXCEPTION;
BEGIN
    IF price < 0 THEN -- the input price is negative
        RAISE negative_error;
    ELSIF price > 7 THEN
        discountPrice := price * 0.80;
    ELSIF price > 5 THEN
        discountPrice := price * 0.90;
    ELSE
        discountPrice := price * 0.95;
    END IF;
    RETURN discountPrice;
    EXCEPTION WHEN negative_error THEN -- User exception
        DBMS_OUTPUT.PUT_LINE('Tried to apply discount on item of negative price!');
        RETURN 9999;
END;
/
-- Test the function
SELECT Price FROM ITEM WHERE ItemID = 1;
SELECT CALC_DISCOUNT(Price) FROM ITEM WHERE ItemID = 1;
--Test error
SELECT CALC_DISCOUNT(-9) FROM ITEM WHERE ItemID = 1;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 6 (defined function), 4 (system exception handler)
-- Purpose: Divide price of item
-- Significance: The store might want to divide the price of an item to lower it for sales.
CREATE OR REPLACE FUNCTION DIVIDE_PRICE(price number, divideBy number)
RETURN number is dividedPrice number;
BEGIN
    dividedPrice:= price/ divideBy;
    RETURN dividedPrice;
    EXCEPTION WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Cannot divide by zero!');
        RETURN 88888;
END;
/
-- Test coded
SELECT DIVIDE_PRICE(Price, 2) FROM ITEM WHERE ItemId = 1;
SELECT DIVIDE_PRICE(Price, 0) FROM ITEM WHERE ItemId = 1;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 1 (loop, variables), 3 (cursors), 6 (stored procedure)
-- Purpose: Discount items based off of amount inventory
-- Significance: The store might want to discount items that it has in large amouunt of stock (that are assumingly not selling well)
CREATE OR REPLACE PROCEDURE DISCOUNT_ITEMS_ON_INVENTORY(minAmountForDiscount IN INT)
IS
    v_ItemAmount INT;
    v_ItemPrice NUMBER(10,2);
    v_ItemID INT;
    CURSOR c_ItemCursor IS SELECT Item.ItemID, Item.Amount, Item.Price FROM Item;
BEGIN
    OPEN c_ItemCursor;
        LOOP
            FETCH c_ItemCursor INTO v_ItemID, v_ItemAmount, v_ItemPrice;
                IF v_ItemAmount > minAmountForDiscount THEN
                    v_ItemPrice := CALC_DISCOUNT(v_ItemPrice);
                END IF;
            UPDATE ITEM SET Item.Price = v_ItemPrice WHERE Item.ItemID = v_ItemID;
        EXIT WHEN c_ItemCursor%NOTFOUND;
        END LOOP;
        COMMIT;
    CLOSE c_ItemCursor;
END;
/
-- Demo code for procedure
SELECT * FROM ITEM;
EXECUTE DISCOUNT_ITEMS_ON_INVENTORY(45);

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 5 (Trigger),
-- Purpose: Log when an item's price is updated
-- Significance: The store's item prices are always changing, it is good to see how each item's price is changing overtime to see how much we are having to discount or raise it.
CREATE OR REPLACE TRIGGER ITEM_LOG_PRICE_UPDATE
AFTER UPDATE ON ITEM
FOR EACH ROW
BEGIN
    IF :OLD.Price != :NEW.Price THEN -- The price did change
        INSERT INTO ItemLog VALUES (:OLD.ItemID, :OLD.ItemName, :OLD.Price, :NEW.Price);
    END IF;
END;
/
EXECUTE DISCOUNT_ITEMS_ON_INVENTORY(45);
SELECT * FROM ITEMLog;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 5 (Trigger),
-- Purpose: Log when an item is deleted
-- Significance: The store may need to know if an item has been deleted from its inventory, so it knows what it no longer carries or offers.
CREATE OR REPLACE TRIGGER ITEM_LOG_DELETE
AFTER DELETE ON ITEM
FOR EACH ROW
BEGIN
    INSERT INTO ItemDeleteLog VALUES (:OLD.ItemID, :OLD.ItemName, :OLD.Location, :OLD.Price);
END;
/
INSERT INTO Item VALUES (ItemID.NextVal, 'TestItem', 'Aisle 99', 5.25, 100);
DELETE FROM Item WHERE ItemName = 'TestItem';
SELECT * FROM ItemDeleteLog;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 8 (Package), 7 (Store procedure), and another function
-- Purpose: Have a package to manage bills
-- Significance: The store needs to know the average it spends on bills of a type, and an easy way to input bills
CREATE OR REPLACE PACKAGE EXPENSE_MANAGMENT AS
    PROCEDURE INSERT_NEW_BILLS (waterExpense IN NUMBER, powerExpense IN NUMBER, payrollExpense IN NUMBER);
    FUNCTION AVG_BILL (billType IN VARCHAR) return NUMBER;
END EXPENSE_MANAGMENT;
/

CREATE OR REPLACE PACKAGE BODY EXPENSE_MANAGMENT AS
PROCEDURE INSERT_NEW_BILLS (waterExpense IN NUMBER, powerExpense IN NUMBER, payrollExpense IN NUMBER)
AS
BEGIN
    INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Water Bill', waterExpense, SYSDATE, '1');
    INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Power Bill', powerExpense, SYSDATE, '1');
    INSERT INTO Expense VALUES (ExpenseID.NextVal, 'Payroll', payrollExpense, SYSDATE, '1');
END INSERT_NEW_BILLS;

FUNCTION AVG_BILL (billType IN VARCHAR) return NUMBER is billAvg Number(10,2);
BEGIN
    SELECT AVG(Cost) INTO billAvg FROM Expense WHERE Type = billType;
    RETURN billAvg;
END AVG_BILL;
END EXPENSE_MANAGMENT;
/
-- Test code
BEGIN
    EXPENSE_MANAGMENT.INSERT_NEW_BILLS(100, 200, 1500);
    COMMIT;
END;
/
SELECT * FROM EXPENSE;
SELECT EXPENSE_MANAGMENT.AVG_BILL('Payroll') FROM DUAL;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Requirements: 9 (Object)
-- Purpose: Have an object to store item info
-- Significance: The store needs to know information about an item, so combining it is useful. It also needs to calculate information about said item, which the object can do.
CREATE OR REPLACE TYPE ITEM_TY AS OBJECT 
(Name varchar(255), Price number(10,2), Amount int,
MEMBER FUNCTION VALUE (Price IN number, Amount IN int)  RETURN NUMBER);
/

CREATE OR REPLACE TYPE BODY ITEM_TY AS
MEMBER FUNCTION VALUE (Price IN number, Amount IN int) RETURN NUMBER IS
BEGIN
    RETURN Price*Amount;
END;
END;
/

-- Example use
DROP TABLE ITEM_OBJECTS;
CREATE TABLE ITEM_OBJECTS(Item_ID INT, ItemObj ITEM_TY);
INSERT INTO ITEM_OBJECTS VALUES (1, ITEM_TY('Soda', 4, 10));
SELECT I.ItemObj.VALUE(I.ItemObj.Price, I.ItemObj.Amount) FROM ITEM_OBJECTS I;
