CREATE DATABASE db_company;
use db_company;
/*criar a tabela tb_cargo*/
CREATE TABLE tb_cargo (
    id_cargo INT NOT NULL PRIMARY KEY,
    nm_cargo VARCHAR(60) NOT NULL,
    salario DECIMAL(9 , 2 ) NOT NULL
);
/*criar a tabela departamento*/ 
CREATE TABLE tb_departamento (
    id_departamento INT NOT NULL PRIMARY KEY,
    nm_departamento VARCHAR(40) NOT NULL
);
CREATE TABLE tb_empregado (
    matricula INT NOT NULL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    dt_nascimento DATE NOT NULL,
    sexo ENUM('F', 'M') NOT NULL,
    dt_admissao DATE NOT NULL,
    fk_cargo INT NOT NULL,
    fk_departamento INT NOT NULL,
    FOREIGN KEY (fk_cargo)
        REFERENCES tb_cargo (id_cargo),
    FOREIGN KEY (fk_departamento)
        REFERENCES tb_departamento (id_departamento)
);
insert into tb_cargo 
(id_cargo, nm_cargo, salario) values
(1, 'Advogado', 9200.00),
(2 , 'Administrador', 6500.00),
(3, 'Contador', 5600.00),
(4, 'Estagiário', 980.00),
(5, 'Gerente de Projeto', 8300.00),
(6, 'Programador', 7500.00),
(7, 'Administrador de Banco de Dados', 5990.00),
(8, 'Cientista de Dados', 8700.00),
(9, 'Secretária', 2200.00);

INSERT INTO tb_departamento
(id_departamento, nm_departamento) VALUES
(100, 'Administrativo'),
(200, 'Jurídico'),
(300, 'Contábil'),
(400, 'Tecnologia da Informação'),
(500, 'Recursos Humanos'),
(600, 'Comercial'),
(700, 'Financeiro');

INSERT INTO tb_empregado(matricula, nome, dt_nascimento, sexo,
dt_admissao, fk_cargo, fk_departamento) VALUES
(123, 'Vânia Alves', '1967-07-02', 'F', '2010-12-08', 2, 100),
(124, 'Florisbela Silva', '1999-10-02', 'F', '2019-10-01', 1, 200),
(125, 'Walter Amaral', '1998-02-02', 'M', '2018-05-25', 7, 400),
(126, 'Ana Cristina Peixoto', '1980-03-02', 'F', '2018-10-02', 4, 200),
(127, 'Clara Rodrigues', '1998-07-05', 'F', '2020-10-02', 4, 400),
(128, 'Flávio Luiz Silva', '1990-09-05', 'M', '2016-02-15', 6, 400),
(129, 'Roberto Oliveira', '1981-03-10', 'M', '2012-12-10', 8, 400),
(130, 'Cristina Moura', '1980-12-20', 'F', '2020-10-02', 9, 100),
(131, 'Gabriel Silva Costa', '1985-10-2', 'M', '2017-01-02', 3,300);


/*---------AULA 2----------*/ 
/*<<<<<<<<<FUNÇÕES AGREGADORAS>>>>>>>>*/


/*EXEMPLO COM COUNT()*/
 SELECT COUNT(*) FROM tb_empregado; 
 
/*EXEMPLO COM SUM()*/ 
SELECT SUM(salario) FROM tb_cargo; 

/*EXEMPLO COM MAX()*/
SELECT MAX(salario) FROM tb_cargo; 

/*EXEMPLO COM MIN()*/ 
SELECT MIN(salario) AS Salario_minimo FROM tb_cargo; 


/*EXEMPLO COM AVG()*/ 
SELECT AVG(salario) AS Salario_medio FROM tb_cargo; 
/*EXEMPLO AVG() ------> COM APROXIMAÇÃO DE DUAS CASAS DECIMAIS*/ 
SELECT ROUND(AVG(salario),2) AS salario_medio FROM tb_cargo; 

/*---------------------------*/ 
/*EXEMPLO COM JOIN()*/  
SELECT 
	d.nm_departamento, 
	COUNT(e.matricula) as total_empregados
FROM
	tb_empregado e 
    JOIN tb_departamento d 
    ON e.fk_departamento = d.id_departamento 
GROUP BY d.nm_departamento; 

/*EXEMPLO COM HAVING()*/ 
SELECT 
	d.nm_departamento, ROUND(AVG (c.salario),2) AS Salario_medio
FROM 
	tb_empregado e 
    JOIN
	tb_cargo c ON e.fk_cargo = c.id_cargo
    JOIN 
    tb_departamento d ON e.fk_departamento = d.id_departamento 
GROUP BY d.nm_departamento 
HAVING AVG (c.salario) > 5000; 

/*EXEMPLO COM HAVING() e GROUP BY()*/
SELECT 
	d.nm_departamento, ROUND(AVG(c.salario),2) AS salario_medio
FROM 
	tb_empregado e 
    JOIN 
    tb_cargo c ON e.fk_cargo = c.id_cargo
	JOIN 
    tb_departamento d ON e.fk_departamento = d.id_departamento
WHERE 
	c.nm_cargo <> 'Estagiário' 
