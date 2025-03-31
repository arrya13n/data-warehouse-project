--which 5 subcategories generate highest revenue

SELECT
	p.subcategory,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC
LIMIT 5

--what are the worst performing products in terms of sale

SELECT
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 5

--find top 10 customers who have generated highest revenue
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_sales
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY total_sales DESC
LIMIT 10


--find bottom 3 customers with lowest order placed
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS total_order_placed
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY total_order_placed ASC
LIMIT 3