-- Q15: Seasonal Sales Analysis to Identify Best-Selling Product Categories by Month
with cte1 as (
SELECT 
 pct.product_category_name_english as product_category_name_english,
    MONTH(o.order_purchase_timestamp) AS SalesMonth,
    SUM(oi.price) AS Revenue
FROM order_items oi 
INNER JOIN Orders o ON o.order_id = oi.order_id
inner join Products p on p.product_id = oi.product_id
inner join product_category_name_translation pct on pct.product_category_name = p.product_category_name
where  YEAR(o.order_purchase_timestamp) = 2017
GROUP BY 
   pct.product_category_name_english,
    SalesMonth
)
,cte2 as (
select product_category_name_english,SalesMonth,max(Revenue) as max_revenue,
rank() over(partition by product_category_name_english order by max(Revenue) desc) as rn 
from cte1
group by product_category_name_english,SalesMonth)
select distinct product_category_name_english,SalesMonth,max_revenue
from cte2
where rn =1
