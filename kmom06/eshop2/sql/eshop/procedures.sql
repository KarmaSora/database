use eshop; 


--
-- select from talbes  customer, product, productcategory
--
DROP PROCEDURE IF EXISTS get_customers;
DELIMITER ;;
CREATE PROCEDURE get_customers()
BEGIN
    SELECT * FROM customer;
END;;
DELIMITER ;

CALL get_customers();



DROP PROCEDURE IF EXISTS get_products;
DELIMITER ;;
CREATE PROCEDURE get_products()
BEGIN
    SELECT * FROM product;
END;;
DELIMITER ;

CALL get_products();



DROP PROCEDURE IF EXISTS get_category;
DELIMITER ;;
CREATE PROCEDURE get_category()
BEGIN
    SELECT * FROM category;
END;;
DELIMITER ;

CALL get_category();




DROP PROCEDURE IF EXISTS get_product_and_its_category;
DELIMITER ;;
CREATE PROCEDURE get_product_and_its_category()
BEGIN

        SELECT 
            p.product_id,
            p.name,
            p.price,
            COALESCE(s1.amount, 0) AS amount, 
            GROUP_CONCAT(COALESCE(cat.category_name, 'Uncategorized')) AS category
        FROM
            product AS p
        LEFT JOIN
            product_category AS pCat ON pCat.product_id = p.product_id
        LEFT JOIN
        category AS cat on cat.category_id = pCat.category_id
        LEFT JOIN
            stock_shelf AS s1 ON p.product_id = s1.product_id
        GROUP BY p.product_id;


END;;
DELIMITER ;

CALL get_product_and_its_category();



DROP PROCEDURE IF EXISTS insert_product;
DELIMITER ;;
CREATE PROCEDURE insert_product(
    p_id INT,
    p_name VARCHAR(100), 
    p_price DECIMAL(10,3) 
    )
BEGIN
    INSERT INTO product (product_id, name, price ) VALUES (p_id, p_name, p_price);
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_product_by_id;
DELIMITER ;;
CREATE PROCEDURE get_product_by_id(
    p_id INT
    )
BEGIN
    SELECT * FROM product WHERE product_id = p_id;
END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS update_product;
DELIMITER ;;
CREATE PROCEDURE update_product(
    p_name VARCHAR(100), 
    p_price DECIMAL(10,3), 
    p_id INT
    )
BEGIN
    UPDATE product SET name = p_name, price =  p_price WHERE product_id = p_id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
    p_id INT
    )
BEGIN
    -- SET FOREIGN_KEY_CHECKS = 0;


    DELETE FROM product WHERE product_id = p_id;


    -- SET FOREIGN_KEY_CHECKS = 1;
END;;
DELIMITER ;



--
-- client.js
--

DROP PROCEDURE IF EXISTS log_details;
DELIMITER ;;
CREATE PROCEDURE log_details(
    count INT
    )
BEGIN
    SELECT * FROM logg ORDER BY time DESC LIMIT count;
END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_shelves;
DELIMITER ;;
CREATE PROCEDURE get_shelves()
BEGIN
    SELECT * FROM stock_shelf ORDER BY shelf_id ;
END;;
DELIMITER ;




DROP PROCEDURE IF EXISTS get_stock_shelf_products;
DELIMITER ;;
CREATE PROCEDURE get_stock_shelf_products()
BEGIN
    SELECT 
    p.product_id, p.name, s.shelf_row, s.amount 
    FROM 
    product AS p
    JOIN
    stock_shelf AS s 
    ON p.product_id = s.product_id;
END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_filtered_inventory;
DELIMITER ;;
CREATE PROCEDURE get_filtered_inventory(
    search VARCHAR(100)

    )
BEGIN
    SELECT DISTINCT 
        p.*, s.product_id AS shelfProductID, s.shelf_row, s.amount 
        FROM product AS p
        RIGHT JOIN stock_shelf AS s 
    ON 
        p.product_id = s.product_id
    WHERE
        p.product_id LIKE search 
        OR p.name LIKE search 
        OR s.shelf_row LIKE search;
END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS add_to_inventory;
DELIMITER ;;
CREATE PROCEDURE add_to_inventory(
    p_id INT, 
    s_row VARCHAR(50), 
    s_amount INT
    )
BEGIN


    IF NOT EXISTS(SELECT * FROM product WHERE product_id = p_id) THEN
        INSERT INTO product (product_id, name, price) VALUES (p_id, 'aRandomProduct', 0);
        INSERT INTO product_category (category_id, product_id) VALUES ( 1, p_id);
    END IF;
    
    IF EXISTS(SELECT * FROM stock_shelf WHERE product_id = p_id AND shelf_row = s_row) THEN
        UPDATE stock_shelf SET amount = amount + s_amount WHERE product_id = p_id AND shelf_row = s_row;
    ELSE
        INSERT INTO stock_shelf (product_id, shelf_row, amount) VALUES (p_id, s_row, s_amount);
    END IF;

END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_inventory;
DELIMITER ;;
CREATE PROCEDURE delete_inventory(
    p_id INT,
    s_shelf_row VARCHAR(10),
    s_amount INT
)
BEGIN
    DECLARE current_amount INT;

    SELECT amount INTO current_amount FROM stock_shelf WHERE product_id = p_id AND shelf_row = s_shelf_row;

    IF current_amount IS NOT NULL THEN
        -- Calculate the new amount after deletion
        SET current_amount = current_amount - s_amount;

        -- Ensure the new amount is not negative
        IF current_amount < 0 THEN
            SET current_amount = 0;
        END IF;

        UPDATE stock_shelf SET amount = current_amount WHERE product_id = p_id AND shelf_row = s_shelf_row ;
    END IF;
