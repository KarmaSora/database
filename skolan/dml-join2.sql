SELECT * FROM kurs, kurstillfalle LIMIT 10;


SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;


--har skapat tripple join view i ddl.sql , med namnet : v_planering
--den joinar kurs och kurstillfalle och larare


-- SELECT för Lärares arbetsbelastning

SELECT 
    akronym, CONCAT(fornamn, " ", efternamn) AS Name, COUNT(lasperiod) AS kurstillfalle
FROM
    v_planering 
GROUP BY 
    akronym 
ORDER BY 
    kurstillfalle DESC, akronym
    ;

--SELECT för Kursansvariges ålder
WITH top_larare AS (
SELECT 
    akronym,
    fornamn,
    efternamn,
    fodd AS birthDate, 
    YEAR(CURDATE()) - YEAR(fodd) AS Age
FROM
    v_planering 
GROUP BY 
    akronym 
ORDER BY Age DESC
LIMIT 3
)
SELECT 
    CONCAT(namn, " (", kurskod,")") AS KursNamn,
    CONCAT(fornamn, " ", efternamn, " (", akronym, ")") AS Larare,

    YEAR(CURDATE()) - YEAR(fodd) AS Age
FROM
    v_planering 
WHERE akronym IN (SELECT akronym FROM top_larare)
GROUP BY 
    KursNamn 
ORDER BY Age DESC, KursNamn;



--dubbelkolla denna!!!   https://dbwebb.se/guide/kom-igang-med-sql-i-mysql-v2/joina-tabeller 