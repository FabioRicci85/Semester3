
--Oefeningen hoofdstuk 2
------------------------
--a)

create sequence seq_afdelingen
start with 50
increment by 10;

insert into afdelingen values (afd_seq.nextval, 'PRODUCTONTWIKKELING', 'HASSELT', 7566)
insert into afdelingen values (afd_seq.nextval, 'KLANTENSERVICE', 'GENK', 7698)

--b)

create sequence seq_hoofdkantoor
start with 1001
increment by 1
minvalue 1000
maxvalue 1999
nocycle;

create sequence seq_opleidingen
start with 2001
increment by 1
minvalue 2000
maxvalue 2999
nocycle;

create sequence seq_verkoop
start with 3001
increment by 1
minvalue 3000
maxvalue 3999
nocycle;

create sequence seq_personeelszaken
start with 4001
increment by 1
minvalue 4000
maxvalue 4999
nocycle;

create sequence seq_productontwikkeling
start with 5001
increment by 1
minvalue 5000
maxvalue 5999
nocycle;

create sequence seq_klantenservice
start with 6001
increment by 1
minvalue 6000
maxvalue 6999
nocycle;

Insert into medewerkers Values (seq_productontwikkeling.nextval, 'BOS', 'Pip', 'MANAGER', 7839, '1999-01-22', 3500, null, 50)
Insert into medewerkers Values (seq_productontwikkeling.nextval, 'VISSER', 'Lea', 'ONTWERPER', 5000, '2001-02-05', 3500, null, 50)
Insert into medewerkers Values (seq_productontwikkeling.nextval, 'SMIT', 'George', 'ONTWERPER', 5000, '2003-07-02', 3500, null, 50)


--c)

create sequence neg_num_seq
start with -100
increment by 2
minvalue -100
maxvalue 0

--d)

create sequence graad_1_seq
start with 1000
increment by 10
minvalue 1000
maxvalue 1990


create sequence graad_2_seq
start with 2000
increment by 10
minvalue 2000
maxvalue 2990


Insert into Cursussen values (graad_1_seq.nextval, 'Web Essentials', 'ALG', 2)
Insert into Cursussen values (graad_1_seq.nextval, 'Communication Skills', 'ALG', 1)
Insert into Cursussen values (graad_1_seq.nextval, 'C# Essentials', 'ALG', 2)
Insert into Cursussen values (1021, 'C# Essentials - Game Development', 'ALG', 3)
Insert into Cursussen values (1022, 'C# Essentials - UX', 'ALG', 1)
Insert into Cursussen values (graad_2_seq.nextval, 'Security and Privacy', 'ALG', 4)
Insert into Cursussen values (graad_2_seq.nextval, 'Data Advanced', 'ALG', 4)
Insert into Cursussen values (2011, 'Data Advanced - Distributed Data', 'ALG', 4)


--e)
Create sequence subsidie_seq
start with 10
incerement by 10
minvalue 10
maxvalue 60
cycle;


--Oefeningen Index
------------------

create index title_index
on imdb 
(title)

--a)
select * from imdb where title like 'You%';

--b)
select * from imdb where title like 'You%'
order by imdb_ranking;

--c)

create index filtering_index
on imdb
(release_date, original_language, imdb_ranking)

select * from imdb
where release_date between to_date('1994-01-01', 'YYYY-MM-DD') and to_date('1994-12-31', 'YYYY-MM-DD')
and original_language = 'fr';

--d)

create index verbeter_index
on imdb
(title, release_date, overview, imdb_ranking)
TABLESPACE index_demo;   -- 6 seconden sneller

--Oefeningen Synonym
--------------------

--a)
Create synonym AFD for AFDELINGEN
create synonym CRS for CURSUSSEN
create synonym INS for INSCHRIJVINGEN
create synonym MED for Medewerkers
create synonym SCH for Schalen
create synonym UIT for UITVOERINGEN

--b)

SELECT OWNER, SYNONYM_NAME, TABLE_OWNER, TABLE_NAME, DB_LINK
FROM ALL_SYNONYMS;

SELECT SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
FROM PUBLIC_SYNONYMS;

