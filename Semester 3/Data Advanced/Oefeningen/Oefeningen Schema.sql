--Oefeningen Schema's
---------------------

--1. Maak een schema Bert waarin je volgende 2 tabellen aanmaakt. Maak gebruik van het 
--CREATE SCHEMA statement.
--Transport:
-- - Nummer (numerisch)
-- - Naam (string 20 lang)
--Verplaatsing:
-- - TransPortId (FK naar Transport)
-- - Werknemer (string 20 lang)
-- - Datum (date)

CREATE SCHEMA AUTHORIZATION BERT
	CREATE TABLE transports
		(transport_id number(10) not null,
		 transport_name VARCHAR2(20),
		 CONSTRAINT transports_pk PRIMARY KEY (transport_id));
	CREATE TABLE verplaatsingen
		(transport_id number(10) not null,
		 werknemer VARCHAR2(20),
         datum DATE,
         CONSTRAINT verplaatsingen_fk FOREIGN KEY (transport_id)
         REFERENCES transports(transport_id)):

--2. Maak een nieuwe gebruiker Sarah aan met paswoord Sarah123 en geef haar rechten om 
--in te loggen en tabellen aan te maken. Doe dit in 1 statement!

CREATE USER Sarah IDENTIFIED BY Sarah123;
GRANT CREATE SESSION, CREATE TABLE TO Sarah;

--3. Log in met gebruiker Sarah en maak onderstaande tabel aan:
--Vervangingen
-- - Medewerker (string 20 lang)
-- - VervangenDoor (string 20 lang)
-- - Datum (date)
--Werkt dit? Zo nee, waarom? Los dit probleem op!

CREATE TABLE Vervangingen
(
    Medewerker VARCHAR2(20),
    VervangenDoor VARCHAR2(20),
    Datum DATE
);


ALTER USER Sarah DEFAULT TABLESPACE system;
ALTER USER Sarah QUOTA UNLIMITED ON system;



--4. Maak een gebruiker AppTester (paswoord AppTester123) aan en geef deze leesrechten 
--op de medewerker tabel van de System account.

CREATE USER AppTester IDENTIFIED BY AppTester123;
GRANT CREATE SESSION TO AppTester;

GRANT SELECT on system.Medewerkers TO AppTester;

--5. Verwijder gebruikers Bert en Sarah.

DROP USER Bert; --CASCADE
DROP USER Sarah; --CASCADE

--6. Log in met gebruiker AppTester en zorg dat deze volgende tabel kan aanmaken:
--Vervangingen
-- - Mnr (FK naar medewerkers)
-- - Vervanging (FK naar medewerkers)
-- - Datum (date)

GRANT CREATE TABLE TO AppTester;
GRANT REFERENCES ON system.Medewerkers TO AppTester;


CREATE TABLE Vervangingen
(
    Mnr INT,  -- Foreign key column referencing the Medewerkers table
    Vervanging INT,  -- Another foreign key column referencing the Medewerkers table
    Datum DATE,
    CONSTRAINT fk_mnr FOREIGN KEY (Mnr)
        REFERENCES system.Medewerkers(Mnr),  -- Foreign key to Medewerkers table
    CONSTRAINT fk_vervanging FOREIGN KEY (Vervanging)
        REFERENCES system.Medewerkers(Mnr)   -- Foreign key to Medewerkers table
);


--7. Maak een extra gebruiker aan AppTesterProxy met paswoord (Proxy123) en geef deze 
--volledige rechten op de tabel Vervangingen van gebruiker AppTester. Test uit of je de 
--tabel kan gebruiken.

CREATE USER AppTesterProxy IDENTIFIED BY Proxy123;
GRANT CREATE SESSION TO AppTesterProxy;

--als AppTester inloggen
GRANT ALL PRIVILEGES ON Vervangingen TO AppTesterProxy;

SELECT * FROM AppTester.Vervangingen;

