
-- Script corrigido com respostas às questões

-- Criação do banco
CREATE DATABASE Agenda_P;

-- Tabela pessoa
CREATE TABLE pessoa(
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(70),
  sexo CHAR(1) NOT NULL CHECK (sexo IN ('M', 'F')),
  datanascimento DATE,
  cpf VARCHAR(11),
  rg VARCHAR(10),
  tituloeleitoral VARCHAR(10),
  estadocivil CHAR(1) NOT NULL CHECK (estadocivil IN ('S', 'C'))
);

-- Inserções
INSERT INTO pessoa VALUES 
(1, 'Sebastiao Alves', 'M', '2000-02-25', '12312345678', '123', NULL, 'S'),
(2, 'Joaquim Camargo', 'M', '1985-01-14', '23456789123', '154', '15232145', 'C'),
(3, 'Fabiana Silva', 'F', '1990-09-01', '55588899977', '563', '12336511', 'S'),
(4, 'Carlos Antonio Souza', 'M', '1998-10-31', '36589741222', '665', '12548631', 'S'),
(5, 'Maria Aparecida Oliveira', 'F', '1995-11-08', '65899555233', '656', '65845565', 'S'),
(6, 'Ana Carla Silveira', 'F', '2002-03-16', '00122000588', '695', NULL, 'S'),
(7, 'Suzana Pires', 'F', '2005-08-23', '05987563200', '998', NULL, 'S'),
(8, 'Luiza Caldas', 'F', '1999-04-10', '98756214633', '898', NULL, 'S'),
(9, 'Aparecido Souza', 'M', '1989-07-15', '87512354899', '752', '598456651', 'C'),
(10, 'Rogerio da Silva e Souza', 'M', '2000-06-05', '00233647898', '515', '645255446', 'S');

-- Tabela cidade
CREATE TABLE cidade(
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(70) NOT NULL,
  estado CHAR(2) DEFAULT 'GO'
);

INSERT INTO cidade VALUES 
(1, 'Anápolis', 'GO'),
(2, 'Goiânia', 'GO'),
(3, 'Brasilia', 'DF'),
(4, 'Aparecida de Goiania', 'GO');

-- Tabela endereço
CREATE TABLE endereco (
  id INT NOT NULL PRIMARY KEY,
  rua VARCHAR(150),
  numero INT NOT NULL,
  complemento VARCHAR(50),
  bairro VARCHAR(40) NOT NULL,
  idcidade INT NOT NULL,
  idpessoa INT NOT NULL,
  tipo VARCHAR(20) NOT NULL,
  FOREIGN KEY (idcidade) REFERENCES cidade(id),
  FOREIGN KEY (idpessoa) REFERENCES pessoa(id)
);

INSERT INTO endereco VALUES 
(1, 'Rua 01', 0, 'qd 10 lt 01', 'centro', 1, 2, 'RESIDENCIAL'),
(2, 'Avenida Sem Nome', 89, NULL, 'Centro', 1, 9, 'RESIDENCIAL'),
(3, 'Rua 101', 15, NULL, 'Setor Sul', 2, 9, 'COMERCIAL'),
(4, 'SQN 15', 0, NULL, 'Esplanada', 3, 4, 'RESIDENCIAL'),
(5, NULL, 0, NULL, 'centro', 4, 5, 'RESIDENCIAL'),
(6, 'Rua A', 25, 'Qd 5 lt 14-A', 'centro', 3, 6, 'RESIDENCIAL'),
(7, 'Av. Goias', 1586, NULL, 'centro', 1, 8, 'RESIDENCIAL'),
(8, 'Av. 136', 795, 'Apto 205', 'centro', 2, 3, 'RESIDENCIAL');

-- Tabela telefone
CREATE TABLE telefone(
  id INT NOT NULL PRIMARY KEY, 
  ddd CHAR(2) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  tipo VARCHAR(15) NOT NULL,
  idpessoa INT NOT NULL,
  FOREIGN KEY (idpessoa) REFERENCES pessoa(id)
);

