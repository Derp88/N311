--1
SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') FROM DUAL;

--2
SELECT USER FROM DUAL;

--3
SELECT ROUND(to_date('12/25','MM/DD') - SYSDATE) FROM DUAL;

--4 (PLEASE NOTE, RESULT IS DIFFERENT FOR FEB BECAUSE 2024 IS A LEAP YEAR.)
SELECT TO_CHAR(CYCLEDATE, 'Month') AS Month, LAST_DAY(CYCLEDATE) - CYCLEDATE AS DaysBetween FROM PAYDAY ;

--5 (This is ugly, but it works)
SELECT DISTINCT CONCAT(REGEXP_SUBSTR(PERSON, ' (.+)'), CONCAT(', ', REGEXP_SUBSTR(PERSON, '[^ ]+'))) AS PERSONS FROM LEDGER WHERE PERSON 
    NOT LIKE '%STORE%'
    AND PERSON NOT LIKE '%BROTHERS%'
    AND PERSON NOT IN ('POST OFFICE', 'BLACKSMITH', 'MILL', 'SCHOOL', 'LIVERY', 'METHODIST CHURCH', 'PHONE COMPANY', 'KAY AND PALMER WALLBOM', 'VERNA HARDWARE');
    
-- 6
SELECT DISTINCT SUBSTR(PHONE, 0, 3) AS AREA_CODE, COUNT(SUBSTR(PHONE, 0, 3)) "COUNT(*)" FROM ADDRESS GROUP BY SUBSTR(PHONE, 0, 3);

-- 7
SELECT RPAD((FIRSTNAME || ' ' || LASTNAME), 50, '.') AS NAME, '(' || SUBSTR(PHONE, 0, 3) || ')' || ' ' ||SUBSTR(PHONE, 5) AS PHONE FROM ADDRESS
ORDER BY LASTNAME, FIRSTNAME;

