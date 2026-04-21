LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INto Table product_category_name_translation
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(product_category_name,
product_category_name_english);
