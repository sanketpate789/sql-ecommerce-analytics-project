Create database Ecommerce;
use Ecommerce;


CREATE TABLE Geolocation (
    geolocation_zip_code_prefix INT PRIMARY KEY,
    geolocation_lat DECIMAL(10, 8) NOT NULL,
    geolocation_lng DECIMAL(10, 8) NOT NULL,
    geolocation_city VARCHAR(100) CHARACTER SET utf8mb4 NOT NULL, 
    geolocation_state CHAR(2) NOT NULL
);

Create table Customers  (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    -- We will add the Foreign Key once the Geolocation table exists
    CONSTRAINT fk_customer_geo 
        FOREIGN KEY (customer_zip_code_prefix) 
        REFERENCES Geolocation(geolocation_zip_code_prefix)
);


-- 1. Create the Parent Table first
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(255) CHARACTER SET utf8mb4 PRIMARY KEY,
    product_category_name_english VARCHAR(255) NOT NULL
);

-- 2. Then create the Child Table
CREATE TABLE Products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(255) CHARACTER SET utf8mb4,
    product_name_length INTEGER, -- Fixed spelling
    product_description_length INTEGER, -- Fixed spelling
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER,
    CONSTRAINT fk_category_name_translation
        FOREIGN KEY (product_category_name)
        REFERENCES product_category_name_translation(product_category_name)
);

Create Table Seller(
 Seller_id varchar(50) primary key,
 seller_zip_code_prefix INT not null,
   CONSTRAINT fk_seller_geo
   FOREIGN KEY (seller_zip_code_prefix) 
        REFERENCES Geolocation(geolocation_zip_code_prefix) 
);

Create Table Orders (
  order_id varchar(50) primary key,
  customer_id varchar(50), 
  order_status varchar(50),
  order_purchase_timestamp timestamp,
  order_approved_at timestamp,
  order_delivered_carrier_date timestamp,
  order_delivered_customer_date timestamp,
  order_estimated_delivery_date date,
  
  constraint fk_customerid_customer
  foreign key (Customer_id)
  References Customers(customer_id) 
);

Create Table Order_Payments (
  order_id varchar(50),
  payment_sequential integer,
  Payment_type varchar(20),
  Payment_installments integer not null,
  Payment_value decimal(10,2) not null,
  PRIMARY KEY (order_id, payment_sequential),
  constraint fk_order_id_Order_Payments
  foreign key (order_id)
  References Orders(order_id) 
);

-- 1. Drop the table and recreate it with a Composite Primary Key
DROP TABLE IF EXISTS Order_Reviews;

CREATE TABLE Order_Reviews (
  review_id VARCHAR(50),
  order_id VARCHAR(50),
  review_score INTEGER,
  review_comment_title VARCHAR(100) CHARACTER SET utf8mb4,
  review_comment_message LONGTEXT,
  review_creation_date DATE, 
  review_answer_timestamp TIMESTAMP,
  
  -- Defining the Composite Primary Key
  PRIMARY KEY (review_id, order_id),
  
  CONSTRAINT fk_order_id_Order_Reviews
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id) 
);

Create Table Order_items (
  order_id varchar(50),
  order_item_id integer, 
  product_id varchar(50),
  seller_id varchar(50),
  Shipping_limit_date timestamp,
  Price decimal(10,2),
  freight_value decimal(10,2),
  
  primary key(
    order_id,order_item_id
  ),
constraint fk_order_id_Order_items
  foreign key (order_id)
  References Orders(order_id),
  constraint fk_product_id_products
  foreign key (product_id)
  References Products(product_id),
  constraint fk_seller_id_Seller
  foreign key (seller_id)
  References Seller(seller_id)
);




