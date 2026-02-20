 CREATE TABLE stg_customers (
    ->     customer_id INT PRIMARY KEY,
    ->     customer_name VARCHAR(100),
    ->     gender VARCHAR(10),
    ->     city VARCHAR(50),
    ->     signup_date DATE
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE stg_products (
    ->     product_id INT PRIMARY KEY,
    ->     product_name VARCHAR(100),
    ->     category VARCHAR(50),
    ->     brand VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE stg_orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     order_status VARCHAR(20),
    ->
    ->     FOREIGN KEY (customer_id)
    ->     REFERENCES stg_customers(customer_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE stg_order_items (
    ->     order_item_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     price DECIMAL(10,2),
    ->
    ->     FOREIGN KEY (order_id)
    ->     REFERENCES stg_orders(order_id),
    ->
    ->     FOREIGN KEY (product_id)
    ->     REFERENCES stg_products(product_id)
    -> );
 CREATE TABLE stg_payments (
    ->     payment_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     payment_type VARCHAR(20),
    ->     payment_value DECIMAL(10,2),
    ->
    ->     FOREIGN KEY (order_id)
    ->     REFERENCES stg_orders(order_id)
    -> );
mysql> INSERT INTO stg_customers VALUES
    -> (1,'Aman','Male','Delhi','2022-01-10'),
    -> (2,'Riya','Female','Mumbai','2022-03-15'),
    -> (3,'Karan','Male','Bangalore','2022-06-21'),
    -> (4,'Neha','Female','Kolkata','2022-09-12'),
    -> (5,'Rahul','Male','Delhi','2023-02-05');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO stg_products VALUES
    -> (101,'T-shirt','Clothing','Nike'),
    -> (102,'Sneakers','Footwear','Adidas'),
    -> (103,'Laptop','Electronics','HP'),
    -> (104,'Headphones','Electronics','Sony'),
    -> (105,'Jeans','Clothing','Levis');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO stg_orders VALUES
    -> (1001,1,'2023-01-01','Delivered'),
    -> (1002,2,'2023-01-05','Delivered'),
    -> (1003,3,'2023-02-10','Delivered'),
    -> (1004,1,'2023-03-15','Cancelled'),
    -> (1005,4,'2023-04-18','Delivered'),
    -> (1006,5,'2023-05-01','Delivered');
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> INSERT INTO stg_order_items VALUES
    -> (1,1001,101,2,500),
    -> (2,1001,102,1,3000),
    -> (3,1002,103,1,50000),
    -> (4,1003,104,2,2000),
    -> (5,1004,105,1,1500),
    -> (6,1005,101,3,500),
    -> (7,1006,102,1,3000);
Query OK, 7 rows affected (0.00 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO stg_payments VALUES
    -> (201,1001,'UPI',4000),
    -> (202,1002,'Credit Card',50000),
    -> (203,1003,'Debit Card',4000),
    -> (204,1005,'UPI',1500),
    -> (205,1006,'Net Banking',3000);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

