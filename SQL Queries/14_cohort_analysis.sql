--Q101 CUSTOMER FIRST PURCHASE MONTH
SELECT s.customer_key,
	MIN(DATE_TRUNC('month',s.order_date)) AS first_purchase_month
FROM sales s
GROUP BY s.customer_key
ORDER BY s.customer_key;

--Q102 CREATE A MONTHLY COHORT TABLE
WITH first_purchase AS
(
	SELECT customer_key,
		MIN(DATE_TRUNC('month',order_date)) AS cohort_month
	FROM sales
	GROUP BY customer_key
)
SELECT fp.cohort_month,
	DATE_TRUNC('month',s.order_date) AS order_month,
	COUNT(DISTINCT s.customer_key) AS customers
FROM first_purchase fp	
JOIN sales s
ON fp.customer_key=s.customer_key
GROUP BY fp.cohort_month,
	DATE_TRUNC('month',s.order_date)
ORDER BY fp.cohort_month,
	order_month;

--Q103 CALCULATE RETENTION RATE FOR EACH MONTHLY COHORT
WITH first_purchase AS(
	SELECT customer_key,
		MIN(DATE_TRUNC('month',order_date)) AS cohort_month
	FROM sales
	GROUP BY customer_key
),
cohort_table AS
(
	SELECT fp.cohort_month,
		DATE_TRUNC('month',s.order_date)AS order_month,
		COUNT(DISTINCT s.customer_key) AS active_customers
	FROM first_purchase fp
	JOIN sales s
	ON fp.customer_key=s.customer_key
	GROUP BY fp.cohort_month,
		DATE_TRUNC('month',s.order_date)
),
cohort_size AS
(
	SELECT cohort_month,
		COUNT(*) AS total_customers
	FROM first_purchase
	GROUP BY cohort_month
)
SELECT ct.cohort_month,
	ct.order_month,
	cs.total_customers,
	ct.active_customers,
	ROUND(
		(ct.active_customers *100)/cs.total_customers,2
	)AS retention_rate
FROM cohort_table ct
JOIN cohort_size cs
ON ct.cohort_month=cs.cohort_month
ORDER BY ct.cohort_month,
	ct.order_month;

--Q104 CALCULATE 1 MONTH RETENTION
WITH first_purchase AS
(
	SELECT customer_key,
		MIN(DATE_TRUNC('month',order_date)) AS cohort_month
	FROM sales
	GROUP BY customer_key
),
month1_customers AS
(
	SELECT fp.cohort_month,
		COUNT(DISTINCT s.customer_key) AS active_customers
	FROM first_purchase fp
	JOIN sales s
	ON fp.customer_key=s.customer_key
	WHERE DATE_TRUNC('month',s.order_date) =
		fp.cohort_month + INTERVAL '1 month'
	GROUP BY fp.cohort_month	
),
cohort_size AS 
(
	SELECT cohort_month,
		COUNT(*)  AS total_customers
	FROM first_purchase
	GROUP BY cohort_month
)
SELECT cs.cohort_month,
	cs.total_customers,
	COALESCE(m1.active_customers,0) AS month1_customers,
	ROUND(
		COALESCE(m1.active_customers,0)*100.0/cs.total_customers,2
	)AS month1_retention
FROM cohort_size cs
LEFT JOIN month1_customers m1
ON cs.cohort_month=m1.cohort_month
ORDER BY cs.cohort_month;

--Q105 CALCULATE MONTH 2 RETENTION FOR EACH MONTHLY COHORT
WITH first_purchase AS
(
	SELECT customer_key,
		MIN(DATE_TRUNC('month',order_date)) AS cohort_month
	FROM sales
	GROUP BY customer_key
),
month2_customers AS
(
	SELECT fp.cohort_month,
		COUNT(DISTINCT s.customer_key) AS active_customers
	FROM first_purchase fp
	JOIN sales s
	ON fp.customer_key=s.customer_key
	WHERE DATE_TRUNC('month',s.order_date)=
		fp.cohort_month + INTERVAL '2month'
	GROUP BY fp.cohort_month
),
cohort_size AS
(
	SELECT cohort_month,
		COUNT(*) AS total_customers
	FROM first_purchase
	GROUP BY cohort_month
)
SELECT cs.cohort_month,
	cs.total_customers,
	COALESCE(m2.active_customers,0) AS month2_customers,
	ROUND(
		COALESCE(m2.active_customers,0)*100.0/
		cs.total_customers,2
	)AS month2_retention
FROM cohort_size cs
LEFT JOIN month2_customers m2
ON cs.cohort_month=m2.cohort_month
ORDER BY cs.cohort_month;




















