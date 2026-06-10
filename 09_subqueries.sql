--Q66 SALES GREATER THAN AVG SALES
SELECT *
FROM sales
WHERE quantity>
(
	SELECT AVG(quantity)
	FROM sales
);

--Q67 HIGHEST REVENUE PRODUCT
SELECT p.product_name,
	SUM(
		s.quantity*
		CAST(
			REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC
		)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY p.product_name
HAVING SUM(
	s.quantity*
		CAST(
			REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)=
(
	SELECT MAX(revenue)
	FROM
	(
		SELECT SUM(
			s.quantity*
			CAST(
			REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	    	)AS revenue
		FROM sales s
		JOIN products p 
		ON s.product_key=p.product_key
		GROUP BY p.product_name
	)temp_table
);

--Q68 HIGHEST SPENDING CUSTOMER
SELECT c.name,
	SUM(
		s.quantity*
		CAST(
			REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC
		)
	)AS spending
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY c.name
HAVING SUM(
	s.quantity*
	CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
) =
(
	SELECT MAX(spending)
	FROM
	(
		SELECT SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS spending
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY s.customer_key
	)temp_table
);

--Q69 SECOND HIGHEST SALE
SELECT MAX(revenue)
FROM(
	SELECT SUM(
	s.quantity*
	CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY s.order_number
)temp_table
WHERE revenue <
(
	SELECT MAX(revenue)
	FROM(
		SELECT SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
		FROM sales s
		JOIN products p
		ON s.product_key=p.product_key
		GROUP BY s.order_number
	)x
);

--Q70 PRODUCTS ABOVE AVG PRICE
SELECT *
FROM products
WHERE CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','') AS NUMERIC)
>
(
	SELECT AVG(
		CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)
	FROM products
);














