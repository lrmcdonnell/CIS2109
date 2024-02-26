-- SQL review --

-- Group by: all except aggregate function --
SELECT first_name, last_name, sum(amount)
FROM payment_info
GROUP BY first_name, last_name

-- Having --
SELECT first_name, sum(amount)
FROM payment_info
GROUP BY first_name
HAVING sum(amount) > 100 

-- non-correlated subquery --
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id
                        FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
                        WHERE f.title LIKE 'AD%');

-- correlated --
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id
                        FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
                        WHERE f.title LIKE 'AD%'
                        AND a.actor_id = fa.actor_id); -- only difference: can not execute parentheses unless you have a.actor_id --


-- where exists --
SELECT a.first_name, a.last_name
FROM actor a
WHERE EXISTS (SELECT fa.actor_id
                FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
                WHERE f.title LIKE 'AD%'
                AND a.actor_id = fa.actor_id);


-- subqueries in the FROM clause --
SELECT avg(number_of_actors)
FROM (SELECT f.title, count(*) AS number_of_actors
        FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
        GROUP BY f.title) a;

-- same as --
SELECT f.title, count(*) AS number_of_actors
FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
GROUP BY f.title;


-- Find salesman with least number of orders --
SELECT salesman_id, count(*)
FROM ot_orders
WHERE salesman_id IS NOT NULL
GROUP BY salesman_id
ORDER BY count(*) ASC
FETCH FIRST 1 ROWS ONLY;