SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

SELECT 
    k.kod,
    k.namn, 
    kt.lasperiod 
    FROM 
    kurstillfalle AS kt
    RIGHT OUTER JOIN kurs as k
    ON k.kod = kt.kurskod
    WHERE kt.lasperiod IS NULL;