INSERT INTO telefone VALUES 
(1, '62', '32132132', 'RESIDENCIAL','1'),
(2, '62', '998751236', 'CELULAR','3'),
(3, '62', '33548956', 'COMERCIAL','9'),
(4, '62', '999915200', 'CELULAR','2'),
(5, '62', '998878564', 'CELULAR','1'),
(6, '62', '998758955', 'CELULAR','3'),
(7, '62', '39022215', 'RESIDENCIAL','5'),
(8, '61', '3897812', 'RESIDENCIAL','4'),
(9, '61', '30072654', 'RESIDENCIAL','6'),
(10, '61', '992156352', 'CELULAR','4'),
(11, '62', '998690000', 'CELULAR','7'),
(12, '62', '980018000', 'CELULAR','8'),
(13, '62', '40045212', 'COMERCIAL','9'),
(14, '62', '999121235', 'CELULAR','7'),
(15, '62', '998788989', 'CELULAR','8'),
(16, '62', '998653523', 'CELULAR','9'),
(17, '62', '998653523', 'CELULAR','10'),
(18, '62', '975898722', 'CELULAR','10'),
(19, '62', '32782562', 'RESIDENCIAL','10');

-- a. Quantas pessoas menores de idade existem no banco
-- Resposta: 0
SELECT COUNT(*) AS qtd_menores
FROM pessoa
WHERE AGE(CURRENT_DATE, datanascimento) < INTERVAL '18 years';

-- b. Quantos casados e quantos solteiros
-- Resposta: 2 casados e 8 solteiros
SELECT
  COUNT(*) FILTER (WHERE estadocivil = 'C') AS qtd_casados,
  COUNT(*) FILTER (WHERE estadocivil = 'S') AS qtd_solteiros
FROM pessoa;

-- c. Pessoas com mais de 16 anos e com título eleitoral
-- Resposta:
-- 2 – Joaquim Camargo
-- 3 – Fabiana Silva
-- 4 – Carlos Antonio Souza
-- 5 – Maria Aparecida Oliveira
-- 9 – Aparecido Souza
-- 10 – Rogerio da Silva e Souza
SELECT id, nome
FROM pessoa
WHERE AGE(CURRENT_DATE, datanascimento) > INTERVAL '16 years'
  AND tituloeleitoral IS NOT NULL;

-- d. Pessoas com mais de um endereço
-- Resposta: 9 – Aparecido Souza
SELECT p.id, p.nome
FROM pessoa p
JOIN endereco e ON p.id = e.idpessoa
GROUP BY p.id, p.nome
HAVING COUNT(e.id) > 1;

-- e. Pessoas sem endereço
-- Resposta:
-- 1 – Sebastiao Alves
-- 7 – Suzana Pires
-- 10 – Rogerio da Silva e Souza
SELECT p.id, p.nome
FROM pessoa p
LEFT JOIN endereco e ON p.id = e.idpessoa
WHERE e.id IS NULL;

-- f. Pessoas e seus telefones
SELECT p.nome, t.ddd, t.numero
FROM pessoa p
JOIN telefone t ON p.id = t.idpessoa;

-- g. Todos os dados de pessoa, seus endereços e telefones
SELECT p.*, e.rua, e.numero, e.bairro, e.tipo AS tipo_endereco,
       t.ddd, t.numero AS telefone, t.tipo AS tipo_telefone
FROM pessoa p
LEFT JOIN endereco e ON p.id = e.idpessoa
LEFT JOIN telefone t ON p.id = t.idpessoa;

-- h. Pessoas com mais de dois telefones
-- Resposta:
-- 9 – Aparecido Souza
-- 10 – Rogerio da Silva e Souza
SELECT p.nome, t.numero
FROM pessoa p
JOIN telefone t ON p.id = t.idpessoa
WHERE p.id IN (
  SELECT idpessoa
  FROM telefone
  GROUP BY idpessoa
  HAVING COUNT(*) > 2
);

-- i. Homens solteiros: nome e telefone
-- Resposta:
-- Sebastiao Alves, Carlos Antonio Souza, Rogerio da Silva e Souza
SELECT p.nome, t.numero
FROM pessoa p
JOIN telefone t ON p.id = t.idpessoa
WHERE p.sexo = 'M' AND p.estadocivil = 'S';

-- Mulheres solteiras: nome e nascimento
-- Resposta:
-- Fabiana Silva – 1990-09-01
-- Maria Aparecida Oliveira – 1995-11-08
-- Ana Carla Silveira – 2002-03-16
-- Suzana Pires – 2005-08-23
-- Luiza Caldas – 1999-04-10
SELECT nome, datanascimento
FROM pessoa
WHERE sexo = 'F' AND estadocivil = 'S';

-- j. Quantidade de endereços por cidade
-- Resposta esperada:
-- Anápolis – 2, Goiânia – 2, Brasília – 2, Aparecida de Goiania – 1
SELECT c.nome AS cidade, COUNT(e.id) AS total_enderecos
FROM cidade c
LEFT JOIN endereco e ON c.id = e.idcidade
GROUP BY c.id, c.nome;
