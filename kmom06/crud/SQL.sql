use bank; -- ska bytas ut mot e_shop

DROP PROCEDURE IF EXISTS get_all;

DELIMITER ;;
CREATE PROCEDURE get_all()
BEGIN
    SELECT * FROM account;

END;;
DELIMITER ;


CALL get_all();





DROP PROCEDURE IF EXISTS insert_account;

DELIMITER ;;
CREATE PROCEDURE insert_account(
    f_userID VARCHAR(50),
    f_name VARCHAR(50),
    f_balance DECIMAL(10,2)
    
    )
    BEGIN
    INSERT INTO account ( id, name, balance) VALUES ( f_userID, f_name, f_balance);
    END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_account;
DELIMITER ;;

CREATE PROCEDURE get_account(
    f_userID VARCHAR(50)
    )
    BEGIN
    SELECT * FROM account WHERE id = f_userID;
    END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS update_account;
DELIMITER ;;
CREATE PROCEDURE update_account(
    f_userID VARCHAR(50),
    f_name VARCHAR(50),
    f_balance DECIMAL(10,2)
    )
    BEGIN
    UPDATE account SET name = f_name, balance = f_balance WHERE id = f_userID;
    END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_account;
DELIMITER ;;
CREATE PROCEDURE delete_account(
    f_userID VARCHAR(50)
    )
    BEGIN
    DELETE FROM account WHERE id = f_userID;
    END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_account;
DELIMITER ;;
CREATE PROCEDURE get_account(
    f_userID VARCHAR(50)
    )
    BEGIN
    SELECT * FROM account WHERE id = f_userID;
    END;;

DELIMITER ;


DROP PROCEDURE IF EXISTS update_account;
DELIMITER ;;
CREATE PROCEDURE update_account(
    f_userID VARCHAR(50),
    f_name VARCHAR(50),
    f_balance DECIMAL(10,2)
    )
    BEGIN
    UPDATE account SET name = f_name, balance = f_balance WHERE id = f_userID;
    END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_account;
DELIMITER ;;
CREATE PROCEDURE delete_account(
    f_userID VARCHAR(50)
    )
    BEGIN
    DELETE FROM account WHERE id = f_userID;
    END;;
DELIMITER ;