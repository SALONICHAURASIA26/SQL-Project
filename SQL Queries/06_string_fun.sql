--Q41 DISPLAY CUSTOMER NAME IN UPPERCASE
SELECT name,
	UPPER(name) AS upper_name
FROM customers;

--Q42 DISPLAY CUSTOMER NAME IN LOWERCASE
SELECT name,
	LOWER(name) AS lower_name
FROM customers;	

--Q43 DISPLAY 1ST THREE CHARACTERS OF CUSTOMER NAME 
SELECT name,
	LEFT(name,3) AS first_three_char
FROM customers;	

--Q44 DISPLAY THE LENGTH OF CUSTOMER NAME 
SELECT name,
	LENGTH(name) AS name_length
FROM customers;	

--Q45 REPLACE SPACES IN PRODUCT NAME WITH '-'
SELECT product_name,
	REPLACE(product_name,' ','-') AS modified_name
FROM products;	
