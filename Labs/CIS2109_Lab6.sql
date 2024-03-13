-- Laura McDonnell --
-- CIS 2109 Lab 5 --
-- February 23, 2024 --


-- Question 1 --

-- 1A --
-- Create a function that has the Employee_Id as input and returns the number of employees 
--that have a salary that is higher than the salary of the given employee.
CREATE OR REPLACE FUNCTION num_emps_higher_salary(eID IN NUMBER)
    RETURN NUMBER 
    IS num_emps NUMBER;
    BEGIN
        SELECT count(employee_id)
        INTO num_emps
        FROM hr_employees
        WHERE salary > (SELECT salary
                        FROM hr_employees
                        WHERE employee_id = eID);
        RETURN(num_emps);
    END;
    

-- 1B1 --
-- Now use the function:
-- Write a select statement that returns the number of employees with a salary that is higher than that of the employee with Employee_Id = 103
SELECT num_emps_higher_salary(103)
FROM dual;


-- 1B2 --
-- Write a select statement that selects all employees (Ids, and names) and the number of employees with a higher salary for each.
SELECT employee_id, first_name || ' ' || last_name AS name, num_emps_higher_salary(employee_id)
FROM hr_employees
GROUP BY (employee_id, first_name || ' ' || last_name);



-- Question 2 -- 

-- 2A --
-- Write a procedure that has as input the Job_Id of employees. Then the procedure should increase the salary of each employee with this Job_Id by 10000.
CREATE OR REPLACE PROCEDURE salary_increase(job_id IN VARCHAR2) IS 
    BEGIN
        UPDATE hr_employees 
        SET salary = salary + 10000
        WHERE job_id = salary_increase.job_id;
    END;


-- 2B --
-- Now execute the procedure to give a raise to all employees with Job_Id ‘IT_PROG ‘. 
SELECT salary FROM hr_employees WHERE job_id = 'IT_PROG';
EXEC salary_increase('IT_PROG')


-- 2C --
-- ROLLBACK; What happens?
ROLLBACK;
-- undoes the procedure (sets salaries back to original values --



-- Question 3 --

-- 3A --
-- Create a view that holds only the employees that have a Job_Id ‘IT_PROG’ (all employee information needs to be included).
CREATE OR REPLACE VIEW job_view AS
    SELECT job_id, first_name, last_name
    FROM hr_employees
    WHERE job_id = 'IT_PROG'
    WITH CHECK OPTION;


-- 3B --
-- Now update one of the Employee names using the view. Do you see this change transferred to the Employees table? 
-- Try updating the employees table and change the name to something else, do you see the change in the view?
-- Note: If you try to update Employees table you may get an error saying: "You can only update salary during office hours". 
-- Can you figure out what is causing this error? To eliminate the error and proceed with the lab execute: drop trigger SECURE_HR_EMPLOYEES;  
UPDATE job_view
SET first_name = 'NAME'
WHERE job_id = 'IT_PROG' AND last_name = 'Ernst';
-- yes, the change is  transferred to hr_employees table
-- drop trigger SECURE_HR_EMPLOYEES;

UPDATE hr_employees
SET first_name = 'NAMETWO'
WHERE job_id = 'IT_PROG' AND last_name = 'Ernst';
-- yes, the change is seen in the view


-- 3C --
-- Now create a view that holds the Employees that have a Job_Id ‘IT_PROG’ and salary larger than 5000, using the WITH CHECK option. 
-- Now update again one of the employee names using the view. Do you see this change transferred to employees table? 
-- Now update the salary and set it to 4000, can you do that? What happens of you try to do the same update, but this time update the employee table directly?
CREATE OR REPLACE VIEW emp_view AS
    SELECT job_id, first_name, last_name
    FROM hr_employees
    WHERE job_id = 'IT_PROG' AND salary > 5000
    WITH CHECK OPTION;    
-- yes, the change is transferred to hr_employees table

UPDATE emp_view
SET salary = 4000
WHERE job_id = 'IT_PROG' AND salary > 5000;
-- does not work

UPDATE hr_employees
SET salary = 4000
WHERE job_id = 'IT_PROG' AND salary > 5000;
-- works
