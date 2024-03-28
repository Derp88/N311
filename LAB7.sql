--Problem 1
DROP TABLE Review;
CREATE TABLE Review(EmployeeID INT NOT NULL PRIMARY KEY, PerformanceReview INT);

INSERT INTO Review (EmployeeID) SELECT EmployeeID FROM EmployeeInfo;

--PL/SQL Code to insert performance review values
DECLARE
    CURSOR c_EmployeeCursor IS SELECT PerformanceReview FROM Review;
BEGIN
    FOR performanceRecord IN c_EmployeeCursor --Requirement 3, use cursor
        LOOP
            UPDATE Review SET PerformanceReview = DBMS_RANDOM.VALUE(1,6);
        END LOOP;
        COMMIT;
END;
/
SELECT * FROM REVIEW;

--Problem 2
DROP TABLE Bonus;
CREATE TABLE Bonus(EmployeeID INT NOT NULL PRIMARY KEY, FirstName VARCHAR(255), LastName VARCHAR(255), Salary INT, BonusAmount NUMBER(10,2));

INSERT INTO Bonus (EmployeeID, FirstName, LastName, Salary) SELECT EmployeeID, FirstName, LastName, Salary FROM EmployeeInfo;

--PL/SQL Code to calculate bonus amount
DECLARE
    v_salary NUMBER(10,2);
    v_performanceReview INT;
    v_bonus NUMBER(10,2);
    v_employeeID INT;
    CURSOR c_BonusCursor IS SELECT Bonus.EmployeeID, Bonus.Salary, Review.PerformanceReview INTO v_employeeID, v_salary, v_performanceReview FROM Bonus, Review WHERE Bonus.EmployeeID = Review.EmployeeID;
BEGIN
    OPEN c_BonusCursor;
        LOOP
            FETCH c_BonusCursor INTO v_employeeID, v_salary, v_performanceReview;
            IF v_performanceReview = 5 THEN
                v_bonus := v_salary*.10;
            ELSIF v_performanceReview = 4 THEN
                v_bonus := v_salary*.08;
            ELSIF v_performanceReview = 3 THEN
                v_bonus := v_salary*.05;
            ELSE
                v_bonus := 0; --0 percent bonus
            END IF;
            UPDATE Bonus SET BonusAmount = v_bonus WHERE EmployeeID = v_employeeID;
            COMMIT;
        EXIT WHEN c_BonusCursor%NOTFOUND;
        END LOOP;
        CLOSE c_BonusCursor;
        
END;
/

SELECT * FROM BONUS;
