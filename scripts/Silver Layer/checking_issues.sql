--check for null and duplicates in primary key--

--crm_cust_info--

SELECT cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1

--check for unwanted spaces--
SELECT cst_firstname FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT cst_gndr FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

--crm_prd_info--
SELECT prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1

SELECT prd_nm FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--check for null or negative numbers--
SELECT prd_cost FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL


--SALES_DETAILS--
--check for invalid date and its datatype--
SELECT 
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LENGTH(CAST(sls_order_dt AS VARCHAR(50))) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19900101

SELECT 
NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0
OR LENGTH(CAST(sls_ship_dt AS VARCHAR(50))) != 8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19900101

SELECT 
NULLIF(sls_due_dt,0) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LENGTH(CAST(sls_due_dt AS VARCHAR(50))) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19900101


--check for invalid date orders--
SELECT * FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--Checking if sales,quantity,price has -ve,0,NULL values--
--BUSINESS RULE : SALES = QUANTITY * PRICE--
SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price

--erp_tables--
--cust_az12--
--check unnecessary words from cid--
SELECT cid FROM bronze.erp_cust_az12

--select out of range birthdays--
SELECT DISTINCT
bdate 
FROM bronze.erp_cust_az12
WHERE bdate < '1925-01-01' OR bdate > CURRENT_DATE

--data standardization and consistency--
SELECT DISTINCT
gen
FROM bronze.erp_cust_az12

--loc_az101-
SELECT DISTINCT
	cntry
FROM bronze.erp_loc_a101
