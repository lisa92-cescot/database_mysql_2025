INSERT INTO moduli (nome, numero_ore, unita_formativa_id) VALUES
('Sicurezza Informatica', 25, 1),
('Analisi dei Dati', 30, 2),
('Cloud Computing', 20, 3);

SELECT * FROM moduli;
SELECT nome, numero_ore FROM moduli;

SELECT moduli.nome, unita_formative.nome FROM moduli 
JOIN unita_formative ON moduli.unita_formativa_id = unita_formative.id;

--estrarre tutti i corsisti (nome, cognome, data_di_nascita) 
--e il (nome) del modulo a cui sono iscritti

SELECT corsisti.nome, corsisti.cognome, corsisti.data_di_nascita, moduli.nome AS modulo_nome
FROM corsisti RIGHT JOIN iscrizioni ON corsisti.id = iscrizioni.corsista_id
JOIN moduli ON iscrizioni.modulo_id = moduli.id;    
--estrarre tutti i corsisti (nome, cognome, data_di_nascita)

/*
Laura | Esposito | 1985-01-01 | Introduzione a SQL
Laura | Esposito | 1985-01-01 | Programmazione Web Base
Marco | Rizzo | 1978-08-23 | Introduzione a SQL
Marco | Rizzo | 1978-08-23 | Database Avanzati
Giulia | Conti | 1995-04-15 | Gestione Progetto
Andrea | Gallo | 1980-12-01 | Database Avanzati
Andrea | Gallo | 1980-12-01 | Sviluppo Frontend
Sara | Ferrari | 1998-10-10 | Programmazione Web Base
Sara | Ferrari | 1998-10-10 | Gestione Progetto
*/

SELECT nome,cognome,localita_residenza FROM corsisti WHERE localita_residenza = 'Roma';
SELECT nome FROM moduli WHERE nome LIKE '%sql%';

SELECT data_di_nascita as dt_nascita FROM corsisti WHERE data_di_nascita < '1990-01-01';

--corsisti nati tra il 1980 e il 1990
SELECT nome, cognome, data_di_nascita FROM corsisti WHERE data_di_nascita 
BETWEEN '1980-01-01' AND '1990-12-31';
-- corsisti che sono tra id 1 e 3
SELECT nome, cognome FROM corsisti WHERE id IN (1,2,3);
SELECT nome, cognome FROM corsisti WHERE id BETWEEN 1 AND 3;
---corsisti di genere femminile residenti a Milano
SELECT nome, cognome FROM corsisti WHERE genere = 'F' AND localita_residenza = 'Milano';
--corsisti senza email
SELECT nome, cognome FROM corsisti WHERE email IS NULL;
--corsisti con il nome che termine con "a"
SELECT nome, cognome FROM corsisti WHERE nome LIKE '%a';
---corsisti che risiedono a Roma, Milano o Torino
SELECT nome, cognome, localita_residenza FROM corsisti WHERE localita_residenza = 'Roma' OR localita_residenza = 'Milano' 
OR localita_residenza = 'Torino';

SELECT nome, cognome, localita_residenza FROM corsisti WHERE genere = 'F' AND (localita_residenza = 'Roma' 
OR localita_residenza = 'Torino');

--sql injection su corsista
--la mia query:
SELECT nome, cognome FROM corsisti WHERE email = 'laura.esposito@mail.it'

SELECT nome, cognome FROM corsisti WHERE email = 'laura.esposito@mail.it' --' OR '1'='1';

SELECT nome, cognome FROM corsisti WHERE email NOT LIKE '%@gmail.com';
-----Operatori aritmetici

SELECT nome, costo_orario * numero_ore AS costo_totale FROM moduli;

--lezioni da 5 ore Numero:
SELECT nome, FLOOR(numero_ore / 4) AS ore_totali FROM moduli where id = 2;
--ultima lezione da ore Numero:
SELECT nome, numero_ore % 4 AS resto_divisione FROM moduli where id = 2;

-- mysql functions
SELECT CONCAT(nome, ' ', cognome) AS nome_completo, 
UPPER(nome) AS nome_maiuscolo, 
LOWER(cognome) AS cognome_minuscolo FROM corsisti;

SELECT UPPER(CONCAT(nome, ' ', cognome)) AS nome_completo FROM corsisti;
SELECT CONCAT_WS(' ', nome, cognome) AS nome_completo FROM corsisti;
SELECT CONCAT(nome, ' - ', cognome, ' - ', localita_residenza, ' - ', cap_residenza, ' - ', indirizzo_residenza) AS info_corsista FROM corsisti;
SELECT CONCAT_WS(' - ', nome, cognome, localita_residenza, cap_residenza, indirizzo_residenza) AS info_corsista FROM corsisti;

SELECT CONCAT_WS(' ', nome, cognome) AS nome_completo, TIMESTAMPDIFF(YEAR, data_di_nascita, CURDATE()) AS eta FROM corsisti;

SELECT * FROM corsisti WHERE TIMESTAMPDIFF(YEAR, data_di_nascita, CURDATE()) >= 40;

--1. considerando che nella tabella moduli c'è il campo numero_ore e che le lezioni durano 3 ore potresti fare apparire
-- il nome e a fianco il numero_lezioni

SELECT nome, CEIL(numero_ore / 3) AS numero_lezioni FROM moduli;


--2. considerando che sono concesse al massimo il 20% di assenze sul totale delle ore del modulo
-- potresti aggiungere alla query precedente (nome del modulo + numero_lezioni) il campo max_ore_assenza


SELECT nome, CEIL(numero_ore / 3) AS numero_lezioni,
FLOOR((numero_ore * 20) / 100) AS max_ore_assenza
FROM moduli;

--trovare la media del numero_ore dei moduli



SELECT AVG(numero_ore) AS media_ore FROM moduli;











