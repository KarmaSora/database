DROP TRIGGER IF EXISTS after_product_insert;
DELIMITER ;;
CREATE TRIGGER after_product_insert
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    INSERT INTO logg (product_id, event )
    VALUES ( NEW.product_id,  CONCAT('Product inserted with id = ',  NEW.product_id));
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS after_product_update;
DELIMITER ;;
CREATE TRIGGER after_product_update
AFTER UPDATE ON product
FOR EACH ROW
BEGIN
    INSERT INTO logg (product_id, event )
    VALUES ( NEW.product_id,  CONCAT('Product  with id = ',  NEW.product_id, ' was updated'));
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS before_product_delete;
DELIMITER ;;
CREATE TRIGGER before_product_delete
BEFORE DELETE ON product
FOR EACH ROW
BEGIN
    
    INSERT INTO logg ( product_id,  event )
    VALUES ( OLD.product_id,  CONCAT('A product with previous id = ',  OLD.product_id, ' was DELETED'));
END;;
    
DELIMITER ;



