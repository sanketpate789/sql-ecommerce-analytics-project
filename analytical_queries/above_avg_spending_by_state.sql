--  Find customers who spent more than the average customer in their state

WITH CustomerSpending AS (
    SELECT 
        c.customer_unique_id,
        g.geolocation_state,
        SUM(op.payment_value) AS total_customer_spend
    FROM order_payments op
    INNER JOIN orders o ON o.order_id = op.order_id
    INNER JOIN customers c ON c.customer_id = o.customer_id
    INNER JOIN geolocation g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
    GROUP BY c.customer_unique_id, g.geolocation_state
),
-- Step 2: Calculate the average of those totals per state
StateAverages AS (
    SELECT 
        geolocation_state,
        AVG(total_customer_spend) AS avg_state_spend
    FROM CustomerSpending
    GROUP BY geolocation_state
)
-- Step 3: Final Join and Filter
SELECT 
    cs.customer_unique_id,
    cs.geolocation_state,
    cs.total_customer_spend,
    sa.avg_state_spend
FROM CustomerSpending cs
JOIN StateAverages sa ON cs.geolocation_state = sa.geolocation_state
WHERE cs.total_customer_spend > sa.avg_state_spend;
