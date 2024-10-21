--Oefeningen Objects, triggers en Schema's
------------------------------------------

--1. Maak een private synonym emp voor de tabel medewerkers aan als de gebruiker 
--student. Kan je als gebruiker Jane het synonym gebruiken om alle medewerkers te 
--selecteren? Zoja, hoe ziet het commando er uit? (Let op: student moet de casus
--tabellen hebben aangemaakt en Jane moet toegang hebben tot de casus tabellen van 
--student.)
CREATE SYNONYM emp FOR student.medewerkers;

GRANT SELECT ON student.medewerkers TO Jane;
SELECT * FROM student.medewerkers;
CREATE PUBLIC SYNONYM emp FOR medewerkers; --als student
SELECT * FROM emp;


--2. Maak vervolgens een public synonym employees voor de tabel medewerkers aan als 
--de gebruiker student. Kan je als gebruiker Jane het synonym gebruiken om alle 
--medewerkers te selecteren? Zoja, hoe ziet het commando er uit?

CREATE PUBLIC SYNONYM employees FOR medewerkers; --als student

Select * from employees; --als Jane

--3. Maak als gebruiker Jane de tabel employees aan en vul deze met vier rijen (Zie Code 
--Snippet A). Kan je hierna nog steeds het public synonym employees gebruiken als 
--Jane? Bespreek met je buur wat de voor- en nadelen zouden zijn van een public 
--synonym te maken.

--a) Jane gaat enkel haar eigen employees nog kunnen gebruiken, als ze student.medewerkers wilt anroepen, dan zal ze at op deze manier moeten doen.

--Ontdek de werking tussen sequences en rollbacks:
--Begin Transaction:
--Een transactie start wanneer het eerste uitvoerbare SQL statement wordt doorgegeven.
--Een uitvoerbaar SQL statement is een statement dat een oproep doet naar de database (DML 
--en DDL statements).
--Zodra een transactie start worden alle statements verzameld in een undo segement, zodat 
--deze ongedaan gemaakt kunnen worden met een ROLLBACK;
--Einde Transaction:
--Een transactie wordt beëindigd wanneer een gebruiker COMMIT; of ROLLBACK; uitvoert.
--- COMMIT bevestigt het doorvoeren van het werk.
--- ROLLBACK zorgt er voor dat de aanpassingen ongedaan worden gemaakt.
--Verder wordt een transactie beëindigd wanneer een gebruiker een CREATE, DROP, RENAME 
--of ALTER commando uitvoert. Deze worden impliciet ge-commit.

--4. COMMIT je voorgaande werk voor je begint met dit onderdeel!
--Voer de code uit Code Snippet B uit om een tabel van customers te maken. Voorzie 
--vervoglens een sequence, customer_id_seq, om primary keys te maken voor de 
--klanten. De sequence start op 100 en wordt verhoogt met 10 voor elke nieuwe 
--waarde. De sequence mag niet herbeginnen en heeft een maximum van 1000.

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100)
);


CREATE SEQUENCE customer_id_seq
    START WITH 100
    INCREMENT BY 10
    MAXVALUE 1000
    NOCYCLE;  

INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'John', 'Doe', 'john.doe@example.com');

INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'Jane', 'Smith', 'jane.smith@example.com');

ROLLBACK;

INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'Bob', 'Williams', 'bob.williams@example.com');

--Value van customer_id_seq gaat niet terug naar vorige val, het blijft door gaan, ook al doen we een rollback.

--5. Maak vervolgens de volgende twee klanten aan met behulp van een INSERT:
--a. Id van sequence, Alice, Johnson, alicejohnson@gmail.com
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'Alice', 'Johnson', 'alicejohnson@gmail.com');


--b. Id van sequence, Bob, Johnson, bobJ@gmail.com
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'Bob', 'Johnson', 'bobJ@gmail.com');


--6. Voer een ROLLBACK uit. Zijn de klanten nog in de customers tabel te vinden? Wat is er 
--gebeurt met de sequence en de tabel? Waarom zijn sommige database objects weg en 
--andere niet?

ROLLBACK;
SELECT * FROM customers;
--de twee INSERTs zijn weg en de nummers lopen gewoon verder, ze gaan niet terug naar "achter"

--7. Voeg opnieuw de twee klanten toe m.b.v. een INSERT. Wat is er gebeurt met de 
--sequence nummering?
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (customer_id_seq.NEXTVAL, 'Charlie', 'Brown', 'charlieb@gmail.com');

SELECT * FROM customers WHERE first_name = 'Charlie';

--2. Triggers & Schema’s
--Los onderstaande oefeningen op:
---------------------------------

--8. Maak een gebruiker Hans met paswoord Hogeschool en zorg dat hij rechten heeft op 
--de medewerkers tabel van de system gebruiker om gegevens te lezen en te wijzigen. 
--LET OP: pas de minimale rechten toe die hiervoor nodig zijn!
--Maak een trigger die ervoor zorgt dat Hans enkel de naam, voornaam en salaris mag 
--wijzigen.

CREATE USER Hans IDENTIFIED BY Hogeschool;

GRANT CREATE SESSION TO Hans;

GRANT select, update on student.medewerkers to hans;

