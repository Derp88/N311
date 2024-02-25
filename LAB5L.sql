--1
SELECT DISTINCT ACTION FROM LEDGER;

--2
DROP VIEW LEDGER_SALES;
CREATE VIEW LEDGER_SALES AS SELECT PERSON, ACTIONDATE, SUM(AMOUNT) AS TOT_AMT FROM LEDGER WHERE ACTION = 'BOUGHT' GROUP BY PERSON, ACTIONDATE;

--3
SELECT MIN(TOT_AMT), MAX(TOT_AMT), ROUND(AVG(TOT_AMT),2) FROM LEDGER_SALES;

--4
SELECT PERSON, COUNT(*) FROM LEDGER_SALES GROUP BY PERSON HAVING COUNT(*) > 1;

--5.1
SELECT PERSON, SUM(AMOUNT) AS TOT_AMT FROM LEDGER INNER JOIN WORKER ON LEDGER.PERSON = WORKER.NAME WHERE ACTION = 'BOUGHT' GROUP BY PERSON ORDER BY PERSON;
--5.2
SELECT PERSON, SUM(AMOUNT) AS TOT_AMT FROM LEDGER WHERE ACTION = 'BOUGHT' AND PERSON IN
(SELECT NAME FROM WORKER)GROUP BY PERSON ORDER BY PERSON;
--5.3
SELECT PERSON, SUM(AMOUNT) AS TOT_AMT FROM LEDGER WHERE ACTION = 'BOUGHT' AND EXISTS
(SELECT NAME FROM WORKER WHERE WORKER.NAME = LEDGER.PERSON) GROUP BY PERSON ORDER BY PERSON;

--6
SELECT NAME, DECODE(SUM(AMOUNT), null, 'NEVER BOUGHT', SUM(AMOUNT)) AS TOT_AMT FROM WORKER LEFT JOIN LEDGER ON WORKER.NAME = LEDGER.PERSON AND LEDGER.ACTION = 'BOUGHT' GROUP BY NAME ORDER BY NAME;

--7.1
SELECT WORKERSKILL.NAME, WORKER.LODGING, WORKER.AGE FROM WORKERSKILL INNER JOIN WORKER ON (WORKER.NAME = WORKERSKILL.NAME) WHERE ABILITY NOT IN ('GOOD', 'EXCELLENT', 'AVERAGE') ORDER BY NAME;
--7.2
SELECT WORKER.NAME, WORKER.LODGING, WORKER.AGE FROM WORKERSKILL LEFT OUTER JOIN WORKER ON (WORKERSKILL.NAME=WORKER.NAME AND ABILITY != 'GOOD' AND ABILITY != 'EXCELLENT' AND ABILITY != 'AVERAGE') WHERE WORKER.NAME IS NOT NULL ORDER BY NAME;

--8
SELECT DECODE(PERSON, null, 'All Persons', PERSON), DECODE(to_char(ACTIONDATE, 'Month'), null, 'All Months', to_char(ACTIONDATE, 'Month')) as MONTH, SUM(QUANTITY*RATE) AS TOT_AMT FROM LEDGER WHERE ACTION = 'SOLD' GROUP BY ROLLUP(PERSON, ACTIONDATE);

