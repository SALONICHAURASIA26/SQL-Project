--Q76 MONTHLY REVENUE USING CTE
WITH monthly_revenue AS
(
	SELECT DATE_TRUNC('month',s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month',s.order_date)
	ORDER BY DATE_TRUNC('month',s.order_date)DESC
)
SELECT *
FROM monthly_revenue;

--Q77 TOP CUSOTMERS USING CTE
WITH customer_spending AS
(
	SELECT c.customer_key,
		c.name,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS spending
	FROM sales s
	JOIN customers c
	ON s.customer_key=c.customer_key
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY c.customer_key,c.name
)
SELECT *
FROM customer_spending
ORDER BY spending desc
LIMIT 10;

--Q78 CATEGORY REVENUE USING CTE
WITH category_revenue AS
(
	SELECT p.category,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY p.category
)
SELECT *
FROM category_revenue;

--Q79 STORE PERFORMANCE USING CTE
WITH store_performance AS
(
	SELECT st.store_key,
		st.country,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN stores st
	ON s.store_key=st.store_key
	JOIN products p 
	ON s.product_key=p.product_key
	GROUP BY st.store_key,st.country
	ORDER BY st.store_key DESC
)
SELECT *
FROM store_performance;

--Q80 RUNNING REVENUE USING CTE
WITH monthly_revenue AS(
	SELECT DATE_TRUNC('month',s.order_date) AS month,
		SUM(
			s.quantity*
			CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
	FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY DATE_TRUNC('month',s.order_date)
)

SELECT month,
	revenue,
	SUM(revenue) OVER(ORDER BY month) AS running_rev
FROM monthly_revenue;	