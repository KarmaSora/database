--
-- JOIN
--
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY akronym
;



--1) Skapa rapporten som visar resultatet enligt nedan.
SELECT
    l.akronym,
    l.lon,
    p.lon AS "pre-lon",
    l.lon AS "lon nu",
    (l.lon - p.lon ) AS "diff",
    ROUND((l.lon / p.lon )*100,2)-100 AS "procent",
        CASE
            WHEN ROUND((l.lon / p.lon )*100,2)-100 <= 0 THEN "nok"
            ELSE "ok"
        END AS "mini"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY procent DESC
;



DROP VIEW IF EXISTS v_join_table;
CREATE VIEW IF NOT EXISTS v_join_table AS 
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    l.kompetens,
    p.lon AS "pre-lon",
    l.lon AS "lon nu",
    (l.lon - p.lon ) AS "diff",
    ROUND((l.lon / p.lon )*100,2)-100 AS "procent",
    p.kompetens AS "pre-kompetens",
    l.kompetens AS "nu-kompetens",
        CASE
            WHEN  ROUND((l.lon / p.lon )*100,2)-100 <= 0 THEN "nok"
            ELSE "ok"
        END AS "mini"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY procent DESC, l.kompetens DESC
;

SELECT * FROM v_join_table; -- testar att view fungerar, det fungerar!!