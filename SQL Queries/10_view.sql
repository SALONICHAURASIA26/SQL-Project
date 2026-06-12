--Q71 CUSTOMER SALES VIEW
CREATE VIEW customer_sales_view AS
SELECT c.name,
	s.order_number,
	s.order_date,
	s.quantity
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key;

SELECT *
FROM customer_sales_view;

--Q72 PRODUCT REVENUE VIEW
CREATE VIEW product_revenue_view AS
SELECT p.product_name,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY p.product_name;

SELECT * 
FROM product_revenue_view;

--Q73 STORE PERFORMANCE VIEW
CREATE VIEW store_performance_view AS
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
GROUP BY st.store_key;

SELECT * 
FROM store_performance_view;

--Q74 MONTHLY SALES VIEW
CREATE VIEW monthly_sales_view AS
SELECT DATE_TRUNC('month',s.order_date) AS month,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN products p
ON s.product_key=p.product_key
GROUP BY DATE_TRUNC('month',s.order_date);

SELECT *
FROM monthly_sales_view
ORDER BY month;

--Q75 TOP CUSTOMERS VIEW
CREATE VIEW top_customers_view AS
SELECT c.name,
	SUM(
		s.quantity*
		CAST(REPLACE(REPLACE(unit_price_usd,'$',''),',','')AS NUMERIC)
	)AS revenue
FROM sales s
JOIN customers c
ON s.customer_key=c.customer_key
JOIN products p
ON s.product_key=p.product_key
GROUP BY c.name;

SELECT *
FROM top_customers_view
ORDER BY name;
