-- Q20: Orders with Shipping Delays (Expected vs Actual Delivery) with Customer and Seller Details

-- Add a virtual column for the severity of the delay (in days)
ALTER TABLE orders 
ADD COLUMN days_delayed INT GENERATED ALWAYS AS (
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)
        ELSE 0 
    END
) VIRTUAL;

-- Index the severity
CREATE INDEX idx_delay_severity ON orders(days_delayed);

select o.customer_id,oi.seller_id,o.order_delivered_customer_date,o.order_estimated_delivery_date 
from orders o 
inner join order_items oi on o.order_id = oi.order_id
where o.days_delayed>=1;
