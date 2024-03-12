-- Laura McDonnell --
-- CIS 2109 Lab 5 --
-- February 16, 2024 --


-- Question 1 --
-- Create a new table named Employee_Statistics with the following columns:
-- Employee_id, Employee_Name, Current_Department_id, Number_of_Previous_Positions, Number_of_Previous_Departments
-- Complete the table definition by choosing the appropriate data types, primary and foreign keys. 

CREATE TABLE Employee_Statistics
    (Employee_id NUMBER(11,0) NOT NULL,
    Employee_Name VARCHAR2(25) NOT NULL,
    Current_Department_id VARCHAR2(25),
    Number_of_Previous_Positions NUMBER(11,0),
    Number_of_Previous_Departments NUMBER(11,0),
CONSTRAINT Employee_PK PRIMARY KEY (Employee_id),
CONSTRAINT Employee_FK FOREIGN KEY (Employee_id) REFERENCES hr_employees(employee_id));
COMMIT;


-- Question 2 --
-- Now write a query that selects for every Employee the corresponding employee category information:
-- - the employee name is the concatenation of first and last 
-- - the current department is the one listed within employee table 
-- - number of previous positions is a count of distinct job ids for the employee in job_history 
-- - number of previous departments is a count of distinct departments ids for the employee. 
-- Notice that in order to get an accurate count for each employee you need to combine information from employees and job history tables. 

SELECT e.first_name ||' '|| e.last_name AS name, e.department_id AS current_dept, count(DISTINCT jh.job_id) AS numJobs, count(DISTINCT jh.department_id) AS numDepts
FROM hr_employees e LEFT OUTER JOIN hr_job_history jh 
        ON e.employee_id = jh.employee_id
GROUP BY e.first_name ||' '|| e.last_name, e.department_id
ORDER BY count(DISTINCT jh.job_id) DESC;


-- Question 3 --
-- Using the query above populate the table Employee_Statistics | Hint: Use the statement INSERT INTO …. SELECT
-- Did you commit? What happens if you rollback? 

INSERT INTO Employee_Statistics
SELECT e.employee_id, e.first_name ||' '|| e.last_name AS name, e.department_id AS current_dept, count(DISTINCT jh.job_id) AS numJobs, count(DISTINCT jh.department_id) AS numDepts
FROM hr_employees e LEFT OUTER JOIN hr_job_history jh 
        ON e.employee_id = jh.employee_id
GROUP BY e.employee_id, e.first_name ||' '|| e.last_name, e.department_id;
COMMIT;


-- Question 4 --
-- Now add a new column to the table called Employee_Index that is a string of maximum length 20;  Did you commit? What happens if you rollback?

ALTER TABLE Employee_Statistics
    ADD Employee_Index VARCHAR2(35);
COMMIT;
-- rollback reverts/ undoes changes --


-- Question 5 --
-- Now let’s update the table so that Employee_Index has the following values:
-- ‘Senior’ when the number of jobs is more than 2
-- ‘Junior’ when the number of orders is 2 
-- ‘New hire’ when the number of orders is 1 or less. 

UPDATE Employee_Statistics
SET Employee_Index = 'New Hire'
WHERE Number_of_Previous_Positions < 1;
    
UPDATE Employee_Statistics
SET Employee_Index = 'Junior'
WHERE Number_of_Previous_Positions = 2;

UPDATE Employee_Statistics
SET Employee_Index = 'Senior'
WHERE Number_of_Previous_Positions > 2;
COMMIT;


-- Question 6 --
-- Delete from the table Employee_Statistics all the employees that currently work in department 30 

DELETE FROM Employee_Statistics
WHERE department_id = 30;


-- Question 7 --
-- Modify the table and change the column definition of Number_of_Previous_Positions to a column that cannot be NULL

ALTER TABLE Employee_Statistics
MODIFY Number_of_Previous_Positions NUMBER(11,0) NOT NULL;  


-- Question 8 --
-- Modify the table and change the column definition of Number_of_Previous_Departments to a column that has a default value 0

ALTER TABLE Employee_statistics
MODIFY Number_of_Previous_Positions DEFAULT 0;


-- Question 9 --

-- 9A --
-- Update the records of table Employee_Statistics and set department of the employee with id 102 to 30

UPDATE Employee_Statistics
SET current_department_id = 30
WHERE employee_id = 102;


-- 9B --
-- Update the records of table Employee_Statistics and set the Employee_Index of all employees to ‘Command designed to make the point’.

UPDATE Employee_Statistics
SET employee_index = 'Command designed to make the point';


-- 9C --
-- Update the records of table Employee_Statistics and set the name of all employees with employee_id smaller than 120 to ‘Papa Bear’ (or anything else!)
-- Did you commit? What happens if you rollback?

UPDATE Employee_Statistics
SET employee_name = 'chunky boi'
WHERE employee_id < 120;
COMMIT;
ROLLBACK;


-- Question 10 --
-- Drop the foreign key constraint you created earlier (the one that says that Employee_Id of Employee_Statistics references Employee_Id of HR_Employees). 
-- If you did not create the FK create it first and then drop it.

ALTER TABLE employee_statistics
DROP CONSTRAINT Employee_FK;

-- Question 11 --
-- Insert a new record with Employee_Id = 300, Employee_Name= ‘Gerald-Of_Rivia’, and the rest of the values set at your choice. 
-- Don’t forget to commit! Could you have done that without dropping the FK?

INSERT INTO employee_statistics (employee_id, employee_name, current_department_id, number_of_previous_positions, number_of_previous_departments, employee_index)
VALUES (300, 'Gerald-Of_Rivia', 30, 0, 0, 'n/a');


-- Question 12 -- 
-- Write a merge statement to merge the data of the tables Employees and Employee_Statistics. You should modify the data of table Employee_Statistics by:
-- Compare the records using Employee_id
-- If the ids are the same but the names or departments are different then update table Employee_Statistics to match Employee
-- If the ids exist In Employee and not exist in Employee_Statistics then insert the Employee with 0 values for everything else 
-- Did you commit? What happens if you rollback?

MERGE INTO employee_statistics AS TARGET
USING hr_employees AS SOURCE
ON (SOURCE.employee_id = TARGET.employee_id)

WHEN NOT MATCHED BY TARGET THEN
    INSERT employee_statistics (employee_id, employee_name, current_department_id, number_of_previous_positions, number_of_previous_departments, employee_index)
    VALUES(SOURCE.employee_id, SOURCE.first_name || ' ' || SOURCE.last_name, 0, 0, 0, 0);

WHEN MATCHED THEN UPDATE SET
    TARGET.employee_name = (SOURCE.first_name || ' ' || SOURCE.last_name),
    TARGET.current_department_id = SOURCE.department_id;



-- Question 13 --
-- Truncate table Employee_Statistics. Can you still see the table definition? What about the data?
-- Did you commit? What happens if you rollback?
TRUNCATE TABLE employee_statistics;
COMMIT;
ROLLBACK;


-- Question 14 --
-- Drop table Employee_Statistics. Can you still see the table definition? Did you commit? What happens if you rollback?
DROP TABLE employee_statistics;
COMMIT;
ROLLBACK;