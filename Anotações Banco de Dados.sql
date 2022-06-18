/* ESSE ARQUIVO É APENAS PARA ANOTAÇÕES E EXEPLOS DE SCRIPTS EM MYSQL*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*CRIAR BANCO DE DADOS*/
CREATE DATABASE escola; /*Criar banco de dados*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*USAR BANCO DE DADOS*/
USE escola;  /*Usar banco de dados*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*CREATE TABLE (com algumas coisa a mais)*/

CREATE TABLE Aluno ( /*Criar tabela*/
Ra INT NOT NULL AUTO_INCREMENT, /* Auto_Increment é para o valor se incrementar sozinho no banco, sem ter a necessidade de inserir valor nesse campo */
NomeAluno VARCHAR(250) NOT NULL, /* Not null é para restringir para que o valor seja obrigatoriamente inserido*/
SexoAluno CHAR(1) NOT NULL,
CONSTRAINT Pk_Ra PRIMARY KEY(Ra), /*Constraint é uma restrição, nesse caso a restrição é dizer que tal campo é uma chave primária*/
CONSTRAINT Ck_SexoAluno CHECK (SexoAluno IN('F','M')) /* Check é uma restrição de checagem, ou seja, vai checar se no campo sexoAluno está com F ou M*/
);

CREATE TABLE Turma( /*Constraint de DEFAULT indica que o valor padrão para aquele campo está dentro das aspaas, ou seja, se ninguém inserir dados ali, o valor que vai ficar no campo é o que está padronizado dentro das aspas*/ 
NumeroTurma INT NOT NULL AUTO_INCREMENT,
DataInicioTurma DATE NOT NULL DEFAULT '2022-02-5',
DataTerminoTurma DATE NOT NULL,
CONSTRAINT PK_NumeroTurma PRIMARY KEY (NumeroTurma)
);

CREATE TABLE Professor( /*Constraint de UNIQUE indica que aquele valor é único e não pode se repetir, é similar a chavé primária, entretanto podemos ter varias constraint de UNIQUE dentro de uma mesma tabela*/
MatriculaProfessor INT NOT NULL AUTO_INCREMENT,
NomeProfessor VARCHAR(250) NOT NULL,
CPF VARCHAR (12) NOT NULL,
RG VARCHAR (16) NOT NULL,
CONSTRAINT UQ_CPF UNIQUE(CPF) ,
CONSTRAINT UQ_RG UNIQUE (RG)
);

CREATE TABLE Disciplina(
CodigoDisciplina INT NOT NULL AUTO_INCREMENT,
NomeDisciplina VARCHAR(50) NOT NULL
);

CREATE TABLE Matricula( /*Constraint de chave estrangera, é a constraint que vai ligar as tabelas e references é a tabela no qual aquela chave estrangeira está como chave primaria*/
NumeroMatricula INT NOT NULL AUTO_INCREMENT, 
DataMatricula DATE NOT NULL,
DataCancelamentoMatricula DATE NOT NULL,
Ra INT NOT NULL,
NumeroTurma INT NOT NULL,
CONSTRAINT Pk_NumeroMatricula PRIMARY KEY(NumeroMatricula), 
CONSTRAINT Ce_ Ra FOREIGN KEY(Ra) REFERENCES Aluno(Ra), /*constraint > nome da constraint > FOREIGN KEY > (campo que vai ser chave estrangeira) > REFERENCES > tabela que a chave estrangeira está como chave primária > campo que é a chave primária da outra tabela*/
CONSTRAINT Ce_NumeroTurma FOREIGN KEY(NumeroTurma) REFERENCES Turma(NumeroTurma)
);

CREATE TABLE Oferecida(
NumeroDisciplinaOferecida INT NOT NULL AUTO_INCREMENT, 
Sala INT NOT NULL, 
Bloco INT NOT NULL, 
MatriculaProfessor INT NOT NULL,
NumeroTurma INT NOT NULL,
CodigoDisciplina INT NOT NULL,
CONSTRAINT Pk_NumeroDisciplinaOferecida PRIMARY KEY(NumeroDisciplinaOferecida),
CONSTRAINT Ce_MatriculaProfessor FOREIGN KEY(MatriculaProfessor) REFERENCES Professor(MatriculaProfessor),
CONSTRAINT Ce_NumeroTurma FOREIGN KEY(NumeroTurma) REFERENCES Turma(NumeroTurma), 
CONSTRAINT Ce_CodigoDisciplina FOREIGN KEY(CodigoDisciplina) REFERENCES Disciplina(CodigoDisciplina)
);

