USE day4;
# Select : selecting column to fetch

SELECT * FROM myemp;
SELECT EMP_ID FROM myemp;
SELECT EMP_ID, SALARY FROM myemp;
SELECT EMP_ID, JOB_ID, EMAIL FROM myemp;

# Alias : Display name for a column

SELECT EMP_ID, DEP_ID, JOB_ID AS Designation, SALARY 
FROM myemp;

# DISTINCT clause : Display distinct result / Remove duplicate results

SELECT DISTINCT DEP_ID FROM myemp;
SELECT DISTINCT JOB_ID FROM myemp;
SELECT DISTINCT DEP_ID, MGR_ID FROM myemp;

# Filtering SELECT Condition
-- get emp_id, job_id, and salary of employees working
-- as "SA_MAN" and "SA_REP" (JOB_ID)

SELECT emp_id, job_id, salary FROM myemp
WHERE job_id IN ("SA_MAN", "SA_REP");

# filter condition using comparision operators (< , <=, >, >=, !=, <>)
-- employees with salary greater than 10k

SELECT emp_id, salary FROM myemp
WHERE salary > 10000;

-- employees with salary less than 5k

SELECT emp_id, salary FROM myemp
WHERE salary < 5000;

-- employees with salary minimum 15k

SELECT emp_id, salary FROM myemp
WHERE salary > 15000;

-- employees with salary maximum 5k

SELECT emp_id, salary FROM myemp
WHERE salary < 5000;

-- employees recieving commission %

SELECT emp_id, commission_pct FROM myemp
WHERE commission_pct > 0;

-- employees not recieving commission %

SELECT emp_id, commission_pct FROM myemp
WHERE commission_pct = 0;

# filter conditions using BETWEEN operator
-- employees with salary between 8k to 13k

SELECT emp_id, salary FROM myemp
WHERE salary BETWEEN 8000 AND 13000;

-- employees hired from 1995 to 2000

SELECT emp_id, hire_date FROM myemp
WHERE YEAR(hire_date) BETWEEN 1995 AND 2000;

#Filtering: Logical operators AND/OR to combine conditions
-- AND: to combine compulsory conditions
-- OR: to combine optional conditions

-- get employees from dep_id 60 or salary greater than 15k

SELECT emp_id, dep_id, salary FROM myemp
WHERE dep_id = 60 OR salary > 15000;

-- get employees from dep_id 80 and commission_pct greater than 0.2

SELECT emp_id, dep_id, commission_pct FROM myemp
WHERE dep_id = 80 AND commission_pct > 0.2;

-- get employees from dep_id 80 and commission_pct greater than 0.35 or salary greater than 7k

SELECT emp_id, dep_id, commission_pct, salary FROM myemp
WHERE dep_id = 80 AND (commission_pct > 0.35 OR salary > 7000);

-- get employees from dep_id 80 or job_id "IT_PROG" with salary > 8k

SELECT emp_id, dep_id, job_id, salary FROM myemp
WHERE dep_id = 80 OR (job_id = "IT_PROG" AND salary > 8000);

# Logical Operator : Not : Reverse condition

-- get all employees apart from "AD_VP"

SELECT emp_id, job_id FROM myemp
WHERE NOT job_id = "AD_VP";

SELECT emp_id, job_id FROM myemp
WHERE job_id <> "AD_VP";

-- get dep employees excluding dep 80 and 50

SELECT emp_id, dep_id FROM myemp
WHERE dep_id NOT IN (80,50);

-- get employees not wrking as "IT_PROG"

SELECT emp_id, joB_id FROM myemp
WHERE NOT job_id = "IT_PROG";

-- Like operator : Wildcard filtering

-- get employee with names starting with 'a'

SELECT emp_id, first_name FROM myemp
WHERE first_name LIKE "a%";

-- get employees with names ending with 'a'

SELECT emp_id, last_name FROM myemp
WHERE last_name LIKE "%a";

-- get employees with names starting with 'a' and endng with'a'

SELECT emp_id, first_name, last_name FROM myemp
WHERE first_name LIKE "a%" AND last_name LIKE "%a";

-- get employees with names starting with 'j' and length 5

SELECT emp_id, first_name FROM myemp
WHERE first_name LIKE "j%" AND LENGTH(first_name) = 5;

-- get employees working in sales dep (job_id starting with 'SA')

SELECT emp_id, job_id FROM myemp
WHERE job_id LIKE "SA%";

SELECT emp_id, job_id FROM myemp
WHERE LOCATE("SA", job_id);

-- get employees with names starting with 'a','c' and 'e'

SELECT emp_id, first_name FROM myemp
WHERE first_name LIKE "a%" OR first_name LIKE "c%" OR first_name LIKE "e%";

-- get employees with first_name starting with 'a' and last name staring with 'b'

SELECT emp_id, first_name, last_name FROM myemp 
WHERE first_name LIKE "a%" AND last_name LIKE "b%";

#Note: When multiple options are defined on the same text column, combine using OR