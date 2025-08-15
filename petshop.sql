CREATE DATABASE petshop;
USE petshop;  

CREATE TABLE Cliente( 
    CPF VARCHAR(11) PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    telefone VARCHAR(12) NOT NULL, 
    endereco TEXT NOT NULL 
); 

CREATE TABLE Animal( 
    Codigo INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    tipo VARCHAR(30) NOT NULL, 
    CPF_dono VARCHAR(11) NOT NULL, 

    FOREIGN KEY(CPF_dono) REFERENCES Cliente(CPF) ON DELETE CASCADE 
); 

CREATE TABLE Funcionario( 
    CPF VARCHAR(11) PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    endereco VARCHAR(200) NOT NULL, 
    telefone VARCHAR(12) NOT NULL, 
    funcao VARCHAR(200) NOT NULL 
); 

CREATE TABLE Servico_Animal( 
    codigo_servico INT AUTO_INCREMENT PRIMARY KEY, 
    CPF_cliente VARCHAR(11) NOT NULL, 
    CPF_funcionario VARCHAR(11) NOT NULL, 
    codigo_animal INT NOT NULL, 
    descricao_servico VARCHAR(100) NOT NULL, 
    preco DECIMAL(10,2) NOT NULL, 
    data_servico DATE NOT NULL, 

    FOREIGN KEY (CPF_cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE,  
    FOREIGN KEY (CPF_funcionario) REFERENCES Funcionario(CPF) ON DELETE CASCADE,  
    FOREIGN KEY (codigo_animal) REFERENCES Animal(Codigo) ON DELETE CASCADE 
); 

CREATE TABLE Produto( 
    codigo_produto INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(200) NOT NULL, 
    descricao VARCHAR(200) NOT NULL, 
    preco DECIMAL(10,2) NOT NULL, 
    qtd_estoque INT NOT NULL 
); 

CREATE TABLE Compra( 
    codigo_compra INT AUTO_INCREMENT PRIMARY KEY, 
    CPF_cliente VARCHAR(11) NOT NULL, 
    CPF_funcionario VARCHAR(11) NOT NULL, 
    valor_total DECIMAL(10,2) NOT NULL, 
    data_compra DATE NOT NULL, 

    FOREIGN KEY (CPF_cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE, 
    FOREIGN KEY (CPF_funcionario) REFERENCES Funcionario(CPF) ON DELETE CASCADE 
); 

CREATE TABLE CompraProduto(
    codigo_produto INT, 
    codigo_compra INT, 

    PRIMARY KEY (codigo_produto, codigo_compra) 
    FOREIGN KEY (codigo_produto) REFERENCES Produto(codigo_produto) ON DELETE CASCADE, 
    FOREIGN KEY (codigo_compra) REFERENCES Compra(codigo_compra) ON DELETE CASCADE 
);

-- Views
CREATE OR REPLACE VIEW Boletim_Servicos AS 
    SELECT 
        C.nome AS nome_cliente, 
        A.nome AS nome_animal, 
        S.descricao_servico AS descricao_servico, 
        F.nome AS nome_funcionario, 
        S.preco AS preco, 
        S.data_servico AS data_servico 
    FROM Servico_Animal S 
        JOIN Cliente C ON C.CPF = S.CPF_cliente 
        JOIN Funcionario F ON F.CPF = S.CPF_funcionario 
        JOIN Animal A ON A.Codigo = S.codigo_animal; 

CREATE OR REPLACE VIEW Relatorio_Compras AS 
	SELECT 
		CL.nome AS nome_cliente, 
        F.nome AS nome_funcionario, 
        CO.codigo_compra AS codigo_compra, 
        P.nome AS nome_produto, 
        CO.valor_total AS valor_total, 
        CO.data_compra AS data_compra 
    FROM Compra CO
		JOIN Cliente CL ON CL.CPF = CO.CPF_cliente
        JOIN Funcionario F ON F.CPF = CO.CPF_funcionario
        JOIN CompraProduto CP ON CP.codigo_compra = CO.codigo_compra
        JOIN Produto P ON P.codigo_produto = CP.codigo_produto;  

-- Insert values
INSERT INTO Cliente (CPF, nome, telefone, endereco) VALUES 
    ('12345678900', 'Jair Ferreira', '14999990000', 'Rua A, 100 - Marília'), 
    ('98765432100', 'Marina Messias', '14999991111', 'Rua B, 200 - Marília'), 
    ('45678912300', 'Nikolas Silva', '14999992222', 'Rua C, 300 - Marília'); 

INSERT INTO Animal (nome, tipo, CPF_dono) VALUES 
    ('Flutter', 'Cachorro', '12345678900'), 
    ('Eu', 'Gato', '98765432100'), 
    ('Gaio', 'Papagaio', '45678912300'); 

INSERT INTO Funcionario (CPF, nome, endereco, telefone, funcao) VALUES 
    ('11223344556', 'Fernanda Oliveira', 'Rua Zilda Bolsonaro, 10 - Marília', '14988880000', 'Veterinária'), 
    ('22334455667', 'Ricardo Mendes', 'Rua Yumi Iupy, 20 - Marília', '14987771111', 'Banho e Tosa'), 
    ('33445566778', 'Juliana Rocha', 'Rua Professor Xavier, 30 - Marília', '14986662222', 'Atendente'); 

INSERT INTO Servico_Animal (CPF_cliente, CPF_funcionario, codigo_animal, descricao_servico, preco, data_servico) VALUES 
    ('12345678900', '11223344556', 1, 'Consulta clínica', 120.00, '2025-07-31'), 
    ('98765432100', '22334455667', 2, 'Banho e Tosa', 80.00, '2025-07-30'), 
    ('45678912300', '11223344556', 3, 'Consulta e vacinação', 150.00, '2025-07-29'); 

INSERT INTO Produto (nome, descricao, preco, qtd_estoque) VALUES
    ('Ração Premium', 'Ração para cães adultos', 150.00, 20),
    ('Coleira Luxo', 'Coleira de couro ajustável', 80.00, 15),
    ('Brinquedo Bola', 'Bola de borracha para cães', 25.00, 30);

INSERT INTO Compra (CPF_cliente, CPF_funcionario, valor_total, data_compra) VALUES
    ('12345678900', '11223344556', 250.00, '2025-08-04'),
    ('98765432100', '22334455667', 300.00, '2025-08-04'),
    ('45678912300', '33445566778', 150.00, '2025-08-04');

INSERT INTO CompraProduto (codigo_produto, codigo_compra) VALUES
    (1, 1),
    (2, 1),  
    (3, 2), 
    (1, 3); 

