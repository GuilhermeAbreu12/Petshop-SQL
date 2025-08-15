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

