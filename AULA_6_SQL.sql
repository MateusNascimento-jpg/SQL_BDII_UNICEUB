-- 1. Criar a base de dados
CREATE DATABASE IF NOT EXISTS Universidade;
USE Universidade;

-- 2. Criar a tabela de Alunos
CREATE TABLE Alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso VARCHAR(100) NOT NULL,
    idade INT CHECK (idade >= 18)
);

-- 3. Inserir alguns alunos fictícios
INSERT INTO Alunos (nome, curso, idade) VALUES
('Carlos Alberto', 'Computação', 22),
('Ana Paula', 'Matemática', 21),
('Ricardo Mendes', 'Engenharia', 23),
('Fernanda Oliveira', 'Administração', 20);

-- 4. Criar a View inicial (Sem idade)
CREATE VIEW view_alunos AS 
SELECT nome,curso FROM Alunos; 

--  Teste 1: Verificar o conteúdo da View antes da alteração
SELECT * FROM view_alunos; 

-- 5. Alterar a View para incluir a idade dos alunos
ALTER VIEW view_alunos AS 
SELECT nome, curso,idade FROM Alunos;
 
--  Teste 2: Verificar o conteúdo da View após a alteração
SELECT * FROM Alunos; 
 
 /*AGORA COM CREATE OR REPLACE VIEW*/ 
 
 -- 4. Criar a View inicial (Sem idade)
CREATE VIEW info_alunos AS 
SELECT nome, curso FROM Alunos; 

--  Teste 1: Verificar o conteúdo da View antes da alteração
SELECT * FROM info_alunos; 

-- 5. Alterar a View para incluir a idade dos alunos
CREATE OR REPLACE VIEW info_alunos AS
SELECT nome,curso,idade FROM Alunos; 

--  Teste 2: Verificar o conteúdo da View após a alteração
SELECT * FROM info_alunos;
 
 
