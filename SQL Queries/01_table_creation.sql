--CREATE TABLE CUSTOMERS
CREATE TABLE customers(
	customer_key INT PRIMARY KEY,
	gender VARCHAR(10),
	name VARCHAR(100),
	city VARCHAR(100),
	state_code VARCHAR(100),
	state VARCHAR(100),
	zip_code VARCHAR(120),
	country VARCHAR(100),
	continent VARCHAR(100),
	birthday DATE
);

SELECT * FROM customers;
--CREATE TABLE PRODUCTS
CREATE TABLE products(
	product_key INT PRIMARY KEY,
	product_name VARCHAR(300),
	brand VARCHAR(100),
	color VARCHAR(50),
	unit_cost_usd TEXT,
	unit_price_usd TEXT,
	subcategory_key INT,
	subcategory VARCHAR(100),
	category_key INT,
	category VARCHAR(100)
);
--CREATE TABLE STORES
CREATE TABLE stores(
	store_key INT PRIMARY KEY,
	country VARCHAR(100),
	state VARCHAR(100),
	square_meter INT,
	open_date DATE
);
--CREATE TABLE SALES
CREATE TABLE sales(
	order_number INT,
	line_item INT,
	order_date DATE,
	delivery_date DATE,
	customer_key INT,
	store_key INT,
	product_key INT,
	qunatity INT,
	currency_code VARCHAR(50),

	PRIMARY KEY(order_number,line_item),

	FOREIGN KEY(customer_key)
		REFERENCES customers(customer_key),
	
	FOREIGN KEY(store_key)
		REFERENCES stores(store_key),
	
	FOREIGN KEY(product_key)
		REFERENCES products(product_key)
);
