---------------------------GOAL: CLEAN AND ANALYZE THE DATA------------------------------------------------
--1.---Display all table content
SELECT * FROM FIFA_21.dbo.fifa21_raw_data;

--2.---Delete unnecessary column
ALTER TABLE FIFA_21.dbo.fifa21_raw_data
DROP COLUMN Name,PhotoURL,PlayerURL,LOAN_DATE_END;
   
--3.---Replace unwanted characters in multiple column
BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Contract=REPLACE(Contract,'~','-'),
Value=REPLACE(Value,'M',''),
Wage=REPLACE(Wage,'â‚¬',''),
Release_Clause=REPLACE(Release_Clause,'â‚¬',''),
IR=REPLACE(IR,'?',''),
W_F=REPLACE(W_F,'?',''),
SM=REPLACE(SM,'?','');
COMMIT;

--4.---CHECK FOR DUPLICATE ROWS 
SELECT Players_name,Club,Nationality
FROM FIFA_21.dbo.fifa21_raw_data
GROUP BY Players_name,Club,Nationality
HAVING COUNT(*)>1;

--5.-----DELETE FOUND DUPLICATE
WITH CTE AS (
    SELECT Players_name,Club,Nationality,
           ROW_NUMBER() OVER (PARTITION BY Players_name,Club,Nationality ORDER BY (SELECT NULL)) AS RN
    FROM FIFA_21.dbo.fifa21_raw_data
)
DELETE FROM CTE
WHERE RN > 1;

--6.---CHECK AND REMOVE FOR FUNNY CHARACTER FROM SINGLE (PLAYERS_NAME) COLUMN
SELECT * FROM FIFA_21.dbo.fifa21_raw_data
where Players_name NOT LIKE '%[A-Za-z%]';

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Players_name=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Players_name, 
'?', ''),'Ã©', 'e'),'Ã¡', 'a'), 'È™', 's'),'Ã¼','u'), 'Ã³', 'o'), 'Ã‡', 'c'),'Ä‡', 'c');
COMMIT;


--7.-converting Height and weight to only numerical values
BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Height =REPLACE(Height, 'cm', ''),
Weight =REPLACE(WEIGHT, 'kg', '');
COMMIT;

--8.-FORMATTING Hits column data (1.6k) to numeric value(1600)
SELECT ID, Hits FROM FIFA_21.dbo.fifa21_raw_data
WHERE Hits LIKE '%K%';

SELECT * FROM FIFA_21.dbo.fifa21_raw_data
WHERE Hits LIKE '%.%';

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Hits = REPLACE(REPLACE(Hits, '.', ''),'K', '00');
COMMIT;

--9.--Updating the hit column data formats exceptions
SELECT ID, Hits FROM FIFA_21.dbo.fifa21_raw_data
WHERE ID IN (255611,251570,244778,220651)

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Hits = REPLACE(Hits, '00', '000')
WHERE ID IN (255611,251570,244778,220651);
COMMIT;

--10.--Replace NULL Values from hits column to 0
SELECT * FROM FIFA_21.dbo.fifa21_raw_data
WHERE Hits IS NULL;

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Hits = COALESCE(Hits, 0);

--11.---Wages to numeric value
SELECT Wage 
FROM FIFA_21.dbo.fifa21_raw_data
WHERE Wage LIKE '%k%';

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Wage = REPLACE(REPLACE(Wage,'€',''), 'K', '');
COMMIT;

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Wage = Wage * 1000;
COMMIT;

--12.--Values and release_clause to numeric value
SELECT Value 
FROM FIFA_21.dbo.fifa21_raw_data
WHERE Value LIKE '%m%';

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Value = REPLACE(REPLACE(Value,'€',''), 'M', ''),
Release_clause = REPLACE(REPLACE(Release_clause,'€',''), 'M', '');
COMMIT;

BEGIN TRANSACTION;
UPDATE FIFA_21.dbo.fifa21_raw_data
SET Value = Value * 1000000,
Release_clause = Release_clause * 1000000;
ROLLBACK;





