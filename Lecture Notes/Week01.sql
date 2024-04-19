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
