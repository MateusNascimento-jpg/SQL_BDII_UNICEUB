-- <<<<<<<<<<<<<< Stored Procedures em MySQL >>>>>>>>>>>>>>
-- Criar banco de dados
CREATE DATABASE loja; 
USE loja;

-- Tabela de Produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    peso DECIMAL(10,2) NOT NULL,  -- Peso do produto em kg
    tipo_produto VARCHAR(50) NOT NULL,
    estoque INT NOT NULL
);

-- Tabela de Endereços (para simular a distância de entrega)
CREATE TABLE enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(100),
    estado VARCHAR(100),
    distancia INT  -- Distância do armazém em km
);

-- Tabela de Compras
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    id_endereco INT,
    data_compra DATETIME,
    valor_frete DECIMAL(10,2),
    FOREIGN KEY (id_produto) REFERENCES produtos(id),
    FOREIGN KEY (id_endereco) REFERENCES enderecos(id)
);

-- Inserir 10 produtos aleatórios
INSERT INTO produtos (nome, peso, tipo_produto,estoque) VALUES
('Smartphone', 0.35, 'Eletrônicos',5),
('TV 55" LED', 7.5, 'Eletrônicos',7),
('Cafeteira', 1.2, 'Eletrônicos',10),
('Arroz', 5.0, 'Alimentos',20),
('Feijão', 3.0, 'Alimentos',5),
('Cadeira Gamer', 12.3, 'Móveis',3),
('Sofá de 3 Lugares', 45.5, 'Móveis',2),
('Notebook', 2.1, 'Eletrônicos',10),
('Livro de História', 0.8, 'Livros',8),
('Camiseta', 0.25, 'Vestuário',30);

-- Inserir 10 endereços aleatórios
INSERT INTO enderecos (cidade, estado, distancia) VALUES
('São Paulo', 'SP', 300),
('Rio de Janeiro', 'RJ', 400),
('Belo Horizonte', 'MG', 600),
('Curitiba', 'PR', 700),
('Porto Alegre', 'RS', 1000),
('Salvador', 'BA', 1200),
('Fortaleza', 'CE', 1500),
('Recife', 'PE', 1100),
('Brasília', 'DF', 900),
('Manaus', 'AM', 2000);

-- Inserir 10 compras aleatórias
INSERT INTO compras (id_produto, id_endereco, data_compra, valor_frete) VALUES
(1, 1, '2025-03-01 10:00:00', 0),
(2, 2, '2025-03-02 11:30:00', 0),
(3, 3, '2025-03-03 09:00:00', 0),
(4, 4, '2025-03-04 14:20:00', 0),
(5, 5, '2025-03-05 15:00:00', 0),
(6, 6, '2025-03-06 16:40:00', 0),
(7, 7, '2025-03-07 17:10:00', 0),
(8, 8, '2025-03-08 18:30:00', 0),
(9, 9, '2025-03-09 20:00:00', 0),
(10, 10, '2025-03-10 21:50:00', 0);


DELIMITER // 
CREATE PROCEDURE AtualizaEstoque (
IN produto_id INT, 
IN quantidade_vendida INT 
)
BEGIN 
UPDATE Produtos 
SET estoque = estoque - quantidade_vendida 
WHERE id = produto_id 
AND estoque >= quantidade_vendida;
END // 

DELIMITER ; 


-- CHAMANDO A PROCEDURE 
CALL AtualizaEstoque (5,3); 

-- APAGANDO UMA PROCEDURE 
DROP PROCEDURE AtualizaEstoque; 


-- SITUAÇÃO PROBLEMA 
DELIMITER //
CREATE PROCEDURE AplicaDesconto( 
    IN valor INT,
    OUT resposta DECIMAL(10,2) 
)
BEGIN 
    IF valor > 2000 THEN 
        SET resposta = valor * 0.9;

    ELSEIF valor > 1000 THEN 
        SET resposta = valor * 0.8;

    ELSE 
        SET resposta = valor; 
    END IF;

END //
DELIMITER ;

CALL AplicaDesconto (1500, @desconto); 
SELECT (@desconto); 

-- <<<<<<<<<<<<<<<<<<< Exemplo: VerificarEnvioProduto com uso de CASE >>>>>>>>>>>>>>>>>>>>>

DELIMITER //
CREATE PROCEDURE VerificarEnvioProduto(
 IN p_id_produto INT,
 OUT p_mensagem_envio VARCHAR(255)
)
BEGIN
 DECLARE v_tipo_produto VARCHAR(50);
 -- Obter o tipo do produto
 SELECT tipo_produto INTO v_tipo_produto
 FROM produtos
 WHERE id = p_id_produto;
 -- Avaliar a mensagem com base no tipo usando CASE
 CASE v_tipo_produto
 WHEN 'Alimentos' THEN
 SET p_mensagem_envio = 'Produto perecível';
 WHEN 'Livros' THEN
 SET p_mensagem_envio = 'Envio padrão';
 WHEN 'Vestuário' THEN
 SET p_mensagem_envio = 'Embalagem flexível';
 ELSE
 SET p_mensagem_envio = 'Avaliação manual';
 END CASE;
END //
DELIMITER ;


