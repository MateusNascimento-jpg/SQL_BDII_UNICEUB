CREATE DATABASE db_ibge;
USE db_ibge;
/*Criar a tabela tb_regioes*/
CREATE TABLE tb_regioes 
(  
  	id INT NOT NULL PRIMARY KEY,  
	nome VARCHAR(40) NOT NULL,  
	sigla VARCHAR(2) NOT NULL
) ;

insert into tb_regioes (id,nome,sigla) 
Values
(1, 'Norte', 'N'),
(2, 'Nordeste', 'NE'),
(3, 'Sudeste', 'SE'),
(4, 'Sul', 'S'),
(5, 'Centro-Oeste', 'CO');


CREATE TABLE tb_estados (
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  sigla VARCHAR(2) NOT NULL,
  id_regiao INT DEFAULT NULL,
  FOREIGN KEY (id_regiao) REFERENCES tb_regioes (id)
);


insert into tb_estados (id,nome,sigla,id_regiao) Values
(11, 'Rondônia', 'RO', 1),
(12, 'Acre', 'AC', 1),
(13, 'Amazonas', 'AM', 1),
(14, 'Roraima', 'RR', 1),
(15, 'Pará', 'PA', 1),
(16, 'Amapá', 'AP', 1),
(17, 'Tocantins', 'TO', 1);


insert into tb_estados (id,nome,sigla,id_regiao) values 
(21, 'Maranhão', 'MA', 2),
(22, 'Piauí', 'PI', 2),
(23, 'Ceará', 'CE', 2),
(24, 'Rio Grande do Norte', 'RN', 2),
(25, 'Paraíba', 'PB', 2),
(26, 'Pernambuco', 'PE', 2),
(27, 'Alagoas', 'AL', 2),
(28, 'Sergipe', 'SE', 2),
(29, 'Bahia', 'BA', 2);

insert into tb_estados (id,nome,sigla,id_regiao) values
(31, 'Minas Gerais', 'MG', 3),
(32, 'Espírito Santo', 'ES', 3),
(33, 'Rio de Janeiro', 'RJ', 3),
(35, 'São Paulo', 'SP', 3);


insert into tb_estados (id,nome,sigla,id_regiao) values
(41, 'Paraná', 'PR', 4),
(42, 'Santa Catarina', 'SC', 4),
(43, 'Rio Grande do Sul', 'RS', 4);

insert into tb_estados (id,nome,sigla,id_regiao) values
(50, 'Mato Grosso do Sul', 'MS', 5),
(51, 'Mato Grosso', 'MT', 5),
(52, 'Goiás', 'GO', 5),
(53, 'Distrito Federal', 'DF', 5);



/*EXEMPLOS UTILIZANDO O WHERE*/ 

SELECT * FROM tb_regioes WHERE nome = 'Sul'; 

SELECT nome FROM tb_regioes WHERE id >= 3;

SELECT * FROM tb_estados WHERE id = 3; 

SELECT sigla,nome FROM tb_estados WHERE nome <= 24;  


/* EXEMPLO COM AND/OR */ 
SELECT * FROM tb_estados WHERE id_regiao = 4 or id_regiao = 5;  

SELECT nome FROM tb_estados WHERE id_regiao = 2 and sigla = 'AL'; 

SELECT nome FROM tb_estados WHERE id_regiao = 2 and sigla = 'AL' or sigla = 'PB' or sigla = 'CE'; 

SELECT nome FROM tb_estados WHERE id_regiao <> 2 and sigla = 'DF'; 


/*EXEMPLO COM ORDER BY*/ 
SELECT * FROM tb_estados ORDER BY nome ASC;  

SELECT * FROM tb_estados ORDER BY nome DESC; 

SELECT nome,sigla FROM tb_estados ORDER BY id_regiao,nome ASC; 


/*CONDIÇÃO LIKE PARA SELEÇÃO DE LINHA */ 
SELECT nome FROM tb_estados WHERE nome LIKE '%rio%';  

SELECT nome FROM tb_estados WHERE nome LIKE 'a%' ORDER BY nome ASC;   

SELECT nome,sigla FROM tb_estados WHERE nome LIKE '%a'; 

SELECT nome, sigla FROM tb_estados WHERE nome LIKE '____';          


/*CONDIÇÃO DE SELECT IN*/ 
SELECT nome FROM tb_estados WHERE sigla IN ('DF', 'TO', 'AC', 'AL', 'PB', 'PA', 'PR');

SELECT nome FROM tb_estados WHERE nome LIKE 'a%' AND sigla <> 'AL'; 

SELECT nome,sigla FROM tb_estados WHERE id NOT IN(11,12); 


/*CONDIÇÃO COM BETWEEN E NOT BETWEEEN*/ 
SELECT nome,id_regiao FROM tb_estados 
WHERE id_regiao BETWEEN 2 AND 4; 

SELECT nome,id_regiao FROM tb_estados 
WHERE id_regiao NOT BETWEEN 2 AND 4;


/*EXEMPLO COM UPDATE*/ 
/*Antes da atualização*/
SELECT * FROM tb_regioes; 

UPDATE tb_regioes 
SET sigla = 'BB' 
WHERE nome = 'Centro-Oeste'; 

/*Apos a atualização*/ 
SELECT * FROM tb_regioes; 

/*EXEMPLO 2 (SEM A UTILIZAÇÃO DO WHERE) -------> INCORRETO*/ 
/*Antes da atualização*/
SELECT * FROM tb_regioes; 

UPDATE tb_regioes 
SET sigla = 'CO' ; 

/*Apos a atualização*/ 
SELECT * FROM tb_regioes; 


/*EXEMPLO UTILIZANDO O DELETE*/ 
/*Antes da atualização*/
SELECT * FROM tb_estados; 

DELETE FROM tb_estados 
WHERE nome = 'Amazonas'; 

/*Apos a atualização*/ 
SELECT * FROM tb_estados ORDER BY nome ASC;  
 
 
/*EXEMPLO 2 COM DELETE (NAO É POSSÍVEL POIS É CHAVE ESTRANGEIRA ASSOCIADA A TABELA ESTADO...*/ 
DELETE FROM tb_regioes 
WHERE nome = 'Norte'; 

/*EXEMPLO COM DELETE (OPÇÃO CORRETA)*/  
DELETE FROM tb_estados
WHERE id_regiao = 1;  

/*SELEÇÃO APOS O PROCESSO*/
SELECT * FROM tb_estados ORDER BY nome ASC; 

















 




 



