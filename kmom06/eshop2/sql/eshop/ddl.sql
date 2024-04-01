
--Karma... ADD INDEX KEY for every foreign key...

-- Create the database tables for the ER2 model eshop
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS pick_list;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS stock_shelf;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS invoice;

DROP TABLE IF EXISTS orderdetails;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100)
    -- KEY cutomer_name_index (name) --Index Key

);


CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    ordered_quantity INT DEFAULT 0,
    date_of_order TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,  -- date of creation
    date_of_last_update TIMESTAMP NULL  , -- date of update
    date_of_delete TIMESTAMP NULL, -- date of deletion
    date_of_activated TIMESTAMP NULL, -- date of activation / beställed
    date_of_sent TIMESTAMP NULL, -- date of sent / skickad,
    

    -- status ENUM('Created', 'Sent', 'Updated', 'Deleted', 'Ordered') DEFAULT 'Created' NOT NULL,
    is_deleted INT DEFAULT 0,  -- 0 for not deleted and 1 for deleted


    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    KEY is_deleted_status_key (is_deleted) -- made it into key for better preformance i think...  
);

CREATE TABLE invoice (
    invoice_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)

);




CREATE TABLE product (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    KEY product_name_index (name) 

);



-----NEW UPDATE...


CREATE TABLE orderdetails (
    order_details_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    ordered_quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



--- END OF UPDATE....


CREATE TABLE category (
    category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100),
    KEY category_index (category_name) 

);

CREATE TABLE product_category (

    product_category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE stock_shelf (
    shelf_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    shelf_row VARCHAR(50),
    stock_category VARCHAR(100),
    amount INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE stock (
    stock_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    shelf_id INT,
    name VARCHAR(100),
    FOREIGN KEY (shelf_id) REFERENCES stock_shelf(shelf_id)  
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);




CREATE TABLE order_details (
    order_details_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    ordered_quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pick_list (
    pick_list_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    shelf_id INT,
    ordered_quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (shelf_id) REFERENCES stock_shelf(shelf_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE logg (
    logg_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    product_id INT,

    event VARCHAR(255),
    time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);




source procedures.sql; -- creates procedures


source triggers.sql; -- creates triggers

