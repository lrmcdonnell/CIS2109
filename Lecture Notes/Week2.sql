SELECT first_name, last_name
FROM OT_CONTACTS
WHERE first_name LIKE 'A%'
ORDER by last_name;

SELECT first_name, substr(first_name, 3,10) AS short_name
FROM OT_CONTACTS;

SELECT customer_id, name, customer_id||'-'||name
FROM ot_customers;

--- Extract area code
SELECT first_name, phone,
SUBSTR(phone,1,3)||'-'||SUBSTR(phone,4,3)||'-'||SUBSTR(phone,8,3)||'-'||SUBSTR(phone,12,4) AS prettier
FROM OT_CONTACTS
WHERE SUBSTR(phone,1,2) = '+1';

--- Extract country code
SELECT phone
FROM OT_CONTACTS;

SELECT phone, RTRIM(SUBSTR(phone,1,Instr(phone,' ')))
from OT_CONTACTS;

---Upper/Lower case
SELECT customer_id, name, upper(name)
FROM OT_CUSTOMERS
WHERE upper(name) LIKE '%G%'
ORDER BY CUSTOMER_ID;


---Order dates
SELECT order_date, to_char(order_date, 'DD-MM-YY'), to_char(order_date, 'Day Month Year')
FROM OT_ORDERS;

SELECT order_date, next_day(order_date, 'Wednesday') AS Next_Shipment_Day
FROM OT_ORDERS;

SELECT order_date, add_months(order_date,1) AS due_date
FROM OT_ORDERS;

---When inserting dates always use to_date
---finds orders that were placed on a certain date
SELECT *
FROM OT_ORDERS
WHERE order_date = to_date('01-11-2016', 'DD-MM-YYYY')


---NULLS:
---NULLS do not exist (empty field), nothing can be equal to null
SELECT *
FROM OT_EMPLOYEES
where email is not null;

SELECT employee_id, employee_id + NULL
FROM OT_EMPLOYEES;


---NVL (for null values, use an alternative value e.g., 'Undefined')
SELECT location_id, state, NVL(state, 'Undefined')
from OT_LOCATIONS;

SELECT * --- * means all columns
FROM OT_LOCATIONS
WHERE state IS NOT NULL;

SELECT location_id, nvl(state, 'Undefined')
FROM OT_LOCATIONS;

--- count how many entries for each attribute
SELECT count(*), count(LOCATION_ID), count(STATE), count(NVL(state, 'NA'))
FROM OT_LOCATIONS;


---- BOOLEAN OPERATORS: NOT, AND, OR
SELECT *
FROM OT_LOCATIONS
WHERE NOT city = 'Tokyo'
OR city = 'London'
OR state is null;

SELECT *
FROM OT_LOCATIONS
WHERE city = 'Roma'
AND state is null;

SELECT *
FROM OT_LOCATIONS
WHERE city = 'Roma'
OR city= 'Venice'
AND state is null; --- 'and' operator takes precedence

---gives all accountants, gives programmers hired before specified date
SELECT *
FROM OT_EMPLOYEES
WHERE job_title = 'Accountant' 
OR job_title = 'Programmer'
AND NOT hire_date > to_date('01-APR-16', 'DD-MON-YY');

---gives all programmers, gives accountants hired before specified date
SELECT *
FROM OT_EMPLOYEES
WHERE job_title = 'Accountant' 
AND NOT hire_date > to_date('01-APR-16', 'DD-MON-YY');
OR job_title = 'Programmer';

---gives accountants & programmers hired before specified date
SELECT * 
FROM OT_EMPLOYEES
WHERE (job_title = 'Accountant' 
OR job_title = 'Programmer')
AND NOT hire_date > to_date('01-APR-16', 'DD-MON-YY');

SELECT * 
FROM OT_EMPLOYEES
WHERE job_title IN ('Accountant', 'Programmer')
AND NOT hire_date > to_date('01-APR-16', 'DD-MON-YY');

SELECT product_id, list_price
FROM OT_PRODUCTS
WHERE list_price between 104.88 and 200; ---inclusive


---DISTINCT
SELECT DISTINCT first_name, last_name
FROM OT_CONTACTS
WHERE first_name LIKE 'C%'
ORDER BY first_name;

SELECT first_name, last_name
FROM OT_CONTACTS
WHERE first_name LIKE 'C%'
ORDER BY first_name asc, last_name asc;

SELECT first_name, count(*)
FROM OT_CONTACTS
WHERE first_name LIKE 'Cha%'
GROUP BY first_name;

---all columns in the selec clause other than the aggregate function need to be included in the GROUP BY

---count employees by: manager_id, job_title, hire month and combinations:

SELECT job_title, manager_id, count(*)
FROM OT_EMPLOYEES
GROUP BY job_title, manager_id
ORDER BY job_title, manager_id;


SELECT job_title, manager_id, count(*)
FROM OT_EMPLOYEES
WHERE manager_id = 3
GROUP BY job_title,manager_id
ORDER BY job_title, manager_id;


SELECT job_title, manager_id, count(*)
FROM OT_EMPLOYEES
GROUP BY job_title, manager_id
HAVING job_title LIKE 'P%'
ORDER BY job_title, manager_id;

---'Having' clause can eliminate records based on count (can't be done in where clause)
SELECT job_title, manager_id, count(*)
FROM OT_EMPLOYEES
GROUP BY job_title, manager_id
HAVING count(*) > 1
ORDER BY job_title, manager_id;

---Order commands are executed: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER

--- in class quiz:
--- 1. How many payments has each customer made and what is the total amount payed by the customer?
SELECT customer_Fname, count(*) AS Payments, sum(payment_amount) AS total
FROM payment
GROUP BY customer_Fname
ORDER BY customer_Fname;

--- 2. 
SELECT Staff, count(*) as Payments
GROUP BY Staff
ORDER BY Staff

--- 3. 
SELECT customer_Fname, Staff, avg(payment_amount) AS Total_avg
FROM payment
GROUP BY customer_Fname, Staff