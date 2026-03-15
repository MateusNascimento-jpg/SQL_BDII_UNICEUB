-- Criação do banco de dados
CREATE DATABASE esocial;

-- Utilização do banco de dados
USE esocial;

-- Criação da tabela de empregadores
CREATE TABLE Empregadores (
    id_empregador INT PRIMARY KEY,
    nome_empregador VARCHAR(100),
    cnpj_empregador VARCHAR(14),
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);

-- Criação da tabela de empregados domésticos
CREATE TABLE Empregados (
    id_empregado INT PRIMARY KEY,
    nome_empregado VARCHAR(100),
    cpf_empregado VARCHAR(11),
    data_admissao DATE,
    id_empregador INT,
    FOREIGN KEY (id_empregador) REFERENCES Empregadores(id_empregador)
);

-- Criação da tabela de folha de pagamentos
CREATE TABLE FolhaPagamentos (
    id_folha INT PRIMARY KEY,
    id_empregado INT,
    mes_referencia DATE,
    valor_salario DECIMAL(10, 2),
    valor_inss DECIMAL(10, 2),
    valor_fgts DECIMAL(10, 2),
    FOREIGN KEY (id_empregado) REFERENCES Empregados(id_empregado)
);

-- Criação da tabela de afastamentos
CREATE TABLE Afastamentos (
    id_afastamento INT PRIMARY KEY,
    id_empregado INT,
    data_inicio DATE,
    data_fim DATE,
    motivo VARCHAR(200),
    FOREIGN KEY (id_empregado) REFERENCES Empregados(id_empregado)
);

-- Criação da tabela de Comunicação de Acidente de Trabalho (CAT)
CREATE TABLE CAT (
    id_cat INT PRIMARY KEY,
    id_empregado INT,
    data_acidente DATE,
    tipo_acidente VARCHAR(100),
    descricao VARCHAR(200),
    FOREIGN KEY (id_empregado) REFERENCES Empregados(id_empregado)
);

-- Criação da tabela de Aviso Prévio
CREATE TABLE AvisoPrevio (
    id_aviso_previo INT PRIMARY KEY,
    id_empregado INT,
    data_aviso DATE,
    FOREIGN KEY (id_empregado) REFERENCES Empregados(id_empregado)
);

-- Criação da tabela de Demissão
CREATE TABLE Demissao (
    id_demissao INT PRIMARY KEY,
    id_empregado INT,
    data_demissao DATE,
    FOREIGN KEY (id_empregado) REFERENCES Empregados(id_empregado)
);

use esocial;
INSERT INTO Empregadores (id_empregador, nome_empregador, cnpj_empregador, endereco, telefone) VALUES
(1, 'Empresa A', '12345678901234', 'Rua A, 123', '11111111'),
(2, 'Empresa B', '23456789012345', 'Rua B, 456', '22222222'),
(3, 'Empresa C', '34567890123456', 'Rua C, 789', '33333333'),
(4, 'Empresa D', '45678901234567', 'Rua D, 987', '44444444'),
(5, 'Empresa E', '56789012345678', 'Rua E, 654', '55555555');
INSERT INTO Empregados (id_empregado, nome_empregado, cpf_empregado, data_admissao, id_empregador) VALUES
(1, 'João', '12345678901', '2022-01-01', 1),
(2, 'Maria', '23456789012', '2022-02-01', 1),
(3, 'Pedro', '34567890123', '2022-03-01', 2),
(4, 'Ana', '45678901234', '2022-04-01', 2),
(5, 'Carlos', '56789012345', '2022-05-01', 3);
INSERT INTO FolhaPagamentos (id_folha, id_empregado, mes_referencia, valor_salario, valor_inss, valor_fgts) VALUES
(1, 1, '2022-01-01', 3000.00, 300.00, 270.00),
(2, 2, '2022-01-01', 2500.00, 250.00, 225.00),
(3, 3, '2022-01-01', 3500.00, 350.00, 315.00),
(4, 4, '2022-01-01', 2800.00, 280.00, 252.00),
(5, 5, '2022-01-01', 3200.00, 320.00, 288.00);
INSERT INTO Afastamentos (id_afastamento, id_empregado, data_inicio, data_fim, motivo) VALUES
(1, 1, '2022-02-01', '2022-02-05', 'Licença médica'),
(2, 2, '2022-03-01', '2022-03-05', 'Licença maternidade'),
(3, 3, '2022-04-01', '2022-04-05', 'Licença médica'),
(4, 4, '2022-05-01', '2022-05-05', 'Licença maternidade'),
(5, 5, '2022-06-01', '2022-06-05', 'Licença médica');
INSERT INTO CAT (id_cat, id_empregado, data_acidente, tipo_acidente, descricao) VALUES
(1, 1, '2022-03-15', 'Acidente de trabalho', 'Fratura no braço'),
(2, 2, '2022-04-15', 'Acidente de trabalho', 'Torção no tornozelo'),
(3, 3, '2022-05-15', 'Acidente de trabalho', 'Corte no dedo'),
(4, 4, '2022-06-15', 'Acidente de trabalho', 'Queimadura na mão'),
(5, 5, '2022-07-15', 'Acidente de trabalho', 'Lesão nas costas');
INSERT INTO AvisoPrevio (id_aviso_previo, id_empregado, data_aviso) VALUES
(1, 1, '2022-02-15'),
(2, 2, '2022-03-15'),
(3, 3, '2022-04-15'),
(4, 4, '2022-05-15'),
(5, 5, '2022-06-15');
INSERT INTO Demissao (id_demissao, id_empregado, data_demissao) VALUES
(1, 1, '2022-02-28'),
(2, 2, '2022-03-31'),
(3, 3, '2022-04-30'),
(4, 4, '2022-05-31'),
(5, 5, '2022-06-30');

