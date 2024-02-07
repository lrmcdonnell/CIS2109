-- Laura McDonnell --
-- CIS 2109 Lab 2 --
-- January 26, 2024 --


-- QUESTION 1 --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0)
FROM hr_employees
ORDER BY last_name;


-- QUESTION 2 --
-- 2a --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), employee_id
FROM hr_employees
WHERE employee_id > 150
ORDER BY last_name;

-- 2b --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), employee_id
FROM hr_employees
WHERE first_name LIKE 'D%'
ORDER BY last_name;

-- 2c --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), employee_id
FROM hr_employees
WHERE UPPER(first_name) LIKE '%D%'
ORDER BY last_name;

-- 2d --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), employee_id
FROM hr_employees
WHERE last_name > 'Matos'
ORDER BY last_name;

-- 2e --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), employee_id
FROM hr_employees
WHERE hire_date > to_date('01-MAR-06', 'DD-MON-YY')
ORDER BY last_name;

-- 2f --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), salary
FROM hr_employees
WHERE salary BETWEEN 10000 AND 12000
ORDER BY last_name;

-- 2g --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), job_id
FROM hr_employees
WHERE job_id IN ('FI_ACCOUNT', 'SA_MAN')
ORDER BY last_name;

-- 2h --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), phone_number
FROM hr_employees
WHERE SUBSTR(phone_number, 1,3) = '515'
ORDER BY last_name;

-- 2i --
SELECT first_name, last_name, hire_date, NVL(commission_pct, 0), department_id
FROM hr_employees
WHERE department_id IS NULL
ORDER BY last_name;


-- QUESTION 3 --
SELECT avg(salary)
FROM hr_employees;


-- QUESTION 4 --
SELECT salary, ROUND(0.038398*salary,2) AS Rounded_City_Tax
FROM hr_employees
ORDER BY Rounded_City_Tax DESC;


-- QUESTION 5 --
SELECT count(department_id), count(department_id) - count(manager_id) AS depts_without_manager
FROM hr_departments;


-- QUESTION 6 --
SELECT employee_id ||' - '|| job_id ||' - FROM: '|| to_char(start_date, 'YYYY') ||' - TO: '|| to_char(end_date, 'YYYY')
FROM hr_job_history;


-- QUESTION 7 --
SELECT employee_id, first_name, last_name, commission_pct, manager_id
FROM hr_employees
WHERE (commission_pct IS NULL 
AND manager_id IS NULL);


-- QUESTION 8 --
SELECT employee_id, first_name, last_name, commission_pct, manager_id
FROM hr_employees
WHERE (commission_pct IS NULL 
OR manager_id IS NULL);


-- QUESTION 9 --
-- 9a --
SELECT employee_id, first_name, last_name, job_id, salary
FROM hr_employees
WHERE job_id = 'IT_PROG' AND salary >= 8000 OR job_id = 'FI_ACCOUNT';

-- 9b --
SELECT employee_id, first_name, last_name, job_id, salary
FROM hr_employees
WHERE job_id IN ('IT_PROG', 'FI_ACCOUNT') AND salary >= 8000; 


-- QUESTION 10 --
-- 10a --
SELECT manager_id, job_id, salary
FROM hr_employees
ORDER BY manager_id asc, salary asc;

-- 10b --
SELECT manager_id, job_id, salary
FROM hr_employees
ORDER BY manager_id asc, salary desc;

-- 10c --
SELECT manager_id, job_id, salary
FROM hr_employees
ORDER BY manager_id desc, salary asc;


-- QUESTION 11 --
SELECT count(location_id)
FROM hr_locations;

SELECT country_id, count(location_id)
FROM hr_locations
GROUP BY country_id;


-- QUESTION 12 --
SELECT country_id, count(location_id)
FROM hr_locations
GROUP BY country_id
HAVING count(*) > 2;


-- QUESTION 13 --
SELECT count(employee_id)
FROM hr_employees
GROUP BY department_id
ORDER BY count(employee_id) DESC;


-- QUESTION 14 --
-- 14a --
SELECT to_char(hire_date, 'YYYY'), count(employee_id)
FROM hr_employees
GROUP BY to_char(hire_date, 'YYYY');

-- 14b --
SELECT to_char(hire_date, 'YYYY'), count(employee_id)
FROM hr_employees
WHERE to_char(hire_date, 'MON') LIKE 'MAR'
GROUP BY to_char(hire_date, 'YYYY');

-- 14c --
SELECT to_char(hire_date, 'YYYY'), count(employee_id)
FROM hr_employees
WHERE hire_date > to_date('12-31-2005', 'MM-DD-YYYY')
GROUP BY to_char(hire_date, 'YYYY');

-- 14d --
SELECT to_char(hire_date, 'YYYY'), count(employee_id)
FROM hr_employees
GROUP BY to_char(hire_date, 'YYYY')
HAVING count(*) > 2;

-- 14e --
SELECT to_char(hire_date, 'YYYY'), department_id, count(employee_id)
FROM hr_employees
GROUP BY to_char(hire_date, 'YYYY'), department_id
ORDER BY to_char(hire_date, 'YYYY') ASC, department_id ASC;
