--report table
DROP TABLE Report;
DROP SEQUENCE LogID;
CREATE SEQUENCE LogID INCREMENT BY 1 START WITH 1;
CREATE TABLE Report (LogID INT NOT NULL PRIMARY KEY, TableCount INT, ViewCount INT, IndexCount INT, UserCount INT, LogTime TIMESTAMP);

--PL/SQL code
DECLARE
    v_TableCount INT;
    v_ViewCount INT;
    v_IndexCount INT;
    v_UserCount INT;

BEGIN
    SELECT COUNT(*) INTO v_TableCount FROM ALL_TABLES;
    SELECT COUNT(*) INTO v_ViewCount FROM ALL_VIEWS;
    SELECT COUNT(*) INTO v_IndexCount FROM ALL_INDEXES;
    SELECT COUNT(*) INTO v_UserCount FROM ALL_USERS;
    
    INSERT INTO Report VALUES (LogID.NextVal, v_TableCount, v_ViewCount, v_IndexCount, v_UserCount, SYSTIMESTAMP);
    COMMIT;
    
END;
/

SELECT * FROM Report;

-----------------------------------------------------------
-- Part 2
DROP TABLE EmployeeInfo;
DROP SEQUENCE EmployeeID;
CREATE SEQUENCE EmployeeID INCREMENT BY 1 START WITH 1;
CREATE TABLE EmployeeInfo(EmployeeID INT NOT NULL PRIMARY KEY, FirstName VARCHAR(255), LastName VARCHAR(255), Email VARCHAR(255), Password VARCHAR(255), Salary INT);

--PL/SQL code
DECLARE
    v_FirstName VARCHAR(255);
    v_LastName VARCHAR(255);
    v_Email VARCHAR(255);
    v_Password VARCHAR(255);
    v_Salary INT;
BEGIN
    FOR i IN 0..500 LOOP
        INSERT INTO EmployeeInfo VALUES (EmployeeID.NextVal, DBMS_RANDOM.STRING('L', TRUNC(DBMS_RANDOM.VALUE(1,11))), --first name from 1 to 10
        DBMS_RANDOM.STRING('L', TRUNC(DBMS_RANDOM.VALUE(1,11))), --last name 1 to 10
        -- creates email less than 20. 9MAX + 1 + 5 MAX + 1 + 3 = 19. NOTE THE UPPER BOUND IS NOT INCLUDED. EX: UPPER BOUND 10 generates up to 9 in length
        DBMS_RANDOM.STRING('L', TRUNC(DBMS_RANDOM.VALUE(1,10))) || '@' || DBMS_RANDOM.STRING('L', TRUNC(DBMS_RANDOM.VALUE(1,6))) || '.' || DBMS_RANDOM.STRING('L', TRUNC(DBMS_RANDOM.VALUE(3,3))),
        DBMS_RANDOM.STRING('X', TRUNC(DBMS_RANDOM.VALUE(9,32))), -- password (with characters and digits)
        TRUNC(DBMS_RANDOM.VALUE(0, 100000)));

    END LOOP;
    COMMIT;
END;
/

SELECT * FROM EmployeeInfo;
        
