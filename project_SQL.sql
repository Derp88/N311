--Drop tables if needed.
DROP TABLE Item;
DROP TABLE ShippingReceiving;

--Create tables
CREATE TABLE Item (ItemID int NOT NULL PRIMARY KEY, ItemName varchar(255), Location varchar(255), Price int , Amount int);
CREATE TABLE ShippingReceiving(ShippingID int NOT NULL PRIMARY KEY, ItemID, CONSTRAINT fk_ItemID FOREIGN KEY (ItemID) REFERENCES Item(ItemID), ArrivalDate date, Amount int, ShippingCompany varchar(255));

--Insert some test data
INSERT INTO Item VALUES (1, 'Cheese', 'Aisle 2B', 500, 100);
INSERT INTO Item VALUES (2, 'Acorns', 'Aisle 9S', 200, 5);
INSERT INTO Item VALUES (3, 'Bread', 'Aisle A2', 300, 33);
INSERT INTO Item VALUES (4, 'Salsa', 'Aisle 6O', 250, 21);
INSERT INTO Item VALUES (5, 'Chips', 'Aisle 21O', 400, 47);

INSERT INTO ShippingReceiving VALUES (3, 1, '23-Feb-2024', 15, 'USPS');
INSERT INTO ShippingReceiving VALUES (1, 2, '27-Feb-2024', 20, 'FedEx');
INSERT INTO ShippingReceiving VALUES (2, 4, '29-Feb-2024', 10, 'UPS');


