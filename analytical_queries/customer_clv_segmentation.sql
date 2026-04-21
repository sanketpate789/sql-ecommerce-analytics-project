-- Q13: Customer Lifetime Value (CLV) Calculation with Bronze, Silver, Gold Segmentation
with cte1 as (
select c.customer_unique_id as customer_id ,
sum(op.Payment_value) as total_order_value_till_date 
from Customers c 
inner join orders o on c.customer_id = o.customer_id
inner join order_payments op on op.order_id = o.order_id
group by c.customer_unique_id)

select customer_id,total_order_value_till_date,
case when total_order_value_till_date>=1000 then 'gold'
      when total_order_value_till_date >=500  then 'silver'
      else
       'Bronze'
       End as Customer_category
 from cte1
 
