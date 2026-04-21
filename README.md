# 🛒 E-Commerce SQL Analytics Project  

🚀 Built using a real-world dataset (100K+ rows) from Olist Brazilian E-Commerce  

---

## 📌 Project Overview  

This project focuses on solving real-world business problems using SQL on a large-scale e-commerce dataset.  
Instead of basic queries, the goal was to simulate real data engineering and analytics scenarios.  

---

## ⚙️ What I Did  

- Designed normalized database schema (3NF)  
- Loaded and processed 100K+ rows of raw data  
- Handled real-world data issues (nulls, inconsistencies, joins)  
- Built analytical queries to extract business insights  
- Optimized performance using indexing and query improvements  

---

## 📊 Key Analytics Implemented  

### 📈 Revenue Analysis  
- Month-over-Month (MoM) revenue growth using `LAG()`  
- Handled edge cases like first month and division by zero  

### 🛍️ Product & Sales Insights  
- Top 10 products by revenue in each category  
- Seasonal sales trends by month  
- Sales aggregation using `ROLLUP` (daily, weekly, monthly)  

### 👤 Customer Analytics  
- Customer Lifetime Value (CLV) segmentation (Bronze/Silver/Gold)  
- Customer 360° view using joins across 5+ tables  
- Customers spending above average in their state  

### 🧠 Advanced SQL Problems  
- Market Basket Analysis (frequently bought together products)  
- Category-based customer behavior analysis  
- Seller performance using `RANK()` and window functions  

### 🚚 Operational Insights  
- Shipping delay analysis (expected vs actual delivery)  
- Created virtual columns to measure delay severity  
- Indexed delay column for performance optimization  

---

## 🚀 Performance Optimization  

- Added indexes on frequently queried columns  
- Implemented composite indexing  
- Used `EXPLAIN` to analyze query performance  
- Reduced query execution time on large datasets  

---

## 🛠️ Tech Stack  

- SQL (MySQL)  
- Window Functions (LAG, RANK)  
- Joins, Subqueries, CTEs  
- Indexing & Query Optimization  

---

## 📁 Project Structure  



---

## ⚡ Key Challenges Faced  

- Handling large dataset (100K+ rows) → faced timeout issues  
- Managing complex joins across multiple tables  
- Optimizing queries for better performance  
- Working with real-world messy data  

---

## 💡 Key Learnings  

- SQL is not just querying — it's about solving business problems  
- Window functions are extremely powerful  
- Indexing plays a critical role in performance  
- Real-world data is always messy and requires careful handling  

---

## 📌 Current Progress  

✅ Completed: 21/30 SQL challenges  
🚀 In Progress: Advanced window functions & optimization  

---

## 🔗 Dataset  

Olist Brazilian E-Commerce Dataset (Kaggle)  

---


