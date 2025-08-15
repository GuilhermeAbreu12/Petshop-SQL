# Sistema de Banco de Dados - Pet Shop

Este projeto consiste em um **banco de dados relacional** para um sistema de Pet Shop, desenvolvido como atividade prática na **ETEC Antônio Devisate**. O sistema gerencia clientes, animais, funcionários, serviços prestados e vendas de produtos, oferecendo consultas detalhadas por meio de views específicas.

---

## 📌 Objetivo

- Registrar informações de clientes, animais de estimação e funcionários.
- Controlar serviços prestados aos animais (como consultas, banho e tosa).
- Gerenciar produtos disponíveis à venda e registrar compras realizadas.
- Fornecer relatórios detalhados de serviços e compras por meio de views.

---

## 🗄️ Estrutura do Banco de Dados

### 1. Tabelas

| Tabela           | Descrição |
|-----------------|-----------|
| **Cliente**      | Armazena CPF, nome, telefone e endereço dos clientes. |
| **Animal**       | Contém código, nome, tipo do animal e CPF do dono. |
| **Funcionario**  | Contém CPF, nome, endereço, telefone e função do funcionário. |
| **Servico_Animal** | Registra serviços prestados aos animais, incluindo código do serviço, cliente, funcionário, animal, descrição, preço e data. |
| **Produto**      | Armazena código, nome, descrição, preço e quantidade em estoque. |
| **Compra**       | Registra compras realizadas, com CPF do cliente, CPF do funcionário, valor total e data. |
| **CompraProduto** | Relaciona produtos às compras realizadas. |

### 2. Relacionamentos

- Cada **Animal** pertence a um **Cliente** (`CPF_dono` → `Cliente.CPF`).
- Cada **Servico_Animal** relaciona Cliente, Funcionário e Animal.
- Cada **Compra** está vinculada a um Cliente e a um Funcionário.
- A tabela **CompraProduto** estabelece a relação muitos-para-muitos entre Compras e Produtos.

---

## 👁️ Views

### 1. `Boletim_Servicos`

Exibe o histórico completo dos serviços prestados:

- Nome do cliente
- Nome do animal
- Descrição do serviço
- Nome do funcionário responsável
- Preço do serviço
- Data do serviço

```sql
SELECT * FROM Boletim_Servicos;
```

### 2. `Relatorio_Compras`

Exibe o detalhamento das compras realizadas:

- Nome do cliente
- Nome do funcionário que realizou a venda
- Código da compra
- Nome do produto comprado
- Valor total da compra
- Data da compra

```sql
SELECT * FROM Relatorio_Compras;
```

---

## ✍🏻 Exemplos de Inserção de Dados

```sql
INSERT INTO Cliente (CPF, nome, telefone, endereco) VALUES 
('12345678900', 'Jair Ferreira', '14999990000', 'Rua A, 100 - Marília');

INSERT INTO Animal (nome, tipo, CPF_dono) VALUES 
('Flutter', 'Cachorro', '12345678900');

INSERT INTO Funcionario (CPF, nome, endereco, telefone, funcao) VALUES 
('11223344556', 'Fernanda Oliveira', 'Rua Zilda Bolsonaro, 10 - Marília', '14988880000', 'Veterinária');

INSERT INTO Servico_Animal (CPF_cliente, CPF_funcionario, codigo_animal, descricao_servico, preco, data_servico) VALUES 
('12345678900', '11223344556', 1, 'Consulta clínica', 120.00, '2025-07-31');
```

---

## 🛠 Tecnologias Utilizadas
- **SGBD:** MySQL;
- **Linguagem de Consulta:** SQL;
- **Ferramentas:** Workbench, scripts SQL para criação, inserção e consultas.

---

## 🔍 Observações
- Todas as relações estão configuradas com **ON DELETE CASCADE** para manter a integridade referencial.
- Os scripts foram criados a fim de concluir duas atividades práticas da **ETEC Antônio Devisate**.
- Este banco de dados serve como base para aprendizado e desenvolvimento de sistemas de Pet Shop completos.
