-- Create Database
CREATE DATABASE OnlineBookstore;

-- Create Tables 
CREATE TABLE Books(
	Book_ID	SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	price NUMERIC(10,2),
	Stock INT
);

CREATE TABLE Customers(
	Customer_ID SERIAL PRIMARY KEY,
	 Name VARCHAR(100),
	 Email VARCHAR(100),
	 Phone VARCHAR(15),
	 City VARCHAR(50),
	 Country VARCHAR(150)
);

CREATE TABLE Orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID	INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1. Retrieve all books in the "Fiction" Genre.
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2. Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_year > 1950;

-- 3. List all customers from the Canada.
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 4. Show orders placed in November 2023.
SELECT * FROM Orders
WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5. Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_stock
FROM Books;

-- 6. Find the details of the most Expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7. Show all Customes who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity > '1';

-- 8. Retrieve all orders where total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_amount > 20;

-- 9. List all genres available in the books tables:
SELECT DISTINCT Genre FROM Books;

-- 10. Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY Stock ASC 
LIMIT 1;

-- 11. Calculate the total revenue genereted from all orders:
SELECT SUM(Total_amount) AS Revenue
FROM Orders;

-- Advance Questions:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1. Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre

-- 2. Find the average price of the books in the "Fantasy" Genre:
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3. List customers who have placed at least 2 orders:
SELECT o.Customer_id, c.name, COUNT(o.Order_id) AS Order_Count
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY o.Customer_id, c.name
HAVING COUNT(Order_id) >= 2;

-- 4. Find the most frequently Ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_id = b.Book_id
GROUP BY o.Book_id, b.title
ORDER BY Order_count DESC LIMIT 1;

-- 5. Show the top 3 most expensive books of 'Fantasy' Genre:
SELECT * FROM Books
WHERE genre ='Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6. Retrieve the total quantity of books slod by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.Book_id = b.Book_id
GROUP BY b.Author;

-- 7. List the cities where Customers who spent over $30 are located:
SELECT DISTINCT c.City, Total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.Customer_id
WHERE o.total_amount > 30;

-- 8. Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.Total_amount) AS Total_Spent
FROM Orders o
JOIN Customers c On o.Customer_id = c.Customer_id
GROUP BY c.Customer_id, c.name
ORDER BY Total_spent DESC LIMIT 1;

-- 9. Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_id, b.Title, b.Stock, COALESCE(SUM(o.Quantity),0) AS Order_Quantity,
	b.Stock- COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o ON b.Book_id = o.Book_id
GROUP BY b.Book_id ORDER BY b.Book_id;



