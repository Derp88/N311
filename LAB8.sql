DROP TABLE  EMPLOYEE_LOG;

CREATE TABLE EMPLOYEE_LOG(EmployeeID INT, FirstName VARCHAR(255), LastName VARCHAR(255), Email VARCHAR(255), Password VARCHAR(255), Salary INT, MOD_USER VARCHAR2(10), MOD_TIMESTAMP DATE);

-- Insert trigger
CREATE OR REPLACE TRIGGER EMPLOYEE_LOG_INSERT_ROW
AFTER INSERT ON EMPLOYEEINFO
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_LOG(EmployeeID, MOD_USER, MOD_TIMESTAMP) VALUES (:NEW.EmployeeID, USER, SYSDATE);
END;
/
-- Test insert
INSERT INTO EMPLOYEEINFO VALUES (EmployeeID.NextVal, 'John', 'Doe', 'test@gmail.com', 'password', 222);

-- Update trigger
CREATE OR REPLACE TRIGGER EMPLOYEE_LOG_UPDATE_ROW
AFTER UPDATE ON EMPLOYEEINFO
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_LOG VALUES (:OLD.EmployeeID, :OLD.FirstName, :OLD.LastName, :OLD.Email, :OLD.Password, :OLD.Salary, USER, SYSDATE);
END;
/

-- Test insert and update
INSERT INTO EMPLOYEEINFO VALUES (9999, 'Bill', 'Bob', 'helloWorld@gmail.com', 'password', 652);
UPDATE EMPLOYEEINFO SET LastName = 'Bobby', Email = 'fooBar@hotmail.com' WHERE EmployeeID = 9999;



-- Part 2. Statement Level Trigger

-- I want to keep track of the total numbers of statements performed on the BOOK_ORDER table. (I don't want to track number of rows updated, just statements ran)
-- The trigger works by updating the count of the operation by which operation was performed.
DROP TABLE BOOK_ORDER_LOG;
CREATE TABLE BOOK_ORDER_LOG(TotalAmount INT, InsertAmount INT, UpdateAmount INT, DeleteAmount INT);
INSERT INTO BOOK_ORDER_LOG VALUES (0,0,0,0);

CREATE OR REPLACE TRIGGER BOOK_ORDER_UPDATE_LOG
AFTER INSERT OR UPDATE OR DELETE ON BOOK_ORDER
BEGIN
    UPDATE BOOK_ORDER_LOG SET TotalAmount = TotalAmount + 1;
    IF INSERTING THEN
        UPDATE BOOK_ORDER_LOG SET InsertAmount = InsertAmount + 1;
    ELSIF UPDATING THEN
        UPDATE BOOK_ORDER_LOG SET UpdateAmount = UpdateAmount + 1;
    ELSIF DELETING THEN
        UPDATE BOOK_ORDER_LOG SET DeleteAmount = DeleteAmount + 1;
    END IF;
END;
/
-- Test values
INSERT INTO BOOK_ORDER VALUES ('4444', 'me', 'testCat');
INSERT INTO BOOK_ORDER VALUES ('5555', 'me', 'testCat');
INSERT INTO BOOK_ORDER VALUES ('1111', 'me', 'testCat');
DELETE FROM BOOK_ORDER WHERE TITLE = '4444';
UPDATE BOOK_ORDER SET Publisher = 'you' WHERE TITLE = '5555';



-- Part 3. Schema level trigger
DROP TABLE OBJECT_CREATION_TRACK;
CREATE TABLE OBJECT_CREATION_TRACK(ObjectAmount INT, CreateDate DATE);

CREATE OR REPLACE TRIGGER DB_CREATE_OBJECT
AFTER CREATE ON SCHEMA
DECLARE
    v_FOUND int;
BEGIN
    SELECT COUNT(*) INTO v_FOUND FROM OBJECT_CREATION_TRACK WHERE trunc(CreateDate) = trunc(SysDate);
    -- Only run if exesting date
    IF v_FOUND != 0 THEN
        UPDATE OBJECT_CREATION_TRACK SET ObjectAmount = ObjectAmount + 1 WHERE trunc(CreateDate) = trunc(SysDate);
    ELSE
        INSERT INTO OBJECT_CREATION_TRACK VALUES (1, SYSDATE);
    END IF;
END;
/

-- Tables to test object tracking
DROP TABLE TEST_TABLE;
CREATE TABLE TEST_TABLE(test INT);



