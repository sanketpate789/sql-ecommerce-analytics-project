create temporary table SellerTemp (
 Seller_id varchar(50),
 seller_zip_code_prefix INT not null
);




LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INto Table SellerTemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
( Seller_id,
 seller_zip_code_prefix);
 
 select count(*)
from    SellerTemp ;

INSERT INTO Seller (
 Seller_id,
 seller_zip_code_prefix
)
SELECT 
 ot.Seller_id ,
 ot.seller_zip_code_prefix
FROM SellerTemp ot
-- This join ensures the customer actually exists in your final table
JOIN Geolocation g ON ot.seller_zip_code_prefix = g.geolocation_zip_code_prefix;

