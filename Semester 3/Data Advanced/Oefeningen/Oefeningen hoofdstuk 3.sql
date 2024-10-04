
--Oefeningen hoofdstuk 3: Triggers
----------------------------------

--1)

create of replace trigger bus_john_trigger
	Before Update of maandsal
	on student.Medewerkers
Begin
	if user == 'John' then
	raise_application_error(-2000,
	'Je hebt geen rechten om het maandsalaris van een medewerker te wijzigen!');
	end if;
End;

