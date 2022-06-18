/* 1-) Mapeamento do DE-R para o Modelo Relacional (O DER está no PDF)*/
/* 2-) Com base na resposta do exercício Nº 1, fala o script em Linguagem SQL(MySQL/MariaDB) para criação de todas as tabelas */
/* 3-) Com base na resposta do exercício Nº 2, faça o cript em Linguagem SQL(MySQL/MariaDB) para inserção de pelo menos:
 3.1 ) Inserções
 3.1.1 ) 2 Turmas (0,1 ponto)
 3.1.2 ) 5 Discipĺinas (0,1 ponto)
 3.1.3 ) 5 Professores (0,1 ponto)
 3.1.4 ) 10 alunos fictícios (0,1) ponto
 3.1.5 ) 10 matrículas em cada turma (0,1 ponto)
*/
/* 4-) Consulta em Linguagem SQL (MySQL/MariaDB) que mostre os nomes dos alunos matriculados em uma Disciplina de uma Turma, que devem ser informados*/
/* 5-) Consulta em Linguagem SQL (MySQL/MariaDB) que liste as turmas (número, data de ínicio e de término) vigentes*/

/*RELAÇÃO EXTRAÍDA DO DER
Aluno (RA, NomeAluno, SexoAluno)
Turma (NumeroTurma, DataInicioTurma, DataTerminoTurma)
Professor (MatriculaProfessor, NomeProfessor)
Disciplina (CodigoDisciplina, NomeDisciplina)
Matricula (NumeroMatricula, DataMatricula, DataCancelamentoMatricula, RACE, NumeroTurma-CE)
Oferecida (NumeroDisciplinaOferecida, Sala, Bloco, MatriculaProfessor-CE,
NumeroTurma-CE, CodigoDisciplina-CE)
AlunoAvaliado (RA-CE, NumeroDisciplinaOferecida-CE, A1, A2, AF)
*/

CREATE DATABASE escola; /*Criar banco de dados*/
USE escola;  /*Usar banco de dados*/

CREATE TABLE Aluno ( /*Criar tabela*/
Ra INT NOT NULL AUTO_INCREMENT, /* Auto_Increment é para o valor se incrementar sozinho no banco, sem ter a necessidade de inserir valor nesse campo */
NomeAluno VARCHAR(250) NOT NULL, /* Not null é para restringir para que o valor seja obrigatoriamente inserido*/
SexoAluno CHAR(1) NOT NULL,
CONSTRAINT Pk_Ra PRIMARY KEY(Ra), /*Constraint é uma restrição, nesse caso a restrição é dizer que tal campo é uma chave primária*/
CONSTRAINT Ck_SexoAluno CHECK (SexoAluno IN('F','M')) /* Check é uma restrição de checagem, ou seja, vai checar se no campo sexoAluno está com F ou M*/
);

CREATE TABLE Turma(
NumeroTurma INT NOT NULL AUTO_INCREMENT,
DataInicioTurma DATE NOT NULL,
DataTerminoTurma DATE NOT NULL,
CONSTRAINT PK_NumeroTurma PRIMARY KEY (NumeroTurma)
);

CREATE TABLE Professor(
MatriculaProfessor INT NOT NULL AUTO_INCREMENT,
NomeProfessor VARCHAR(250) NOT NULL
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

