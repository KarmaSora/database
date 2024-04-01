--
-- Reset part 3
--

source create-database.sql;

use skolan;

-- source ddl-larare.sql
-- source insert-larare.sql
-- source ddl-alter.sql
-- source dml-update.sql
-- source ddl-copy.sql
-- source dml-update-lonerevision.sql
-- source dml-view.sql
-- source dml-join.sql

source ddl.sql
source insert.sql
source dml-update-lonerevision.sql

SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare_pre;

SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare;

SHOW FULL TABLES;