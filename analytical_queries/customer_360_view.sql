-- Q16: Customer 360-Degree View using Multi-Table Joins (Customers, Orders, Items, Products, Reviews)
select c.customer_unique_id,gl.geolocation_city,gl.geolocation_state,oi.order_id,oi.total_order_value,ors.review_score,ors.review_comment_message
from customers c 
inner join geolocation gl on c.customer_zip_code_prefix = gl.geolocation_zip_code_prefix
inner join orders o on o.customer_id = c.customer_id
inner join (
 select order_id,sum(Payment_value) as total_order_value
 from order_payments 
 group by 
order_id
) oi on oi.order_id = o.order_id
inner join order_reviews ors on ors.order_id = oi.order_id

