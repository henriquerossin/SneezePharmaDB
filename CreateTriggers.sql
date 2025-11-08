USE SneezePharmaDB
GO

CREATE TRIGGER TRG_Medicamentos_Categoria
ON Medicamentos
FOR INSERT, UPDATE
AS
BEGIN

IF EXISTS (
SELECT 1
FROM inserted
WHERE Categoria NOT IN ('A', 'I', 'V', 'B')
)

BEGIN
RAISERROR ('Categoria inválida! Só pode ser A, I, V ou B.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE TRIGGER TRG_Clientes_IdadeMinima
ON Clientes
FOR INSERT, UPDATE
AS
BEGIN

IF EXISTS (
SELECT 1
FROM inserted
WHERE 
DATEDIFF(YEAR, DataNascimento, GETDATE()) - CASE 
WHEN DATEADD(YEAR, DATEDIFF(YEAR, DataNascimento, GETDATE()), DataNascimento) > GETDATE() 
THEN 1 ELSE 0 
END < 18
)

BEGIN
RAISERROR ('Cliente deve ter pelo menos 18 anos.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_Vendas_ClienteInativo
ON dbo.Vendas
AFTER INSERT
AS
BEGIN

SET NOCOUNT ON
IF EXISTS (
SELECT 1
FROM inserted i
INNER JOIN dbo.SituacaoClientes s ON i.IdCliente = s.IdCliente
WHERE s.Situacao = 'I'
)

BEGIN
RAISERROR ('Cliente inativo não pode realizar compras.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_Compras_FornecedorRestricao
ON dbo.Compras
AFTER INSERT
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS (
SELECT 1
FROM inserted i
INNER JOIN dbo.Fornecedor f ON i.IdFornecedor = f.IdFornecedor
WHERE DATEDIFF(YEAR, f.DataAbertura, GETDATE()) < 2
)

BEGIN
RAISERROR ('Fornecedor com menos de 2 anos de abertura não pode vender.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

IF EXISTS (
SELECT 1
FROM inserted i
INNER JOIN dbo.SituacaoFornecedores s ON i.IdFornecedor = s.IdFornecedor
WHERE s.Situacao = 'I'
)

BEGIN
RAISERROR ('Fornecedor inativo não pode vender.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_SituacaoClientes_Valida
ON dbo.SituacaoClientes
AFTER INSERT, UPDATE
AS
BEGIN

SET NOCOUNT ON;
IF EXISTS (
SELECT 1
FROM inserted
WHERE Situacao NOT IN ('A', 'I')
)

BEGIN
RAISERROR ('Situação inválida! Só é permitido A (Ativo) ou I (Inativo).', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_SituacaoFornecedores_Valida
ON dbo.SituacaoFornecedores
AFTER INSERT, UPDATE
AS
BEGIN

SET NOCOUNT ON;
IF EXISTS (
SELECT 1
FROM inserted
WHERE Situacao NOT IN ('A', 'I')
)

BEGIN
RAISERROR ('Situação inválida! Só é permitido A (Ativo) ou I (Inativo).', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_SituacaoMedicamentos_Valida
ON dbo.SituacaoMedicamentos
AFTER INSERT, UPDATE
AS
BEGIN

SET NOCOUNT ON;
IF EXISTS (
SELECT 1
FROM inserted
WHERE Situacao NOT IN ('A', 'I')
)

BEGIN
RAISERROR ('Situação inválida! Só é permitido A (Ativo) ou I (Inativo).', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO

CREATE OR ALTER TRIGGER TRG_SituacaoPrincipiosAtivos_Valida
ON dbo.SituacaoPrincipiosAtivos
AFTER INSERT, UPDATE
AS
BEGIN

SET NOCOUNT ON;
IF EXISTS (
SELECT 1
FROM inserted
WHERE Situacao NOT IN ('A', 'I')
)

BEGIN

RAISERROR ('Situação inválida! Só é permitido A (Ativo) ou I (Inativo).', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END

END;
GO
