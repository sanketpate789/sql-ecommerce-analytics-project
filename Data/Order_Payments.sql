create temporary table Order_PaymentsTemp (
  order_id varchar(50),
  payment_sequential integer,
  Payment_type varchar(20),
  Payment_installments integer not null,
  Payment_value decimal(10,2) not null
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INto Table Order_PaymentsTemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
( order_id ,
  payment_sequential,
  Payment_type,
  Payment_installments,
  Payment_value);
  
  INSERT INTO Order_Payments (
 order_id,
  payment_sequential,
  Payment_type,
  Payment_installments,
  Payment_value
)
SELECT 
 ot.order_id,
  ot.payment_sequential,
  ot.Payment_type,
  ot.Payment_installments,
  ot.Payment_value
FROM Order_PaymentsTemp ot
-- This join ensures the customer actually exists in your final table
JOIN Orders g ON ot.order_id = g.order_id;

