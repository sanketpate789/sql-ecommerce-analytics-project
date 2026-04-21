-- Q11: Month-over-Month Revenue Growth Analysis using LAG() with Edge Case Handling

ALTER TABLE Orders ADD INDEX (order_purchase_timestamp);

WITH MonthlyAggregatedSales AS (
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month_year,
        SUM(op.payment_value) AS monthly_sales
    FROM Orders o
    JOIN Order_Payments op ON o.order_id = op.order_id
    WHERE o.order_purchase_timestamp >= '2017-01-01' 
      AND o.order_purchase_timestamp < '2018-01-01'
    GROUP BY 1
),
CalculatedMoM AS (
    SELECT 
        month_year,
        monthly_sales,
        LAG(monthly_sales) OVER (ORDER BY month_year) AS prev_sales
    FROM MonthlyAggregatedSales
)
SELECT 
    month_year,
    monthly_sales,
    prev_sales,
    IFNULL(((monthly_sales - prev_sales) / prev_sales) * 100, 0) AS growth_percentage
FROM CalculatedMoM;
