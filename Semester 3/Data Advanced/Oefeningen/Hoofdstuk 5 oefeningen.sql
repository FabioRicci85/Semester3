--oefeningen PL/SQL

--oefening 1
------------

CREATE TRIGGER ais_count_medewerkers
AFTER INSERT ON student.medewerkers
DECLARE
	l_aantal pls_integer;
BEGIN
	SELECT COUNT(*) INTO l_aantal FROM student.medewerkers;
	dbms_output.put_line('Het aantal medewerkers is nu ' || l_aantal);
END;
/

insert into medewerkers values(7999,'RICCI','FABIO','TRAINER',7902,'17-DEC-1985',2300,NULL,20);

--oefening 2
------------

CREATE TRIGGER bis_check_leeftijd_trigger
BEFORE INSERT ON student.medewerkers
DECLARE
	l_leeftijd pls_integer;
BEGIN
	l_leeftijd := FLOOR(MONTHS_BETWEEN(SYSDATE, :NEW.GBDATUM) / 12);
	
	IF l_leeftijd > 18 THEN
		dbms_output.put_line('De medewerker is ouder dan 18 jaar');
	ELSE
		dbms_output.put_line('De medewerker is niet ouder dan 18 jaar');
	END IF;
END;
/

--oefeningen 3
--------------





--4. Schrijf een PL/SQL-script dat een overzicht maakt van het aantal medewerkers voor elk departement (afd) 
--in de tabel "medewerkers". Het script moet het aantal medewerkers per departement weergeven met behulp van 
--DBMS_OUTPUT.PUT_LINE(). Druk de volgende regel af per afdeling: ‘Aantal medewerkers in afdeling 
--{departement naam}: {aantal medewerkers per departement}’

DECLARE
	CURSOR a_afd is Select afd from student.afdelingen;
	count_mdw pls_integer;
	a_departement student.afdelingen.anr%TYPE;
BEGIN
	FOR afdelingen IN a_afd LOOP
	
	a_departement = afdeling.anr;
	
	SELECT COUNT(*) INTO count_mdw FROM student.medewerkers WHERE anr = a_departement;

	DBMS_OUTPUT.PUT_LINE('In de afdeling '|| a_departement || ' zijn er '|| count_mdw || ' aanwezig.'); 
END;
/