SELECT * FROM larare;

--upp1 Visa alla rader i tabellen där avdelningen är DIDD.
SELECT * FROM larare WHERE avdelning = 'DIDD';
-- upp2 Visa de rader som har en akronym som börjar med bokstaven ‘h’ (ledtråd LIKE).
SELECT * FROM larare WHERE akronym LIKE 'h%';

--upp3 Visa de rader vars lärares förnamn innehåller bokstaven ‘o’.
SELECT * FROM larare WHERE fornamn LIKE '&o%';

-- upp 4 Visa de rader där lärarna tjänar mellan 30 000 - 50 000.
SELECT * FROM larare WHERE 30000 <= lon AND lon <= 50000;

--upp5 Visa rader som innehåller lärarna sna, dum, min (ledtråd IN).
SELECT * FROM larare WHERE akronym IN ('sna','dum','min');

-- upp6 Visa de lärare som har lön över 80 000, tillsammans med de lärare som har en kompetens om 2 och jobbar på avdelningen ADM.
SELECT * FROM larare WHERE lon >80000 OR (kompetens =2 AND avdelning = 'ADM');
