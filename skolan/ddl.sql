use skolan;

--new section
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;
--end of new section

--merging ddl-larare.sql and ddl-alter.sql by altering the table larare when creating it.
--source ddl-larare.sql;
--source ddl-alter.sql;
--
-- Create table: larare
--
-- resten av CREATE statementet.
DROP TABLE IF EXISTS larare;
CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,
    kompetens INT DEFAULT 1,

    PRIMARY KEY (akronym)
);



source ddl-copy.sql;
source dml-view.sql;
source dml-join.sql;


--Copy of ddl-copy.sql
-- Make copy of table
--
DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

-- -- Check the content of the tables, for sanity checking
-- SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
-- SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;


-- NEW SECTION



--Creating table kurs-- new
-- DROP TABLE IF EXISTS kurs;
CREATE TABLE kurs (
    kod char(6) NOT NULL,
    namn varchar(40) DEFAULT NULL,
    poang float DEFAULT NULL,
    niva char(3) DEFAULT NULL,
    PRIMARY KEY (kod)
);


-- Creating new Table kurstillfalle 
-- DROP TABLE IF EXISTS kurstillfalle;
CREATE TABLE kurstillfalle 
(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    kurskod CHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,
    
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
);


source insert-csv.sql; --har lagt till detta själv här, ska det vara med?
source dml-join2.sql;



--triple join view 
DROP VIEW IF EXISTS v_planering;
CREATE VIEW IF NOT EXISTS v_planering 
AS 
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;




