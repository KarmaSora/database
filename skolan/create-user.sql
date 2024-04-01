CREATE USER 'maria'@'localhost'
IDENTIFIED BY 'P@ssw0rd'
;
GRANT ALL PRIVILEGES
ON *.* TO 'maria'@'localhost'
WITH GRANT OPTION
;
FLUSH PRIVILEGES;


--SELECT User, Host FROM mysql.global_priv;
