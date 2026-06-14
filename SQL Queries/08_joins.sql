--Q51 JOIN SALES AND PRODUCTS
SELECT s.order_number,
	s.order_date,
	s.quantity,
	p.product_name,
	p.category,
	p.unit_price_usd
FROM sales s
JOIN products p
ON s.product_key=p.product_key;

--Q52 JOIN SALES AND CUSTOMERS
SELECT s.order_number,
	c.name,
	s.order_date,
	s.quantity,
	c.city
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key;

SELECT DISTINCT country
from stores;


SELECT DISTINCT country
from customers;

--Q53 JOIN SALES AND STORES
SELECT s.order_number,
	s.order_date,
	s.store_key,
	sa.country,
	sa.state,
	s.quantity
FROM sales s
JOIN stores sa
ON s.store_key=sa.store_key;

--Q54 DISPLAY CUSTOMER NAME & PRODUCT NAME
SELECT c.name,
	p.product_name
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key = p.product_key;

--Q55 ORDER DETAILS WITH CUSTOMER & PRODUCT INFORMATION
SELECT s.order_number,
	s.line_item,
	s.order_date,
	s.quantity,
	c.name,
	p.product_name,
	p.category
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key=p.product_key;

--Q56 CALCULATE REVENUE PER ORDER
SELECT s.order_number,
	SUM(
		s.quantity*
		CAST(
			REPLACE(
				REPLACE(p.unit_price_usd,'$',''),',','')
		AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY s.order_number;

--Q57 CALCULATE TOTAL SALES AMOUNT
SELECT SUM(
	s.quantity*
	CAST(
		REPLACE(
			REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
)AS total_sales_amount
FROM sales s
JOIN products p
ON s.product_key=p.product_key;

--Q58 PRODUCT WISE REVENUE
SELECT p.product_name,
	SUM(
		s.quantity*
		CAST(
			REPLACE(
			REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY p.product_name;

--Q59 CUSTOMER WISE SPENDING
SELECT c.name,
	SUM(
		s.quantity*
		CAST(
			REPLACE(
			REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS spending
FROM sales s 
JOIN customers c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key = p.product_key
GROUP BY c.name;

--Q60 STORE WISE REVENUE
SELECT st.store_key,
	SUM(
	s.quantity*
	CAST(
		REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS renveue
FROM sales s
JOIN stores st
ON s.store_key=st.store_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY st.store_key;

--Q61 TOP 10 PRODUCTS BY REVENUE
SELECT p.product_name,
	SUM(
	s.quantity*
	CAST(
		REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

--Q62 TOP 10 CUSTOMERS BY SPENDING
SELECT c.name,
	SUM(
	s.quantity*
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),',',''
		)AS NUMERIC)
	)AS spending
FROM sales s
JOIN customerS c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY c.name
ORDER BY spending DESC
LIMIT 10;

--Q63 BEST PERFORMING STORE
SELECT st.store_key,
	SUM(
	s.quantity*
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),',',''
		)AS NUMERIC)
	)AS revenue
FROM sales s
JOIN stores st
ON s.store_key=st.store_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY st.store_key
ORDER BY revenue DESC
LIMIT 1;

--Q64 CATEGORY-WISE REVENUE
SELECT p.category,
	SUM(
	s.quantity*
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),',',''
		)AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY p.category; 

--Q65 COUNTRY-WISE REVENUE
SELECT st.country,
	SUM(
	s.quantity*
	CAST(
		REPLACE(
			REPLACE(unit_price_usd,'$',''),',',''
		)AS NUMERIC)
	)AS revenue	
FROM sales s
JOIN stores st
ON s.store_key=st.store_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY st.country;
