--calculate total sales per month and runnnig total of sales overtime
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) as cumulative_sales,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date)) as cumulative_avg_price
FROM
(
SELECT
	DATE_TRUNC('year', order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	ROUND(AVG(price)) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('year', order_date) 
)