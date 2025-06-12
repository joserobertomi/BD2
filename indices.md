### Introdução aos Índices em Banco de Dados

Esta apresentação aborda os conceitos fundamentais de índices em bancos de dados, suas diferentes classificações e como eles otimizam o acesso e a manipulação de dados.

#### Objetivos
O principal objetivo é apresentar os conceitos de índices, incluindo:
* [cite_start]Índices primários [cite: 2]
* [cite_start]Índices secundários [cite: 2]
* [cite_start]Índices compostos [cite: 2]

#### Árvores Binárias
Árvores binárias são estruturas de dados onde cada nó tem no máximo dois filhos e armazena uma chave, ponteiros para o pai, filho esquerdo e filho direito. [cite_start]Nelas, as chaves na subárvore esquerda de um nó $x$ são menores ou iguais a $chave[x]$, e as chaves na subárvore direita são maiores que $chave[x]$. [cite: 3]
[cite_start]As árvores binárias implementam operações como busca, mínimo, máximo, predecessor, sucessor, inserção e deleção em $O(h)$, onde $h$ é a altura da árvore. [cite: 4] [cite_start]Uma árvore binária é considerada balanceada (Árvore AVL) se a altura de suas subárvores difere em no máximo 1 para cada nó. [cite: 5]

#### Árvores B
[cite_start]Árvores B são uma generalização das árvores binárias de busca, permitindo que um nó contenha mais de uma chave e mais de duas ramificações. [cite: 6] [cite_start]Elas são estruturas de dados otimizadas para armazenamento externo, essenciais quando o conjunto de chaves é grande demais para ser mantido na memória principal. [cite: 6] [cite_start]O modelo de custos para Árvores B é baseado na quantidade de acessos ao armazenamento externo (modelo I/O de computação). [cite: 6]

#### Conceitos de Índices
[cite_start]Um índice é uma estrutura de dados que recebe uma propriedade de registros e encontra rapidamente os registros que satisfazem essa propriedade. [cite: 27] [cite_start]Apenas uma fração dos registros no sistema de armazenamento é consultada. [cite: 28]

Os índices têm as seguintes finalidades:
* [cite_start]Estabelecer a ligação lógica entre blocos que compõem um arquivo que representa uma relação. [cite: 29]
* [cite_start]Manter arquivos de dados ordenados. [cite: 30]
* [cite_start]Implementar restrições de integridade (como PRIMARY KEY, FOREIGN KEY, UNIQUE). [cite: 30]
* [cite_start]Acelerar a execução de consultas. [cite: 31]
* [cite_start]Implementar estratégias para processamento de transações. [cite: 31]

**Elementos de um Índice:**
* [cite_start]**Chave de busca:** Um ou mais campos do arquivo indexado sobre os quais um índice é definido. [cite: 32]
* [cite_start]**Ponteiros:** Associados às chaves no índice, representados por RIDs (identificador da página e entrada na tabela de offsets). [cite: 33]
* [cite_start]**Arquivo de dados (Heap):** Representação de uma relação do banco de dados com registros organizados sem uma ordem definida. [cite: 34, 35]
* [cite_start]**Arquivo de índice:** Conjunto de pares formados por chaves e ponteiros. [cite: 35]
* [cite_start]**Arquivo sequencial:** Arquivo de dados logicamente ordenado pela ordenação das chaves de um índice associado. [cite: 36]

#### Tipos de Índices
* [cite_start]**Índices Primários:** Índices cuja chave de busca define a ordem do arquivo sequencial. [cite: 37]
    * [cite_start]**Índices agrupados (clustering indexes):** A ordenação lógica dos registros no arquivo sequencial é a mesma do arquivo de índice. [cite: 37, 46]
    * [cite_start]Pode existir apenas um índice primário sobre uma relação. [cite: 54]
    * [cite_start]Podem ser densos ou esparsos. [cite: 55]
    * [cite_start]Quando um índice primário é criado, a ordenação física e lógica coincidem, mas inserções e modificações podem criar blocos de overflow, degradando o agrupamento físico dos dados. [cite: 50, 51, 52]

* [cite_start]**Índices Primários Densos:** Possuem uma entrada no arquivo de índices para cada registro do arquivo de dados. [cite: 38] [cite_start]Dispensam buscas sequenciais dentro de blocos para consultas pontuais e podem cobrir certas consultas. [cite: 66, 67]

* [cite_start]**Índices Primários Esparsos:** Possuem uma entrada no arquivo de índices para cada bloco do arquivo de dados. [cite: 39] [cite_start]Tipicamente, armazenam apenas o valor da chave de busca do primeiro registro de cada bloco, junto com um ponteiro para ele ou para o bloco. [cite: 63] [cite_start]São consideravelmente menores que índices densos, o que pode evitar operações de I/O e melhorar a performance para certas consultas. [cite: 68, 69, 70]

* [cite_start]**Índices Secundários:** Índices cuja chave de busca define uma ordem diferente da ordem do arquivo sequencial. [cite: 37]
    * [cite_start]**Índices não agrupados (nonclustering indexes):** Não determinam a organização do arquivo de dados indexado. [cite: 37, 72]
    * [cite_start]Heaps e arquivos sequenciais podem ser indexados por índices secundários. [cite: 73]
    * [cite_start]Vários índices secundários podem ser definidos sobre uma mesma relação. [cite: 74]
    * [cite_start]Índices secundários são sempre densos. [cite: 74]
    * Para consultas multi-pontuais e baseadas em intervalos, índices primários são mais vantajosos. [cite_start]Acessos usando índices secundários podem resultar em acessos randômicos ao disco. [cite: 76, 77] [cite_start]No entanto, para consultas pontuais, primários e secundários têm o mesmo desempenho. [cite: 79]

* [cite_start]**Índices Compostos:** Índices definidos sobre mais de um campo do arquivo indexado, possuindo múltiplas chaves de busca. [cite: 41, 81] [cite_start]A ordem das chaves na definição do índice determina a ordem do arquivo de índice. [cite: 82] [cite_start]Podem ser primários ou secundários. [cite: 83] [cite_start]São elegíveis para consultas onde o conjunto de atributos na condição da consulta constitui um prefixo da sequência de chaves de busca do índice. [cite: 87] [cite_start]São frequentemente usados para cobrir consultas executadas com frequência. [cite: 88] [cite_start]A ordem dos atributos é importante para o desempenho do índice. [cite: 89] [cite_start]Índices compostos são maiores que índices simples, e atualizações em qualquer atributo indexado requerem a atualização do índice. [cite: 91]

#### Criação de Índices (Exemplo SQL)
A sintaxe `CREATE INDEX` é utilizada para criar índices. Por exemplo:
[cite_start]`CREATE INDEX title_idx ON films (title);` [cite: 71]
[cite_start]Métodos de indexação incluem `btree`, `hash`, `gist` e `gin`, sendo `btree` o método padrão. [cite: 71]