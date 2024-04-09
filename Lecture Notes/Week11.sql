-- Range partitioning
--partitions defined by range of field values


CREATE TABLE employees (
    id      INT     NOT NULL,
    fname   VARCHAR(25) NOT NULL,
    lname   VARCHAR(25) NOT NULL,
    store_id    INT     NOT NULL,
    dept_id     INT     NOT NULL
)

PARTITION BY RANGE(id) (
    PARTITION p0 VALUES LESS THAN (5),
    PARTITION p1 VALUES LESS THAN (10),
    PARTITION p2 VALUES LESS THAN (15),
    PARTITION p3 VALUES LESS THAN (100)
);

-- list  partitioning
-- based on predefined lists of values for the partitioning key

CREATE TABLE sales (
    item_no     INT,
    qty         INT,
    store_name  VARCHAR(30),
    state_code  VARCHAR(2)

)
PARTITION BY LIST (state_code) (
    PARTITION region_east
    VALUES ('MA', 'NY', 'CT', 'NH', 'RI', 'MA', 'MD', 'PA', 'NJ'),
    PARTITION region_west
    VALUES ('CA', 'AZ', 'NM'),
    --etc
    PARTITION region_null
    VALUES (NULL)
);

-- Hash partitioning 
-- partitions defined using hash functions
-- Hash function: a function with any input (str, int) and the output is always of standard length
-- ex. modulo function

CREATE TABLE dept (
    deptno      NUMBER,
    deptname    VARCHAR(32) 
)

-- partitions randomly into equal sized partitions
PARTITION BY HASH(deptno) PARTITIONS 16;


-- Composite partitioning
-- uses > 1 partitioning methods


-- Tablespaces: named logical storage unit in which data from multiple tables can be stored


-- indexes: organize data to retrieve easier & quicker
-- unique index: used for primary keys
CREATE UNIQUE INDEX CustIndex_PK ON Customer_T(CustomerID);

CREATE UNIQUE INDEX LineIndex_PK ON OrderLine_T(OrderID, ProductID);

-- hash indexes only work well if you have an exact match; else use sequential or B+ tree

CREATE INDEX DescIndex ON Product_T(Description);

-- CREATE BITMAP INDEX
