-- Skapa vyn
DROP VIEW IF EXISTS v_namn_alder;

CREATE VIEW IF NOT EXISTS v_namn_alder 
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;

-- Använd vyn
SELECT * FROM v_namn_alder;


-- Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare inklusive en ny kolumn med lärarens ålder

DROP VIEW IF EXISTS v_larare;

CREATE VIEW IF NOT EXISTS v_larare
AS
SELECT
    *,   YEAR(CURDATE())- YEAR(fodd) AS alder
FROM larare;

-- Använd vyn
SELECT * FROM v_larare;


-- Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning. 
--Visa avdelningens namn och medelålder sorterad på medelåldern.

DROP VIEW IF EXISTS v_age_depart;
CREATE VIEW IF NOT EXISTS v_age_depart 
AS 
SELECT
    avdelning AS "Department",
    AVG(TIMESTAMPDIFF(YEAR, fodd, CURDATE())) AS "AVG alder"
    FROM larare
    GROUP BY avdelning
    ;



SELECT * FROM v_age_depart;