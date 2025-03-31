-- Generate business report to show all metrics

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales

UNION ALL

SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales

UNION ALL

SELECT 'Average Price' AS measure_name, ROUND(AVG(price)) AS measure_value FROM gold.fact_sales

UNION ALL

SELECT 'Total Orders' AS measure_name,COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
	--COUNT(order_number) as total_orders,

UNION ALL

SELECT 'Total products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.dim_products

UNION ALL

SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers