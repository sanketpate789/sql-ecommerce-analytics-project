-- Q18: Best-Selling Product per Seller in Each Category using RANK()
select s.Seller_id,oh.product_id,oh.count_per_product,oh.product_category_name_english
from seller s 
inner join(
select oi.product_id as product_id,count(oi.product_id) as count_per_product,oi.seller_id as seller_id,pct.product_category_name_english as product_category_name_english,
Rank() over(partition by oi.seller_id,pct.product_category_name_english order by count(oi.product_id) desc) rn
from order_items oi 
inner join products p on p.product_id = oi.product_id
inner join product_category_name_translation pct on pct.product_category_name = p.product_category_name
group by oi.seller_id,oi.product_id,pct.product_category_name_english
) oh on s.Seller_id = oh.seller_id
where 
oh.rn=1
