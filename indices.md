# Introdução aos Índices em Banco de Dados

Esta apresentação aborda os conceitos fundamentais de índices em bancos de dados, suas diferentes classificações e como eles otimizam o acesso e a manipulação de dados.

## Objetivos

O principal objetivo é apresentar os conceitos de índices, incluindo:

* Índices primários
* Índices secundários
* Índices compostos

## Árvores Binárias

Árvores binárias são estruturas de dados onde cada nó tem no máximo dois filhos e armazena uma chave, ponteiros para o pai, filho esquerdo e filho direito. Nelas, as chaves na subárvore esquerda de um nó $x$ são menores ou iguais a $chave[x]$, e as chaves na subárvore direita são maiores que $chave[x]$.
As árvores binárias implementam operações como busca, mínimo, máximo, predecessor, sucessor, inserção e deleção em $O(h)$, onde $h$ é a altura da árvore. Uma árvore binária é considerada balanceada (Árvore AVL) se a altura de suas subárvores difere em no máximo 1 para cada nó.

## Árvores B

Árvores B são uma generalização das árvores binárias de busca, permitindo que um nó contenha mais de uma chave e mais de duas ramificações. Elas são estruturas de dados otimizadas para armazenamento externo, essenciais quando o conjunto de chaves é grande demais para ser mantido na memória principal. O modelo de custos para Árvores B é baseado na quantidade de acessos ao armazenamento externo (modelo I/O de computação).

## Conceitos de Índices

Um índice é uma estrutura de dados que recebe uma propriedade de registros e encontra rapidamente os registros que satisfazem essa propriedade. Apenas uma fração dos registros no sistema de armazenamento é consultada.

Os índices têm as seguintes finalidades:

* Estabelecer a ligação lógica entre blocos que compõem um arquivo que representa uma relação.
* Manter arquivos de dados ordenados.
* Implementar restrições de integridade (como PRIMARY KEY, FOREIGN KEY, UNIQUE).
* Acelerar a execução de consultas.
* Implementar estratégias para processamento de transações.

**Elementos de um Índice:**

* **Chave de busca:** Um ou mais campos do arquivo indexado sobre os quais um índice é definido.
* **Ponteiros:** Associados às chaves no índice, representados por RIDs (identificador da página e entrada na tabela de offsets).
* **Arquivo de dados (Heap):** Representação de uma relação do banco de dados com registros organizados sem uma ordem definida.
* **Arquivo de índice:** Conjunto de pares formados por chaves e ponteiros.
* **Arquivo sequencial:** Arquivo de dados logicamente ordenado pela ordenação das chaves de um índice associado.

## Tipos de Índices

* **Índices Primários:** Índices cuja chave de busca define a ordem do arquivo sequencial.
  * **Índices agrupados (clustering indexes):** A ordenação lógica dos registros no arquivo sequencial é a mesma do arquivo de índice.
  * Pode existir apenas um índice primário sobre uma relação.
  * Podem ser densos ou esparsos.
  * Quando um índice primário é criado, a ordenação física e lógica coincidem, mas inserções e modificações podem criar blocos de overflow, degradando o agrupamento físico dos dados.

* **Índices Primários Densos:** Possuem uma entrada no arquivo de índices para cada registro do arquivo de dados. Dispensam buscas sequenciais dentro de blocos para consultas pontuais e podem cobrir certas consultas.

* **Índices Primários Esparsos:** Possuem uma entrada no arquivo de índices para cada bloco do arquivo de dados. Tipicamente, armazenam apenas o valor da chave de busca do primeiro registro de cada bloco, junto com um ponteiro para ele ou para o bloco. São consideravelmente menores que índices densos, o que pode evitar operações de I/O e melhorar a performance para certas consultas.

* **Índices Secundários:** Índices cuja chave de busca define uma ordem diferente da ordem do arquivo sequencial.
  * **Índices não agrupados (nonclustering indexes):** Não determinam a organização do arquivo de dados indexado.
  * Heaps e arquivos sequenciais podem ser indexados por índices secundários.
  * Vários índices secundários podem ser definidos sobre uma mesma relação.
  * Índices secundários são sempre densos.
  * Para consultas multi-pontuais e baseadas em intervalos, índices primários são mais vantajosos. Acessos usando índices secundários podem resultar em acessos randômicos ao disco. No entanto, para consultas pontuais, primários e secundários têm o mesmo desempenho.

* **Índices Compostos:** Índices definidos sobre mais de um campo do arquivo indexado, possuindo múltiplas chaves de busca. A ordem das chaves na definição do índice determina a ordem do arquivo de índice. Podem ser primários ou secundários. São elegíveis para consultas onde o conjunto de atributos na condição da consulta constitui um prefixo da sequência de chaves de busca do índice. São frequentemente usados para cobrir consultas executadas com frequência. A ordem dos atributos é importante para o desempenho do índice. Índices compostos são maiores que índices simples, e atualizações em qualquer atributo indexado requerem a atualização do índice.

## Criação de Índices (Exemplo SQL)

A sintaxe `CREATE INDEX` é utilizada para criar índices. Por exemplo:
`CREATE INDEX title_idx ON films (title);`
Métodos de indexação incluem `btree`, `hash`, `gist` e `gin`, sendo `btree` o método padrão.
