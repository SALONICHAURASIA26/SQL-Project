--Q36 CATEGORIES HAVING MORE THAN 10 PRODUCTS
SELECT category,
	COUNT(*) AS pro_count
FROM products
GROUP BY category
HAVING COUNT(*)>10;

--Q37 BRANDS HAVING MORE THAN 5 PRODUCTS
SELECT brand,
	COUNT(*) AS pro_count
FROM products
GROUP BY brand
HAVING COUNT(*)>5;

--38 CITIES HAVING MORE THAN 20 CUSTOMERS
SELECT city,
	COUNT(DISTINCT customer_key)AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(DISTINCT customer_key)>20;

--Q39 COUNTRIES HAVING MORE THAN 10 STORES
SELECT country,
	COUNT(*)AS store_count
FROM stores
GROUP BY country
HAVING COUNT(*)>10;

--Q40 DISPALY CATEGORIES WHOSE AVG PRICE IS GREATER THAN 500 USD
SELECT category,
	AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC
		)
	)AS avg_price
FROM products
GROUP BY category
HAVING AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC
		)
	)>500;

	
