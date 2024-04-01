/*
1. Skriv en SELECT-sats som skriver ut förnamn + efternamn + avdelning i samma kolumn enligt följande struktur: 
förnamn efternamn (avdelning). (Tips: Att slå ihop strängar kallas att konkatenera/concatenate).
*/
SELECT 
    CONCAT( fornamn, " ", efternamn, ":  ", avdelning ) AS "NAME and Division"
    FROM larare;

/*
    2. Gör om samma sak men skriv ut avdelningens namn med små bokstäver och begränsa utskriften till 3 rader.
*/
SELECT 
    CONCAT( fornamn, " ", efternamn, ":  (", LOWER(avdelning ), ")") AS "NAME and Division"
    FROM larare LIMIT 3;

/*1.Skriv en SELECT-sats som endast visar dagens datum.
*/

SELECT NOW();


/*2.Gör en SELECT-sats som visar samtliga lärare, deras födelseår samt dagens datum och klockslag.
*/

SELECT 
    CONCAT(fornamn, " ", efternamn) AS "Name", DATE_FORMAT(fodd, "%Y-%m-%d") , DATE_FORMAT(NOW(), "%Y-%m-%d") AS "Dagens datum", CURRENT_TIME() AS clock 
FROM larare; 

--Beräkna ålder
/*
1. Skriv en SELECT-sats som beräknar lärarens ålder, sortera rapporten för att visa vem som är äldst och yngst.
*/
SELECT 
    CONCAT(fornamn, " ", efternamn) AS "Name", fodd, ROUND(DATEDIFF(DATE_FORMAT(NOW(), "%Y-%m-%d"),  DATE_FORMAT(fodd, "%Y-%m-%d"))/365)  AS "age"
    FROM larare ORDER BY fodd ;

--Visa de lärare som är födda på 40-talet.

SELECT 
    CONCAT(fornamn, " ", efternamn) AS "Name",
    ROUND(DATEDIFF(DATE_FORMAT(NOW(), "%Y-%m-%d"),  DATE_FORMAT(fodd, "%Y-%m-%d"))/365)  AS "age",
    fodd
    FROM larare 
    WHERE 
        YEAR(fodd) >= 1940 
        AND YEAR(fodd)<1950; 