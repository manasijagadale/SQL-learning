# LIMIT Clause : Limit no. of rows returned
# ORDER BY Clause : Sort the result table
/* ascending (low---high) : ASC
	descending (high---low) : desc
*/

# get emp_id, dep_id, salary sorted in desc order of salary

SELECT emp_id, dep_id, salary FROM myemp
ORDER BY SALARY DESC;

-- text : ascending (a-z) : ASC
-- text : descending (z-a) : desc

-- date : ascending (old---new) : ASC
-- date : descending (new---old) : DESC

# Multilevel sorting

-- GET dep_id, emp_id, job_id and salary from the myemp table sort the result by
-- dep_id first in asc order
-- salary second in desc order

SELECT emp_id, dep_id, job_id, salary FROM myemp
ORDER BY dep_id ASC, salary DESC;

-- top 5 employees by salary

SELECT emp_id, salary FROM myemp
ORDER BY salary DESC
LIMIT 5;

-- bottom 5 employees by salary

SELECT emp_id, salary FROM myemp
ORDER BY salary ASC
LIMIT 5;

-- top 10 employees by COMMISSION_PCT

SELECT emp_id, commission_pct FROM myemp
ORDER BY commission_pct DESC
LIMIT 10;

-- bottom 10 employees by COMMISSION_PCT

SELECT emp_id, commission_pct FROM myemp
ORDER BY commission_pct ASC
LIMIT 10;

-- top 5 recently hired employees

SELECT emp_id, hire_date FROM myemp
ORDER BY hire_date DESC
LIMIT 5;

-- top 5 older employees

SELECT emp_id, hire_date FROM myemp
ORDER BY hire_date ASC
LIMIT 5;

-- top 5 salaries

SELECT salary FROM myemp
ORDER BY salary DESC
LIMIT 5;

# Note:
# TopN/BottomN Results 
# use combinattion of ORDER BY + LIMIT Clause

-- 2nd highest salary 

SELECT emp_id, salary FROM myemp
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- 5th highest salary

SELECT emp_id, salary FROM myemp
ORDER BY salary DESC
LIMIT 4,1;

-- 3rd to 6th highest salary

SELECT emp_id, salary FROM myemp
ORDER BY salary DESC
LIMIT 2, 4;

-- 3rd lowest salary

SELECT emp_id, salary FROM myemp
ORDER BY salary ASC
LIMIT 2,1;