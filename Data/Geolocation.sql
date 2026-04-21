SHOW VARIABLES LIKE "secure_file_priv";

create temporary table geolocationtemp (
  geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10, 8) NOT NULL,
    geolocation_lng DECIMAL(10, 8) NOT NULL,
    geolocation_city VARCHAR(100) CHARACTER SET utf8mb4 NOT NULL, 
    geolocation_state CHAR(2) NOT NULL
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
INto Table geolocationtemp
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state);

select count(geolocation_zip_code_prefix) from geolocationtemp;

with cte1 as (
select geolocation_zip_code_prefix,avg(geolocation_lat) as geolocation_lat ,avg(geolocation_lng) as geolocation_lng,max(geolocation_city) as geolocation_city,max(geolocation_state) as geolocation_state 
from geolocationtemp
group by geolocation_zip_code_prefix)

select count(geolocation_zip_code_prefix) from cte1;

INSERT INTO Geolocation (
    geolocation_zip_code_prefix, 
    geolocation_lat, 
    geolocation_lng, 
    geolocation_city, 
    geolocation_state
)
SELECT 
    geolocation_zip_code_prefix,
    AVG(geolocation_lat),
    AVG(geolocation_lng),
    MAX(geolocation_city),
    MAX(geolocation_state)
FROM geolocationtemp
GROUP BY geolocation_zip_code_prefix;
select count(*) from Geolocation


