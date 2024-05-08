/* script name: Lab_10.sql                 	 */

CREATE TABLE Customer_OLTP
	(CustomerID         NUMBER(4)          NOT NULL,
	 CustomerName       VARCHAR(25)    ,
	 CustomerAddress    VARCHAR(30)    ,
         CustomerCity       VARCHAR(20)    ,              
         CustomerState      CHAR(2)        ,
         CustomerPostalCode VARCHAR(10)    ,
CONSTRAINT Customer_PK PRIMARY KEY (CustomerID));

CREATE TABLE Order_OLTP
	(OrderID            NUMBER(5)        NOT NULL,
	 CustomerID         NUMBER(4)   ,
         OrderDate          DATE        ,
	 FulfillmentDate    DATE	,
	 SalespersonID	    NUMBER(4)	,
	 ShipAdrsID	    NUMBER(4)	,
CONSTRAINT Order_PK PRIMARY KEY (OrderID),
CONSTRAINT Order_FK1 FOREIGN KEY (CustomerID) 
	REFERENCES Customer_OLTP(CustomerID));


Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (1,'Contemporary Casuals','1355 S Hines Blvd','Gainesville','FL','32601-2871');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (2,'Value Furnitures','15145 S.W. 17th St.','Plano','TX','75094-7743');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (3,'Home Furnishings','1900 Allard Ave','Albany','NY','12209-1125');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (4,'Eastern Furniture','1925 Beltline Rd.','Carteret','NJ','07008-3188');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (5,'Impressions','5585 Westcott Ct.','Sacramento','CA','94206-4056');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (6,'Furniture Gallery','325 Flatiron Dr.','Boulder','CO','80514-4432');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (7,'New Furniture','Palace Ave','Farmington','NM',null);
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (8,'Dunkins Furniture','7700 Main St','Syracuse','NY','31590');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (9,'A Carpet','434 Abe Dr','Rome','NY','13440');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (12,'Flanigan Furniture','Snow Flake Rd','Ft Walton Beach','FL','32548');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (13,'Ikards','1011 S. Main St','Las Cruces','NM','88001');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (14,'Wild Bills','Four Horse Rd','Oak Brook','Il','60522');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (15,'Janet''s Collection','Janet Lane','Virginia Beach','VA','10012');
Insert into Customer_OLTP (CustomerID,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode) values (16,'ABC Furniture Co.','152 Geramino Drive','Rome','NY','13440');


INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (1, to_Date('08/Sep/09', 'DD/MON/RR'), 4, to_date('25/Nov/05', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (2, to_date('04/Oct/09', 'DD/MON/RR'), 3, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (3, to_date('19/Jul/09', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), 2, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (4, to_date('01/Nov/09', 'DD/MON/RR'), 6, to_date('', 'DD/MON/RR'), 5, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (5, to_date('28/Jul/09', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (6, to_Date('27/Aug/09', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (7, to_date('16/Sep/09', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), 2, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (8, to_date('16/Sep/09', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (9, to_date('16/Sep/09', 'DD/MON/RR'), 6, to_date('', 'DD/MON/RR'), 5, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (19, to_date('05/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (20, to_date('06/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (21, to_date('06/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (22, to_date('06/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (23, to_date('06/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (24, to_date('10/Mar/10', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), 2, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (25, to_date('10/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (26, to_date('10/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (27, to_date('10/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (28, to_date('10/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (29, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (30, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, 4);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (31, to_date('11/Mar/10', 'DD/MON/RR'), 15, to_date('', 'DD/MON/RR'), 4, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (32, to_date('11/Mar/10', 'DD/MON/RR'), 15, to_date('', 'DD/MON/RR'), 4, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (34, to_date('11/Mar/10', 'DD/MON/RR'), 15, to_date('', 'DD/MON/RR'), 4, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (35, to_date('11/Mar/10', 'DD/MON/RR'), 8, to_date('', 'DD/MON/RR'), 5, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (36, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, 1);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (37, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (38, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, 1);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (39, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, 1);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (40, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (41, to_date('11/Mar/10', 'DD/MON/RR'), 12, to_date('', 'DD/MON/RR'), 6, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (42, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (43, to_date('11/Mar/10', 'DD/MON/RR'), 12, to_date('', 'DD/MON/RR'), 6, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (44, to_date('11/Mar/10', 'DD/MON/RR'), 6, to_date('', 'DD/MON/RR'), 9, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (45, to_date('11/Mar/10', 'DD/MON/RR'), 12, to_date('', 'DD/MON/RR'), 6, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (46, to_date('11/Mar/10', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), 2, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (47, to_date('11/Mar/10', 'DD/MON/RR'), 12, to_date('', 'DD/MON/RR'), 6, NULL);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (48, to_date('11/Mar/10', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), 2, 3);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (49, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 3, 2);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (50, to_date('11/Mar/10', 'DD/MON/RR'), 8, to_date('', 'DD/MON/RR'), null, 9);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (51, to_date('11/Mar/10', 'DD/MON/RR'), 16, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (52, to_date('11/Mar/10', 'DD/MON/RR'), 16, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (53, to_date('11/Mar/10', 'DD/MON/RR'), 16, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (54, to_date('11/Mar/10', 'DD/MON/RR'), 16, to_date('', 'DD/MON/RR'), 9, 10);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (55, to_date('11/Mar/10', 'DD/MON/RR'), 16, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (56, to_date('11/Mar/10', 'DD/MON/RR'), 9, to_date('', 'DD/MON/RR'), 2, 11);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (57, to_date('11/Mar/10', 'DD/MON/RR'), 9, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (58, to_date('11/Mar/10', 'DD/MON/RR'), 14, to_date('', 'DD/MON/RR'), 5, 13);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (59, to_date('11/Mar/10', 'DD/MON/RR'), 13, to_date('', 'DD/MON/RR'), 8, 14);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (63, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 6, 15);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (64, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 6, 2);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (65, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 6, 1);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (66, to_date('11/Mar/10', 'DD/MON/RR'), 9, to_date('', 'DD/MON/RR'), 5, 17);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (69, to_date('11/Mar/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), 2, 2);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (71, to_date('08/Sep/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (73, to_date('08/Sep/10', 'DD/MON/RR'), 12, to_date('', 'DD/MON/RR'), null, null);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (75, to_date('08/Sep/10', 'DD/MON/RR'), 1, to_date('', 'DD/MON/RR'), null, 3);

INSERT INTO Order_OLTP (OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID) 
VALUES (76, to_date('15/Sep/10', 'DD/MON/RR'), 4, to_date('', 'DD/MON/RR'), null, null);

commit; 

/*Create table Date Dimension*/
Drop table Date_Dim; 
CREATE TABLE Date_Dim(
DateKey Integer NOT NULL,
DateValue Date NOT NULL,
Day Char(10 ),
DayOfWeek Integer,
DayOfMonth Integer,
DayOfYear Integer,
PreviousDay date,
NextDay date,
WeekOfYear Integer,
Month Char(10 ),
MonthOfYear Integer,
QuarterOfYear Integer,
Year Integer, 
	 CONSTRAINT Date_Dim_PK PRIMARY KEY (DateKey)
);

INSERT INTO Date_Dim
SELECT
to_number(to_char(CurrDate, 'YYYYMMDD')) as DateKey,
CurrDate AS DateValue,
TO_CHAR(CurrDate,'Day') as Day,
to_number(TO_CHAR(CurrDate,'D')) AS DayOfWeek,
to_number(TO_CHAR(CurrDate,'DD')) AS DayOfMonth,
to_number(TO_CHAR(CurrDate,'DDD')) AS DayOfYear,
CurrDate - 1 as PreviousDay,
CurrDate + 1 as NextDay,
to_number(TO_CHAR(CurrDate+1,'IW')) AS WeekOfYear,
TO_CHAR(CurrDate,'Month') AS Month,
to_number(TO_CHAR(CurrDate,'MM')) AS MonthofYear,
to_number((TO_CHAR(CurrDate,'Q'))) AS QuarterOfYear,
to_number(TO_CHAR(CurrDate,'YYYY')) AS Year
FROM (
select level n, TO_DATE('01/06/2009','DD/MM/YYYY') + NUMTODSINTERVAL(level,'day') CurrDate
from dual
connect by level <= 500)
order by 1;

CREATE SEQUENCE customer_seq START WITH 1;


-- Part 01

-- 1. Let’s create a new table name Customer_Dim, which will be the customer dimension of your datawarehouse. 
-- You can create the table to be exactly the same as Customer_OLTP but the Primary Key should be a new PK named Customer_Key 
-- and there must be one additional column named Active_Flag to indicate if the record is active or not.


CREATE TABLE Customer_Dim
     (Customer_Key         NUMBER(4)          NOT NULL,
      CustomerName       VARCHAR(25)    ,
      CustomerAddress    VARCHAR(30)    ,
      CustomerCity       VARCHAR(20)    ,              
      CustomerState      CHAR(2)        ,
      CustomerPostalCode VARCHAR(10)    ,
      Active_Flag        NUMBER(1),
CONSTRAINT Customer_Dim_PK PRIMARY KEY (Customer_Key));


-- 2. Now insert data. To do that, you can write a statement of the form:
-- Insert Into Customer_Dim
-- Select customer_seq.NEXTVAL, …
-- From Customer_OLTP;

INSERT INTO Customer_Dim (Customer_Key, CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode, Active_Flag)
SELECT customer_seq.NEXTVAL, CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode, 1
FROM Customer_OLTP;



--Part 02

--Now let’s try the Slowly Changing dimensions:
--Assume one of your customers updates their address and you want to keep track of this change following the SCD rules. To do that:
-- Update the old record so that active_flag = 0
-- Insert the new record with active_flag =1;


-- Step 1: Update the old record
UPDATE Customer_Dim
SET Active_Flag = 0
WHERE CustomerName = 'Contemporary Casuals';

-- Step 2: Insert the new record
INSERT INTO Customer_Dim (Customer_Key, CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode, Active_Flag)
VALUES (customer_seq.NEXTVAL, 'Contemporary Casuals', 'NEW ADDRESS', 'NEW CITY', 'NA', '12345', 1);

COMMIT;


-- Part 03 – Extra Credit
-- Now we can create a fact table, with Date_key, Customer_Key, Order_Count columns.

CREATE TABLE Sales_Fact (
    Date_Key INTEGER NOT NULL,
    Customer_Key INTEGER NOT NULL,
    Order_Count INTEGER,
    CONSTRAINT SF_PK PRIMARY KEY (Date_Key, Customer_Key),
    CONSTRAINT Date_FK FOREIGN KEY (Date_Key) REFERENCES Date_Dim(DateKey),
    CONSTRAINT Customer_FK FOREIGN KEY (Customer_Key) REFERENCES Customer_Dim(Customer_Key)
);

-- And let’s populate the table by executing a statement of the form:

    -- Insert Into Sales_Fact
    -- Select Date_key, Customer_Key, count(Order_Id) AS Order_Count
    -- From ….
    -- Group by Date_key, Customer_Key;  
    -- Hint: You need to combine Order_OLTP with Customer_Dim and Date_Dim.
    
INSERT INTO Sales_Fact (Date_Key, Customer_Key, Order_Count)
SELECT d.DateKey, cd.Customer_Key, count(OrderId)
FROM Order_OLTP o INNER JOIN Customer_Dim cd ON o.CustomerID = cd.Customer_key 
INNER JOIN Date_Dim d ON o.OrderDate = d.datevalue
GROUP BY d.datekey, cd.customer_key;
