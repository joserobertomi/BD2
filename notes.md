**Cheat Sheet de SQL**
---

### 📊 **Funções de Agregação**

| Função                  | Descrição                                 | Exemplo                                                      |
| ----------------------- | ----------------------------------------- | ------------------------------------------------------------ |
| `COUNT(*)`              | Conta o total de linhas                   | `SELECT COUNT(*) FROM pessoa;`                               |
| `COUNT(*) FILTER (...)` | Conta condicional (SQL padrão/PostgreSQL) | `COUNT(*) FILTER (WHERE estadocivil = 'S') AS qtd_solteiros` |
| `COUNT(coluna)`         | Conta os valores não nulos da coluna      | `COUNT(e.id)`                                                |

---

### ⏳ **Funções de Data**

| Função              | Descrição                            | Exemplo                             |
| ------------------- | ------------------------------------ | ----------------------------------- |
| `AGE(data1, data2)` | Retorna a diferença entre duas datas | `AGE(CURRENT_DATE, datanascimento)` |
| `INTERVAL 'x unit'` | Define um intervalo de tempo         | `INTERVAL '18 years'`               |

---

### 🧮 **Filtros e Condições**

| Operador / Cláusula | Descrição                      | Exemplo                                             |
| ------------------- | ------------------------------ | --------------------------------------------------- |
| `WHERE ...`         | Filtro para linhas             | `WHERE sexo = 'F'`                                  |
| `AND`, `OR`         | Combinações lógicas            | `WHERE p.sexo = 'M' AND p.estadocivil = 'S'`        |
| `IS NOT NULL`       | Verifica se o campo não é nulo | `WHERE tituloeleitoral IS NOT NULL`                 |
| `IN (SELECT ...)`   | Filtro baseado em subquery     | `WHERE p.id IN (SELECT idpessoa FROM telefone ...)` |

---

### 🔗 **Joins**

| Tipo de Join             | Descrição                                                | Exemplo                                     |
| ------------------------ | -------------------------------------------------------- | ------------------------------------------- |
| `JOIN` (ou `INNER JOIN`) | Retorna apenas registros que combinam em ambas tabelas   | `JOIN telefone t ON p.id = t.idpessoa`      |
| `LEFT JOIN`              | Retorna todos da esquerda, mesmo que sem correspondência | `LEFT JOIN endereco e ON p.id = e.idpessoa` |

---

### 📦 **Cláusulas de Agrupamento**

| Cláusula   | Descrição                                    | Exemplo                 |
| ---------- | -------------------------------------------- | ----------------------- |
| `GROUP BY` | Agrupa os resultados por uma ou mais colunas | `GROUP BY p.id, p.nome` |
| `HAVING`   | Filtro após agregação                        | `HAVING COUNT(*) > 2`   |

---

### 📐 **Seleção e Aliases**

| Elemento              | Descrição                                       | Exemplo                          |
| --------------------- | ----------------------------------------------- | -------------------------------- |
| `SELECT col AS alias` | Renomeia a coluna de resultado                  | `SELECT COUNT(*) AS qtd_menores` |
| `tabela.coluna`       | Refere-se a uma coluna específica de uma tabela | `p.nome`, `t.numero`             |
| `*`                   | Seleciona todas as colunas                      | `SELECT * FROM pessoa`           |

---

### 📋 **Subqueries**

| Tipo                  | Descrição                          | Exemplo                                             |
| --------------------- | ---------------------------------- | --------------------------------------------------- |
| Subquery em `IN`      | Lista de valores para filtrar      | `WHERE p.id IN (SELECT idpessoa FROM telefone ...)` |
| Subquery com `HAVING` | Filtra os grupos agregados (como se fosse um WHERE após o GROUP BY) | `HAVING COUNT(*) > 2`                               |

---

### Exemplo

```sql
SELECT p.nome, COUNT(*) AS qtd_telefones
FROM pessoa p
JOIN telefone t ON p.id = t.idpessoa
WHERE p.sexo = 'F'
GROUP BY p.id, p.nome
HAVING COUNT(*) > 1
ORDER BY qtd_telefones DESC;
```
