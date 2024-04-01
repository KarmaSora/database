
use eshop;


DELETE FROM orderdetails;
DELETE FROM pick_list;

DELETE FROM orders;
DELETE FROM invoice;

DELETE FROM stock;

DELETE FROM stock_shelf;
DELETE FROM product;
DELETE FROM product_category;
DELETE FROM customer;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';


LOAD DATA LOCAL INFILE 'customer.csv'
INTO TABLE customer
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'product.csv'
INTO TABLE product
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'category.csv'
INTO TABLE category
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'productcategory.csv'
INTO TABLE product_category
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;





LOAD DATA LOCAL INFILE 'stockshelf.csv'
INTO TABLE stock_shelf
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'stock.csv'
INTO TABLE stock
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;




LOAD DATA LOCAL INFILE 'invoice.csv'
INTO TABLE invoice
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'orders.csv'
INTO TABLE orders
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
-- (order_id, customer_id,  ordered_quantity)
(order_id, customer_id, ordered_quantity)

;



-- Begin OF NEW
LOAD DATA LOCAL INFILE 'pick_list.csv'
INTO TABLE pick_list
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'orderdetails.csv'
INTO TABLE orderdetails
CHARSET utf8
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;
-- END OF NEW



SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM product_category;
SELECT * FROM stock_shelf;
SELECT * FROM stock;
