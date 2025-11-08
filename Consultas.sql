USE SneezePharmaDB;

-- CLIENTES + TELEFONES + SITUAÇÃO
SELECT 
    c.IdCliente,
    c.Nome,
    c.CPF,
    c.DataNascimento,
    s.Situacao,
    t.CodPais,
    t.CodArea,
    t.Numero
FROM Clientes c
INNER JOIN SituacaoClientes s ON c.IdCliente = s.IdCliente
INNER JOIN Telefones t ON c.IdCliente = t.IdCliente;

-- CLIENTES + VENDAS + ITENSVENDA + MEDICAMENTOS
SELECT
v.IdVenda,
c.Nome AS Cliente,
m.Nome AS Medicamento,
iv.Quantidade,
iv.ValorUnitario,
iv.TotalItem,
v.ValorTotal,
v.DataVenda
FROM Vendas v
INNER JOIN Clientes c ON v.IdCliente = c.IdCliente
INNER JOIN ItensVenda iv ON v.IdVenda = iv.IdVenda
INNER JOIN Medicamentos m ON iv.IdMedicamento = m.IdMedicamento;

-- FORNECEDORES + COMPRAS + ITENSCOMPRA + PRINCÍPIOS ATIVOS
SELECT
f.IdFornecedor,
f.RazaoSocial AS Fornecedor,
f.CNPJ,
c.IdCompra,
pa.Nome AS PrincipioAtivo,
ic.Quantidade,
ic.ValorUnitario,
ic.TotalItem,
c.ValorTotal AS ValorCompra,
c.DataCompra
FROM Compras c
INNER JOIN Fornecedor f ON c.IdFornecedor = f.IdFornecedor
INNER JOIN ItensCompra ic ON c.IdCompra = ic.IdCompra
INNER JOIN PrincipiosAtivos pa ON ic.IdPrincipio = pa.IdPrincipio;

-- PRODUÇÕES + ITENSPRODUCAO + PRINCÍPIOS ATIVOS + MEDICAMENTOS
SELECT
pr.IdProducao,
m.Nome AS Medicamento,
pa.Nome AS PrincipioAtivo,
ip.QuantidadePrincipio,
pr.DataProducao,
pr.Quantidade AS QuantidadeProduzida
FROM Producoes pr
INNER JOIN Medicamentos m ON pr.IdMedicamento = m.IdMedicamento
INNER JOIN ItensProducao ip ON pr.IdProducao = ip.IdProducao
INNER JOIN PrincipiosAtivos pa ON ip.IdPrincipio = pa.IdPrincipio;

-- FORNECEDORES + SITUAÇÃO + TEMPO DE ABERTURA
SELECT
f.IdFornecedor,
f.RazaoSocial,
f.Pais,
s.Situacao,
DATEDIFF(YEAR, f.DataAbertura, GETDATE()) AS AnosDeAbertura
FROM Fornecedor f
INNER JOIN SituacaoFornecedores s ON f.IdFornecedor = s.IdFornecedor;

-- MEDICAMENTOS + SITUAÇÃO
SELECT
m.IdMedicamento,
m.Nome AS Medicamento,
m.Categoria,
s.Situacao
FROM Medicamentos m
INNER JOIN SituacaoMedicamentos s ON m.IdMedicamento = s.IdMedicamento;

-- CLIENTES RESTRITOS
SELECT
cr.IdClienteRestrito,
c.Nome AS Cliente
FROM ClientesRestritos cr
INNER JOIN Clientes c ON cr.IdCliente = c.IdCliente;

-- FORNECEDORES BLOQUEADOS
SELECT
fb.IdFornecedorBloqueado,
f.RazaoSocial AS Fornecedor
FROM FornecedoresBloqueados fb
INNER JOIN Fornecedor f ON fb.IdFornecedor = f.IdFornecedor;

-- VENDAS COMPLETAS
SELECT
v.IdVenda,
c.Nome AS Cliente,
sc.Situacao AS SituacaoCliente,
m.Nome AS Medicamento,
m.Categoria,
iv.Quantidade,
iv.TotalItem,
v.ValorTotal,
v.DataVenda
FROM Vendas v
INNER JOIN Clientes c ON v.IdCliente = c.IdCliente
INNER JOIN SituacaoClientes sc ON c.IdCliente = sc.IdCliente
INNER JOIN ItensVenda iv ON v.IdVenda = iv.IdVenda
INNER JOIN Medicamentos m ON iv.IdMedicamento = m.IdMedicamento;
