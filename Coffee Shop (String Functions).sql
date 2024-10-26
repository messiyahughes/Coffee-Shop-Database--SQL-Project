CREATE DATABASE CoffeeShop;
USE CoffeeShop;

CREATE TABLE Customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(5, 2)
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    Quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (first_name, last_name, email, phone)
VALUES
	('Bubba', 'Smith', 'bubba.smith@gmail.com', '404-555-0123'),
    ('Daisy', 'Johnson', 'daisy.johnson@gmail.com', '404-555-4567'),
    ('Ellie', 'Mae', 'ellie.mae@gmail.com', '404-555-8901'),
    ('Jethro', 'Davis', 'jethro.davis@gmail.com', '404-555-2345'),
    ('Mary', 'Lou', 'mary.lou@gmail.com', '404-555-6789'),
    ('Roy', 'McGee', 'roy.mcgee@gmail.com', '404-555-3456'),
    ('Bonnie', 'Parker', 'bonnie.parker@gmail.com', '404-555-7890');
    
INSERT INTO Products (product_name, price)
VALUES
	('Sweet Tea', 2.00),
    ('Biscuits', 1.50),
    ('Pecan Coffee', 3.25),
    ('Southern Mocha', 4.00),
    ('Grits Latte', 3.50),
    ('Country Americano', 2.50),
    ('Maple Frappe', 3.75);
    
INSERT INTO Orders (order_id, customer_id, product_id, order_date, quantity)
VALUES
	(1, 1, 1, '2023-01-15', 2),
    (2, 1, 3, '2023-01-15', 1),
    (3, 2, 2, '2023-02-18', 4),
    (4, 2, 6, '2023-02-18', 2),
    (5, 3, 4, '2023-03-22', 1),
    (6, 4, 5, '2023-04-10', 3),
    (7, 5, 7, '2023-05-05', 2),
    (8, 6, 1, '2023-06-14', 1),
    (9, 7, 3, '2023-07-20', 5),
    (10, 6, 2, '2023-08-30', 1);

SHOW TABLES;

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM Customers;

SELECT REPLACE(product_name, ' ', '_') AS ModifiedProductName FROM Products;

SELECT o.order_id, 
       c.first_name, 
       c.last_name, 
       p.product_name, 
       o.quantity, 
       (o.quantity * p.price) AS total_cost
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;

SELECT c.customer_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       SUM(o.quantity * p.price) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id;

SELECT p.product_name, 
       COUNT(o.order_id) AS times_ordered
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_id
ORDER BY times_ordered DESC;

SELECT c.customer_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       p.product_name, 
       COUNT(o.product_id) AS times_ordered
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id, p.product_id
ORDER BY c.customer_id, times_ordered DESC;

SELECT o.order_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       p.product_name, 
       o.quantity, 
       o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE YEAR(o.order_date) = 2023
ORDER BY o.order_date;