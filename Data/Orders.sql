create temporary table Orderstemp (
  order_id varchar(50),
  customer_id varchar(50), 
  order_status varchar(50),
  order_purchase_timestamp timestamp,
  order_approved_at timestamp,
  order_delivered_carrier_date timestamp,
  order_delivered_customer_date timestamp,
  order_estimated_delivery_date date
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INto Table Orderstemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(order_id,
  customer_id, 
  order_status,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_carrier_date,
  order_delivered_customer_date,
  order_estimated_delivery_date);
  
select count(*) from Orderstemp;
SELECT order_id, order_purchase_timestamp FROM Orderstemp LIMIT 5;

drop table CustomerMapping;
CREATE TEMPORARY TABLE CustomerMapping AS
with WinnerCTE as(
SELECT 
        c.customer_unique_id,
        c.customer_id AS master_customer_id,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id 
            ORDER BY o.order_purchase_timestamp DESC
        ) as rn
    FROM Customerstemp c
    INNER JOIN Orderstemp o ON c.customer_id = o.customer_id)
SELECT count(*)
FROM WinnerCTE
WHERE rn = 1;



-- Run your UPDATE query here
UPDATE Orderstemp o
JOIN Customerstemp c ON o.customer_id = c.customer_id
JOIN CustomerMapping m ON c.customer_unique_id = m.customer_unique_id
SET o.customer_id = m.master_customer_id;

-- Disable the safety check
SET SQL_SAFE_UPDATES = 0;
-- Re-enable it afterward for safety
SET SQL_SAFE_UPDATES = 1;

-- Adding indexes to the temp tables so the join is fast
ALTER TABLE Customerstemp ADD INDEX (customer_id);
ALTER TABLE Customerstemp ADD INDEX (customer_unique_id);
ALTER TABLE Orderstemp ADD INDEX (customer_id);
ALTER TABLE CustomerMapping ADD INDEX (customer_unique_id);


SET SESSION sql_mode = '';

UPDATE Orderstemp 
SET 
    order_approved_at = NULLIF(order_approved_at, '0000-00-00 00:00:00'),
    order_delivered_carrier_date = NULLIF(order_delivered_carrier_date, '0000-00-00 00:00:00'),
    order_delivered_customer_date = NULLIF(order_delivered_customer_date, '0000-00-00 00:00:00'),
    order_estimated_delivery_date = NULLIF(order_estimated_delivery_date, '0000-00-00 00:00:00');


INSERT INTO Orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT 
    ot.order_id,
    ot.customer_id,
    ot.order_status,
    ot.order_purchase_timestamp,
    ot.order_approved_at,
    ot.order_delivered_carrier_date,
    ot.order_delivered_customer_date,
    ot.order_estimated_delivery_date
FROM Orderstemp ot
-- This join ensures the customer actually exists in your final table
JOIN Customers c ON ot.customer_id = c.customer_id;

