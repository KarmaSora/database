
ALTER TABLE larare ADD COLUMN IF NOT EXISTS kompetens INT DEFAULT 1;

SHOW COLUMNS FROM larare;

SELECT akronym, fornamn, kompetens FROM larare;

SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
