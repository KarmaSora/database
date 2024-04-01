source setup.sql; -- create database
use eshop; -- selects the databasee 

source functions.sql; -- creates functions

source ddl.sql; -- create tables

source insert.sql;  -- insert data into table from csv files

SET profiling = 1; -- start profiling, keep track of time and resources used by the queries

-- SET profiling = 0; -- stop profiling
--SHOW PROFILES; -- show all the profiles of the queries
--SHOW PROFILE; -- show the profile of the last query

--SHOW INDEX FROM tableName; -- show index of a table

--EXPLAIN  tableName; -- show the execution plan of a query

--SHOW WARNINGS; -- show the warnings of the last query
--SHOW ERRORS; -- show the errors of the last query
--SHOW VARIABLES LIKE 'profiling'; -- show the status of profiling
--SHOW STATUS LIKE 'Handler%'; -- show the status of the handler
--SHOW STATUS LIKE 'Created_tmp%'; -- show the status of the temporary tables
--SHOW STATUS LIKE 'Select%'; -- show the status of the select queries
--SHOW STATUS LIKE 'Table%'; -- show the status of the tables