CREATE TRIGGER aur_naamVoornMaandsal_wijzig
AFTER UPDATE ON student.medewerkers
FOR EACH ROW
BEGIN
	IF UPDATING('NAAM') OR UPDATING('VOORN') OR UPDATING('MAANDSAL') THEN 
	NULL;
	ELSE
		RAISE_APPLICATION_ERROR(-20000, 'JE hebt het recht niet om dfit te wijzigen');
	END IF;
END;
/


--9. Als iemand de commissie van een medewerker wijzigt, moet de melding komen “Je 
--hebt geen rechten om de commissie van een medewerker te wijzigen!”, behalve voor 
--gebruiker Jane.

CREATE TRIGGER bus_commissie_jane
BEFORE UPDATE of conn on student.medewerkers
BEGIN
	IF USER != 'JANE' THEN 
		IF UPDATING('COMM') THEN
			RAISE_APPLICATION_ERROR(-20001, 'Je hebt geen rechten om de commissie van een medewerker te wijzigen!');
		END IF;
	END IF;
END;
/


--10. Enkel gebruiker John mag de naam van een medewerker wijzigen tussen 8u en 10u.

CREATE TRIGGER bus_john_time
BEFORE UPDATE of naam ON student.medewerkers
BEGIN
	IF USER != 'JOHN' THEN
		RAISE_APPLICATION_ERROR(-20002, 'Je hebt geen rechten om de naam van een medewerker te wijzigen');
	END IF;
	IF TO_NUMBER(TO_CHAR(SYSDATE,'hh24')) not between 8 and 10 THEN
		RAISE_APPLICATION_ERROR(-20003, 'Je mag enkel de naam wijzigen tussen 8u en 10u');
	END IF;
END;
/


--11. Geef een melding als het salaris van een medewerker met meer dan de helft verhoogt.

CREATE TRIGGER bus_maandsal_verhoging
BEFORE UPDATE of maandsal ON student.medewerkers
BEGIN
	IF :NEW.maandsal > (:OLD.maandsal * 1.5) THEN
	RAISE_APPLICATION_ERROR(-20004, 'Maandsalaris mag niet meer dan de helft verhoogd worden');
	END IF;
END;
/

--12. Maak een trigger die ervoor zorgt dat Hans enkel mag inloggen tussen 12u en 18u.

CREATE OR REPLACE TRIGGER als_restrict_hans_logon
AFTER LOGON ON DATABASE
BEGIN
	IF USER = 'HANS' THEN
		IF TO_NUMBER(TO_CHAR(SYSDATE, 'hh24')) not between 12 and 18 THEN
			RAISE_APPLICATION_ERROR(-20005, 'Je mag enkel inloggen tussen 12u en 18u HANS!');
		END IF;
	END IF;
END;
/

--13. Een medewerker verwijderen mag niet tijdens de nachtverwerking die loopt tussen 1 
--en 5 uur.

CREATE OR REPLACE TRIGGER bds_delete_nighttime
BEFORE DELETE ON student.medewerkers
BEGIN
	IF TO_NUMBER(TO_CHAR(SYSDATE, 'hh24')) between 1 and 5 THEN
		RAISE_APPLICATION_ERROR(-20006, 'Je mag niemand verwijderen tussen 1u en 5u s ochtend!');
	END IF;
END;
/

--14. Maak 1 (!) trigger die ervoor zorgt dat Jane geen afdelingen mag verwijderen en ook 
--geen naam van een afdeling mag wijzigen.

CREATE OR REPLACE TRIGGER bdus_jane_mdw
BEFORE DELETE ON student.afdelingen OR UPDATE of naam ON student.afdelingen
BEGIN
	IF USER = 'JANE' THEN
		IF DELETING THEN
			RAISE_APPLICATION_ERROR(-20007, 'Je hebt het recht niet om iets te verwijderen');
		ELSE
			RAISE_APPLICATION_ERROR(-20008, 'Je hebt het recht niet om de naam te wijzigen van de afdeling');
		END IF;
	END IF;
END;
/

--15. Pas de trigger uit stap 4 aan dat dit wèl mag voor medewerkers van afdeling 
--Hoofdkantoor.


--16. Maak een trigger op de tabel cursussen die enkel afgaat voor cursussen van het type 
--“DAT”. Er wordt een foutmelding gegeven wanneer de lengte meer dan 5 eenheden 
--wijzigt.

CREATE OR REPLACE TRIGGER aur_cursussen_dat
AFTER UPDATE of lengte
ON student.cursussen
FOR EACH ROW
WHEN (old.type = 'DAT')
BEGIN
	IF ABS(:NEW.lengte:OLD.lengte) > 5 THEN
		RAISE_APPLICATION_ERROR(-20009. 'lengte mag niet met meer dan 5 veranderd worden');
	END IF;
END;
/

--17. Zorg ervoor dat niemand een object kan aanmaken tijdens de nachtverwerking dit 
--loopt tussen 1 en 5 uur.

CREATE OR REPLACE TRIGGER bcs_nachtverwerking
BEFORE CREATE ON DATABASE
BEGIN
	IF TO_NUMBER(TO_CHAR(SYSDATE, 'hh24')) between 1 and 5 THEN
		RAISE_APPLICATION_ERROR(-20010, 'Je mag geen objecten aanmaken tussen 1u en 5u');
	END IF;
END;
/

