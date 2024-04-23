--------------------------------------------------------------------------------------
-- Name	       : OT (Oracle Tutorial) Sample Database
-- Link	       : http://www.oracletutorial.com/oracle-sample-database/
-- Version     : 1.0
-- Last Updated: July-28-2017
-- Copyright   : Copyright © 2017 by www.oracletutorial.com. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.
--               Credit the site oracletutorial.com explitly in your materials that
--               use this sample database.
--------------------------------------------------------------------------------------
DROP TABLE ot_order_items;  
DROP TABLE ot_orders;
DROP TABLE ot_inventories;
DROP TABLE ot_products;
DROP TABLE ot_product_categories;
DROP TABLE ot_warehouses;
DROP TABLE ot_employees;
DROP TABLE ot_contacts;
DROP TABLE ot_customers;
DROP TABLE ot_locations;
DROP TABLE ot_countries;
DROP TABLE ot_regions;
---------------------------------------------------------------------------
-- execute the following statements to create tables
---------------------------------------------------------------------------
-- regions
CREATE TABLE OT_regions
  (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2( 50 ) NOT NULL
  );
-- countries table
CREATE TABLE OT_countries
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR2( 40 ) NOT NULL,
    region_id    NUMBER                 , -- fk
    CONSTRAINT fk_countries_regions FOREIGN KEY( region_id )
      REFERENCES OT_regions( region_id ) 
      ON DELETE CASCADE
  );

-- location
CREATE TABLE OT_locations
  (
    location_id NUMBER   PRIMARY KEY       ,
    address     VARCHAR2( 255 ) NOT NULL,
    postal_code VARCHAR2( 20 )          ,
    city        VARCHAR2( 50 )          ,
    state       VARCHAR2( 50 )          ,
    country_id  CHAR( 2 )               , -- fk
    CONSTRAINT fk_locations_countries 
      FOREIGN KEY( country_id )
      REFERENCES OT_countries( country_id ) 
      ON DELETE CASCADE
  );
-- warehouses
CREATE TABLE OT_warehouses
  (
    warehouse_id NUMBER PRIMARY KEY,
    warehouse_name VARCHAR( 255 ) ,
    location_id    NUMBER( 12, 0 ), -- fk
    CONSTRAINT fk_warehouses_locations 
      FOREIGN KEY( location_id )
      REFERENCES OT_locations( location_id ) 
      ON DELETE CASCADE
  );
-- employees
CREATE TABLE OT_employees
  (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR( 255 ) NOT NULL,
    last_name  VARCHAR( 255 ) NOT NULL,
    email      VARCHAR( 255 ) NOT NULL,
    phone      VARCHAR( 50 ) NOT NULL ,
    hire_date  DATE NOT NULL          ,
    manager_id NUMBER( 12, 0 )        , -- fk
    job_title  VARCHAR( 255 ) NOT NULL,
    CONSTRAINT fk_employees_manager 
        FOREIGN KEY( manager_id )
        REFERENCES OT_employees( employee_id )
        ON DELETE CASCADE
  );
-- product category
CREATE TABLE OT_product_categories
  (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2( 255 ) NOT NULL
  );

-- products table
CREATE TABLE OT_products
  (
    product_id NUMBER PRIMARY KEY,
    product_name  VARCHAR2( 255 ) NOT NULL,
    description   VARCHAR2( 2000 )        ,
    standard_cost NUMBER( 9, 2 )          ,
    list_price    NUMBER( 9, 2 )          ,
    category_id   NUMBER NOT NULL         ,
    CONSTRAINT fk_products_categories 
      FOREIGN KEY( category_id )
      REFERENCES OT_product_categories( category_id ) 
      ON DELETE CASCADE
  );
-- customers
CREATE TABLE OT_customers
  (
    customer_id NUMBER  PRIMARY KEY,
    name         VARCHAR2( 255 ) NOT NULL,
    address      VARCHAR2( 255 )         ,
    website      VARCHAR2( 255 )         ,
    credit_limit NUMBER( 8, 2 )
  );
-- contacts
CREATE TABLE OT_contacts
  (
    contact_id NUMBER  PRIMARY KEY,
    first_name  VARCHAR2( 255 ) NOT NULL,
    last_name   VARCHAR2( 255 ) NOT NULL,
    email       VARCHAR2( 255 ) NOT NULL,
    phone       VARCHAR2( 20 )          ,
    customer_id NUMBER                  ,
    CONSTRAINT fk_contacts_customers 
      FOREIGN KEY( customer_id )
      REFERENCES OT_customers( customer_id ) 
      ON DELETE CASCADE
  );
-- orders table
CREATE TABLE OT_orders
  (
    order_id NUMBER   PRIMARY KEY,
    customer_id NUMBER( 6, 0 ) NOT NULL, -- fk
    status      VARCHAR( 20 ) NOT NULL ,
    salesman_id NUMBER( 6, 0 )         , -- fk
    order_date  DATE NOT NULL          ,
    CONSTRAINT fk_orders_customers 
      FOREIGN KEY( customer_id )
      REFERENCES OT_customers( customer_id )
      ON DELETE CASCADE,
    CONSTRAINT fk_orders_employees 
      FOREIGN KEY( salesman_id )
      REFERENCES OT_employees( employee_id ) 
      ON DELETE SET NULL
  );
-- order items
CREATE TABLE OT_order_items
  (
    order_id   NUMBER( 12, 0 )                                , -- fk
    item_id    NUMBER( 12, 0 )                                ,
    product_id NUMBER( 12, 0 ) NOT NULL                       , -- fk
    quantity   NUMBER( 8, 2 ) NOT NULL                        ,
    unit_price NUMBER( 8, 2 ) NOT NULL                        ,
    CONSTRAINT pk_order_items 
      PRIMARY KEY( order_id, item_id ),
    CONSTRAINT fk_order_items_products 
      FOREIGN KEY( product_id )
      REFERENCES OT_products( product_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_order_items_orders 
      FOREIGN KEY( order_id )
      REFERENCES OT_orders( order_id ) 
      ON DELETE CASCADE
  );
-- inventories
CREATE TABLE OT_inventories
  (
    product_id   NUMBER( 12, 0 )        , -- fk
    warehouse_id NUMBER( 12, 0 )        , -- fk
    quantity     NUMBER( 8, 0 ) NOT NULL,
    CONSTRAINT pk_inventories 
      PRIMARY KEY( product_id, warehouse_id ),
    CONSTRAINT fk_inventories_products 
      FOREIGN KEY( product_id )
      REFERENCES OT_products( product_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_inventories_warehouses 
      FOREIGN KEY( warehouse_id )
      REFERENCES OT_warehouses( warehouse_id ) 
      ON DELETE CASCADE
  );