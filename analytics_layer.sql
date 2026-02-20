mysql> CREATE TABLE an_customer_kpi_summary AS
    -> SELECT
    ->     customer_id,
    ->     SUM(total_amount) AS CLV,
    ->     DATEDIFF(CURDATE(), MAX(order_date)) AS recency,
    ->     COUNT(order_id) AS frequency,
    ->     AVG(total_amount) AS monetary,
    ->     MIN(order_date) AS first_purchase,
    ->     MAX(order_date) AS last_purchase
    -> FROM wh_fact_orders
    -> GROUP BY customer_id;
Query OK, 5 rows affected (0.02 sec)
mysql> CREATE TABLE an_rfm_segmentation AS
    -> SELECT
    ->     customer_id,
    ->
    ->     NTILE(4) OVER (ORDER BY recency DESC) AS recency_score,
    ->     NTILE(4) OVER (ORDER BY frequency) AS frequency_score,
    ->     NTILE(4) OVER (ORDER BY monetary) AS monetary_score
    ->
    -> FROM an_customer_kpi_summary;
Query OK, 5 rows affected (0.04 sec)
mysql> ALTER TABLE an_rfm_segmentation
    -> ADD rfm_segment VARCHAR(20);
Query OK, 0 rows affected (0.02 sec)


mysql> UPDATE an_rfm_segmentation
    -> SET rfm_segment =
    -> CASE
    ->     WHEN recency_score >=3 AND frequency_score >=3 AND monetary_score >=3 THEN 'Champions'
    ->     WHEN recency_score >=2 AND frequency_score >=3 THEN 'Loyal'
    ->     WHEN recency_score <=2 AND frequency_score >=2 THEN 'At Risk'
    ->     ELSE 'Lost'
    -> END;
