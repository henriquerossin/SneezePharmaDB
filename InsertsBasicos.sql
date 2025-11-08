/*
Ordem dos inserts pro caminho feliz (seguir pra sempre):

- Clientes
- Telefones (depende de Clientes)
- SituaçãoClientes (depende de Clientes)
- Fornecedor
- SituaçãoFornecedores
- PrincipiosAtivos
- SituaçãoPrincipiosAtivos
- Medicamentos
- SituaçãoMedicamentos
- Produções -> ItensProducao -> Compras -> ItensCompra -> Vendas -> ItensVenda
*/

USE SneezePharmaDB;
GO

INSERT INTO Clientes (Nome, CPF, DataNascimento, UltimaCompra, DataCadastro)
VALUES
('Ana Costa', '12345678901', '1990-05-10', NULL, GETDATE()),
('Carlos Silva', '98765432100', '1985-09-15', NULL, GETDATE()),
('Mariana Souza', '45678912345', '1999-03-22', NULL, GETDATE());
GO

INSERT INTO Telefones (CodPais, CodArea, Numero, IdCliente)
VALUES
('55', '11', '988776655', 1),
('55', '21', '997654321', 2),
('55', '31', '988123456', 3);
GO

INSERT INTO SituacaoClientes (Situacao, IdCliente)
VALUES
('A', 1),
('A', 2),
('A', 3);
GO

INSERT INTO Fornecedor (CNPJ, RazaoSocial, Pais, DataAbertura, UltimoFornecimento, DataCadastro)
VALUES
('12345678000199', 'Farmabrasil LTDA', 'Brasil', '2018-01-01', NULL, GETDATE()),
('98765432000111', 'SaudeMais SA', 'Brasil', '2020-06-10', NULL, GETDATE()),
('55544433000122', 'Vida Natural', 'Argentina', '2015-09-05', NULL, GETDATE());
GO

INSERT INTO SituacaoFornecedores (Situacao, IdFornecedor)
VALUES
('A', 1),
('A', 2),
('A', 3);
GO

INSERT INTO PrincipiosAtivos (Nome, UltimaCompra, DataCadastro)
VALUES
('Paracetamol', NULL, GETDATE()),
('Ibuprofeno', NULL, GETDATE()),
('Dipirona', NULL, GETDATE());
GO

INSERT INTO SituacaoPrincipiosAtivos (Situacao, IdPrincipio)
VALUES
('A', 1),
('A', 2),
('A', 3);
GO

INSERT INTO Medicamentos (CDB, Nome, Categoria, ValorVenda, UltimaVenda, DataCadastro)
VALUES
('7891234567890', 'Paracetamol 500mg', 'A', 9.90, NULL, GETDATE()),
('7899876543210', 'Ibuprofeno 400mg', 'V', 14.50, NULL, GETDATE()),
('7891112223334', 'Dipirona 1g', 'B', 12.75, NULL, GETDATE());
GO

INSERT INTO SituacaoMedicamentos (Situacao, IdMedicamento)
VALUES
('A', 1),
('A', 2),
('A', 3);
GO

INSERT INTO Producoes (IdMedicamento, DataProducao, Quantidade)
VALUES
(1, '2024-01-10', 1000),
(2, '2024-02-15', 800),
(3, '2024-03-20', 1200);
GO

INSERT INTO ItensProducao (IdProducao, IdPrincipio, QuantidadePrincipio)
VALUES
(1, 1, 250.00),
(2, 2, 200.00),
(3, 3, 300.00);
GO

INSERT INTO Compras (IdFornecedor, DataCompra, ValorTotal)
VALUES
(1, '2024-04-10', 1500.00),
(2, '2024-05-12', 2300.00),
(3, '2024-06-20', 1800.00);
GO

INSERT INTO ItensCompra (IdPrincipio, IdCompra, Quantidade, ValorUnitario)
VALUES
(1, 1, 100.00, 10.00),
(2, 2, 150.00, 12.00),
(3, 3, 200.00, 9.00);
GO

INSERT INTO Vendas (IdCliente, DataVenda, ValorTotal)
VALUES
(1, '2024-07-10', 100.00),
(2, '2024-07-11', 150.00),
(3, '2024-07-12', 200.00);
GO

INSERT INTO ItensVenda (IdVenda, IdMedicamento, Quantidade, ValorUnitario)
VALUES
(1, 1, 2, 9.90),
(2, 2, 3, 14.50),
(3, 3, 2, 12.75);
GO

INSERT INTO ClientesRestritos (IdCliente)
VALUES
(2),
(3),
(1);
GO

INSERT INTO FornecedoresBloqueados (IdFornecedor)
VALUES
(3),
(2),
(1);
GO
