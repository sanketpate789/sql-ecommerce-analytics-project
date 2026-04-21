-- Q17: Customers Who Purchased Electronics but Never Purchased Books
 select c.customer_unique_id
 from customers c 
 inner join orders o on c.customer_id = o.customer_id 
 inner join order_items oi on oi.order_id = o.order_id
 inner join products p on p.product_id = oi.product_id
 inner join product_category_name_translation pct on pct.product_category_name = p.product_category_name
 where pct.product_category_name_english regexp 'electronics ?'
 and c.customer_unique_id not in (SELECT DISTINCT c2.customer_unique_id
    FROM customers c2
    JOIN orders o2 ON c2.customer_id = o2.customer_id
    JOIN order_items oi2 ON o2.order_id = oi2.order_id
    JOIN products p2 ON oi2.product_id = p2.product_id
    JOIN product_category_name_translation pct2 ON p2.product_category_name = pct2.product_category_name
    WHERE pct2.product_category_name_english = 'books')