GROUP BY d.nm_departamento 
HAVING AVG (c.salario) > 6000; 


/*<<<<<<<<< SUB-QUERIES >>>>>>>>>*/



 /*WHERE*/ 
 SELECT AVG(salario) FROM tb_cargo; 
SELECT * FROM tb_cargo; 

/*------SELECT DENTRO DE SELECT------*/ 
SELECT 
	nome,
    fk_cargo AS cargo,
    fk_departamento AS departamento 
FROM tb_empregado WHERE fk_cargo IN (
	SELECT id_cargo 
    FROM tb_cargo
    WHERE salario > (SELECT AVG(salario) FROM tb_cargo)
    
    ); 




/*EXERCICIOS FINAIS (TREINO)*/ 


/* 1. Contagem de Empregados Escreva uma consulta para contar quantos empregados existem na tabela tb_empregado.*/
SELECT COUNT(*) AS Contagem_total FROM tb_empregado; 

/* 2. Soma dos Salários Calcule o total gasto com salários na empresa, utilizando a tabela tb_cargo.*/
SELECT 	SUM(salario) AS Gasto_total FROM tb_cargo; 
 
/* 3. Média Salarial Determine a média salarial dos empregados cadastrados na tabela tb_cargo.*/
SELECT ROUND(AVG(salario), 2) AS Media_salario FROM tb_cargo;

/* 4. Maior Salário Identifique o maior salário registrado na tabela tb_cargo.*/
SELECT MAX(salario) AS Salario_máximo FROM tb_cargo; 

/* 5. Menor Salário Recupere o menor salário presente na tabela tb_cargo.*/
SELECT MIN(salario) AS Mínimo_salário FROM tb_cargo; 

/* 6. Número de Departamentos Conte quantos departamentos existem na tabela
 tb_departamento. */ 
SELECT COUNT(id_departamento) AS numero_departamentos FROM tb_departamento; 

/* 7. Contagem de Empregados por Cargo Liste os cargos e a quantidade de empregados em cada um, sem utilizar JOIN.*/SELECT fk_cargo, COUNT(*) AS total_empregados_por_cargo 
SELECT fk_cargo, COUNT(*) AS total_empregados_por_cargo 
FROM tb_empregado
GROUP BY fk_cargo;


/* 8. Salário Médio por Cargo Liste os cargos e o salário médio correspondente, sem usar JOIN.*/ 
SELECT nm_cargo, AVG(salario) AS Salário_medio
FROM tb_cargo GROUP BY nm_cargo; 


/* 9. Departamentos com mais de 5 Empregados Utilize uma subquery para listar os departamentos que possuem mais de 2
empregados.*/ 
SELECT nm_departamento FROM tb_departamento
WHERE id_departamento IN(
SELECT fk_departamento FROM tb_empregado
GROUP BY fk_departamento 
HAVING COUNT(*) > 2 ); 


/* 10. Identificação do Cargo com Maior Salário Recupere o nome do cargo com o maior salário utilizando uma subquery.*/ 
SELECT nm_cargo AS Maior_salário FROM tb_cargo 
WHERE salario = (SELECT MAX(salario) FROM tb_cargo); 


/* 11. Identificação do Cargo com Menor Salário Recupere o nome do cargo com o menor salário utilizando uma subquery.*/ 
SELECT nm_cargo FROM tb_cargo 
WHERE salario = (SELECT MIN(salario) FROM tb_cargo); 


/* 12. Funcionários com Salário Acima da Média Liste os IDs dos empregados cujo salário está acima da média salarial geral, sem
JOIN. */ 
SELECT nome,matricula FROM tb_empregado
WHERE fk_cargo IN(

SELECT id_cargo FROM tb_cargo 
WHERE salario > (SELECT AVG(salario) FROM tb_cargo)
); 

/*<<<<<<<<<<<<<<<<<<<<< MAIS EXERCÍCIOS  >>>>>>>>>>>>>>>>>>>>>>>>>>>*/ 

/* 13. Recupere o nome de todos os empregados cujo cargo possua um salário superior ao do cargo 'Administrador' utilizando uma subquery.*/
SELECT nome 
FROM tb_empregado 
WHERE fk_cargo IN (
    SELECT id_cargo 
    FROM tb_cargo 
    WHERE salario > (
        SELECT salario 
        FROM tb_cargo 
        WHERE nm_cargo = 'Administrador'
    )
);

/* 14. Liste o nome dos departamentos que não possuem nenhum funcionário com o cargo de 'Programador' (ID 6) 
utilizando uma subquery com NOT IN.*/
SELECT nm_departamento FROM tb_departamento
WHERE id_departamento NOT IN(
SELECT fk_departamento FROM tb_empregado 
WHERE fk_cargo = 6
); 


/* 15. Recupere o nome de todos os departamentos e, ao lado, uma coluna mostrando 
a quantidade total de funcionários em cada um, utilizando uma subquery no SELECT (sem usar JOIN). */

SELECT d.nm_departamento,
(SELECT COUNT(*) FROM tb_empregado WHERE fk_departamento = d.id_departamento) AS total_funcionarios 
FROM tb_departamento d; 































        
	



