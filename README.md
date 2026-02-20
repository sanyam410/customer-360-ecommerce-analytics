# Customer 360° E-Commerce Analytics Warehouse

## Business Problem

E-commerce companies generate large volumes of transactional data, but raw operational data does not directly provide insights into customer behaviour.

Businesses need to understand:

- Who are high value customers?
- Which customers are likely to churn?
- Who purchases frequently?
- How much revenue does each customer generate?

This project builds a Customer 360 analytics warehouse using MySQL to transform raw transactional data into business-ready customer intelligence.

---

## Project Architecture

The project follows a layered data warehouse architecture:

1. **Staging Layer** – Stores raw transactional data (OLTP simulation)
2. **Warehouse Layer** – Star schema for analytical processing
3. **Analytics Layer** – Customer KPI model and RFM segmentation
4. **Presentation Layer** – Final Customer 360 business view

---

##  Database Layers

### Staging Tables
- stg_customers
- stg_orders
- stg_order_items
- stg_products
- stg_payments

### Warehouse Tables
- wh_fact_orders
- wh_dim_customers
- wh_dim_products
- wh_dim_date
- wh_dim_payments

### Analytics Tables
- an_customer_kpi_summary
- an_rfm_segmentation

### Presentation View
- vw_customer_360

---

##  Customer KPIs

Customer-level metrics are calculated using SQL aggregations:

- **CLV (Customer Lifetime Value)** = Total amount spent
- **Recency** = Days since last purchase
- **Frequency** = Number of orders placed
- **Monetary** = Average order value

---

##  RFM Segmentation

Customers are segmented based on:

- Recency
- Frequency
- Monetary

Using NTILE(4) window function, customers are grouped into:

- Champions
- Loyal
- At Risk
- Lost

---

## Churn Detection

Customers with no purchases in the last 90 days are flagged as churned in the final Customer 360 view.

---

## Tech Stack

- MySQL
- Data Warehousing
- Star Schema
- Window Functions
- RFM Segmentation
- ETL
- OLAP Modeling
