USE SneezePharmaDB

CREATE TABLE Clientes (
	IdCliente INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) NOT NULL UNIQUE,
	DataNascimento DATE NOT NULL,
	UltimaCompra DATE,
	DataCadastro DATE NOT NULL
);
GO

CREATE TABLE ClientesRestritos (
	IdClienteRestrito INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdCliente INTEGER NOT NULL UNIQUE
);
GO

CREATE TABLE Fornecedor (
	IdFornecedor INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CNPJ VARCHAR(14) NOT NULL UNIQUE,
	RazaoSocial VARCHAR(50) NOT NULL,
	Pais VARCHAR(20) NOT NULL,
	DataAbertura DATE NOT NULL,
	UltimoFornecimento DATE,
	DataCadastro DATE NOT NULL
);
GO

CREATE TABLE FornecedoresBloqueados (
	IdFornecedorBloqueado INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdFornecedor INTEGER NOT NULL UNIQUE
);
GO

CREATE TABLE PrincipiosAtivos (
	IdPrincipio INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL, 
	UltimaCompra DATE,
	DataCadastro DATE NOT NULL
);
GO

CREATE TABLE Medicamentos (
	IdMedicamento INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CDB VARCHAR(13) NOT NULL UNIQUE,
	Nome VARCHAR(50) NOT NULL,
	Categoria CHAR(1) NOT NULL,
	ValorVenda DECIMAL(7,2) NOT NULL,
	UltimaVenda DATE,
	DataCadastro DATE NOT NULL
);
GO

CREATE TABLE ItensVenda (
	IdItemVenda INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdVenda INTEGER NOT NULL,
	IdMedicamento INTEGER NOT NULL,
	Quantidade INTEGER NOT NULL,
	ValorUnitario DECIMAL(7,2) NOT NULL,
	TotalItem AS (Quantidade * ValorUnitario) PERSISTED
);
GO

CREATE TABLE Compras (
	IdCompra INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdFornecedor INTEGER NOT NULL,
	DataCompra DATE NOT NULL,
	ValorTotal DECIMAL(9,2) NOT NULL
);
GO

CREATE TABLE ItensCompra (
	IdItemCompra INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdPrincipio INTEGER NOT NULL,
	IdCompra INTEGER NOT NULL,
	Quantidade DECIMAL(7,2) NOT NULL,
	ValorUnitario DECIMAL(7,2) NOT NULL,
	TotalItem AS (Quantidade * ValorUnitario) PERSISTED
);
GO

CREATE TABLE Producoes (
	IdProducao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdMedicamento INTEGER NOT NULL,
	DataProducao DATE NOT NULL,
	Quantidade INTEGER NOT NULL
);
GO

CREATE TABLE Telefones (
	IdTelefone INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CodPais VARCHAR(2) NOT NULL,
	CodArea VARCHAR(2) NOT NULL,
	Numero VARCHAR (9) NOT NULL,
	IdCliente INTEGER NOT NULL
);
GO

CREATE TABLE SituacaoClientes (
	IdSituacao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Situacao CHAR(1) NOT NULL,
	IdCliente INTEGER NOT NULL
);
GO

CREATE TABLE Vendas (
	IdVenda INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdCliente INTEGER NOT NULL,
	DataVenda DATE NOT NULL,
	ValorTotal DECIMAL(9,2) NOT NULL
);
GO

CREATE TABLE ItensProducao (
	IdItemProducao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdProducao INTEGER NOT NULL,
	IdPrincipio INTEGER NOT NULL,
	QuantidadePrincipio DECIMAL(7,2) NOT NULL
);
GO

CREATE TABLE SituacaoMedicamentos (
	IdSituacao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Situacao CHAR(1) NOT NULL,
	IdMedicamento INTEGER NOT NULL
);
GO

CREATE TABLE SituacaoFornecedores (
	IdSituacao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Situacao CHAR(1) NOT NULL,
	IdFornecedor INTEGER NOT NULL
);
GO

CREATE TABLE SituacaoPrincipiosAtivos (
	IdSituacao INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Situacao CHAR(1) NOT NULL,
	IdPrincipio INTEGER NOT NULL
);
GO

ALTER TABLE Telefones
ADD CONSTRAINT FK_Telefones_Clientes
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente);
GO

ALTER TABLE ClientesRestritos
ADD CONSTRAINT FK_ClientesRestritos_Clientes
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente);
GO

ALTER TABLE SituacaoClientes
ADD CONSTRAINT FK_SituacaoClientes_Clientes
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente);
GO

ALTER TABLE Vendas
ADD CONSTRAINT FK_Vendas_Clientes
FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente);
GO

ALTER TABLE ItensVenda
ADD CONSTRAINT FK_ItensVenda_Vendas
FOREIGN KEY (IdVenda) REFERENCES Vendas(IdVenda);
GO

ALTER TABLE ItensVenda
ADD CONSTRAINT FK_ItensVenda_Medicamentos
FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento);
GO

ALTER TABLE Compras
ADD CONSTRAINT FK_Compras_Fornecedor
FOREIGN KEY (IdFornecedor) REFERENCES Fornecedor(IdFornecedor);
GO

ALTER TABLE ItensCompra
ADD CONSTRAINT FK_ItensCompra_Compras
FOREIGN KEY (IdCompra) REFERENCES Compras(IdCompra);
GO

ALTER TABLE ItensCompra
ADD CONSTRAINT FK_ItensCompra_PrincipiosAtivos
FOREIGN KEY (IdPrincipio) REFERENCES PrincipiosAtivos(IdPrincipio);
GO

ALTER TABLE Producoes
ADD CONSTRAINT FK_Producoes_Medicamentos
FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento);
GO

ALTER TABLE ItensProducao
ADD CONSTRAINT FK_ItensProducao_Producoes
FOREIGN KEY (IdProducao) REFERENCES Producoes(IdProducao);
GO

ALTER TABLE ItensProducao
ADD CONSTRAINT FK_ItensProducao_PrincipiosAtivos
FOREIGN KEY (IdPrincipio) REFERENCES PrincipiosAtivos(IdPrincipio);
GO

ALTER TABLE SituacaoMedicamentos
ADD CONSTRAINT FK_SituacaoMedicamentos_Medicamentos
FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento);
GO

ALTER TABLE SituacaoFornecedores
ADD CONSTRAINT FK_SituacaoFornecedores_Fornecedor
FOREIGN KEY (IdFornecedor) REFERENCES Fornecedor(IdFornecedor);
GO

ALTER TABLE SituacaoPrincipiosAtivos
ADD CONSTRAINT FK_SituacaoPrincipiosAtivos_PrincipiosAtivos
FOREIGN KEY (IdPrincipio) REFERENCES PrincipiosAtivos(IdPrincipio);
GO

ALTER TABLE FornecedoresBloqueados
ADD CONSTRAINT FK_FornecedoresBloqueados_Fornecedor
FOREIGN KEY (IdFornecedor) REFERENCES Fornecedor(IdFornecedor);
GO
