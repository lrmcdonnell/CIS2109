-- Laura McDonnell --
-- CIS 2109 Lab 4 --
-- February 9, 2024 --


-- Question 1 --
-- Find the names of employees that are listed as managers of departments --
Update HR_Departments SET manager_id = 205 where department_id = 120; commit;

-- 1a --
-- Using joins --
SELECT m.first_name, m.last_name
FROM hr_departments d INNER JOIN hr_employees m
    ON d.manager_id = m.employee_id;
    
-- 1a/e --
SELECT m.first_name, m.last_name
FROM hr_departments d RIGHT OUTER JOIN hr_employees m
    ON d.manager_id = m.employee_id
WHERE d.manager_id IS NULL;

-- 1b --
-- Using non-correlated subqueries --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE m.employee_id IN (SELECT NVL(manager_id, -99)
                        FROM hr_departments);
                        
-- 1b/e --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE m.employee_id NOT IN (SELECT NVL(manager_id, -99)
                            FROM hr_departments);
-- 1c --
-- Using correlated subqueries with the IN statement --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE m.employee_id IN (SELECT NVL(manager_id, -99)
                        FROM hr_departments d
                        WHERE m.employee_id = d.manager_id);

-- 1c/e --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE m.employee_id NOT IN (SELECT NVL(manager_id, -99)
                        FROM hr_departments d
                        WHERE m.employee_id = d.manager_id);

-- 1d --
-- Using WHERE EXISTS --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE EXISTS (SELECT *
                FROM hr_departments d
                WHERE m.employee_id = d.manager_id);
    
-- 1d/e --
SELECT m.first_name, m.last_name
FROM hr_employees m
WHERE NOT EXISTS (SELECT *
                FROM hr_departments d
                WHERE m.employee_id = d.manager_id);



-- Question 2 --
-- Execute the following commands --
INSERT INTO hr_job_History values

(200, to_date('01-JUL-07', 'DD-MON-YY'), to_date('01-JAN-08', 'DD-MON-YY'), 'AC_MGR', 110);

INSERT INTO hr_job_History values

(117, to_date('01-JUL-08', 'DD-MON-YY'), to_date('01-JAN-09', 'DD-MON-YY'), 'AC_MGR', 110);

INSERT INTO hr_job_History values

(119, to_date('01-JUL-08', 'DD-MON-YY'), to_date('01-JAN-09', 'DD-MON-YY'), 'AC_ACCOUNT', 110);

commit;

-- Look at the employees who have had a position in the company other than the one they currently hold. 
-- Hint: you can find this information on the job_history table that holds all previous positions of employees.


-- 2a --
-- The names of employees who have previously been 'AC_ACCOUNT' or 'AC_MGR'. Do you see distinct results, or duplicates? 
-- How can you see distinct results?
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT'
UNION
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_MGR';

-- results are distinct --


-- 2a/e --
SELECT DISTINCT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id IN ('AC_ACCOUNT', 'AC_MGR');


-- 2b --
-- The names of employees who have previously been 'AC_ACCOUNT' and 'AC_MGR' --
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT'
INTERSECT
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_MGR';


-- 2b/e --
SELECT e.first_name, e.last_name, jh.job_id
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT'
AND jh.employee_id IN (SELECT jh.employee_id
                    FROM hr_employees e INNER JOIN hr_job_history jh
                    ON e.employee_id = jh.employee_id
                    WHERE jh.job_id = 'AC_MGR');


-- 2c --
-- The names of employees who have previously been 'AC_ACCOUNT' but not 'AC_MGR' --
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT'
MINUS
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_MGR';


-- 2c/e --
SELECT e.first_name, e.last_name, jh.job_id
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT'
AND jh.employee_id NOT IN (SELECT jh.employee_id
                             FROM hr_employees e INNER JOIN hr_job_history jh
                               ON e.employee_id = jh.employee_id
                            WHERE jh.job_id = 'AC_MGR');


-- 2d --
-- The names of employees who have previously been 'AC_MGR' but not 'AC_ACCOUNT' --
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_MGR'
MINUS
SELECT e.first_name, e.last_name
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_ACCOUNT';
     
                    
-- 2d/e --
SELECT e.first_name, e.last_name, jh.job_id
FROM hr_employees e INNER JOIN hr_job_history jh
    ON e.employee_id = jh.employee_id
WHERE jh.job_id = 'AC_MGR'
AND jh.employee_id NOT IN (SELECT jh.employee_id
                             FROM hr_employees e INNER JOIN hr_job_history jh
                               ON e.employee_id = jh.employee_id
                            WHERE jh.job_id = 'AC_ACCOUNT');



-- Question 3 --

-- 3a --
-- Find the employees whose salary is higher than the average employee salary (ignore the commission) --
SELECT first_name, last_name, salary
FROM hr_employees
GROUP BY first_name, last_name, salary
HAVING avg(salary) > (SELECT avg(salary) FROM hr_employees);

-- 3b --
-- Find the employee departments whose employee’s salary is higher than the average employee salary --
SELECT d.department_name, round(avg(salary), 0) AS avg_salary
FROM hr_employees e INNER JOIN hr_departments d
    ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING avg(salary) > (SELECT avg(salary) FROM hr_employees);

-- Question 4 --

-- 4a --
-- In the previous question you calculated the average salary of employees per department. 
-- Now each department is assigned to a location, so you are asked to calculate the average 
-- salary of employees per City (the city that corresponds to their department). 
-- Round the average to the dollar and order your results by average salary descending. 

