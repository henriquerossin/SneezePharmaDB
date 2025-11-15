USE SneezePharmaDB;
GO

-- Registrar Produção
CREATE OR ALTER PROCEDURE sp_RegistrarProducao
    @IdMedicamento INT,
    @DataProducao DATE,
    @Quantidade INT,
    @IdPrincipio INT,
    @QuantidadePrincipio DECIMAL(7,2)
AS
BEGIN
    DECLARE @IdProducao INT;

    INSERT INTO Producoes (IdMedicamento, DataProducao, Quantidade)
    VALUES (@IdMedicamento, @DataProducao, @Quantidade);

    SET @IdProducao = SCOPE_IDENTITY();

    INSERT INTO ItensProducao (IdProducao, IdPrincipio, QuantidadePrincipio)
    VALUES (@IdProducao, @IdPrincipio, @QuantidadePrincipio);
END;
GO

-- Exemplo funcionando
EXEC sp_RegistrarProducao 
    @IdMedicamento = 1,
    @DataProducao = '2025-01-01',
    @Quantidade = 500,
    @IdPrincipio = 2,
    @QuantidadePrincipio = 150.00;
GO

-- Registrar Compra
CREATE OR ALTER PROCEDURE sp_RegistrarCompra
    @IdFornecedor INT,
    @DataCompra DATE,
    @ValorTotal DECIMAL(10,2),
    @IdPrincipio INT,
    @Quantidade DECIMAL(10,2),
    @ValorUnitario DECIMAL(10,2)
AS
BEGIN
    DECLARE @IdCompra INT;

    INSERT INTO Compras (IdFornecedor, DataCompra, ValorTotal)
    VALUES (@IdFornecedor, @DataCompra, @ValorTotal);

    SET @IdCompra = SCOPE_IDENTITY();

    INSERT INTO ItensCompra (IdPrincipio, IdCompra, Quantidade, ValorUnitario)
    VALUES (@IdPrincipio, @IdCompra, @Quantidade, @ValorUnitario);
END;
GO

-- Exemplo funcionando
EXEC sp_RegistrarCompra 
    @IdFornecedor = 1,
    @DataCompra = '2025-01-01',
    @ValorTotal = 1500.00,
    @IdPrincipio = 2,
    @Quantidade = 100.00,
    @ValorUnitario = 15.00;
GO

-- Registrar Venda Completa

USE SneezePharmaDB;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarVenda
    @IdCliente INT,

    @IdMedicamento1 INT = NULL,
    @Quantidade1 INT = NULL,
    @ValorUnitario1 DECIMAL(7,2) = NULL,

    @IdMedicamento2 INT = NULL,
    @Quantidade2 INT = NULL,
    @ValorUnitario2 DECIMAL(7,2) = NULL,

    @IdMedicamento3 INT = NULL,
    @Quantidade3 INT = NULL,
    @ValorUnitario3 DECIMAL(7,2) = NULL

AS
BEGIN
    DECLARE @IdVenda INT;
    DECLARE @ValorTotal DECIMAL(9,2) = 0;

    IF @IdMedicamento1 IS NOT NULL
        SET @ValorTotal += (@Quantidade1 * @ValorUnitario1);

    IF @IdMedicamento2 IS NOT NULL
        SET @ValorTotal += (@Quantidade2 * @ValorUnitario2);

    IF @IdMedicamento3 IS NOT NULL
        SET @ValorTotal += (@Quantidade3 * @ValorUnitario3);

    INSERT INTO Vendas (IdCliente, DataVenda, ValorTotal)
    VALUES (@IdCliente, GETDATE(), @ValorTotal);

    SET @IdVenda = SCOPE_IDENTITY();

    IF @IdMedicamento1 IS NOT NULL
    BEGIN
        INSERT INTO ItensVenda (IdVenda, IdMedicamento, Quantidade, ValorUnitario)
        VALUES (@IdVenda, @IdMedicamento1, @Quantidade1, @ValorUnitario1);
    END

    IF @IdMedicamento2 IS NOT NULL
    BEGIN
        INSERT INTO ItensVenda (IdVenda, IdMedicamento, Quantidade, ValorUnitario)
        VALUES (@IdVenda, @IdMedicamento2, @Quantidade2, @ValorUnitario2);
    END

    IF @IdMedicamento3 IS NOT NULL
    BEGIN
        INSERT INTO ItensVenda (IdVenda, IdMedicamento, Quantidade, ValorUnitario)
        VALUES (@IdVenda, @IdMedicamento3, @Quantidade3, @ValorUnitario3);
    END

END;
GO

-- Exemplo funcionando
EXEC sp_RegistrarVenda
    @IdCliente = 1,

    @IdMedicamento1 = 1,
    @Quantidade1 = 3,
    @ValorUnitario1 = 9.90,

    @IdMedicamento2 = 2,
    @Quantidade2 = 1,
    @ValorUnitario2 = 14.50,

    @IdMedicamento3 = 3,
    @Quantidade3 = 2,
    @ValorUnitario3 = 12.75;
GO

-- Relatório de compras por fornecedor
CREATE OR ALTER PROCEDURE sp_ComprasFornecedor
AS
BEGIN
    SELECT 
        f.RazaoSocial,
        COUNT(DISTINCT c.IdCompra) AS QuantidadeCompras,
        COUNT(i.IdCompra) AS ItensComprados,
        ISNULL(SUM(i.TotalItem), 0) AS ValorTotalGasto,
        MAX(c.DataCompra) AS UltimaCompra
    FROM Fornecedor f
    LEFT JOIN Compras c ON c.IdFornecedor = f.IdFornecedor
    LEFT JOIN ItensCompra i ON i.IdCompra = c.IdCompra
    GROUP BY f.RazaoSocial;
END;
GO

-- Exemplo funcionando
EXEC sp_ComprasFornecedor;
GO
