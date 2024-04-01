SELECT SUM(lon) AS 'Lönesumma', SUM(lon) * 0.064 AS Lonepott FROM larare;

--upp1
UPDATE larare SET Kompetens = 7, lon = 85000 WHERE fornamn = 'Albus';
--upp 2
UPDATE larare SET lon = lon + 4000 WHERE fornamn = 'Minerva';

--do number 3,   https://dbwebb.se/guide/kom-igang-med-sql-i-mysql-v2/uppdatera-varden-lonerevision

--upp3)Argus har fått ett risktillägg om 2 000 och kompetensen är satt till 3.
UPDATE larare SET lon = lon + 2000, Kompetens = 3 WHERE fornamn = 'Argus';

--upp 4
UPDATE larare SET lon = lon - 3000 WHERE fornamn IN ('Gyllenroy','Alastor');

--upp5) Alla lärare på avdelningen DIDD fick en extra lönebonus om 2%.
UPDATE larare SET lon = lon *1.02 WHERE avdelning = 'DIDD';

-- upp6) Alla låglönade kvinnliga lärare, de som tjänar färre än 40 000, fick en lönejustering om extra 3%.

UPDATE larare SET lon = lon *1.03 WHERE kon = 'K' AND lon < 40000;

--upp7) Ge Severus, Minerva och Hagrid ett extra lönetillägg om 5 000 för extra arbete de utför åt Albus och öka deras kompetens med +1.

UPDATE larare SET lon = lon + 5000, kompetens = kompetens + 1 WHERE fornamn IN ('Severus','Minerva','Hagrid');

--Upp8) Ge alla lärare en ökning om 2.2% men exkludera Albus, Severus, Minerva och Hagrid som redan fått tillräckligt.
UPDATE larare SET lon = lon * 1.022 WHERE fornamn NOT IN ('Albus','Severus','Minerva', 'Hagrid');


--1)Vilken är numer den totala lönesumman?
SELECT SUM(lon) AS lonsumma FROM larare;

--2)Vilken är numer den totala lönesumman?

SELECT SUM(lon) / 30000 AS 'lonsumma %' FROM larare;

--3 Vilken är numer den totala kompetensen?
SELECT SUM(kompetens) AS 'Sum of Kompetens' FROM larare;

SELECT * FROM larare;


SELECT 
(SUM(lon)-305000)/305000 *100 AS "lönsumma ökning " FROM larare;