SELECT l.city, round(avg(salary), 0) AS avg_salary
FROM hr_employees e INNER JOIN hr_departments d
        ON d.department_id = e.department_id
    INNER JOIN hr_locations l
        ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY avg(salary) DESC;

-- 4b --
-- Can you modify the above query so that only the first record is returned?? --
SELECT l.city, round(avg(salary), 0) AS avg_salary
FROM hr_employees e INNER JOIN hr_departments d
        ON d.department_id = e.department_id
    INNER JOIN hr_locations l
        ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY avg(salary) DESC
FETCH FIRST 1 ROWS ONLY;

-- 4c --
-- Now repeat the query of A. but this time print: 'Best Place to work', for the cities 
-- that have average salary higher than $9000. Print 'Good Place to work' for cities with more than $7500, 
-- 'Fair Place to work' for 5000 or more and ‘Avoid at all cost’ for all else.
SELECT l.city, round(avg(salary), 0) AS avg_salary,
CASE
    WHEN avg(salary) > 9000 THEN 'Best place to work'
    WHEN avg(salary) > 7500 THEN 'Good place to work'
    WHEN avg(salary) > 5000 THEN 'Fair place to work'
    ELSE 'avoid at all costs'
END AS description
FROM hr_employees e INNER JOIN hr_departments d
        ON d.department_id = e.department_id
    INNER JOIN hr_locations l
        ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY avg(salary) DESC;

-- 4d --
-- How about cities with no assigned departments? Repeat the last question but this time include the cities 
-- that have no assigned departments, with null average salary and print ‘No Information Available’.
SELECT l.city, round(avg(salary), 0) AS avg_salary,
CASE
    WHEN avg(salary) > 9000 THEN 'Best place to work'
    WHEN avg(salary) > 7500 THEN 'Good place to work'
    WHEN avg(salary) > 5000 THEN 'Fair place to work'
    WHEN avg(salary) IS NULL THEN 'No Information Available.'
    ELSE 'avoid at all costs'
END AS description
FROM hr_employees e INNER JOIN hr_departments d
        ON d.department_id = e.department_id
    RIGHT OUTER JOIN hr_locations l
        ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY avg(salary) DESC;

-- 4e --
-- How about employees who are not assigned to a department? Repeat the last question but this time include the 
-- employees that have no assigned departments, with city listed as ‘Missing Information’.
SELECT NVL(l.city,'Missing Information'), round(avg(salary), 0) AS avg_salary,
CASE
    WHEN avg(salary) > 9000 THEN 'Best place to work'
    WHEN avg(salary) > 7500 THEN 'Good place to work'
    WHEN avg(salary) > 5000 THEN 'Fair place to work'
    WHEN avg(salary) IS NULL THEN 'No Information Available.'
    ELSE 'avoid at all costs'
END AS description
FROM hr_employees e LEFT OUTER JOIN hr_departments d
        ON d.department_id = e.department_id
    LEFT OUTER JOIN hr_locations l
        ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY avg(salary) DESC;


-- Question 5 --
-- Execute the following commands:

drop table HR_INCENTIVES;

create table HR_INCENTIVES

(

  EMPloyee_ID            INTEGER,

  INCENTIVE_DATE   DATE,

  INCENTIVE_AMOUNT NUMBER(18,2)

);

insert into HR_INCENTIVES (EMPloyee_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT)

values (101, to_date('01-02-2019', 'dd-mm-yyyy'), 5000.00);

 

insert into HR_INCENTIVES (EMPloyee_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT)

values (200, to_date('06-02-2019', 'dd-mm-yyyy'), 3000.00);

 

insert into HR_INCENTIVES (EMPloyee_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT)

values (162, to_date('07-02-2019', 'dd-mm-yyyy'), 4000.00);

 

insert into HR_INCENTIVES (EMPloyee_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT)

values (155, to_date('01-01-2019', 'dd-mm-yyyy'), 4500.00);

 

insert into HR_INCENTIVES (EMPloyee_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT)

values (178, to_date('04-01-2019', 'dd-mm-yyyy'), 3500.00);

commit;

-- 5a --
-- Now write SQL queries to print the employee first and last name, department name and incentive amount. 
-- Substitute empty information with a text of your choice:
SELECT e.first_name, e.last_name, NVL(d.department_name, '(NO DEPT)') AS dept, NVL(i.incentive_amount, 0) AS incentive
FROM hr_employees e Full OUTER JOIN hr_departments d USING (department_id)
INNER JOIN hr_incentives i USING (employee_id);


-- 5b --
-- Employees with departments, but not necessarily incentives. --
SELECT e.first_name, e.last_name, d.department_name, NVL(i.incentive_amount, 0) AS incentive
FROM hr_employees e INNER JOIN hr_departments d USING (department_id)
LEFT OUTER JOIN hr_incentives i USING (employee_id);

-- 5c --
-- Employees with incentives, but not necessarily departments --
SELECT e.first_name, e.last_name, NVL(d.department_name, '(NO DEPT)') AS dept, NVL(i.incentive_amount, 0) AS incentive
FROM hr_employees e FULL OUTER JOIN hr_departments d USING (department_id)
RIGHT OUTER JOIN hr_incentives i USING (employee_id);

-- 5d --
-- Employees with or without incentives, and not necessarily departments --
SELECT e.first_name, e.last_name, NVL(d.department_name, '(NO DEPT)') AS dept, NVL(i.incentive_amount, 0) AS incentive
FROM hr_employees e LEFT OUTER JOIN hr_departments d USING (department_id)
FULL OUTER JOIN hr_incentives i USING (employee_id);