--Q81 ROW_NUMBER()
SELECT order_number,
	quantity,
	ROW_NUMBER() OVER() AS row_no
FROM sales;

--Q82 RANK()
SELECT c.name,
	SUM(
		s.quantity*
		CAST(
			REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC
		)
	)AS revenue,
	RANK() OVER(
		ORDER BY SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)DESC)AS customer_rank
FROM sales s
JOIN customers c
ON s.customer_key =c.customer_key
JOIN products p
ON  s.product_key=p.product_key
GROUP BY c.name;

--Q83 DENSE_RANK()
SELECT c.name,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue,
	RANK() OVER(
		ORDER BY SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)DESC
	)AS customer_rank
FROM sales s
JOIN customers c
ON s.customer_key =c.customer_key
JOIN products p
ON  s.product_key=p.product_key
GROUP BY c.name;	

--Q84 TOP THREE CUSTOMERS
WITH customer_spending AS
(
	SELECT c.name,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS spending
	FROM sales s
	JOIN customers c
	ON s.customer_key=c.customer_key
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY c.name
)
SELECT *
FROM(
	SELECT *,
		DENSE_RANK() OVER(ORDER BY spending DESC)AS rnk
	FROM customer_spending
)temp_table
WHERE rnk<=3;

--Q85 TOP 3 PRODUCTS
WITH product_rev AS
(
	SELECT p.product_name,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY p.product_name
)
SELECT * 
FROM
(
	SELECT * ,
		DENSE_RANK() OVER(ORDER BY revenue DESC)AS rnk
	FROM product_rev
)temp_table
WHERE rnk<=3;

--Q86 RUNNING TOTAL REVENUE
SELECT s.order_date,
	SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue,
	SUM(
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)
	)OVER(ORDER BY s.order_date) AS running_total
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY s.order_date
ORDER BY s.order_date;

--Q87 MONTHLY RUNNING REVENUE
WITH monthly_revenue AS
(
	SELECT DATE_TRUNC('month', s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month', s.order_date)
)

SELECT month, 
	revenue, 
	SUM(revenue) OVER(ORDER BY month) AS running_rev
FROM monthly_revenue;	

--Q88 LAG()
WITH monthly_revenue AS
(
	SELECT DATE_TRUNC('month',s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month',s.order_date)
)

SELECT month,
	revenue,
	LAG(revenue) OVER(ORDER BY month) AS previous_rev
FROM monthly_revenue;	

--Q89 LEAD()
WITH monthly_revenue AS
(
	SELECT DATE_TRUNC('month',s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month',s.order_date)
)
SELECT month,
	revenue,
	LEAD(revenue) OVER(ORDER BY month) AS next_rev
FROM monthly_revenue;	

--Q90 PREVIOUS SALE AMOUNT COMPARE
WITH monthly_revenue AS 
(
		SELECT DATE_TRUNC('month',s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month',s.order_date)
)
SELECT month,
	revenue,
	LAG(revenue) OVER(ORDER BY month) AS pre_rev,
	revenue -
	LAG(revenue) OVER(ORDER BY month) AS difference
FROM monthly_revenue;	