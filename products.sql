CREATE DATABASE  practice;
USE practice;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    quantity INT,
    added_date DATE,
    discount_rate NUMERIC(5,2)
);

INSERT INTO products
(product_name, category, price, quantity, added_date, discount_rate)
VALUES
('Laptop', 'Electronics', 75000.50, 10, '2024-01-15', 10.00),
('Smartphone', 'Electronics', 45000.99, 25, '2024-02-20', 5.00),
('Headphones', 'Accessories', 1500.75, 50, '2024-03-05', 15.00),
('Office Chair', 'Furniture', 5500.00, 20, '2023-12-01', 20.00),
('Desk', 'Furniture', 8000.00, 15, '2023-11-20', 12.00),
('Monitor', 'Electronics', 12000.00, 8, '2024-01-10', 8.00),
('Printer', 'Electronics', 9500.50, 5, '2024-02-01', 7.50),
('Mouse', 'Accessories', 750.00, 40, '2024-03-10', 10.00),
('Keyboard', 'Accessories', 1250.00, 35, '2024-03-18', 10.00),
('Tablet', 'Electronics', 30000.00, 12, '2024-02-28', 5.00);
SELECT * FROM products;
----------------------------------------------------------------
SELECT product_name, UPPER(product_name) AS UPPERR, LOWER(product_name) AS LOWERR
FROM products;
-----------------------------------------------------------------
SELECT product_name, LENGTH(product_name) AS COUNT_OF_PRODUCT_NAME
FROM products;
--------------------------------------------------------------------------
 SELECT TRIM('               MOHAN                  ') AS TRIM_VALUE;
 -----------------------------------------------------------------------------
 SELECT CONCAT(product_name,'--',price) AS Product_and_price
 FROM products;
 ------------------------------------------------------------------
 SELECT SUBSTRING(product_name,1,5)
 FROM products;
 /*
CURRENT_DATE_AND_TIME  */

 SELECT NOW() AS current_datetime;
 -----------------------------------------------------------------------------
SELECT CURRENT_DATE() AS Today_Time;
------------------------------------------------------------------------------------------------------------------------
SELECT  added_date, CURRENT_DATE() AS today_date, (CURRENT_DATE - added_date) AS date_difference FROM products;
------------------------------------------------------------------------------------------------------------------------
SELECT product_name,
		extract(YEAR FROM added_date) AS year
FROM products;
--------------------------------------------------------------------------------------
SELECT product_name,
		extract(MONTH FROM added_date) AS MONTH
FROM products;
-----------------------------------------------------------------------------------------------------------------------
SELECT product_name,
		EXTRACT(YEAR FROM added_date) AS year,
		EXTRACT(MONTH FROM added_date) AS month,
        EXTRACT(DAY FROM added_date) AS date
FROM products;
----------------------------------------------------------------------------------
SELECT product_name, 
	DATEDIFF(CURDATE() , added_date) AS age_count
FROM products;
-------------------------------------------------------------------
SELECT product_name, 
	DATE_FORMAT(added_date,'%D-%M-%Y') AS format_change
FROM products;
-------------------------------------------------------------------------
SELECT product_name, price, 
	CASE
		WHEN price >= 50000 THEN 'Expensive'
        WHEN price>=10000 AND price<= 49999 THEN 'Affordeable'
        ELSE 'Cheap'
	END AS product_stage
FROM products;
--------------------------------------------------------------------------
SELECT product_name,quantity,
		CASE 
			WHEN quantity>= 10 THEN 'In Stock'
            WHEN quantity BETWEEN 5 AND 9 THEN 'Available'
            ELSE 'Limited Stock'
		END AS quantity_measure
FROM products;
-----------------------------------------------------------------------
SELECT product_name, added_date, 
	DAYNAME( added_date) AS Date_Of_Week
FROM products;
---------------------------------------------------------------------------
SELECT product_name,added_date,
	DATE_FORMAT(added_date,'%Y-%M-%D') AS Month_Start,
    DAYNAME( added_date) AS Date_Of_Week
FROM products;
--------------------------------------------------------------------
SELECT product_name,added_date,
	DATE_ADD(added_date,INTERVAL 6 day) AS new_date,
    DATE_ADD(added_date,INTERVAL 6 MONTH) AS new_month,
    DATE_ADD(added_date,INTERVAL 6 YEAR) AS new_year
FROM products;
---------------------------------------------------------------------
SELECT CURRENT_DATE() AS Current_dates;
-----------------------------------------------------------------
SELECT added_date,
	DATE_FORMAT(added_date,'%D-%M-%Y') AS converted_date, 
    DAYNAME(added_date) AS Day_name
FROM products;
---------------------------------------------------------------------
ALTER TABLE products
		ADD COLUMN discount_price NUMERIC(10,2);
SET SQL_SAFE_UPDATES = 0;
UPDATE products 
SET discount_price = price*0.9
WHERE product_name  
NOT  IN ('Laptop','Smartphone') ;
---------------------------------------------------------------------
SELECT product_name,
		COALESCE(discount_price,price) AS new_price
FROM products;
--------------------------------------------------------
SELECT product_name,category,price,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS row_ranking
FROM products;
----------------------------------------------------------------------
SELECT product_name,category,price,
	SUM(price) OVER(PARTITION BY category ORDER BY price ASC) AS Sum_of_category,
	AVG(price) OVER(PARTITION BY category ORDER BY price ASC) AS AVG_of_category,
	COUNT(price) OVER(PARTITION BY category ORDER BY price ASC) AS Count_of_category
FROM products;
-------------------------------------------------------------------------------------
