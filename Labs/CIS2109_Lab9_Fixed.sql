-- Q3: To fix the errors, the security details need to be added for each table. 
-- We can do this by putting 'VISIBLE' or 'ENCRYPT' next to values depending
-- on the security we want.



-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-03-22 15:51:32 EDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE comp_solo (
    composition_composition_id NUMBER NOT NULL VISIBLE,
    soloist_soloist_id         NUMBER NOT NULL VISIBLE,
    date_last_performed        DATE
);

ALTER TABLE comp_solo ADD CONSTRAINT comp_solo_pk PRIMARY KEY ( composition_composition_id,
                                                                soloist_soloist_id );

CREATE TABLE composition (
    composition_id       NUMBER NOT NULL VISIBLE,
    composer_name        VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 
    ,
    composition_name     VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 
    ,
    movement_movement_id NUMBER NOT NULL VISIBLE
);

ALTER TABLE composition ADD CONSTRAINT composition_pk PRIMARY KEY ( composition_id );

CREATE TABLE concert (
    concert_id               NUMBER NOT NULL VISIBLE,
    concert_date             DATE VISIBLE,
    tickets_available        NUMBER VISIBLE,
    concert_season_season_id NUMBER NOT NULL VISIBLE,
    conductor_conductor_id   NUMBER NOT NULL VISIBLE 
);

ALTER TABLE concert ADD CONSTRAINT concert_pk PRIMARY KEY ( concert_id );

CREATE TABLE concert_comp (
    concert_concert_id         NUMBER NOT NULL VISIBLE,
    composition_composition_id NUMBER NOT NULL VISIBLE
);

ALTER TABLE concert_comp ADD CONSTRAINT concert_comp_pk PRIMARY KEY ( concert_concert_id,
                                                                      composition_composition_id );

CREATE TABLE concert_season (
    season_id    NUMBER NOT NULL VISIBLE,
    opening_date DATE VISIBLE,
    duration     NUMBER VISIBLE,
    high_season  CHAR(1) VISIBLE
);

ALTER TABLE concert_season ADD CONSTRAINT concert_season_pk PRIMARY KEY ( season_id );

CREATE TABLE conductor (
    conductor_id        NUMBER NOT NULL VISIBLE,
    conductor_name      VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 
    ,
    years_of_experience NUMBER VISIBLE,
    degree              VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE conductor ADD CONSTRAINT conductor_pk PRIMARY KEY ( conductor_id );

CREATE TABLE movement (
    movement_id   NUMBER NOT NULL VISIBLE,
    movement_name VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE movement ADD CONSTRAINT movement_pk PRIMARY KEY ( movement_id );

CREATE TABLE soloist (
    soloist_id   NUMBER NOT NULL VISIBLE,
    soloist_name VARCHAR2 VISIBLE
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE soloist ADD CONSTRAINT soloist_pk PRIMARY KEY ( soloist_id );

ALTER TABLE comp_solo
    ADD CONSTRAINT comp_solo_composition_fk FOREIGN KEY ( composition_composition_id )
        REFERENCES composition ( composition_id );

ALTER TABLE comp_solo
    ADD CONSTRAINT comp_solo_soloist_fk FOREIGN KEY ( soloist_soloist_id )
        REFERENCES soloist ( soloist_id );

ALTER TABLE composition
    ADD CONSTRAINT composition_movement_fk FOREIGN KEY ( movement_movement_id )
        REFERENCES movement ( movement_id );

ALTER TABLE concert_comp
    ADD CONSTRAINT concert_comp_composition_fk FOREIGN KEY ( composition_composition_id )
        REFERENCES composition ( composition_id );

ALTER TABLE concert_comp
    ADD CONSTRAINT concert_comp_concert_fk FOREIGN KEY ( concert_concert_id )
        REFERENCES concert ( concert_id );

ALTER TABLE concert
    ADD CONSTRAINT concert_concert_season_fk FOREIGN KEY ( concert_season_season_id )
        REFERENCES concert_season ( season_id );

ALTER TABLE concert
    ADD CONSTRAINT concert_conductor_fk FOREIGN KEY ( conductor_conductor_id )
        REFERENCES conductor ( conductor_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             15
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   6
-- WARNINGS                                 0