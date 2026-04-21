create temporary table Order_itemsTemp (
  order_id varchar(50),
  order_item_id integer, 
  product_id varchar(50),
  seller_id varchar(50),
  Shipping_limit_date timestamp,
  Price decimal(10,2),
  freight_value decimal(10,2)
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INto Table Order_itemsTemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(  order_id,
  order_item_id, 
  product_id,
  seller_id,
  Shipping_limit_date,
  Price,
  freight_value);



UPDATE Order_itemsTemp 
SET 
    Shipping_limit_date = NULLIF(Shipping_limit_date, '0000-00-00 00:00:00');


INSERT INTO Order_items (
 order_id,
  order_item_id, 
  product_id ,
  seller_id ,
  Shipping_limit_date,
  Price ,
  freight_value
)
SELECT 
 ot.order_id,
  ot.order_item_id, 
  ot.product_id ,
  ot.seller_id ,
  ot.Shipping_limit_date,
  ot.Price ,
  ot.freight_value
FROM Order_itemsTemp ot
-- This join ensures the customer actually exists in your final table
JOIN Orders g ON ot.order_id = g.order_id
join products p on ot.product_id = p.product_id
join Seller s on ot.seller_id = s.seller_id

