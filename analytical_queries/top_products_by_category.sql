-- Q12: Top 10 Products by Revenue in Each Category using RANK()
with top10products as (
select oi.product_id as product_id,
sum(oi.price) as Payment_value,
pt.product_category_name_english as product_category_name_english,
dense_rank() over(partition by pt.product_category_name_english order by sum(oi.price) desc) as rn
from Order_items oi
inner join Products p on oi.product_id = p.product_id
inner join product_category_name_translation pt on pt.product_category_name= p.product_category_name
group by oi.product_id,pt.product_category_name_english)

select product_id,Payment_value,product_category_name_english
from top10products 
where rn<=10;
