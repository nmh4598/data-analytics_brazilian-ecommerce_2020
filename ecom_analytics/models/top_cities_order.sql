WITH temp_view AS (
    SELECT
  DISTINCT c.customer_city,
  c.customer_state,
  COUNT(o.customer_id) order_count
FROM
  {{ source('source', 'olist_orders_dataset') }} o
JOIN
  {{ source('source', 'olist_customers_dataset') }} c
ON
  o.customer_id = c.customer_id
GROUP BY
  1, 2
ORDER BY
  3 DESC
)

SELECT *
FROM temp_view