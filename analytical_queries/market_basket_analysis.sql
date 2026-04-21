-- Q19: Market Basket Analysis to Identify Frequently Bought Together Products
SELECT 
    p1.product_id AS Product_A, 
    p2.product_id AS Product_B, 
    COUNT(*) AS Times_Bought_Together
FROM order_items p1
INNER JOIN order_items p2 ON p1.order_id = p2.order_id
-- This line is the "magic" that prevents duplicates and self-pairing
WHERE p1.product_id < p2.product_id 
GROUP BY p1.product_id, p2.product_id
ORDER BY Times_Bought_Together DESC;
