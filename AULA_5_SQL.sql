-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS SistemaAcademico;
USE SistemaAcademico;

-- Criando a tabela de Estudantes
CREATE TABLE Estudantes (
    id_estudante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Criando a tabela de Professores
CREATE TABLE Professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Criando a tabela de Disciplinas
CREATE TABLE Disciplinas (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_professor INT NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES Professores(id_professor)
);

-- Criando a tabela de Matrículas
CREATE TABLE Matriculas (
    id_estudante INT NOT NULL,
    id_disciplina INT NOT NULL,
    semestre VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_estudante, id_disciplina, semestre),
    FOREIGN KEY (id_estudante) REFERENCES Estudantes(id_estudante),
    FOREIGN KEY (id_disciplina) REFERENCES Disciplinas(id_disciplina)
);

-- Inserindo dados fictícios
-- Inserindo Estudantes
INSERT INTO Estudantes (nome, email) VALUES
('Alice Souza', 'alice@email.com'),
('Bruno Lima', 'bruno@email.com'),
('Carlos Mendes', 'carlos@email.com');

-- Inserindo Professores
INSERT INTO Professores (nome) VALUES
('Dr. Ricardo Silva'),
('Profa. Juliana Costa'),
('Dr. Marcos Ribeiro');

-- Inserindo Disciplinas
INSERT INTO Disciplinas (nome, id_professor) VALUES
('Banco de Dados', 1),
('Estruturas de Dados', 2),
('Algoritmos', 3);

-- Inserindo Matrículas
INSERT INTO Matriculas (id_estudante, id_disciplina, semestre) VALUES
(1, 1, '2024.1'),
(1, 2, '2024.1'),
(2, 1, '2024.1'),
(3, 3, '2024.1'),
(2, 3, '2024.1');

-- Quais disciplinas a Alice Souza está cursando e quem são os professores?
SELECT 
    e.nome AS Estudante,
    d.nome AS Disciplina,
    p.nome AS Professor
FROM
    Matriculas m
        JOIN
    Estudantes e ON m.id_estudante = e.id_estudante
        JOIN
    Disciplinas d ON m.id_disciplina = d.id_disciplina
        JOIN
    Professores p ON d.id_professor = p.id_professor
WHERE
    e.nome = 'Alice Souza';

-- Quais alunos estão cursando Algoritmos e em qual semestre?
SELECT 
    e.nome AS Estudante, d.nome AS Disciplina, m.semestre
FROM
    Matriculas m
        JOIN
    Estudantes e ON m.id_estudante = e.id_estudante
        JOIN
    Disciplinas d ON m.id_disciplina = d.id_disciplina
WHERE
    d.nome = 'Algoritmos';

-- Quantos alunos estão matriculados em cada disciplina e quem é o professor responsável?
SELECT 
    d.nome AS Disciplina,
    p.nome AS Professor,
    COUNT(m.id_estudante) AS Total_Alunos
FROM
    Matriculas m
        JOIN
    Disciplinas d ON m.id_disciplina = d.id_disciplina
        JOIN
    Professores p ON d.id_professor = p.id_professor
GROUP BY d.nome , p.nome
ORDER BY Total_Alunos DESC;


-- <<<<<<<<<<<<<<<Estudo de View>>>>>>>>>>>>>>> 
CREATE VIEW total_alunos_por_disciplina AS 
SELECT 
    d.nome AS Disciplina,
    p.nome AS Professor,
    COUNT(m.id_estudante) AS Total_alunos
FROM 
    Matriculas m 
INNER JOIN 
    Disciplinas d ON m.id_disciplina = d.id_disciplina
INNER JOIN 
    Professores p ON d.id_professor = p.id_professor 
GROUP BY d.nome, p.nome
ORDER BY Total_alunos DESC; 

/* Consultando a View recém-criada */
SELECT * FROM total_alunos_por_disciplina;


/*(OBS: caos duas ou mais views sejam criadas, 
pode-se deletar as duas de uma vez utilizando:	
 
 "DROP VIEW IF EXISTS NomePrimeiraView, NomeSegundaView; "*/ 

SELECT * FROM total_alunos_por_disciplina;

/* ==========================================
 5. VIEW SIMPLES (Testando INSERT, UPDATE, DELETE)
========================================== */ 

DROP VIEW IF EXISTS ViewEstudantes; -- (So pra ter certeza)

-- Criando uma view simples dos estudantes
CREATE VIEW ViewEstudantes
AS SELECT id_estudante,nome,email 
FROM Estudantes;
 
-- INSERT (Adicionando um novo estudante pela View)
INSERT INTO ViewEstudantes (nome,email) 
VALUES ('Mateus Bueno','mateus@gmail.com'); 
SELECT * FROM ViewEstudantes;
  
-- UPDATE (Atualizando o email do estudante pela View)
UPDATE ViewEstudantes SET email = 'dan.pereira@gmail.com' WHERE nome = 'Daniel Pereira'; 
SELECT * FROM ViewEstudantes;
 
-- DELETE (Removendo o estudante pela View)
DELETE FROM ViewEstudantes WHERE nome = 'Mateus Bueno'; 
SELECT * FROM ViewEstudantes; 


/* ==========================================
 Testando limite de INSERT
========================================== */ 

DROP VIEW IF EXISTS alunos_por_disciplina; -- (So pra ter certeza)

-- Criando uma view complexa (com JOIN e COUNT)
CREATE VIEW alunos_por_disciplina AS 
SELECT 
	d.nome AS 'Disciplina',
    p.nome AS 'Professor',
	COUNT(m.id_estudante) AS 'Total_Alunos' 
FROM 
	Matriculas m 
JOIN 
	Disciplinas d ON m.id_disciplina = d.id_disciplina -- << Corrigido: 'Disciplinas'
JOIN
	Professores p ON d.id_professor = p.id_professor 
GROUP BY 
    d.nome, p.nome 	
ORDER BY 
    'Total Alunos' DESC; 

SELECT * FROM alunos_por_disciplina;
  
-- INSERT (Tentando adicionar em uma view)
-- View não atualizável!
INSERT INTO alunos_por_disciplina (d.nome) VALUES ('Cálculo I'); 



-- <<<<<<<<<<<<<<<<<<<<<<<Listar Todas as Views do Banco>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
	TABLE_SCHEMA AS 'Nome do banco',
	TABLE_NAME AS 'Nome das Views' 
FROM 
	INFORMATION_SCHEMA.VIEWS
WHERE 
	TABLE_SCHEMA = 'SistemaAcademico';
     
-- <<<<<<<<<<<<<<<<<<<<<<<<Listar Views de um Banco Específico>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 		
	TABLE_SCHEMA AS 'Nome do banco', 
    TABLE_NAME AS 'Nome das Views' 
FROM INFORMATION_SCHEMA.VIEWS 
WHERE 
	TABLE_SCHEMA = 'sistemaacademico' 
AND TABLE_NAME = 'alunos_por_disciplina'; 



















