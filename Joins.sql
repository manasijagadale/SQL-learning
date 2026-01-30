# JOIN : to pull data from more than one tables
-- Criteria : common column 
USE classicmodels;
-- 1. get customer number, customer name, country, order_id, status
-- customers -- (customerNumber) -- orders

SELECT c.customerNumber, c.customerName, c.country, o.orderNumber, o.status FROM customers c
JOIN orders o USING (customerNumber);

-- 2. get customerNumber, customername, phone, paymentDate, check number
-- customers --(customernumber) -- payments

SELECT c.customerNumber, c.customerName, c.phone, p.paymentDate, p.checkNumber FROM customers c
JOIN payments p USING (customerNumber);

-- 3. get empnumber , emp name, email, and location of working(country)
-- employees --(officeCode) -- offices

SELECT e.employeeNumber, CONCAT(e.firstName ," ", e.lastName) AS empName, e.email, o.country FROM employees e
JOIN offices o USING (officeCode);

-- customername, Phone, paymentDate, amount
-- customers -- (customerNumber)  -- payments

SELECT c.customerName, c.phone, p.paymentDate, p.amount FROM customers c
JOIN payments p USING (customerNumber);

-- employeenumber, empname, customerNumber, customerName, phone 
-- employees (employeeNumber)  -- customers (salesRepEmployeeNumber)

SELECT e.employeeNumber, CONCAT(e.firstName, " ", e.lastName) AS empName , c.customerNumber, c.customerName, c.phone FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

-- Get order ids and products ordered - product id, product name

SELECT o.orderNumber, p.productCode, p.productname FROM orders o
JOIN orderdetails od USING (orderNumber) JOIN products p USING (productCode);

-- order date, order number, product code, product name
-- orders - orderDetails - products

SELECT o.orderDate, o.orderNumber, p.productCode, p.productName FROM orders o
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode);

-- no. of employees per country

SELECT COUNT(e.employeeNumber) AS totalEmp , o.country FROM employees e
JOIN offices o USING (officeCode) 
GROUP BY o.country;

-- no. of payments per customer

SELECT c.customerNumber, COUNT(p.checkNumber) AS totalPayment FROM customers c
JOIN payments p USING (customerNumber)
GROUP BY c.customerNumber
ORDER BY totalPayment DESC;

-- no. of customers and employees per country

SELECT COUNT(c.customerNumber) AS totalCustomer , COUNT(DISTINCT e.employeeNumber) AS totalEmp , c.country FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.country
ORDER BY totalCustomer, totalEmp;

-- get customers, and total purchase

SELECT c.customerNumber, c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalPurchase FROM customers c
JOIN orders o USING (customerNumber) 
JOIN orderdetails od USING (orderNumber)
GROUP BY c.customerNumber, c.customername
ORDER BY totalPurchase DESC;

-- get productCode, productName, and their total quantity sold, find top 5 products

SELECT p.productCode, p.productName, SUM(od.quantityOrdered) AS totalQuantity FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productCode, p.productName
ORDER BY totalQuantity DESC
LIMIT 5;

-- Types of Joins
-- 1) INNER JOIN : matching rows from both tables
-- 2) LEFT JOIN : all rows from left table, matching rows from right table
-- 3) RIGHT JOIN : all rows from right table, matching rows from left table
-- 4) FULL JOIN : get all rows from both tables
-- 5) SELF JOIN : a table joined to itself
-- 6) CROSS JOIN : match all rows of left table to all rows of right table (no join condition)

-- Example INNER JOIN:
-- get customers who have places orders, display no. of order placed

SELECT c.customerNumber, COUNT(o.orderNumber) AS totalorder FROM customers c
INNER JOIN orders o USING(customerNumber)
GROUP BY c.customerNumber
ORDER BY totalOrder DESC;

-- Example LEFT JOIN :
-- get customers with no. of orders placed, if any

