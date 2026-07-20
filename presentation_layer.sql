-- ============================================================
-- PRESENTATION LAYER
-- Final Customer 360 business view: joins KPI summary with
-- RFM segmentation and flags churned customers (no delivered
-- order in the last 90 days).
-- ============================================================

DROP VIEW IF EXISTS vw_customer_360;

CREATE VIEW vw_customer_360 AS
SELECT
    k.customer_id,
    k.CLV,
    k.recency,
    k.frequency,
    k.monetary,
    k.first_purchase,
    k.last_purchase,
    r.recency_score,
    r.frequency_score,
    r.monetary_score,
    r.rfm_segment,
    CASE
        WHEN k.recency > 90 THEN 'Churned'
        ELSE 'Active'
    END AS churn_status
FROM an_customer_kpi_summary k
JOIN an_rfm_segmentation r ON k.customer_id = r.customer_id;