/*>>>>>>>>>>>>>>>>>>>EXERCICIOS COM JOIN DE VÁRIAS MANEIRAS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */

/* 4.1
Liste o nome do empregador e o nome do empregado que possuem o mesmo id_empregador.
*/
SELECT 
    c.nome_empregador, 
    b.nome_empregado
FROM 
    empregadores c 
INNER JOIN 
    empregados b 
ON c.id_empregador = b.id_empregador;


/* 4.2
Exiba o nome do empregador, o nome do empregado e a data de admissão do empregado
para todos os registros da tabela Empregados, mesmo que não haja correspondência
com a tabela Empregadores.*/
SELECT 
    c.nome_empregador AS 'Empregador',
    b.nome_empregado AS 'Empregado' ,
    b.data_admissao AS 'Data admissao'
FROM 
    empregados b
LEFT JOIN 
    empregadores c
ON b.id_empregador = c.id_empregador; 




/* 4.3 Liste o nome do empregador e o nome do empregado apenas para os registros
em que o empregado possui uma folha de pagamento.*/
SELECT 
    c.nome_empregador AS 'Empregador',
    b.nome_empregado AS 'Empregado'
FROM 
    FolhaPagamentos f
INNER JOIN 
    Empregados b
        ON f.id_empregado = b.id_empregado
INNER JOIN 
    Empregadores c
        ON b.id_empregador = c.id_empregador;


/* 4.4 Exiba o nome do empregador e o nome do empregado para todos os registros
da tabela Empregadores, mesmo que não haja correspondência com a tabela Empregados.*/

SELECT 
    c.nome_empregador,
    b.nome_empregado
FROM 
    empregadores c
LEFT JOIN 
    empregados b
ON c.id_empregador = b.id_empregador;


/* 4.5Liste o nome do empregador, o nome do empregado e o mês de referência
da folha de pagamento para todos os registros da tabela FolhaPagamentos. */
SELECT 
    c.nome_empregador AS 'Empregador', 
    b.nome_empregado AS 'Empregado', 
    f.mes_referencia AS 'Mês de Referência'
FROM 
    FolhaPagamentos f
INNER JOIN 
    empregados b
ON f.id_empregado = b.id_empregado
INNER JOIN 
    empregadores c
ON b.id_empregador = c.id_empregador;


/* 4.6 Exiba o nome do empregador, o nome do empregado, o cpf do empregado
e o motivo de afastamento do empregado apenas para os registros
em que o empregado possui um afastamento.*/
SELECT 
    c.nome_empregador AS 'Empregador', 
    b.nome_empregado AS 'Empregado', 
    b.cpf_empregado AS 'CPF',
    f.motivo
FROM 
    empregadores c
INNER JOIN 
    empregados b
ON c.id_empregador = b.id_empregador 
INNER JOIN 
    afastamentos f
ON f.id_empregado = b.id_empregado;


/* 4.7Liste o nome do empregador e o tipo de acidente do empregado apenas
para os registros em que o empregado possui uma Comunicação de
Acidente de Trabalho (CAT).*/
SELECT 
    c.nome_empregador,
    cat.tipo_acidente
FROM 
    empregadores c
INNER JOIN 
    empregados b
ON c.id_empregador = b.id_empregador
INNER JOIN 
    cat 
ON b.id_empregado = cat.id_empregado;


/*  4.8Exiba o nome do empregador e a data de aviso do empregado apenas
para os registros em que o empregado possui um aviso prévio. */

SELECT 
    c.nome_empregador AS 'Empregador',
    av.data_aviso AS 'Data'
FROM 
    AvisoPrevio av
INNER JOIN 
    empregados b
ON av.id_empregado = b.id_empregado
INNER JOIN 
    empregadores c
ON b.id_empregador = c.id_empregador; 
    
    
/* 4.9 Liste o nome do empregador e a data de demissão do empregado apenas
para os registros em que o empregado possui uma demissão registrada.*/
SELECT 
	c.nome_empregador AS 'Empregador',
	d.data_demissao AS 'Demissao' 
FROM  
	demissao d
INNER JOIN 
	empregados b
ON d.id_empregado = b.id_empregado
INNER JOIN 
	empregadores c
ON c.id_empregador = b.id_empregador; 


















