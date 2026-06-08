--Q26 CATEGORY-WISE PRODUCT COUNT
SELECT category,
	COUNT(*)AS product_count
FROM products
GROUP BY category;

--Q27 BRAND-WISE PRODUCT COUNT
SELECT brand,
	COUNT(*) AS product_count
FROM products
GROUP BY brand;

--Q28 COUNTRY-WISE CUSTOMER COUNT
SELECT country,
	COUNT(*) AS customer_count
FROM customers
GROUP BY country;

--Q29 GENDER-WISE CUSTOMER COUNT
SELECT gender,
	COUNT(*) AS customer_count
FROM customers
GROUP BY gender;

--Q30 STATE-WISE CUSTOMER COUNT
SELECT state,
	COUNT(*) AS customer_count
FROM customers
GROUP BY state;

--Q31 CITY-WISE CUSTOMER COUNT
SELECT city,
	COUNT(*) AS customer_count
FROM customers
GROUP BY city;

--Q32 COUNTRY-WISE STORE COUNT 
SELECT country,
	COUNT(*) AS store_count
FROM stores
GROUP BY country;

--Q33 CATEGORY-WISE AVERAGE PRICE
SELECT category,
	AVG(
		CAST(REPLACE(
				REPLACE(unit_price_usd,'$',''),
		',','')AS NUMERIC)
	)AS avg_price
FROM products
GROUP BY category;	

--Q34 BRAND-WISE AVERAGE PRICE
SELECT brand,
	AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
			',','')
		AS NUMERIC)
	)AS avg_price
FROM products
GROUP BY brand;
		
--Q35 CATEGORY-WISE MAXIMUM PRICE
SELECT category,
	MAX(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')
		AS NUMERIC)
	)AS max_price
FROM products
GROUP BY category;

