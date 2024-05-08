-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-03-29 16:23:58 EDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE author (
    aid    NUMBER NOT NULL,
    alname VARCHAR2(32) 
--  ERROR: VARCHAR2 size not specified 
    ,
    afname VARCHAR2(32) 
--  ERROR: VARCHAR2 size not specified 
    ,
    ainst  VARCHAR2(32) 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE author ADD CONSTRAINT author_pk PRIMARY KEY ( aid );

CREATE TABLE authorbook (
    authbroyalty  NUMBER,
    book_bnbr     NUMBER NOT NULL,
    author_aid    NUMBER NOT NULL,
    book_bpublish VARCHAR2(32)   
     NOT NULL
);

ALTER TABLE authorbook ADD CONSTRAINT authorbook_pk PRIMARY KEY ( book_bnbr,
                                                                  author_aid );

CREATE TABLE book (
    bnbr               NUMBER NOT NULL,
    bname              VARCHAR2(32)  

    ,
    bprice             NUMBER,
    publisher_bpublish VARCHAR2(32)  

     NOT NULL
);

ALTER TABLE book ADD CONSTRAINT book_pk PRIMARY KEY ( bnbr );

CREATE TABLE publisher (
    bpublish VARCHAR2(32)  

     NOT NULL,
    pubcity  VARCHAR2(32)  


);

ALTER TABLE publisher ADD CONSTRAINT publisher_pk PRIMARY KEY ( bpublish );

ALTER TABLE authorbook
    ADD CONSTRAINT authorbook_author_fk FOREIGN KEY ( author_aid )
        REFERENCES author ( aid );

ALTER TABLE authorbook
    ADD CONSTRAINT authorbook_book_fk FOREIGN KEY ( book_bnbr )
        REFERENCES book ( bnbr );

ALTER TABLE book
    ADD CONSTRAINT book_publisher_fk FOREIGN KEY ( publisher_bpublish )
        REFERENCES publisher ( bpublish );



-- insert data --
INSERT INTO book VALUES
(106, 'JavaScript and HTML5', 62.75, 'Wall & Vintage');
INSERT INTO book VALUES
(102, 'Quick Mobile Apps', 49.95, 'Gray Brothers');
INSERT INTO book VALUES
(104, 'Innovative Data Management', 158.65, 'Smith and Sons');
INSERT INTO book VALUES
(126, 'Networks and Data Centers', 250.00, 'Grey Brothers');
INSERT INTO book VALUES
(180, 'Server Infrastructure', 122.85, 'Gray Brothers');

INSERT INTO author VALUES
(10, 'Gold', 'Josh', 'Sleepy Hollow U');
INSERT INTO author VALUES
(24, 'Shippen', 'Mary', 'Green Lawns U');
INSERT INTO author VALUES
(32, 'Oswan', 'Jan', 'Middlestate College');

INSERT INTO authorbook VALUES
(6.28, 106, 10, 'Wall & Vintage');
INSERT INTO authorbook VALUES
(2.50, 102, 24, 'Gray Brothers');
INSERT INTO authorbook VALUES
(15.87, 104, 24, 'Smith and Sons');
INSERT INTO authorbook VALUES
(6.00, 106, 24, 'Wall & Vintage');
INSERT INTO authorbook VALUES
(12.50, 126, 32, 'Grey Brothers');
INSERT INTO authorbook VALUES
(12.30, 180, 32, 'Gray Brothers');
INSERT INTO authorbook VALUES
(2.25, 102, 32, 'Gray Brothers');

INSERT INTO publisher VALUES
('Wall & Vintage', 'Chicago, IL');
INSERT INTO publisher VALUES
('Gray Brothers', 'Boston, MA');
INSERT INTO publisher VALUES
('Smith and Sons', 'Dallas, TX');
INSERT INTO publisher VALUES
('Grey Brothers', 'Boston, NH');


SELECT a.aid, a.alname, a.afname, a.ainst, b.bnbr, b.bname, p.bpublish, p.pubcity, b.bprice, ab.authbroyalty
FROM authorbook ab FULL OUTER JOIN author a USING (aid)
NATURAL JOIN book b NATURAL JOIN publisher p;