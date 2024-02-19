-- DDL --
-- Data Definition Language --

-- Creating databases --
-- example --
CREATE TABLE order_t 
    (OrderID        NUMBER(11,0)   NOT NULL, 
    OrderDate DATE DEFAULT SYSDATE,
    CustomerID      NUMBER(11,0)    NOT NULL,
COSTRAINT Order PH PRIMARY KEY (OrderID),
CONSTRAINT Order FK FOREIGN KEY (CustomerID) REFERENCES Customer_T(CustomerID));

-- Datatypes --
-- char: string of fixed length --
-- varchar: strings of varying length --
-- dates --
-- boolean --
-- numbers --


-- indexes --
-- organizes descriptions of product table --
CREATE INDEX DescIndex ON Product_T Description 

-- unique indexes --
-- ON clause specifies which table is being indexed --
-- forces uniqueness --
CREATE UNIQUE INDEX CustIndex_PK ON Customer_T(CustomerID)


-- Alter table: edit the table definition --
ALTER TABLE table_name alter_table_action;

-- Table actions --
-- [COLUMN] = column definition (name, datatype, constraints) --
ADD [COLUMN] column_definition
ALTER [COLUMN] column_name SET DEFAULT default_value
ALTER [COLUMN] column_name DROP DEFAULT
ADD table_constraint

-- examples --
ALTER TABLE Customer_T 
ADD COLUMN CustomerType VARCHAR2 (2) DEFAULT "Commercial";

ALTER TABLE supplier 
MODIFY (supplier_name char(100) NOT NULL, city char(75));

ALTER TABLE supplier
RENAME COLUMN supplier_name TO sname;

ALTER TABLE table_name 
RENAME TO new_table_name

-- Drop table --
-- removes table from schema --
DROP TABLE Customer_T;
-- this will fail since there are foreign keys referencing this table --
-- use: --
DROP TABLE Customer_T CASCADE;

-- insert data --
INSERT INTO Customer_T VALUES
(001, 'Contemportary Casuals', '1355 Street Road', 'Gainesville', 'FL', 32601)

-- load in data --
LOAD DATA INFILE 'data.txt' INTO TABLE table_name
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

-- delete data --
DELETE FROM Customer_T 
WHERE CustomerState = 'HI';

-- update data --
UPDATE Product_T
SET ProductPrice = 775
WHERE ProductID = 101;

-- Merge --

-- Transaction Control Language (TCL) --
-- COMMIT, ROLLBACK, SAVEPOINT --

-- Data Control Language (DCL) --
-- Grant, Deny & Revoke --
GRANT SELECT
ON HR.employees
TO Joe

DENY DELETE
ON HR.employees
TO Joe

REVOKE SELECT
ON HR.employees
FROM Joe


-- role: set of priveleges that can be granted to users --
CREATE ROLE OrderTrans;

GRANT SELECT ON Customer TO OrderTrans With Grant Option 
CREATE USER anne IDENTIFIED BY Password123 
GRANT OrderTrans TO anne


-- PL SQL --
-- Persistent stored modules (SQL/PSM): ability to create and drop code modules --
-- Four objects: 
    -- routines (anonymous blocks that execute on demand), 
    -- functions 
    -- procedures (routines that do not return values and can take input or output parameters)
    -- triggers (routines that execute in response to a databse event)

-- declares variable called 'qty_on_hand' which is a numerical value
DECLARE
    qty_on_hand NUMBER(5)
BEGIN
    SELECT quantity INTO qty_on_hand FROM inventory
        WHERE product = 'TENNIS RACKET'
        FOR UPDATE of quantity;
    IF qty_on_hand > 0 THEN 
        UPDATE inventory SET quantity = quantity - 1

-- function --
CREATE FUNCTION order_total(order_number IN NUMBER)
    RETURN NUMBER
    IS acc_bal NUMBER (11,2);
    BEGIN
        SELECT sum(unit_price*order_qty)
        INTO acc_bal
        FROM orders o INNER JOIN order_details t USING(order_id)
            INNER JOIN items i USING(item_id)
        WHERE o.order_id = order_number
        GROUP BY o.order_id
        RETURN(acc_bal);
    END;

-- dual: a pseudotable you can select when there is no table you are selecting --
-- ex. selecting a date or number --

-- Trigger --
CREATE OR REPLACE TRIGGER log_salary_increase
    AFTER UPDATE OF salary ON employees
    --...

CREATE OR REPLACE PROCEDURE drop_location (loc VARCHAR2) IS
BEGIN 
    -- delete the employee table for location 'loc'
    -- DROP TABLE emp_PA ; (PA = loc)
    EXECUTE IMMEDIATE 'DROP TABLE' || 'emp' || loc;
    -- remove location from master table
    DELETE FROM offices WHERE location = loc;
END;
/
SHOW ERRORS;

-- delete all tables --
BEGIN

FOR i IN (SELECT ut.table_name FROM USER_TABLES ut)

LOOP
EXECUTE IMMEDIATE 'DROP TABLE' || i.table_name || 'CASCADE CONSTRAINTS';
END LOOP;
END;
/

-- Using and defining views -- 
