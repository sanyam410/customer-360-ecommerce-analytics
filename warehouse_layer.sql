-- ============================================================
-- WAREHOUSE LAYER
-- Star schema built from the staging layer for analytical
-- processing: one fact table (orders) + four dimension tables.
-- ============================================================

DROP TABLE IF EXISTS wh_fact_orders;
DROP TABLE IF EXISTS wh_dim_customers;
DROP TABLE IF EXISTS wh_dim_products;
DROP TABLE IF EXISTS wh_dim_date;
DROP TABLE IF EXISTS wh_dim_payments;

-- ------------------------------------------------------------
-- Fact table: one row per order line item, Delivered orders only
-- ------------------------------------------------------------
CREATE TABLE wh_fact_orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2)
);

INSERT INTO wh_fact_orders
SELECT
    o.order_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    oi.quantity,
    (oi.quantity * oi.price) AS total_amount
FROM stg_orders o
JOIN stg_order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- ------------------------------------------------------------
-- Dimension tables
-- ------------------------------------------------------------
CREATE TABLE wh_dim_customers AS
SELECT DISTINCT
    customer_id,
    city,
    signup_date
FROM stg_customers;

CREATE TABLE wh_dim_products AS
SELECT DISTINCT
    product_id,
    category,
    brand
FROM stg_products;

CREATE TABLE wh_dim_date AS
SELECT DISTINCT
    order_date,
    MONTH(order_date) AS month,
    YEAR(order_date) AS year
FROM stg_orders;

CREATE TABLE wh_dim_payments AS
SELECT DISTINCT
    payment_id,
    payment_type
FROM stg_payments;
