# Column Functions: 
-- Aggregate Functions :  Summary of column data
-- SUM() : add all no. from the column
-- AVG() : average of all no. in the column
-- MIN() : smallest no.
-- MAX() : largest no.
-- COUNT() : count non-nulll values in the column

-- Note : all aggregate functions ignore NULL values

USE day4;
# Examples: 
-- SALARY
SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY)
FROM myemp;

-- DEP_ID
SELECT COUNT(DEP_ID), COUNT(DISTINCT(DEP_ID)), COUNT(JOB_ID), COUNT(DISTINCT(JOB_ID))
FROM myemp;

-- EMAIL
SELECT 
	COUNT(*) AS COUNT_ROWS,
	COUNT(EMAIL) AS COUNT_EMAILS,
    COUNT(*) - COUNT(EMAIL) AS COUNT_MISSING_EMAILS
FROM myemp;

# Aggregations:

-- total employees
SELECT COUNT(*) FROM myemp;

-- count of job_id

SELECT COUNT(job_id) FROM myemp;

-- difference between min and max salary
SELECT MIN(salary), MAX(salary) , MAX(salary) - MIN(salary) FROM myemp;

-- 2. total employees working in dep 50

SELECT COUNT(*), dep_id FROM myemp
WHERE dep_id = 50;

-- 3. total salary distributed to job_id IT_PROG
SELECT SUM(salary), job_id FROM myemp
WHERE job_id = "IT_PROG";

-- 4. min and max salary of clerk
SELECT MIN(salary), MAX(salary), job_id FROM myemp
WHERE LOCATE("clerk", job_id)
GROUP BY job_id;

-- 5. employees hired after year 2000
SELECT emp_id , hire_date FROM myemp
WHERE YEAR(hire_date) > 2000
ORDER BY hire_date ;

# GROUP BY CLAUSE : summary tables

-- total employees per department

SELECT COUNT(emp_id), dep_id FROM myemp
GROUP BY dep_id
ORDER BY COUNT(emp_id) DESC;

-- total employees working under each manager
SELECT COUNT(emp_id), mgr_id FROM myemp
GROUP BY mgr_id;

-- total employees hired by month
SELECT COUNT(emp_id), MONTH(hire_date) FROM myemp
GROUP BY MONTH(hire_date)
ORDER BY COUNT(emp_id) DESC;

-- total empoyees and average salary for each job_id
SELECT COUNT(emp_id), ROUND(AVG(salary),2), job_id FROM myemp
GROUP BY job_id;

-- 5. employees and manager count for each dept
SELECT COUNT(emp_id), COUNT(mgr_id), dep_id FROM myemp
GROUP BY dep_id;

-- Top 3 dept with highest emp_to_mgr_ratio

SELECT dep_id, ROUND(COUNT(emp_id)/ COUNT(DISTINCT mgr_id), 0) AS emp_to_mgr_ratio
FROM myemp
GROUP BY dep_id
ORDER BY emp_to_mgr_ratio DESC
LIMIT 3;

-- total salary distributed by dept and manager 

SELECT dep_id, mgr_id, SUM(salary) FROM myemp
GROUP BY dep_id, mgr_id;

-- total employees hired by year and month

SELECT COUNT(emp_id), YEAR(hire_date), MONTH(hire_date) FROM myemp
GROUP BY YEAR(hire_date), MONTH(hire_date)
ORDER BY YEAR(hire_date), MONTH(hire_date);

# HAVING Clause: Filter on Aggregated columns

-- 1. department wise total employees, with emp count more than 10

SELECT dep_id, COUNT(emp_id) AS total_emp FROM myemp
GROUP BY dep_id
HAVING total_emp > 10;

-- 2. get departments with total salary greater than 1L

SELECT dep_id , SUM(salary) AS salary FROM myemp
GROUP BY dep_id
HAVING salary > 100000;

-- get departments with total salary between 50000 and 1L

SELECT dep_id, SUM(salary) AS salary FROM myemp
GROUP BY dep_id
HAVING salary BETWEEN 50000 AND 100000;

-- 3. job_ids with avg salary > 5K and emp_count > 5

SELECT job_id, AVG(salary) AS salary , COUNT(emp_id) AS emp_count FROM myemp
GROUP BY job_id
HAVING salary > 5000 AND emp_count > 5;

-- 4. find job_ids with employee count equals to 1

SELECT job_id , COUNT(emp_id) AS emp_count FROM myemp
GROUP BY job_id
HAVING emp_count = 1;

-- 6.(A) get employees hired by department after 2000

SELECT dep_id, COUNT(emp_id) AS emp_count FROM myemp
WHERE YEAR(hire_date) > 2000
GROUP BY dep_id;

-- 6.(B) get department that has not hired any employees after 2000

SELECT dep_id, COUNT(emp_id) AS emp_count FROM myemp
WHERE YEAR(hire_date) < 2000
GROUP BY dep_id;

-- 7. get avg salary and avg commission_pct of employees per job_id recieving commission

SELECT job_id, ROUND(AVG(salary),2) AS avg_salary , ROUND(AVG(commission_pct),2) AS avg_commission FROM myemp
GROUP BY job_id
HAVING avg_commission <> 0;

-- 8. find job_ids with max salary > 5k, for employees hired after 2000

SELECT job_id, MAX(salary) AS max_salary FROM myemp
WHERE YEAR(hire_date) > 2000
GROUP BY job_id
HAVING max_salary > 5000;

-- 9. get departments with total salary greater than 5k, excluding dep 50

SELECT dep_id, SUM(salary) AS total_sal FROM myemp
WHERE dep_id <> 50
GROUP BY dep_id
HAVING total_sal > 5000;

USE classicmodels;
-- 1. WRITE A QUERY TO FIND TOTAL NO.OF CUSTOMERS FROM NORWAY AND SWEDEN 

SELECT country, COUNT(customerNumber) AS total_customers FROM customers 
WHERE country IN ("Norway", "Sweden")
GROUP BY country;

-- 2. WRITE A QUERY TO FIND TOTAL NO.OF CUSTOMERS WITH CREDIT LIMIT > 1000 FROM NORWAY AND SWEDEN

SELECT country, SUM(creditLimit) AS total_creditLimit, COUNT(customerNumber) AS toal_customer FROM customers 
WHERE country IN ("Norway","Sweden") AND creditLimit > 1000
GROUP BY country;

-- 3. DISPLAY COUNTRIES WITH CUSTOMER COUNT GREATER THAN 10

SELECT country , COUNT(customerNumber) AS customer_count FROM customers 
GROUP BY country
HAVING customer_count > 10;

-- 4. FIND TOTAL CREDIT LIMIT AND HIGHEST CREDIT LIMIT FOR EACH SALES REPRESENTATIVE , AND 
-- SORT THE RESULT IN DESCENDING ORDER OF THE HIGHEST CREDIT LIMIT.

SELECT salesRepEmployeeNumber, SUM(creditLimit) AS total_creditLimit, MAX(creditLimit) AS highest_creditLimit FROM customers 
GROUP BY salesRepEmployeeNumber
ORDER BY highest_creditLimit DESC;

-- 5. WRITE A QUERY TO FIND TOP 3 
-- COUNTRIES WITH HIGHEST NO.OF CUSTOMRES

SELECT country, COUNT(customerNumber) AS total_customer FROM customers 
GROUP BY country
ORDER BY total_customer DESC
LIMIT 3;

