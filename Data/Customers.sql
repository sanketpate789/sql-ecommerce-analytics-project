create temporary table Customerstemp (
	customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL
);


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INto Table Customerstemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(customer_id,
    customer_unique_id,
    customer_zip_code_prefix);
    
select count(*) from Customerstemp;

with cte2 as (select max(customer_id) as customer_id from Customerstemp
group by customer_unique_id)

select count(customer_id) from cte2;


INSERT INTO Customers (
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix
)
SELECT 
    c.customer_id, 
    c.customer_unique_id, 
    c.customer_zip_code_prefix
FROM Customerstemp c
JOIN CustomerMapping m ON c.customer_id = m.master_customer_id
JOIN Geolocation g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix;


select count(*) from Customers