CREATE TABLE AlunoAvaliado( /* Decimal é um número decimal, nesse caso DECIMAL (10,2) se aplica com 10 números antes da vírgula e 2 depois da vírgula*/
Ra INT NOT NULL, 
NumeroDisciplinaOferecida INT NOT NULL, 
A1 DECIMAL (10,2), 
A2 DECIMAL (10,2),
AF DECIMAL (10,2),
CONSTRAINT Pk_Ra_NumeroDisciplinaOferecida PRIMARY KEY(Ra,NumeroDisciplinaOferecida),
CONSTRAINT Fk_Ra FOREIGN KEY (Ra) REFERENCES Aluno(Ra),
CONSTRAINT Fk_NumeroDisciplinaOferecida FOREIGN KEY(NumeroDisciplinaOferecida) REFERENCES Oferecida(NumeroDisciplinaOferecida)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*CONSTRAINT DE PRIMARY KEY(VALOR ÚNICO E NÃO PODE SE REPETIR NO CAMPO, SÓ PODE TER UMA CHAVE PRIMÁRIA POR TABELA)*/
CONSTRAINT NomeDaConstraint PRIMARY KEY (CampoQueVaiSerAPrimaryKey)
CONSTRAINT PK_PESSOA PRIMARY KEY (COD_PESSOA)

/*CONSTRAINT FOREIGN KEY (CHAVE ESTRANGEIRA, É A CHAVE QUE VAI INTERLIGAR AS TABELAS, A CHAVE ESTRANGEIRA TEM QUE SER CHAVE PRIMÁRIA EM OUTRA TABELA*/
CONSTRAINT NomeDaConstraint FOREIGN KEY(CampoQueVaiSerAForeignKey) REFERENCES NomeDaTabelaQueAForeignKeyFazReferencia(CampoQueAForeignKeyFazReferenciaNaTabelaReferenciada),
CONSTRAINT Ce_NumeroTurma FOREIGN KEY(NumeroTurma) REFERENCES Turma(NumeroTurma), 
CONSTRAINT Ce_CodigoDisciplina FOREIGN KEY(CodigoDisciplina) REFERENCES Disciplina(CodigoDisciplina)

/*CONSTRAINT DE UNIQUE (VALOR ÚNICO PARA O CAMPO, SEMILAR A CHAVE ESTRANGEIRA, ENTRETANTO PODE TER VÁRIAS CONSTRAINTS DE UNIQUE NA MESMA TABELA)*/
CONSTRAINT NomeDaConstraint UNIQUE (CampoQueDesejaQueSejaUnico),
CONSTRAINT UQ_PESSOA_RG UNIQUE (RG_PESSOA),
CONSTRAINT UQ_PESSOA_EMAIL UNIQUE (EMAIL_PESSOA)

/*CONSTRAINT DE CHECK(CHECAGEM AUTOMÁTICA PARA SÓ PERMITIR VALORES NO CAMPO QUE ESTÃO DENTRO DA CONSTRAINT CHECK)*/
CONSTRAINT NomeDaConstraint CHECK (CampoQueDesejaQueSejaChecado IN (‘ValoresQuePodereãoSerInseridos’,’ValoresQuePodereãoSerInseridos’)),
CONSTRAINT CK_PESSOA_ATIVO CHECK (IDF_ATIVO IN (‘S’,’N’))

/*CONSTRAINT DEFAULT (CASO NINGUÉM INSIRA VALORES DENTRO DOS CAMPOS, VAI SER INSERIDO AUTOMÁTICAMENTE O VALOR DENTRO DAS ASPAS DO DEFAULT)*/
CampoQueDesejaQueSejaPadronizado DATE NOT NULL DEFAULT ‘1800-01-01’, /*O default não é feito seguido de constraint, ele é feito na linha de código do campo*/
IDF_ATIVO VARCHAR(1) NOT NULL DEFAULT ‘S’,

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*ALTER TABLE MYSQL*/

/*ADIÇÃO DE CAMPOS DEPOIS QUE A TABLEA ESTÁ FEITA, PARA NÃO TER A NECESSIDADE DE APAGALÁ E REFAZER DE NOVO*/
ALTER TABLE TESTE.PESSOA ADD NOM_DA_MAE VARCHAR(150);

/*FORMA DE RENOMEAR COLUNA*/
ALTER TABLE TESTE.PESSOA CHANGE COLUMN NOM_DA_MAE NOM_MAE VARCHAR(150) NOT NULL;

/*FORMA DE ALTERAR O TAMANHO DA ISERÇÃOI DE DADOS, EXEMPLO: DE VARCHAR(90) PARA VARCHAR(20) */
ALTER TABLE TESTE.PESSOA MODIFY COLUMN IDF_ATIVO VARCHAR(1) ;

/*FORMA DE APAGAR CAMPOS*/
ALTER TABLE TESTE.PESSOA DROP COLUMN NOM_MAE;

/*FORMA DE RENOMEAR TABELA*/
ALTER TABLE TESTE.PESSOA RENAME TESTE.CLIENTE;

/*FORMA DE ADICIONAR CONSTRAINT(PODE SER QUALQUER TIPO DE CONSTRAINT)*/
ALTER TABLE Cliente ADD CONSTRAINT uqClienteCPF UNIQUE (CPF);

/*ALTER TABLE SQL SERVER*/
ALTER TABLE Cliente ADD Nome varchar(30) NOT NULL
ALTER TABLE Cliente ADD SobreNome varchar(30) NOT NULL
ALTER TABLE Cliente ALTER COLUMN Nome varchar(50) NULL
ALTER TABLE Cliente DROP COLUMN SobreNome
ALTER TABLE Cliente ADD CONSTRAINT uqClienteCPF UNIQUE (CPF)

/*ALTER TABLE ORACLE/POSTGREE*/
ALTER TABLE PESSOA ADD NOM_DA_MAE VARCHAR2(150);
ALTER TABLE PESSOA MODIFY COLUMN NOM_DA_MAE NOT NULL;
ALTER TABLE PESSOA MODIFY COLUMN NOM_DA_MAE VARCHAR2(250) NOT NULL;
ALTER TABLE PESSOA RENAME COLUMN NOM_DA_MAE TO NOM_MAE ;
ALTER TABLE PESSOA DROP COLUMN NOM_MAE;
ALTER TABLE PESSOA RENAME TO PESSOAS;
ALTER TABLE PESSOAS RENAME TO PESSOA

/*ALTER TABLE FIREBIRD*/
ALTER TABLE CLIENTE ADD NOM_DA_MAE VARCHAR(150);
ALTER TABLE CLIENTE CHANGE COLUMN 
NOM_DA_MAE NOM_MAE VARCHAR(150) NOT NULL;
ALTER TABLE CLIENTE ALTER COLUMN IDF_ATIVO VARCHAR(1) DEFAULT ‘S’;
ALTER TABLE CLIENTE ALTER 
NOM_MAE NOM_DA_MAE VARCHAR(150) NOT NULL;
ALTER TABLE CLIENTE DROP COLUMN NOM_MAE;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*DROP TABLE*/

/*Exclui a estrutura de uma tabela do banco de dados. Obs: Se uma tabela for referenciada (tiver filhos), não ser poss vel exclu -la sem antes apagar as filhas.*/
/*Sintaxe: DROP TABLE [IF EXISTS] <NOME-DA-TABELA>;*/
 DROP TABLE IF EXISTS PROGRAMA;

 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*INSERT*/
/*A ORDEM DA INSERÇÃO DE DADOS TEM QUE SER DE ACORDO COM A ORDEM DA CRIAÇÃO DA TABELA*/

INSERT INTO NomeDaTabela(
CAMPO1,
CAMPO2,
CAMPO3
)VALUES(
1,
'RAFAEL', /*Inserção de String tem que estar entre aspas(símples ou duplas)*/
'2022-05-15'/*Inserção de DATE tem que estar entre aspas(símples ou duplas)*/
);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*SELECT (não vou colocar todos os selects, são muitos existentes)*/
/*
Cláusula       Expressão                            Descrição
SELECT      <lista de seleção>          Quais colunas (atributos) serão devolvidos.
FROM        <tabela de origem>          Tabelas envolvidas na consulta.
WHERE       <condição da pesquisa>      Filtra as linhas (tuplas) desejadas.
GROUP BY    <lista de grupos>           Agrupa as linhas por grupos.
HAVING      <condição do agrupamento>   Filtra as linhas pelo agrupamento.
ORDER BY    <ordem da lista>            Ordena a resposta da consulta
*/
SELECT * FROM NomeDaTabela;

SELECT DISTINCT NomeDoCampo FROM NomeDaTabela; /*Para selecionar somente os NomeDoCampo distintos: usar DISTINCT, não vai trazer valores iguais desse campo*/

SELECT * FROM NomeDaTabela WHERE NomeDoCampo = DeterminadoValor;

SELECT * FROM clientes AS nome_temporario_da_tabela; /*Renomeia temporariamente a tabela, o nome fica válido apenas nas consultas, posteriormente volta ao nome normal*/

SELECT UPPER( nome ) FROM clientes; /*Coloca os dados de nome em maiúsculo*/

SELECT LOWER( nome ) FROM clientes; /*Coloca os dados de nome em minúsculo*/

SELECT Sexo,   /*caso sexo for igual a 0 então vai ser escrito Feminino e assim sucessivamente*/
    CASE Sexo
     WHEN 0 THEN ‘Feminino’
     WHEN 1 THEN ‘Masculino’
    END AS Gênero
 FROM Cliente;
 
 
 
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*CONSULTAS ATRAVÉS DO JOIN (O JOIN SERVE PARA FAZER CONSULTA EM 2 OU MAIS TABELAS, DESDE QUE O BANCO ESTEJA NORMALIZADO)*/

/*JOIN é a cláusula que une duas tabelas pela chave estrangeira de uma e chave primária da outra.
Quando indicamos apenas JOIN, o SGBD entende 
como INNER JOIN e retorna TODOS os registro 
relacionados nas duas tabelas*/


/*INNER JOIN (TRAZ SOMENTE OS DADOS QUE SÃO COMUNS EM AMBAS AS TABELAS)*/
/*        O que quer filtrar         tabela1          tabela2     primary key de uma tabela    foreign key da outra tabela */
SELECT Nome_Autor, Nome_Livro  FROM  Autor  INNER JOIN  Livro  ON (Autor.Id_Autor = Livro.Id_Autor); 
/*Vai trazer o nome do autor e o nome do livro que tem dados tanto em autor quanto em livro*/

/*Quais são os nomes das pessoas que tem um carro da cor preta?*/
SELECT Nome, Cor FROM PESSOA INNER JOIN CARRO ON (Reg_carro = Registro) WHERE Cor = ‘Preta’
/*Vai trazer nome da pessoa e cor do carro, da tabela pessoa e da tabela carro, que tem a ligação entre chave primária e chave estrangeira, onde a cor do carro é igual a preta*/


/*OUTER JOIN
(COMPOSTO POR:
LEFT JOIN (PRIORIDADE PARA A TABELA QUE ESTÁ A ESQUERDA(VAI TRAZER TODOS OD DADOS DA TABELA À ESQUERDA E OS DADOS EM COMUM COM A TABELA DA DIREITA)
RIGHT JOIN (PRIORIDADE PARA A TABELA QUE ESTÁ A DIREITA(VAI TRAZER TODOS OD DADOS DA TABELA À DIREIRA E OS DADOS EM COMUM COM A TABELA DA ESQUERDA)
FULL JOIN (no mysql  NÃO TEM FULL JOIN) (PRIORIDADE TANTO A TABELA QUE ESTÁ A ESQUERDA QUANTO A QUE ESTÁ A DIREITA(VAI TRAZER TODOS OD DADOS DA TABELA À ESQUERDA E TODOS OS DADOS DA TABELA À DIREITA)
)*/

SELECT Nome_Autor, Nome_Livro  FROM  Autor  LEFT JOIN  Livro  ON (Autor.Id_Autor = Livro.Id_Autor); 
/*Vai trazer todos os autores e os livros que tem relação com autores, ou seja, como se trata do left, a tabela da esquerda vai vim todos os registros, já a da direita vai vim todos os registros que tem relação com a da esquerda*/

SELECT Nome_Autor, Nome_Livro  FROM  Autor  RIGHT JOIN  Livro  ON (Autor.Id_Autor = Livro.Id_Autor); 
/*Vai trazer todos os autores que tem relação com livros e otodos os livros, mesmo que não tenha relação com autores, ou seja, como se trata do right, a tabela da direita vai vim todos os registros, já a da esquerda vai vim todos os registros que tem relação com a da direita*/

/*Gambiarra da full join (gambiarra porque não tem full no mysql)*/
SELECT Nome_Autor, Nome_Livro  FROM  Autor  LEFT JOIN  Livro  ON (Autor.Id_Autor = Livro.Id_Autor); 
UNION /*UNION vai unir as tabelas*/
SELECT Nome_Autor, Nome_Livro  FROM  Autor  RIGHT JOIN  Livro  ON (Autor.Id_Autor = Livro.Id_Autor); 
/*Vai trazer tudo(nome autor, nome livro) das duas tabelas*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

BETWEEN
É feito no select e serve para indicar "entre" algum valor
select * from TABELA where CAMPO between VALOR and VALOR

IN
É feito no select e serve para indicar um registro ou todos eles, dando o valor desejado da busca
select * from TABELA where id in (110,115,120)
Se tiver esses valores o select vai trazer, ou todos eles, ou algum, ou nenhum

LIKE
É feito no select e serve para procurar algo genérico
select * from TABELA where campo LIKE '%5'
ou seja, vai selecionar tudo que terminar com a, a porcentagem serve para indicar qualquer coisa, ou seja, não me importo com o que vem antes de a, mas tem que terminar com a
