create temporary table Order_ReviewsTemp (
  Review_id varchar(50),
  order_id varchar(50),
  review_score integer,
  review_comment_title VARCHAR(100) CHARACTER SET utf8mb4,
  review_comment_message LONGTEXT,
  review_creation_date date, 
  review_answer_timestamp timestamp
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INto Table Order_Reviews
fields terminated by ','
enclosed by '"'
Lines terminated by '\n'
Ignore 1 Rows
(  Review_id,
  order_id,
  review_score,
  review_comment_title,
  review_comment_message,
  review_creation_date, 
  review_answer_timestamp);
  
UPDATE Order_ReviewsTemp 
SET 
    review_creation_date = NULLIF(review_creation_date, '0000-00-00 00:00:00'),
    review_answer_timestamp = NULLIF(review_answer_timestamp, '0000-00-00 00:00:00');
  
INSERT INTO Order_Reviews (
  Review_id,
  order_id,
  review_score,
  review_comment_title,
  review_comment_message,
  review_creation_date, 
  review_answer_timestamp
)
SELECT 
 ot.Review_id,
  ot.order_id,
  ot.review_score,
  ot.review_comment_title,
  ot.review_comment_message,
  ot.review_creation_date, 
  ot.review_answer_timestamp
FROM Order_ReviewsTemp ot
-- This join ensures the customer actually exists in your final table
JOIN Orders g ON ot.order_id = g.order_id;


