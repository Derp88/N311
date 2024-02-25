-- WHERE, AND
SELECT * FROM BOOK_ORDER WHERE PUBLISHER = 'PENGUIN' AND CATEGORYNAME = 'ADULTNF';
SELECT * FROM BREEDING WHERE COW = 'EVE' and BULL = 'ADAM';

-- OR
SELECT * FROM BOOKSHELF WHERE RATING = 4 OR RATING = 5;
SELECT * FROM BREEDING WHERE COW = 'EVE' OR BULL = 'ADAM';

--LIKE
SELECT * FROM LEDGER WHERE PERSON LIKE '%STORE';

--IN
SELECT * FROM LEDGER WHERE ITEM IN ('CORN', 'BEEF', 'SUGAR');

--Sub query
SELECT inner.*
    FROM (
        SELECT * 
            FROM LEDGER WHERE ACTION = 'BOUGHT'
        ) inner
WHERE inner.QUANTITY = 1;

--NULL
SELECT * FROM AUTHOR WHERE COMMENTS IS NULL;

--ORDER BY
SELECT * FROM AUTHOR ORDER BY AUTHORNAME;

--JOIN
SELECT STOCK_ACCOUNT.ACCOUNTLONGNAME, STOCK_TRX.SYMBOL, STOCK_TRX.PRICE,  STOCK_TRX.QUANTITY FROM STOCK_ACCOUNT
INNER JOIN STOCK_TRX
ON STOCK_ACCOUNT.Account = STOCK_TRX.Account;

--VIEW (Uses Where, AND, OR, LIKE)
CREATE VIEW EXAMPLE_VIEW3 AS
SELECT ITEM, QUANTITY, RATE, PERSON FROM LEDGER
WHERE PERSON LIKE '%STORE' OR (RATE = 1 AND QUANTITY = 1) OR ITEM = 'COFFEE';

SELECT * FROM EXAMPLE_VIEW3;
