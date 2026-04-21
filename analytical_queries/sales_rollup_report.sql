-- Q14: Sales Report with Daily, Weekly, and Monthly Subtotals using ROLLUP
SELECT 
    YEAR(o.order_purchase_timestamp) AS SalesYear,
    MONTH(o.order_purchase_timestamp) AS SalesMonth,
    WEEK(o.order_purchase_timestamp) AS SalesWeek,
    DAY(o.order_purchase_timestamp) AS SalesDay,
    SUM(oi.price) AS TotalRevenue
FROM order_items oi 
INNER JOIN Orders o ON o.order_id = oi.order_id
GROUP BY 
    SalesYear, 
    SalesMonth, 
    SalesWeek, 
    SalesDay 
WITH ROLLUP;
