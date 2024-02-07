-- Question 1 --
-- 1a --
SELECT e.employee_id, e.first_name, e.last_name, j.start_date, j.job_id
FROM hr_job_history j, hr_employees e
WHERE j.employee_id = e.employee_id;

-- 1b --
SELECT e.employee_id, e.first_name, e.last_name, j.start_date AS START_DATE, j.job_id AS JOB_ID
FROM hr_job_history j INNER JOIN hr_employees e ON j.employee_id = e.employee_id;

-- 1c --
SELECT start_date AS START_DATE, job_id AS JOB_ID
FROM hr_job_history j NATURAL JOIN hr_employees e;

-- The results for the first 2 queries are the same. However, the third query with the natural join gives a different result 
-- because of how the database management system joins the data with natural join. --

-- Question 2 --
SELECT e.employee_id, e.first_name, e.last_name, NVL(j.start_date, to_date('01/01/1900', 'MM-DD-YYYY')), NVL(j.job_id, '-99')
FROM hr_job_history j RIGHT OUTER JOIN hr_employees e ON j.employee_id = e.employee_id;

-- Question 3 --
-- 3a --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e INNER JOIN hr_departments d
    ON e.department_id = d.department_id;

-- 3b --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e LEFT OUTER JOIN hr_departments d
    ON e.department_id = d.department_id;

-- 3b2 --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e LEFT OUTER JOIN hr_departments d
    ON e.department_id = d.department_id 
WHERE e.department_id IS NULL;

-- 3c --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e RIGHT OUTER JOIN hr_departments d
    ON e.department_id = d.department_id;

-- 3c2 --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e RIGHT OUTER JOIN hr_departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

-- 3d --
SELECT e.first_name, e.last_name, d.department_name
FROM hr_employees e FULL OUTER JOIN hr_departments d
    ON e.department_id = d.department_id;

-- Question 4 --
-- 4a -- 
SELECT e.employee_id, e.first_name, e.last_name, COUNT(jh.job_id), MAX(jh.start_date)
FROM hr_employees e INNER JOIN hr_job_history jh
ON e.employee_id = jh.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

-- 4b --
SELECT e.employee_id, e.first_name, e.last_name, COUNT(jh.job_id), MAX(jh.start_date)
FROM hr_employees e FULL OUTER JOIN hr_job_history jh
ON e.employee_id = jh.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

-- Question 5 --
-- 5a --
SELECT e.employee_id, e.first_name, e.last_name, jh.start_date, j.job_title
FROM hr_job_history jh INNER JOIN hr_employees e
        ON jh.job_id = e.job_id
    INNER JOIN hr_jobs j
        ON jh.job_id = j.job_id;

-- 5b --
SELECT e.employee_id, e.first_name, e.last_name, jh.job_id, jh.start_date, e.hire_date, j.job_title
FROM hr_job_history jh INNER JOIN hr_employees e
        ON jh.job_id = e.job_id
    INNER JOIN hr_jobs j
        ON jh.job_id = j.job_id
WHERE jh.start_date = e.hire_date;
        
-- 5c --
SELECT e.employee_id, e.first_name, e.last_name, jh.job_id, jh.start_date, j.job_title
FROM hr_employees e LEFT OUTER JOIN hr_job_history jh
        ON jh.employee_id = e.employee_id
    LEFT OUTER JOIN hr_jobs j
        ON jh.job_id = j.job_id;

-- I used left outer joins using 'hr_employees' as the main table. This gets all employees, even including the ones without job title --
-- You could also use a FULL OUTER JOIN then a LEFT OUTER JOIN to get same result. --

-- 5d --
SELECT jh.employee_id, e.first_name, e.last_name, jh.job_id, jh.start_date, j.job_title
FROM hr_employees e RIGHT OUTER JOIN hr_job_history jh
        ON jh.employee_id = e.employee_id
    RIGHT OUTER JOIN hr_jobs j
        ON jh.job_id = j.job_id;
        
-- I used right outer joins using 'hr_jobs' as the main table. This gets all jobs, even including jobs with no employees. --
-- You could also use a FULL OUTER JOIN then a RIGHT OUTER JOIN to get same result. --

-- Question 6 --
-- 6a --
SELECT e.first_name, e.last_name, e.hire_date, m.first_name||' '||m.last_name AS manager, m.hire_date
FROM hr_employees e INNER JOIN hr_employees m
        ON e.manager_id = m.employee_id;

-- 6b --
SELECT e.first_name, e.last_name, e.hire_date, m.first_name AS manager, m.hire_date
FROM hr_employees e LEFT OUTER JOIN hr_employees m
        ON e.manager_id = m.employee_id;
        
-- 6c --
SELECT e.first_name, e.last_name, e.hire_date, m.first_name||' '||m.last_name AS manager, m.hire_date
FROM hr_employees e RIGHT OUTER JOIN hr_employees m
        ON e.manager_id = m.employee_id;

-- 6d --
SELECT e.first_name, e.last_name, e.hire_date, m.first_name AS manager, m.hire_date
FROM hr_employees e INNER JOIN hr_employees m
        ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;