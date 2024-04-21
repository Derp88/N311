-- Step 1 TEMP table. REQ: Create table by copying any 10 rows from the table you created in lab 6 
CREATE TABLE TEMP AS SELECT * FROM EmployeeInfo WHERE ROWNUM <= 10; -- create new table, copy only 10 rows from lab 6 table
SELECT * FROM TEMP;

-- Step 2 PHONE_USERS
CREATE TABLE PHONE_USERS(TELEPHONE_NUMBER VARCHAR2(80) NOT NULL PRIMARY KEY, FIRST_NAME VARCHAR2(80), LAST_NAME VARCHAR2(80) UNIQUE, KEYMAP_LASTNAME CHAR(4), PASSWORD VARCHAR2(80));

-- Step 3 function
CREATE OR REPLACE FUNCTION KEYMAP(lastName VARCHAR2)
RETURN VARCHAR2 is teleExtension VARCHAR2(4);
BEGIN
    teleExtension := TRANSLATE(UPPER(SUBSTR(lastName, 1, 4)),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','22233344455566677778889999');
    -- Pad with 0 if needed
    teleExtension := RPAD(teleExtension, 4, '0');
    RETURN teleExtension;
END;
/

SELECT KEYMAP('Doe') AS teleExtension FROM DUAL; -- Test example

-- Step 4 procedure
CREATE OR REPLACE PROCEDURE sp_p(n IN INT) IS v_TELEPHONE_NUMBER VARCHAR2(14); v_LAST_NAME  varchar2(255); v_KEYMAP_LASTNAME VARCHAR2(4);
BEGIN
    FOR i IN 1..n LOOP
        --FOR j IN 1..10 LOOP
        FOR row in (SELECT * FROM TEMP) LOOP -- This will only select 10 rows as temp only has 10 rows, as defined by project requirements
            --Generate telephone number
            v_TELEPHONE_NUMBER := '(' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 1000)), 3, '0') || ')'
            || ' ' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 1000)), 3, '0') || '-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 10000)), 4, '0');
            --Generate last name
            v_LAST_NAME := row.LastName || LPAD(i, 4, '0');
            INSERT INTO PHONE_USERS VALUES (v_TELEPHONE_NUMBER, row.FirstName, v_LAST_NAME, KEYMAP(row.LastName), row.Password);
        END LOOP;
    END LOOP;
    COMMIT;
END;
/
-- Test scripts
DELETE FROM PHONE_USERS;
EXECUTE sp_p(2);
SELECT * FROM PHONE_USERS;

-- Step 5 package
CREATE OR REPLACE PACKAGE PHONE_MANAGEMENT AS
    FUNCTION KEYMAP(lastName VARCHAR2) RETURN VARCHAR2;
    PROCEDURE sp_p(n IN INT);
END PHONE_MANAGEMENT;
/

CREATE OR REPLACE PACKAGE BODY PHONE_MANAGEMENT AS

FUNCTION KEYMAP(lastName VARCHAR2) RETURN VARCHAR2 is teleExtension VARCHAR2(4);
BEGIN
    teleExtension := TRANSLATE(UPPER(SUBSTR(lastName, 1, 4)),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','22233344455566677778889999');
    -- Pad with 0 if needed
    teleExtension := RPAD(teleExtension, 4, '0');
    RETURN teleExtension;
END KEYMAP;

PROCEDURE sp_p(n IN INT) IS v_TELEPHONE_NUMBER VARCHAR2(14); v_LAST_NAME  varchar2(255); v_KEYMAP_LASTNAME VARCHAR2(4);
BEGIN
    FOR i IN 1..n LOOP
        --FOR j IN 1..10 LOOP
        FOR row in (SELECT * FROM TEMP) LOOP -- This will only select 10 rows as temp only has 10 rows, as defined by project requirements
            --Generate telephone number
            v_TELEPHONE_NUMBER := '(' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 1000)), 3, '0') || ')'
            || ' ' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 1000)), 3, '0') || '-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(000, 10000)), 4, '0');
            --Generate last name
            v_LAST_NAME := row.LastName || LPAD(i, 4, '0');
            INSERT INTO PHONE_USERS VALUES (v_TELEPHONE_NUMBER, row.FirstName, v_LAST_NAME, KEYMAP(row.LastName), row.Password);
        END LOOP;
    END LOOP;
    COMMIT;
END sp_p;

END PHONE_MANAGEMENT;
/

-- Step 6 run programs
-- Test function
SELECT PHONE_MANAGEMENT.KEYMAP('Doe') FROM Dual;
-- Test procedure
DELETE FROM PHONE_USERS;
BEGIN
    PHONE_MANAGEMENT.sp_p(5);
END;
/
SELECT * FROM PHONE_USERS;
