drop user jane;
create user jane identified by pxl;

Grant CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK,
  CREATE MATERIALIZED VIEW, CREATE PROCEDURE, CREATE PUBLIC SYNONYM,CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE,CREATE TRIGGER, CREATE TYPE, CREATE VIEW, UNLIMITED TABLESPACE
TO jane;

GRANT select, insert, update, delete ON system.medewerkers to jane;
GRANT select, insert, update, delete ON system.afdelingen to jane;
GRANT select, insert, update, delete ON system.schalen to jane;
GRANT select, insert, update, delete ON system.cursussen to jane;
GRANT select, insert, update, delete ON system.uitvoeringen to jane;
GRANT select, insert, update, delete ON system.inschrijvingen to jane;

GRANT DROP ANY TABLE to jane;