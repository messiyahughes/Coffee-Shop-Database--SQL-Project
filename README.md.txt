Coffee Shop Database Case Study
Project Overview
This project demonstrates how a SQL-based database was designed for a fictional coffee shop to help track customer orders, products, and sales data. The goal is to provide insights into customer behavior, top-selling products, and strategic marketing opportunities.

The database consists of three main tables: Customers, Products, and Orders. Using SQL queries, we were able to extract valuable information for business decision-making.

Business Problem
The coffee shop wanted to improve its profitability by:

Identifying the top-selling products.
Understanding which customers are the most valuable.
Developing marketing campaigns targeting high-value customers and promoting popular products.
Solution
Using SQL queries, the database provided answers to key business questions:

1. Top-Selling Products
By analyzing the number of orders for each product, we identified which products were ordered most frequently. This insight allows the coffee shop to ensure adequate stock of popular items and make data-driven decisions on product promotion.

SQL Query:
sql
Copy code
SELECT p.product_name, 
       COUNT(o.order_id) AS times_ordered
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_id
ORDER BY times_ordered DESC;
2. Most Valuable Customers
We calculated which customers spent the most on their orders, allowing the coffee shop to target high-value customers for loyalty programs or special promotions.

SQL Query:
sql
Copy code
SELECT c.customer_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       SUM(o.quantity * p.price) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;
3. Customer Purchase Behavior
We analyzed customer purchase patterns to find which products each customer prefers and how often they place orders. This provides deeper insights into individual customer preferences and allows the shop to personalize promotions.

SQL Query:
sql
Copy code
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * p.price) AS total_spent,
    (SELECT p2.product_name 
     FROM Orders o2
     JOIN Products p2 ON o2.product_id = p2.product_id
     WHERE o2.customer_id = c.customer_id
     GROUP BY p2.product_id
     ORDER BY COUNT(o2.order_id) DESC
     LIMIT 1) AS favorite_product
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    Products p ON o.product_id = p.product_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC;
Business Insights
Top Products: The coffee shop’s most frequently ordered products are key drivers of revenue and should be prioritized for promotions.
High-Value Customers: Targeting top spenders with loyalty rewards will increase customer retention and overall sales.
Personalized Campaigns: Using customer purchase behavior insights, the coffee shop can tailor marketing campaigns to customer preferences, promoting favorite products to frequent buyers.
Database Structure
The database consists of the following tables:

Customers: Stores customer details such as first name, last name, email, and phone number.
Products: Stores product details, including product name and price.
Orders: Stores order details, including which customer placed the order, which product was ordered, and the order date.
An ER diagram is provided below to illustrate the database structure:

(Include ER diagram image here if possible)
Conclusion
The Coffee Shop database provides valuable insights for the business, enabling data-driven decisions on product stocking, marketing campaigns, and customer retention strategies. By leveraging SQL queries, the coffee shop can optimize its operations and boost profitability.