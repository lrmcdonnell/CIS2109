--
SELECT NVL(country_name, 'NA'), count(location_id)
FROM ot_locations l LEFT OUTER JOIN ot_countries c
        ON l.country_id = c.country_id
GROUP BY NVL(country_name, 'NA');

-- USING --
SELECT *
FROM ot_locations LEFT OUTER JOIN ot_countries USING(country_id);

--
SELECT r.region_id, region_name, country_name, address
FROM ot_locations l RIGHT OUTER JOIN ot_countries c USING(country_id)
    -- countries even without locations
    RIGHT OUTER JOIN ot_regions r USING(region_id);
    -- countries with regions including regions with no countries


--- Subqueries ---
-- used when you would like to produce a list or want an intermediate result --
-- can usually also be written using joins --

-- ex 1 --
-- used to produce a list of countries that start with 'U' --
SELECT *
FROM ot_locations
WHERE country_id IN ('US', 'UK');

SELECT *
FROM ot_locations
WHERE country_id IN (SELECT country_id 
                       FROM ot_locations 
                      WHERE country_id LIKE 'U%');

-- ex 2 --
-- subquery makes a list of customers who have placed orders --
SELECT customerName
FROM customers
WHERE customerID in (SELECT customerID 
                       FROM orders);


-- ex 3 --
-- find courses offered in both fall 2009 and spring 2010 --
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall'
    AND year = 2009
    AND course_id IN (SELECT course_id
                        FROM section
                        WHERE semester = 'Spring' AND year = 2010);

-- be mindful of nulls when using 'NOT IN' --
-- Use NVL to substitute nulls --


-- ex  4 --
-- print order ids in which products have the finish 'natural ash' --
SELECT DISTINCT orderID
FROM orderLineTable
WHERE productID IN (SELECT productID
                      FROM productTable
                      WHERE productFinish = 'Natural Ash');

-- goes through every record and checks the requirements --
SELECT DISTINCT orderID
FROM orderLineTable o
WHERE productID IN (SELECT productID
                      FROM productTable p
                      WHERE p.productID = o.productID
                      AND productFinish = 'Natural Ash');


-- WHERE EXISTS --
-- if subquery returns something, returns True --
SELECT DISTINCT orderID
FROM orderLineTable o
WHERE EXISTS (SELECT *
                FROM productTable p
               WHERE p.productID = o.productID
                 AND productFinish = 'Natural Ash');

-- in class quiz --
-- INNER JOIN query --
SELECT i.item_name, a.artist_name
FROM artists a INNER JOIN items i 
        ON a.artist_id = i.artist_id
WHERE a.artist_name < "Cat";

-- non-correlated subquery --
SELECT item_name
FROM items i 
WHERE artist_id IN (SELECT artist_id
                     FROM artists a 
                     WHERE artist_name < 'Cat');

-- correlated subquery --
SELECT item_name
FROM items i 
WHERE artist_id IN (SELECT artist_id 
                    FROM artists a 
                    WHERE a.artist_id = i.artist_id
                    AND artist_name < 'Cat');

-- correlated subquery with the WHERE EXISTS clause --
SELECT item_name
FROM items i 
WHERE EXISTS (SELECT *
                FROM artists a 
                WHERE a.artist_id = i.artist_id
                AND artist_name < 'Cat');

-- Dual --
SELECT 2 
FROM DUAL;

-- subqueries --
-- prints items with a price greater than average --
SELECT title, unit_price
FROM items i, (SELECT avg(unit_price) AS average_price FROM items) av 
WHERE i.unit_price > average_price

-- prints artists who have items with prices greater than average --
SELECT artist, avg(unit_price)
FROM items
GROUP BY artist
HAVING avg(unit_price) > (SELECT avg(unit_price) FROM items)


-- Set operations --
-- union - union all
-- intersection
-- minus

-- union --
-- implies distinct --
SELECT customer_state AS state FROM customersT
UNION
SELECT salesrep_state AS state FROM salesrepsT

-- union all --
-- includes duplicate values --
SELECT customer_state AS state FROM customersT
UNION ALL
SELECT salesrep_state AS state FROM salesrepsT

-- intersect --
SELECT customer_state AS state FROM customersT
INTERSECT
SELECT salesrep_state AS state FROM salesrepsT

-- minus --
SELECT customer_state AS state FROM customersT
MINUS
SELECT salesrep_state AS state FROM salesrepsT


-- comma between tables: cartesian product (all possible combinations) --
SELECT c.city, s.city
FROM customers c, suppliers s

-- order by the third printed column --
'ORDER BY 3'

SELECT productID, ProductDescription
    CASE WHEN ProductDescription LIKE '%Desk' THEN 'Desk'
        WHEN ProductDescription LIKE '%Table' THEN 'Table'
        ELSE 'Something else'
    END AS short_description
FROM products


-- find employees who have completed the certificate with ID 1 or ID 2 --
SELECT e.employee_id, e.first_name, e.last_name
FROM ot_employees e INNER JOIN ot_certification c ON e.employee_id = c.employee_id
WHERE c.certificate_id = 1 OR c.certificate_id = 2;

-- using union (eliminates redundancy) --
SELECT e.employee_id, e.first_name, e.last_name
FROM ot_employees e INNER JOIN ot_certification c ON e.employee_id = c.employee_id
WHERE c.certificate_id = 1
UNION
SELECT e.employee_id, e.first_name, e.last_name
FROM ot_employees e INNER JOIN ot_certification c ON e.employee_id = c.employee_id
WHERE c.certificate_id = 2;

-- intersect without set operators --
SELECT e.employee_id, e.first_name, e.last_name
FROM ot_employees e INNER JOIN ot_certification c ON e.employee_id = c.employee_id
WHERE c.certificate_id = 1
AND c.employee_id IN (SELECT c.employee_id
                        FROM ot_employees INNER JOIN ot_certification c ON e.employee_id = c.employee_id
                        WHERE  c.certificate_id = 2);

-- minus without set operators (NOT IN) --
SELECT e.employee_id, e.first_name, e.last_name
FROM ot_employees e INNER JOIN ot_certification c ON e.employee_id = c.employee_id
WHERE c.certificate_id = 1
AND c.employee_id NOT IN (SELECT c.employee_id
                        FROM ot_employees INNER JOIN ot_certification c ON e.employee_id = c.employee_id
                        WHERE  c.certificate_id = 2);

-- set operators act on the entire record so be mindful of what you are printing/selecting --