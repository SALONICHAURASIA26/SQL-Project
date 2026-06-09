--Q46 CLASSIFY PRODUCTS AS LOW,MEDIUM AND HIGH PRICE
SELECT product_name,
	unit_price_usd,
	CASE
		WHEN CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC)<500
					THEN 'Low Price'

		WHEN CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC) BETWEEN 500 AND 1000
					THEN 'Medium Price'

		ELSE 'High Price'
	END AS price_category
FROM products;	

--Q47 CLASSIFY CUSTOMERS INTO YOUNG, ADULT & SENIOR AGE GROUPS
SELECT  name,
	birthday,
	CASE
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE,birthday))<30
			THEN 'Young'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthday)) BETWEEN 30 AND 50
			THEN 'Adult'
		ELSE 'Senior'
	END AS age_group
FROM customers;	

--Q48 CLASSIFY STORES AS SMALL, MEDIUM & LARGE 
SELECT store_key,
	square_meter,
	CASE
		WHEN square_meter <500
			THEN 'Small'
		WHEN square_meter BETWEEN 500 AND 1500
			THEN 'Medium'
		ELSE 'Large'
	END AS store_size
FROM stores;	

--Q49 CATEGORY PRICE SEGMENT
SELECT category,
	AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC)
	)AS avg_price,
	CASE
		WHEN AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC)
				)<500
					THEN 'Budget'

		WHEN AVG(
		CAST(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',','')AS NUMERIC)
				) BETWEEN 500 AND 1000
					THEN 'Mid Range'
		ELSE 'Premium'
	END AS price_segment
FROM products
GROUP BY category;

--Q50 COUNTRY GROUPING
SELECT country,
	CASE 
		WHEN country IN ('United States','Canada')
			THEN 'North America'
		WHEN country IN ('United Kingdom','Germany','France','Italy','Netherlands')	
			THEN 'Europe'
		WHEN country = 'Australia'
			THEN 'Oceania'
		ELSE 'Other'
	END AS country_group
FROM customers;	
	





