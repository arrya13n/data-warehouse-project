--explore all objects in DATABASE
SELECT * FROM information_schema.tables;

--explore all COLUMNS
SELECT * FROM information_schema.columns

--Exploring dimensions--
--explore countries--
SELECT DISTINCT
	country
FROM gold.dim_customers

--explore major product categories--

SELECT DISTINCT category,subcategory,product_name FROM gold.dim_products
ORDER BY product_name

--first and last order date 
--how many years diff between them--
SELECT 
	MIN(order_date) first_order_date,
	MAX(order_date) last_order_date,
	EXTRACT(YEAR FROM MAX(order_date)) - EXTRACT(YEAR FROM MIN(order_date)) AS order_range
FROM gold.fact_sales

--find the youngest and oldest customers and age difference between them--

SELECT 
	MIN(birth_date) oldest_customer,
	MAX(birth_date) youngest_customer,
	EXTRACT(YEAR FROM MAX(birth_date)) - EXTRACT(YEAR FROM MIN(birth_date)) AS age_difference
FROM gold.dim_customers

--exploring measures (big numbers)

---find total sales and no. of items sold
--avg selling price
--total no. of products, customers,orders--

SELECT 
 	SUM(sales_amount) AS total_sales,
 	SUM(quantity) AS total_items
FROM gold.fact_sales

SELECT AVG(price) AS avg_price FROM gold.fact_sales

SELECT 
	COUNT(order_number) as total_orders,
	COUNT(DISTINCT order_number) as distinct_orders 
FROM gold.fact_sales

SELECT 
	COUNT(product_key) as total_products
	--COUNT(DISTINCT product_key) as distinct_products
FROM gold.dim_products

SELECT 
	COUNT(customer_key) as total_customers
	--COUNT(DISTINCT customer_key) as distinct_customers 
FROM gold.dim_customers

--total no. of orders placed by customer
SELECT COUNT(customer_key) as total_customers_ordered FROM gold.fact_sales