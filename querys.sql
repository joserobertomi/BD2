-- Aula 24/04/2025 

CREATE TABLE IF NOT EXISTS contato(
	id_contanto SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	empresa VARCHAR(30) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone VARCHAR(30) NULL,
	cargo VARCHAR(10) NOT NULL
);

ALTER TABLE contato RENAME id_contanto TO id_contato;
ALTER TABLE contato DROP column phone;

SELECT * FROM contato ORDER BY first_name;

CREATE TABLE IF NOT EXISTS telephone(
	id_telephone SERIAL PRIMARY KEY,
	phone CHARACTER(9) NOT NULL,
	ddd CHARACTER(2) NOT NULL,
	type_phone VARCHAR(50) NOT NULL,
	id_contato INT NOT NULL REFERENCES contato(id_contato)
);
