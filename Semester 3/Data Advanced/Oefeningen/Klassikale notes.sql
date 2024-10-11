CREATE OR REPLACE TRIGGER bdus_mdw
BEFORE DELETE
OR UPDATE OF maandsal
ON medewerkers
BEGIN
IF USER != 'JAN' THEN
IF DELETING THEN
RAISE_APPLICATION_ERROR(
-20000,
‘U heeft geen rechten om te verwijderen’);
ELSE
RAISE_APPLICATION_ERROR(
-20001,
‘U heeft geen rechten om het
maandsal te wijzigen’);
END IF;
END IF;
END;



CREATE OR REPLACE TRIGGER aur_mdw_maandsal
	AFTER UPDATE OF maandsal
	ON medewerkers
	FOR EACH ROW
BEGIN
	IF(:NEW.maandsal-:OLD.maandsal> 0.1 * :OLD.maandsal)THEN
		RAISE_APPLICATION_ERROR(-20000, ‘ Maandsal te veel verhoogd’);
	END IF;
END;



CREATE OR REPLACE TRIGGER before_create_trigger
	BEFORE CREATE
	ON schema
BEGIN
	IF to_number to_char (sysdate,’hh24’)) not between 8 and 12 THEN
	RAISE_APPLICATION_ERROR(-20000,
		‘U mag enkel creëren tussen 8 en 12 u’);
	END IF;
END;





CREATE TABLE ddl_log (operation VARCHAR2(30), obj_owner VARCHAR2(30),
object_name VARCHAR2(30), attempt_by VARCHAR2(30), attempt_dt DATE);

CREATE OR REPLACE TRIGGER after_ddl_trigger
	AFTER DDL
	ON schema
BEGIN
	INSERT INTO ddl_log
	SELECT ora_sysevent , ora_dict_obj_owner , ora_dict_obj_name , USER,
	SYSDATE
	FROM DUAL;
END;