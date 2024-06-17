WITH temp_view AS (
    SELECT
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
  COUNT(DISTINCT o.order_id) AS order_count,
  ROUND(CAST(SUM(p.payment_value) AS numeric), 2) as revenue
FROM
  {{ source('source', 'olist_orders_dataset') }} o
JOIN
  {{ source('source', 'olist_customers_dataset') }} c
ON
  o.customer_id = c.customer_id
JOIN
  {{ source('source', 'olist_order_payments_dataset') }} p 
ON
  o.order_id = p.order_id
GROUP BY
  year, month
ORDER BY
  year, month

)

SELECT *
FROM temp_view