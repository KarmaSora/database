USE skolan;

SELECT SUM(lon) FROM larare;

--Hur mycket är den högsta lönen som en lärare har?
SELECT MAX(lon) FROM larare;

--Hur mycket är den lägsta lönen som en lärare har?
SELECT MIN(lon) FROM larare;


--GROUB BY
SELECT avdelning, kompetens, SUM(lon) AS Summa
FROM larare
GROUP BY avdelning, kompetens
ORDER BY Summa DESC
;

--Hur många lärare jobbar på de respektive avdelning?
SELECT avdelning, COUNT(fornamn) AS "Members count" FROM larare GROUP BY avdelning;

--Hur mycket betalar respektive avdelning ut i lön varje månad?
SELECT avdelning, SUM(lon) AS "Tot Cost" FROM larare GROUP BY avdelning;

--Hur mycket är medellönen för de olika avdelningarna?
SELECT avdelning, AVG(lon) AS "Average pay" FROM larare GROUP BY avdelning;

--Hur mycket är medellönen för kvinnor kontra män?
--MariaDB [skolan] > SELECT kon, AVG(lon) AS "pay differ" FROM larare GROUP BY kon;

SELECT kon, AVG(lon) AS "pay differ" FROM larare GROUP BY kon;

--Visa snittet på kompetensen för alla avdelningar, 
--sortera på kompetens i sjunkande ordning och visa enbart den avdelning som har högst kompetens.
SELECT avdelning, AVG(kompetens) AS "Avrage komp" FROM larare GROUP BY avdelning;


--Visa den avrundade snittlönen (ROUND()) grupperad per avdelning och per kompetens, 
--sortera enligt avdelning och snittlön. Visa även hur många som matchar i respektive gruppering. 
--Ditt svar skall se ut så här.

SELECT avdelning, ROUND(AVG(kompetens),0) AS "Avrage komp", ROUND(AVG(lon),0) AS "snitt lon", COUNT(lon) AS "Antal" FROM larare GROUP BY avdelning,lon;



--p2 Fortsättning...

--Vi vill se snittlön per avdelning (och antal), men bara om snittlönen är större än 35000.

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon > 35000
ORDER BY
    Snittlon DESC
;

--Vi vill se snittlönen per avdelning (och antal), men bara om det är 3 eller fler personer på den avdelningen.

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Antal >= 3
ORDER BY
    Snittlon DESC
;



--uppgifter
--1) Visa per avdelning hur många anställda det finns, gruppens snittlön, sortera per avdelning och snittlön.
SELECT
    avdelning,
    ROUND(AVG(lon)) AS "Snittlon",
    COUNT(lon) AS "Antal"
FROM larare
GROUP BY
    avdelning 
ORDER BY 
    "Snittlon" DESC
;

--2) Visa samma sak som i 1), 
-- men visa nu även de kompetenser som finns. Du behöver gruppera på avdelning och per kompetens,
-- sortera per avdelning och per kompetens.
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal,
    kompetens AS Komp
FROM larare
GROUP BY
    avdelning, Komp
ORDER BY 
    "Snittlon" DESC, komp DESC
;

-- 3) Visa samma sak som i 2), men ignorera de kompetenser som är större än 3.

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal,
    kompetens AS Komp
FROM larare
GROUP BY
    avdelning, Komp
HAVING Komp <= 3
ORDER BY 
    "Snittlon" DESC, komp DESC
;


-- 4) Visa samma sak som i 3), men exkludera de grupper som har fler än 1 deltagare
-- och inkludera de som har snittlön mellan 30 000 - 45 000. Sortera per snittlön.

SELECT
    avdelning,
    kompetens AS Komp,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE kompetens <= 3  
GROUP BY
    avdelning, kompetens
HAVING Antal = 1
    AND Snittlon >= 30000
    AND Snittlon <= 45000
ORDER BY 
    Snittlon DESC
;

