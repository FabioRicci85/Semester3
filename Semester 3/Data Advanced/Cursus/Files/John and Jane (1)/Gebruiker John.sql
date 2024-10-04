drop user john;
create user john identified by pxl;

Grant CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK,
  CREATE MATERIALIZED VIEW, CREATE PROCEDURE, CREATE PUBLIC SYNONYM,CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE,CREATE TRIGGER, CREATE TYPE, CREATE VIEW, UNLIMITED TABLESPACE
TO john;

GRANT select, insert, update, delete ON system.medewerkers to john;
GRANT select, insert, update, delete ON system.afdelingen to john;
GRANT select, insert, update, delete ON system.schalen to john;
GRANT select, insert, update, delete ON system.cursussen to john;
GRANT select, insert, update, delete ON system.uitvoeringen to john;
GRANT select, insert, update, delete ON system.inschrijvingen to john;

GRANT DROP ANY TABLE to john;