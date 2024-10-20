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


--2. Maak een nieuwe gebruiker Sarah aan met paswoord Sarah123 en geef haar rechten om 
--in te loggen en tabellen aan te maken. Doe dit in 1 statement!


--3. Log in met gebruiker Sarah en maak onderstaande tabel aan:
--Vervangingen
-- - Medewerker (string 20 lang)
-- - VervangenDoor (string 20 lang)
-- - Datum (date)
--Werkt dit? Zo nee, waarom? Los dit probleem op!


--4. Maak een gebruiker AppTester (paswoord AppTester123) aan en geef deze leesrechten 
--op de medewerker tabel van de System account.


--5. Verwijder gebruikers Bert en Sarah.


--6. Log in met gebruiker AppTester en zorg dat deze volgende tabel kan aanmaken:
--Vervangingen
-- - Mnr (FK naar medewerkers)
-- - Vervanging (FK naar medewerkers)
-- - Datum (date)


--7. Maak een extra gebruiker aan AppTesterProxy met paswoord (Proxy123) en geef deze 
--volledige rechten op de tabel Vervangingen van gebruiker AppTester. Test uit of je de 
--tabel kan gebruiken.