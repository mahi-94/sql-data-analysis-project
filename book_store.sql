CREATE DATABASE onlinebookstore;
USE onlinebookstore;
DROP TABLE IF EXISTS Orders;
CREATE TABLE Books(
Book_ID	SERIAL	PRIMARY KEY,
Title	VARCHAR(150)	NOT NULL,
Author	VARCHAR(100)	NOT NULL,
Genre	VARCHAR(100)	NOT NULL,
Published_Year	INT	NOT NULL,
Price	NUMERIC(10,2)	NOT NULL,
Stock	INT	NOT NULL
);
CREATE TABLE Customers(
Customer_ID	 SERIAL	 PRIMARY KEY,
Name	VARCHAR(100),	
Email	VARCHAR(100),	
Phone	VARCHAR(15),	
City	VARCHAR(50),	
Country	VARCHAR(150)	
);
CREATE TABLE Orders(
Order_ID	SERIAL	PRIMARY KEY,
Customer_ID	INT	REFERENCES Customers(Customer_ID),
Book_ID	INT	REFERENCES  Books(Books_ID),
Order_Date	DATE,	
Quantity	INT,	
Total_Amount NUMERIC(10,2)
);
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
#--------------Showing_Only_Frictions----------------------------------------------------
SELECT * FROM Books
WHERE Genre = 'Fiction';
#-----------------------Books_Publish_after_1950----------------
SELECT * FROM Books
WHERE Published_Year > 1950;
#---------------------List All The Customer From Canada------------
SELECT * FROM Customers
WHERE Country = 'Canada';
#-------------------SHOW ORDER PLACE IN NOVEMBER 2023----
SELECT * FROM Orders
WHERE Order_Date  BETWEEN '2023-11-01' AND '2023-11-30';
#-----Total Stock OF Book AvailabLe
SELECT SUM(Stock) AS Total_Stock FROM Books;
#Find The Delails of most expensive books
SELECT * FROM Books ORDER BY price DESC LIMIT 5;
#--------- Show all the customers who order more then 1 quantity of book
SELECT * FROM Orders
WHERE Quantity > 1;
#--------Retrieve all orders where the total amount exceed $20
SELECT  * FROM Orders
WHERE Total_Amount > 20;
#--------ALL GENRE AVAILABLE IN BOOK TABLE
SELECT DISTINCT genre FROM Books;
#find the book with The lowest stock
SELECT * FROM Books
ORDER BY Stock ASC LIMIT 5;
#------------Calculate total revenue genterted from  all orders
SELECT SUM(Total_Amount) AS Revenue FROM Orders;
#--------------ADVANCE QUESTIONS
#-------TOTAL NUMBERS OF BOOKS SOLD OF EACH GENRE
SELECT b.Genre,SUM(o.Quantity) AS Total_sold, c.City,c.Phone
FROM Books b
JOIN
Orders o
ON b.book_id = o.book_id
JOIN Customers c 
ON c.Customer_ID= b.Book_ID
GROUP BY b.Genre,c.City,c.Phone;
#AVG price of book in fantesy
SELECT AVG(price) AS Averege_price 
FROM Books
WHERE Genre = 'Fantasy';
#-------FIND ATLIST 2 ORDERS ARE PLACED
SELECT o.customer_id , c.Name, c.Phone, c. Country,COUNT(o.Order_id) AS Total_Count
FROM Orders o
JOIN
customers c
ON 
o.customer_id = c.customer_id
GROUP BY  o.customer_id , c.Name, c.Phone, c. Country
HAVING COUNT(Order_id)>2;
#---------- MOST FREQUENTY ORDER BOOK 
SELECT o.Book_ID ,b.Title,b.Author,b.Genre,b.Price, COUNT(o.Order_ID) AS Order_count
FROM Orders o
JOIN 
Books b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID ,b.Title,b.Author,b.Genre,b.Price
ORDER BY  Order_count DESC;
#Show the top 3 books of 'Fantasy'
SELECT * FROM Books
WHERE Genre = 'Fantasy' 
ORDER BY Price DESC LIMIT 3;
#----------The total quentity sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Quantity
FROM Books b
JOIN
Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY  Total_Quantity DESC 
LIMIT 5;
# -----------List the cities where customer spent over $300 are located
SELECT DISTINCT (c.City),c.Name, o.Total_Amount
FROM customers c
JOIN 
Orders o
ON c.Customer_ID = o.Customer_ID 
WHERE o.Total_Amount >300
ORDER BY Total_Amount DESC;
#--------------Find the customers who spent most orders
SELECT DISTINCT c.Name,c.Customer_ID , SUM(Total_Amount) AS Total_Spent
FROM customers c
JOIN 
Orders o 
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name,c.Customer_ID 
ORDER BY Total_Spent DESC;
#------------Calculate the stock remaining 
SELECT  b.Book_ID,b.Title,b.Stock,COALESCE(SUM(Quantity),0) AS Order_Quantity,
	b.Stock - COALESCE(SUM(o.Quantity),0) AS Remaining_Stock
FROM Books b
LEFT JOIN orders o ON b.Book_id=o.Book_id
GROUP BY b.Book_id;
