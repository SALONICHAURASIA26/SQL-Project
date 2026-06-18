--Q91 CURRENT MONTH SALES
SELECT DATE_TRUNC('month',s.order_date)AS month,
	SUM(
		s.quantity *
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS current_month_sales
FROM sales s
JOIN products p
ON s.product_key=p.product_key
WHERE DATE_TRUNC('month',s.order_date)=(
	SELECT DATE_TRUNC('month',MAX(order_date))
	FROM sales
)
GROUP BY DATE_TRUNC('month',s.order_date);

--Q92 LATEST YEAR SALES
SELECT EXTRACT(YEAR FROM s.order_date)AS year,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS latest_month_sales
FROM sales s
JOIN products p
ON s.product_key=p.product_key
WHERE EXTRACT(YEAR FROM s.order_date)=
(
	SELECT MAX(EXTRACT(YEAR FROM order_date))
	FROM sales
)
GROUP BY EXTRACT(YEAR FROM s.order_date);

--Q93 MONTH WISE SALES
SELECT DATE_TRUNC('month',s.order_date) AS month,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP  BY DATE_TRUNC('month',s.order_date)
ORDER BY month;

--Q94 WEEK-WISE REVENUE
SELECT DATE_TRUNC('week',s.order_date) AS week,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s	
JOIN products p
ON s.product_key=p.product_key
GROUP BY DATE_TRUNC('week',s.order_date)
ORDER BY week;

--Q95 DAY-WISE REVENUE
SELECT s.order_date,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s	
JOIN products p
ON s.product_key=p.product_key
GROUP BY s.order_date
ORDER BY s.order_date;

--Q96 QUARTER WISE REVENUE
SELECT EXTRACT(YEAR FROM s.order_date) AS year,
	EXTRACT(QUARTER FROM s.order_date) AS quarter,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s	
JOIN products p
ON s.product_key=p.product_key
GROUP BY EXTRACT(YEAR FROM s.order_date),
	EXTRACT(QUARTER FROM s.order_date) 
ORDER BY year, quarter;

--Q97 HIGHEST REVENUE MONTH
SELECT DATE_TRUNC('month',s.order_date) AS month,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s	
JOIN products p
ON s.product_key=p.product_key
GROUP BY DATE_TRUNC('month',s.order_date)
ORDER BY revenue DESC
LIMIT 1;

--Q98 LOWEST REVENUE MONTH
SELECT DATE_TRUNC('month',s.order_date)AS month,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s	
JOIN products p
ON s.product_key=p.product_key
GROUP BY DATE_TRUNC('month',s.order_date)
ORDER BY revenue ASC
LIMIT 1;

--Q99 MONTH-OVER-MONTH GROWTH
WITH monthly_rev AS
(
	SELECT DATE_TRUNC('month',s.order_date)AS month,
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
	LAG(revenue) OVER(ORDER BY month) AS previous_month_rev,
	revenue - LAG(revenue) OVER(ORDER BY month) AS growth
FROM monthly_rev;

--Q100 YEAR-OVER-YEAR GROWTH
WITH yearly_rev AS
(
	SELECT EXTRACT(YEAR FROM s.order_date) AS year,
		SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(p.unit_price_usd,'$',''),',','')AS NUMERIC)
		)AS revenue
		FROM sales s
	JOIN products p
	ON s.product_key=p.product_key
	GROUP BY EXTRACT(YEAR FROM s.order_date)
)
SELECT year,
	revenue,
	LAG(revenue) OVER(ORDER BY year) AS previous_year,
	revenue - LAG(revenue) OVER(ORDER BY year)AS growth
FROM yearly_rev;	
