CREATE DATABASE petshop;
USE petshop;  

CREATE TABLE Cliente( 
    CPF VARCHAR(11) PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    telefone VARCHAR(12) NOT NULL, 
    endereco TEXT NOT NULL 
); 

