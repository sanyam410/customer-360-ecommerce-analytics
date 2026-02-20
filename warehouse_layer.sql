mysql> CREATE TABLE wh_fact_orders (
    ->     order_id INT,
    ->     customer_id INT,
    ->     product_id INT,
    ->     order_date DATE,
    ->     quantity INT,
    ->     total_amount DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO wh_fact_orders
    -> SELECT
    ->     o.order_id,
    ->     o.customer_id,
    ->     oi.product_id,
    ->     o.order_date,
    ->     oi.quantity,
    ->     (oi.quantity * oi.price) AS total_amount
    -> FROM stg_orders o
    -> JOIN stg_order_items oi
    -> ON o.order_id = oi.order_id
    -> WHERE o.order_status = 'Delivered';
Query OK, 6 rows affected (0.01 sec)
  mysql> CREATE TABLE wh_dim_customers AS
    -> SELECT DISTINCT
    ->     customer_id,
    ->     city,
    ->     signup_date
    -> FROM stg_customers;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE wh_dim_products AS
    -> SELECT DISTINCT
    ->     product_id,
    ->     category,
    ->     brand
    -> FROM stg_products;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE wh_dim_date AS
    -> SELECT DISTINCT
    ->     order_date,
    ->     MONTH(order_date) AS month,
    ->     YEAR(order_date) AS year
    -> FROM stg_orders;
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE wh_dim_payments AS
    -> SELECT DISTINCT
    ->     payment_id,
    ->     payment_type
    -> FROM stg_payments;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0