END;;
DELIMITER ; 



-- 
-- extra
--

DROP PROCEDURE IF EXISTS get_products_row_count;
DELIMITER ;;
CREATE PROCEDURE get_products_row_count()
BEGIN
    SELECT COUNT(*) AS row_count FROM product;

END;;
DELIMITER ;




--
-- Kmom06
--

-- DROP PROCEDURE IF EXISTS get_all_customers;
-- DELIMITER ;;
-- CREATE PROCEDURE get_all_customers()
-- BEGIN
--     SELECT * FROM customer;
-- END;;
-- DELIMITER ;



DROP PROCEDURE IF EXISTS get_all_orders_and_customers;
DELIMITER ;;
CREATE PROCEDURE get_all_orders_and_customers()
BEGIN
    SELECT o.*, c.*, order_status(   
        o.date_of_order,
        o.date_of_last_update, -- date of update
        o.date_of_delete , -- date of deletion
        o.date_of_activated , -- date of activation / beställed
        o.date_of_sent 
        )  AS status
    FROM orders AS o
    JOIN customer AS c ON o.customer_id = c.customer_id;
END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_customer_orders;
DELIMITER ;;
CREATE PROCEDURE get_customer_orders(
    c_id INT
    )
BEGIN
    SELECT o.*, c.name, order_status(   
        o.date_of_order,
        o.date_of_last_update, -- date of update
        o.date_of_delete , -- date of deletion
        o.date_of_activated , -- date of activation / beställed
        o.date_of_sent 
        )  AS status FROM orders AS o JOIN customer AS c ON o.customer_id = c.customer_id WHERE o.customer_id = c_id;
END;;
DELIMITER ;




DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;
CREATE PROCEDURE create_order(
    c_id INT
    )
BEGIN
    INSERT INTO orders (customer_id) VALUES (c_id);
END;;
DELIMITER ;



--Picklist

DROP PROCEDURE IF EXISTS pick_list_item_details;
DELIMITER ;;
CREATE PROCEDURE pick_list_item_details(
    o_id INT
)
BEGIN
    SELECT plist.*,  p.name, p.price
    FROM pick_list as plist
    JOIN product as p ON plist.product_id = p.product_id
    WHERE plist.order_id = o_id;

END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS add_item_to_picklist;
DELIMITER ;;
CREATE PROCEDURE add_item_to_picklist(
    o_id INT,
    p_id INT,
    pro_count INT
)
BEGIN
    IF EXISTS(SELECT * FROM pick_list WHERE order_id = o_id AND product_id = p_id) THEN
        UPDATE pick_list SET ordered_quantity = ordered_quantity + pro_count WHERE product_id = p_id AND order_id = o_id;
    ELSE
    INSERT INTO pick_list (order_id, product_id, ordered_quantity) VALUES(o_id, p_id, pro_count);
    END IF;
    UPDATE stock_shelf SET amount = amount - pro_count WHERE product_id = p_id;

    UPDATE orders SET date_of_last_update = NOW(), ordered_quantity = ordered_quantity + pro_count WHERE order_id = o_id;






END;;
DELIMITER ;



DROP PROCEDURE IF EXISTS updateOrderDate;
DELIMITER ;;
CREATE PROCEDURE updateOrderDate(
    o_id INT
)
BEGIN
    UPDATE orders SET date_of_activated = NOW() WHERE order_id = o_id;
    
END;;
DELIMITER ;



--cli.js kmom06

DROP PROCEDURE IF EXISTS get_order_details_and_customers_id;
DELIMITER ;;
CREATE PROCEDURE get_order_details_and_customers_id(
)
BEGIN
    SELECT o.order_id, o.date_of_order, c.customer_id, COUNT(o.order_id) AS numberOfOrders, order_status(   
        o.date_of_order,
        o.date_of_last_update, -- date of update
        o.date_of_delete , -- date of deletion
        o.date_of_activated , -- date of activation / beställed
        o.date_of_sent 
        )  AS status
    FROM orders AS o
    JOIN customer AS c 
    ON o.customer_id = c.customer_id
    GROUP BY o.order_id;

END;;
DELIMITER ;





DROP PROCEDURE IF EXISTS get_orders_and_customers_filtered_by_id;
DELIMITER ;;
CREATE PROCEDURE get_orders_and_customers_filtered_by_id(
    the_filter_id INT
)
BEGIN
    SELECT o.order_id, o.date_of_order, c.customer_id, COUNT(o.order_id) AS numberOfOrders, order_status(   
        o.date_of_order,
        o.date_of_last_update, -- date of update
        o.date_of_delete , -- date of deletion
        o.date_of_activated , -- date of activation / beställed
        o.date_of_sent 
        )  AS status
    FROM orders AS o
    JOIN customer AS c 
    ON o.customer_id = c.customer_id
    WHERE o.order_id = the_filter_id 
    OR c.customer_id = the_filter_id
    GROUP BY o.order_id;

END;;
DELIMITER ;




DROP PROCEDURE IF EXISTS ship_order_by_id;
DELIMITER ;;
CREATE PROCEDURE ship_order_by_id(
    o_id INT
)
BEGIN
    UPDATE orders SET date_of_sent = NOW() WHERE order_id = o_id;
    
END;;
DELIMITER ;