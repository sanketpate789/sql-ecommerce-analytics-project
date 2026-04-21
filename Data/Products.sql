LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INto Table Products
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(    product_id,
    product_category_name,
    product_name_length, -- Fixed spelling
    product_description_length, -- Fixed spelling
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm);
    
    select count(*) from Products