SELECT c.customerNumber, COUNT(o.orderNumber) AS totalOrder FROM customers c
LEFT JOIN orders o USING (customerNumber) 
GROUP BY c.customerNumber
ORDER BY totalOrder DESC;

-- get customers with no orders placed

SELECT c.customerNumber, COUNT(o.orderNumber) AS totalOrder FROM customers c
LEFT JOIN orders o USING (customerNumber) 
GROUP BY c.customerNumber
HAVING totalOrder = 0;

-- Example RIGHT JOIN :
-- get customers with no. of order placed, if any

SELECT c.customerNumber, COUNT(orderNumber) AS totalOrder FROM customers c 
RIGHT JOIN orders o USING ( customerNumber)
GROUP BY c.customerNumber 
ORDER BY totalOrder DESC;

-- get customers with no order placed

SELECT c.customerNumber, COUNT(o.orderNumber) AS totalOrder FROM orders o
RIGHT JOIN customers c USING(customerNumber) 
GROUP BY c.customerNumber 
HAVING totalOrder = 0;

# Example CROSS JOIN :

USE day8;


SELECT * 
FROM accessories, electronics_items;

SELECT *, a.price + e.price AS combined_price
FROM accessories AS a, electronics_items AS e;


-- Example SELF JOIN :
-- get employees(ids, name) and respective managers(ids, name)

SELECT e1.emp_id, CONCAT(e1.first_name, " ",e1.last_name) AS emp_name, e1.mgr_id, CONCAT(e2.first_name , " ", e2.last_name) AS mgr_name FROM myemp e1
JOIN myemp e2 ON e1.mgr_id = e2.emp_id;

-- all employees with manager or no manager

SELECT e1.emp_id , CONCAT(e1.first_name , " " , e1.last_name) AS emp_name, e1.mgr_id, CONCAT(e2.first_name, " ", e2.last_name) AS mgr_name FROM myemp e1
LEFT JOIN myemp e2 ON e1.mgr_id = e2.emp_id;

-- get employees with salary greater than manager

SELECT e1.emp_id, CONCAT(e1.first_name, " ", e1.last_name) AS emp_name, e1.salary , e1.mgr_id, e2.salary, CONCAT(e2.first_name, " " , e2.last_name) AS mgr_name FROM myemp e1
JOIN myemp e2 ON e1.mgr_id = e2.emp_id
WHERE e1.salary > e2.salary;


-- 1) customers with payments

SELECT DISTINCT customerNumber , COUNT(checkNumber) AS payment_count FROM customers 
JOIN payments USING(customerNumber)
GROUP BY customerNumber;

-- 2) all customers, with or without payments

SELECT DISTINCT customerNumber , COUNT(checkNumber) AS payment_count FROM customers 
LEFT JOIN payments USING(customerNumber)
GROUP BY customerNumber;

-- 3) customers with no payments

SELECT customerNumber, COUNT(checkNumber) AS paymentCount FROM customers
LEFT JOIN payments USING(customerNumber) 
GROUP BY customerNumber
HAVING paymentCount = 0;

SELECT DISTINCT customerNumber, COUNT(checkNumber) AS payment_count FROM customers
LEFT JOIN payments USING(customerNumber)
WHERE checkNumber IS NULL
GROUP BY customerNumber;

 -- Display Top 5 and Bottom 5 employees by salary

(SELECT emp_id, CONCAT(first_name," ",last_name) AS emp_name, salary FROM myemp
ORDER BY salary DESC
LIMIT 5)
UNION ALL
(SELECT emp_id, CONCAT(first_name, " ", last_name) AS emp_name , salary FROM myemp
ORDER BY salary ASC
LIMIT 5);

-- 5th and 8th highest salary

(SELECT emp_id, salary FROM myemp
ORDER BY salary DESC
LIMIT 4,1)
UNION 
(SELECT emp_id, salary FROM myemp
ORDER BY salary ASC 
LIMIT 7, 1);

