--- Cartesian Product: Student x SCoursess ---
SELECT *
FROM Student, SCourses
WHERE Student.SID = SCourses.SID

--- find the course ID, semester, year, and title of each course offered by the comp. sci dept: ---
--- if the 2 tables have an attribute name in common (e.g., course_id), 
--- then you must specify from which table ---
SELECT section.course_id, semester, year, title
FROM section, course
WHERE section.course_id = course.course_id
AND dept_name = 'Comp_Science';

--- Join syntax---
--- Alias 'a', 'i' ---
SELECT a.artist_id, a.artist_name, i.item_id, i.item_name
FROM artist a, item i
WHERE a.artist_id = i.artist_id;

--- Inner join ---
SELECT a.artist_id, a.artist_name, i.item_id, i.item_name
FROM artist a INNER JOIN item i ON a.artist_id = i.artist_id;


--- Natural join ---
--- ON clause is omitted, DBMS assumes columns with the same name are the same; merges ---
SELECT *
FROM artist a NATURAL JOIN item i;

SELECT *
FROM artist a INNER JOIN item i ON a.artist_id = i.artist_id;


--- Outer join ---
--- includes excluded records ---
--- Left outer join - main table is artist ---
SELECT a.artist_id, a.artist_name, i.item_id, i.item_name
FROM artist a LEFT OUTER JOIN item i ON a.artist_id = i.artist_id;

--- Right outer join - main table is item ---
SELECT a.artist_id, a.artist_name, i.item_id, i.item_name
FROM artist a RIGHT OUTER JOIN item i ON a.artist_id = i.artist_id;


--- all combinations ---
SELECT country_name, location_id, address
FROM ot_countries, ot_locations ;

--- matches locations ---
SELECT country_name, location_id, address
FROM ot_countries c, ot_locations l
WHERE c.country_id = l.country_id;

SELECT c.country_id, country_name, location_id, address
FROM ot_countries c, ot_locations l
WHERE c.country_id = l.country_id
AND country_name LIKE 'A%';

SELECT c.country_id, country_name, location_id, address
FROM ot_countries c INNER JOIN ot_locations l ON c.country_id = l.country_id
WHERE country_name LIKE 'A%';

--- orders ---
SELECT *
FROM customerTable c INNER JOIN orderTable o
    ON c.customer_ID = o.customer_ID
INNER JOIN orderLineTable ot_locations
    ON o.orderID= ol.orderID;

--- In-class quiz ---
SELECT employee_name, department
FROM employees e LEFT OUTER JOIN EmpDepartments ed
        ON e.employee_id = ed.employee_id
    LEFT OUTER JOIN depts d
        ON d.department_id = ed.department_id;


--- self-joins ---
SELECT e.employee_id, e.employee_name, m.employee_name AS manager
FROM employees e, employees m
WHERE e.employeeManager = m.employeeID;

SELECT e.employee_id, e.employee_name, m.employee_name AS manager
FROM employees e INNER JOIN employees m
        ON e.employeeManager = m.employeeID;
WHERE m.salary > e.salary

-- depts --
SELECT d.department AS dept_name, f.department AS adminDept
FROM departments d INNER JOIN departments f
        ON d.admin_dept = f.department_id
