--Q1 DISPLAY ALL CUSTOMERS
SELECT * FROM customers;

--Q2 DISPLAY UNIQUE PRODUCT CATEGORY
SELECT DISTINCT category
	FROM products;

--Q3 DISPLAY FIRST 10 SALES RECORD
SELECT * FROM sales
LIMIT 10;

--Q4 PRODUCT WITH PRICE GREATER THAN 1000
SELECT product_name,
	unit_price_usd
FROM products	
WHERE CAST(
	REPLACE(
		REPLACE(unit_price_usd,'$',''),
		',','')
	AS NUMERIC)>1000;

--Q5 FIND ALL FEMALE CUSTOMERS
SELECT name
FROM customers
WHERE gender='Female';

--Q6 DISPLAY PRODUCT IN DESCENDING ORDER OF PRICE
SELECT product_name,
	unit_price_usd
FROM products
ORDER BY CAST(
	REPLACE(
		REPLACE(unit_price_usd,'$',''),
			',','')AS NUMERIC
			)DESC;

--Q7 DISPLAY THE TOP 5 MOST EXPENSIVE PRODUCTS
SELECT product_name,
	unit_price_usd
FROM products
ORDER BY CAST(
	REPLACE(
		REPLACE(unit_price_usd,'$',''),
		',','')AS NUMERIC
	)DESC
LIMIT 5;

--Q8 COUNT CUSTOMERS BY CITY
SELECT city,
	COUNT(customer_key)
FROM customers	
GROUP BY city;

--Q9 COUNT TOTAL NO. OF PRODUCTS WITH PRODUCT NAME
SELECT product_name,
	COUNT(product_key)
FROM products
GROUP BY product_key;

--Q10 COUNT TOTAL NO. OF PRODUCTS
SELECT COUNT(*)
FROM products;

--Q11 COUNT TOTAL NO. OF CUSTOMERS
SELECT COUNT(customer_key)
FROM customers;

--Q12 FIND MAX PRODUCT PRICE
SELECT MAX(
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),
			',','') AS NUMERIC
	)
)AS max_price
FROM products;

--Q13 FIND MIN PRODUCT PRICE
SELECT MIN(
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),
			',','') AS NUMERIC
	)
)AS min_price
FROM products;

--Q14 FIND AVG PRODUCT PRICE
SELECT AVG(
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),
			',','')AS NUMERIC
		)
	)AS avg_price
FROM products;

--Q15 DISPLAY 10 CHEAPEST PRODUCT
SELECT product_name,
	unit_price_usd
FROM products
ORDER BY CAST(
	REPLACE(
		REPLACE(unit_price_usd,'$',''),
		',',''
	)AS NUMERIC
)ASC
LIMIT 10;

 
