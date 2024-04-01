--
-- Reset part 1
--
source create-database.sql; --Skapa om en tom databas.


use skolan;

source ddl-larare.sql; -- Skapa tabellen för lärare.
source insert-larare.sql; -- Lägg till rader i tabellen lärare.
source ddl-alter.sql; -- Uppdatera tabellen lärare och lägg till kompetensen.

source dml-update.sql; -- Förbered lönerevisionen, alla lärare har grundlön.
source ddl-copy.sql;	-- New, Kopiera till larare_pre innan lönerevisionen.

source dml-update-lonerevision.sql; -- Utför lönerevisionen.

source dml-view.sql; -- Skapa vyerna v_namn_alder och v_larare.

source dml-join.sql; -- New, Skapa vyn v_lonerevision.

