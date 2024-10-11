
--Oefeningen Triggers
---------------------
-- 1. Als John het maandsalaris van een medewerker wijzigt, moet de melding komen “Je hebt geen rechten om het maandsalaris van een medewerker te wijzigen!”. Iemand anders mag deze wijziging wel doorvoeren.
CREATE OR REPLACE TRIGGER bus_maandsal_john
BEFORE UPDATE OF maandsal ON student.medewerkers
BEGIN
	IF USER = 'JOHN' THEN
		RAISE_APPLICATION_ERROR(-20001,
		'Je hebt geen rechten om het maandsalaris van een medewerker te wijzigen!');
	END IF;
END;
/

Drop trigger bus_maandsal_john;

-- 2. Jane mag enkel een update doen van een maandsalaris tot een maximum van €3000. Geef een gepaste melding indien ze dit wel probeert en zorg dat er een rollback gebeurt van de transactie.
CREATE OR REPLACE TRIGGER bur_maandsal_jane
BEFORE UPDATE OF maandsal ON student.medewerkers
FOR EACH ROW
BEGIN
    IF USER = 'JANE' THEN
        IF :NEW.maandsal > 3000 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Je mag het maandsalaris niet boven €3000 verhogen!');
        END IF;
    END IF;
END;
/

drop trigger bur_maandsal_jane;

-- 3. Gebruiker John mag geen enkele schaal verwijderen!
CREATE OR REPLACE TRIGGER bds_schalen_john
BEFORE DELETE ON student.Schalen
BEGIN 
	IF USER = 'John' THEN
	RAISE_APPLICATION_ERROR(-20003, 'Je mag geen schalen verwijderen');
	END IF;
END;
/

drop trigger bds_schalen_john;


-- 4. Jane mag niet inloggen tussen 8u en 10u.
CREATE OR REPLACE TRIGGER jane_logon_tijd
AFTER LOGON ON DATABASE
BEGIN
    IF USER = 'JANE' THEN
        IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) BETWEEN 8 AND 9 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Je mag niet inloggen tussen 08:00 en 10:00 uur.');
        END IF;
    END IF;
END;
/


-- 5. John mag geen medewerkers verwijderen én mag geen maandsalaris wijzigen.

CREATE OR REPLACE TRIGGER bdus_john_trig
BEFORE DELETE OR UPDATE OF maandsal
ON student.medewerkers
BEGIN
	IF USER = 'JOHN' THEN
		IF DELETING THEN
			RAISE_APPLICATION_ERROR(-20005, 'Je hebt geen recht niet om medewerkers te verwijderen.');
		ELSE
			RAISE_APPLICATION_ERROR(-20005, 'Je hebt geen recht om het maandsalaris te verwijderen');
		END IF;
	END IF;
END;


-- 6. De commissie van een medewerker mag maximaal met 20% verhoogd worden.

CREATE OR REPLACE TRIGGER 

-- 7. Een object droppen mag enkel tussen 8u en 10u.



-- 8. Een nieuwe cursus mag enkel een lengte van 1 hebben èn wanneer een cursus wijzigt met de lengte maximaal met 3 stappen verhoogd of verlaagd worden. 
-- Foutmelding aanmaken: ORA-20000: Bij het aanmaken van een cursus moet de lengte 1 zijn! Foutmelding wijzigen: ORA-20001: 
-- Bij het wijzigen van een cursus mag de lengte max 3 eenheden verschillen! (huidig: 1 nieuw: 5)