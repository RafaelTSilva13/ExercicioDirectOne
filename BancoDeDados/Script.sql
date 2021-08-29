USE [master]
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE [name] = 'Teste')
BEGIN
	CREATE DATABASE Teste COLLATE SQL_Latin1_General_CP850_CI_AI
END
GO

ALTER DATABASE Teste SET AUTO_CLOSE OFF 
GO

USE [Teste]
GO


/******************************************
*************** Tabelas *******************
******************************************/


IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblTipoTelefone')
BEGIN
	CREATE TABLE tblTipoTelefone
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		Descricao				NVARCHAR(100)			NULL,
		Ativo					TINYINT					NULL,		
		DataCriado				DATETIME				NULL,		
		DataModificado			DATETIME				NULL,		
		
		PRIMARY KEY(ID)
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblTipoRedeSocial')
BEGIN
	CREATE TABLE tblTipoRedeSocial
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		Descricao				NVARCHAR(100)			NULL,
		Ativo					TINYINT					NULL,		
		DataCriado				DATETIME				NULL,		
		DataModificado			DATETIME				NULL,		
		
		PRIMARY KEY(ID)
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblTipoEndereco')
BEGIN
	CREATE TABLE tblTipoEndereco
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		Descricao				NVARCHAR(100)			NULL,
		Ativo					TINYINT					NULL,		
		DataCriado				DATETIME				NULL,		
		DataModificado			DATETIME				NULL,		
		
		PRIMARY KEY(ID)
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblCliente')
BEGIN
	CREATE TABLE tblCliente
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		Nome					NVARCHAR(100)			NOT NULL,
		CPF						NVARCHAR(20)			NOT NULL,
		RG						NVARCHAR(20)			NOT NULL,
		DataNascimento			DATETIME				NOT NULL,
		Ativo					TINYINT					NOT NULL,
		DataCriado				DATETIME				NULL,		
		DataModificado			DATETIME				NULL,		
		
		PRIMARY KEY(ID)
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblTelefone')
BEGIN
	CREATE TABLE tblTelefone
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		ID_Cliente				BIGINT					NOT NULL,
		ID_TipoTelefone			BIGINT					NOT NULL,
		DDD						NVARCHAR(3)				NOT NULL,
		Numero					NVARCHAR(15)			NOT NULL,
		Ativo					TINYINT					NOT NULL,
		DataCriado				DATETIME				NOT NULL,
		DataModificado			DATETIME				NULL,
		
		PRIMARY KEY(ID),
		CONSTRAINT FK_TBLTELEFONE_TBLCLIENTE FOREIGN KEY(ID_Cliente) REFERENCES tblCliente(ID) ON DELETE CASCADE,
		CONSTRAINT FK_TBLTELEFONE_TBLTIPOTELEFONE FOREIGN KEY(ID_TipoTelefone) REFERENCES tblTipoTelefone(ID) ON DELETE CASCADE,
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblEndereco')
BEGIN
	CREATE TABLE tblEndereco
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		ID_Cliente				BIGINT					NOT NULL,
		ID_TipoEndereco			BIGINT					NOT NULL,
		CEP						NVARCHAR(15)			NOT NULL,
		Logradouro				NVARCHAR(100)			NOT NULL,
		Numero					INT						NOT NULL,
		Complemento				NVARCHAR(50)			NOT NULL,
		Ativo					TINYINT					NOT NULL,
		DataCriado				DATETIME				NOT NULL,
		DataModificado			DATETIME				NULL,
		
		PRIMARY KEY(ID),
		CONSTRAINT FK_TBLENDERECO_TBLCLIENTE FOREIGN KEY(ID_Cliente) REFERENCES tblCliente(ID) ON DELETE CASCADE,
		CONSTRAINT FK_TBLENDERECO_TBLTIPOENDERECO FOREIGN KEY(ID_TipoEndereco) REFERENCES tblTipoEndereco(ID) ON DELETE CASCADE,
	)
END
GO

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tblRedeSocial')
BEGIN
	CREATE TABLE tblRedeSocial
	(
		ID						BIGINT IDENTITY(1,1)	NOT NULL,	-- PK.
		ID_Cliente				BIGINT					NOT NULL,
		ID_TipoRedeSocial		BIGINT					NOT NULL,
		URL						NVARCHAR(150)			NOT NULL,
		Ativo					TINYINT					NOT NULL,
		DataCriado				DATETIME				NOT NULL,
		DataModificado			DATETIME				NULL,
		
		PRIMARY KEY(ID),
		CONSTRAINT FK_TBLREDESOCIAL_TBLCLIENTE FOREIGN KEY(ID_Cliente) REFERENCES tblCliente(ID) ON DELETE CASCADE,
		CONSTRAINT FK_TBLREDESOCIAL_TBLTIPOREDESOCIAL FOREIGN KEY(ID_TipoRedeSocial) REFERENCES tblTipoRedeSocial(ID) ON DELETE CASCADE,
	)
END
GO

/******************************************
********** CRUD tblTipoTelefone ***********
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaTipoTelefone'))
BEGIN
	DROP PROCEDURE spListaTipoTelefone
END
GO

CREATE PROCEDURE spListaTipoTelefone
AS
BEGIN TRY
	SELECT * FROM tblTipoTelefone
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
********* CRUD tblTipoRedeSocial **********
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaTipoRedeSocial'))
BEGIN
	DROP PROCEDURE spListaTipoRedeSocial
END
GO

CREATE PROCEDURE spListaTipoRedeSocial
AS
BEGIN TRY
	SELECT * FROM tblTipoRedeSocial
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
********** CRUD tblTipoEndereco ***********
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaTipoEndereco'))
BEGIN
	DROP PROCEDURE spListaTipoEndereco
END
GO

CREATE PROCEDURE spListaTipoEndereco
AS
BEGIN TRY
	SELECT * FROM tblTipoEndereco
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
**********  CRUD tblCliente  **************
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spInsereCliente'))
BEGIN
	DROP PROCEDURE spInsereCliente
END
GO

CREATE PROCEDURE spInsereCliente
(
@Nome NVARCHAR(100),
@CPF NVARCHAR(20),
@RG NVARCHAR(20),
@DataNascimento DATETIME,
@Ativo TINYINT
)
AS
BEGIN TRY
	INSERT INTO tblCliente(Nome, CPF, RG, DataNascimento, Ativo, DataCriado)
	OUTPUT inserted.ID
	VALUES (@Nome, @CPF, @RG, @DataNascimento, @Ativo, GETDATE())
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spObtemClientePorID'))
BEGIN
	DROP PROCEDURE spObtemClientePorID
END
GO

CREATE PROCEDURE spObtemClientePorID
(
@ID BIGINT
)
AS
BEGIN TRY
	SELECT * FROM tblCliente WHERE ID = @ID
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaCliente'))
BEGIN
	DROP PROCEDURE spListaCliente
END
GO

CREATE PROCEDURE spListaCliente
AS
BEGIN TRY
	SELECT * FROM tblCliente WHERE Ativo = 1
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spAtualizaCliente'))
BEGIN
	DROP PROCEDURE spAtualizaCliente
END
GO

CREATE PROCEDURE spAtualizaCliente
(
@ID BIGINT,
@Nome NVARCHAR(100),
@CPF NVARCHAR(20),
@RG NVARCHAR(20),
@DataNascimento DATETIME,
@Ativo TINYINT
)
AS
BEGIN TRY

	UPDATE tblCliente SET 
		Nome = @Nome,
		CPF = @CPF,
		RG = @RG,
		DataNascimento = @DataNascimento,
		Ativo = @Ativo,
		DataModificado = GETDATE()
	WHERE 
		ID = @ID
	SELECT @@ROWCOUNT AS Retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spDeletaCliente'))
BEGIN
	DROP PROCEDURE spDeletaCliente
END
GO

CREATE PROCEDURE spDeletaCliente
(
@ID BIGINT
)
AS
BEGIN TRY
	DELETE FROM tblCliente WHERE ID = @ID
	SELECT @@ROWCOUNT AS retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
**********  CRUD tblTelefone  *************
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spInsereTelefone'))
BEGIN
	DROP PROCEDURE spInsereTelefone
END
GO

CREATE PROCEDURE spInsereTelefone
(
@ID_Cliente BIGINT,
@ID_TipoTelefone BIGINT,
@DDD NVARCHAR(3),
@Numero NVARCHAR(15),
@Ativo TINYINT
)
AS
BEGIN TRY
	INSERT INTO tblTelefone(ID_Cliente, ID_TipoTelefone, DDD, Numero, Ativo, DataCriado)
	OUTPUT inserted.ID
	VALUES (@ID_Cliente, @ID_TipoTelefone, @DDD, @Numero, @Ativo, GETDATE())
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spObtemTelefonePorID'))
BEGIN
	DROP PROCEDURE spObtemTelefonePorID
END
GO

CREATE PROCEDURE spObtemTelefonePorID
(
@ID BIGINT
)
AS
BEGIN TRY
	SELECT * FROM tblTelefone WHERE ID = @ID
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaTelefone'))
BEGIN
	DROP PROCEDURE spListaTelefone
END
GO

CREATE PROCEDURE spListaTelefone
AS
BEGIN TRY
	SELECT * FROM tblTelefone WHERE Ativo = 1
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spAtualizaTelefone'))
BEGIN
	DROP PROCEDURE spAtualizaTelefone
END
GO

CREATE PROCEDURE spAtualizaTelefone
(
@ID BIGINT,
@ID_Cliente BIGINT,
@ID_TipoTelefone BIGINT,
@DDD NVARCHAR(3),
@Numero NVARCHAR(15),
@Ativo TINYINT
)
AS
BEGIN TRY

	UPDATE tblTelefone SET 
		ID_Cliente = @ID_Cliente,
		ID_TipoTelefone = @ID_TipoTelefone,
		DDD = @DDD,
		Numero = @Numero,
		Ativo = @Ativo,
		DataModificado = GETDATE()
	WHERE 
		ID = @ID
	SELECT @@ROWCOUNT AS Retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spDeletaTelefone'))
BEGIN
	DROP PROCEDURE spDeletaTelefone
END
GO

CREATE PROCEDURE spDeletaTelefone
(
@ID BIGINT
)
AS
BEGIN TRY
	DELETE FROM tblTelefone WHERE ID = @ID
	SELECT @@ROWCOUNT AS retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
**********  CRUD tblEndereco  *************
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spInsereEndereco'))
BEGIN
	DROP PROCEDURE spInsereEndereco
END
GO

CREATE PROCEDURE spInsereEndereco
(
@ID_Cliente BIGINT,
@ID_TipoEndereco BIGINT,
@CEP NVARCHAR(15),
@Logradouro NVARCHAR(100),
@Numero INT,
@Complemento NVARCHAR(50),
@Ativo TINYINT
)
AS
BEGIN TRY
	INSERT INTO tblEndereco(ID_Cliente, ID_TipoEndereco, CEP, Logradouro, Numero, Complemento, Ativo, DataCriado)
	OUTPUT inserted.ID
	VALUES (@ID_Cliente, @ID_TipoEndereco, @CEP, @Logradouro, @Numero, @Complemento, @Ativo, GETDATE())
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spObtemEnderecoPorID'))
BEGIN
	DROP PROCEDURE spObtemEnderecoPorID
END
GO

CREATE PROCEDURE spObtemEnderecoPorID
(
@ID BIGINT
)
AS
BEGIN TRY
	SELECT * FROM tblEndereco WHERE ID = @ID
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaEndereco'))
BEGIN
	DROP PROCEDURE spListaEndereco
END
GO

CREATE PROCEDURE spListaEndereco
AS
BEGIN TRY
	SELECT * FROM tblEndereco WHERE Ativo = 1
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spAtualizaEndereco'))
BEGIN
	DROP PROCEDURE spAtualizaEndereco
END
GO

CREATE PROCEDURE spAtualizaEndereco
(
@ID BIGINT,
@ID_Cliente BIGINT,
@ID_TipoEndereco BIGINT,
@CEP NVARCHAR(15),
@Logradouro NVARCHAR(100),
@Numero INT,
@Complemento NVARCHAR(50),
@Ativo TINYINT
)
AS
BEGIN TRY

	UPDATE tblEndereco SET 
		ID_Cliente = @ID_Cliente,
		ID_TipoEndereco = @ID_TipoEndereco,
		CEP = @CEP,
		Logradouro = @Logradouro,
		Numero = @Numero,
		Complemento = @Complemento,
		Ativo = @Ativo,
		DataModificado = GETDATE()
	WHERE 
		ID = @ID
	SELECT @@ROWCOUNT AS Retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spDeletaEndereco'))
BEGIN
	DROP PROCEDURE spDeletaEndereco
END
GO

CREATE PROCEDURE spDeletaEndereco
(
@ID BIGINT
)
AS
BEGIN TRY
	DELETE FROM tblEndereco WHERE ID = @ID
	SELECT @@ROWCOUNT AS retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

/******************************************
**********  CRUD tblRedeSocial  ***********
******************************************/


IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spInsereRedeSocial'))
BEGIN
	DROP PROCEDURE spInsereRedeSocial
END
GO

CREATE PROCEDURE spInsereRedeSocial
(
@ID_Cliente BIGINT,
@ID_TipoRedeSocial BIGINT,
@URL NVARCHAR(150),
@Ativo TINYINT
)
AS
BEGIN TRY
	INSERT INTO tblRedeSocial(ID_Cliente, ID_TipoRedeSocial, URL, Ativo, DataCriado)
	OUTPUT inserted.ID
	VALUES (@ID_Cliente, @ID_TipoRedeSocial, @URL, @Ativo, GETDATE())
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spObtemRedeSocialPorID'))
BEGIN
	DROP PROCEDURE spObtemRedeSocialPorID
END
GO

CREATE PROCEDURE spObtemRedeSocialPorID
(
@ID BIGINT
)
AS
BEGIN TRY
	SELECT * FROM tblRedeSocial WHERE ID = @ID
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spListaRedeSocial'))
BEGIN
	DROP PROCEDURE spListaRedeSocial
END
GO

CREATE PROCEDURE spListaRedeSocial
AS
BEGIN TRY
	SELECT * FROM tblRedeSocial WHERE Ativo = 1
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spAtualizaRedeSocial'))
BEGIN
	DROP PROCEDURE spAtualizaRedeSocial
END
GO

CREATE PROCEDURE spAtualizaRedeSocial
(
@ID BIGINT,
@ID_Cliente BIGINT,
@ID_TipoRedeSocial BIGINT,
@URL NVARCHAR(150),
@Ativo TINYINT
)
AS
BEGIN TRY

	UPDATE tblRedeSocial SET 
		ID_Cliente = @ID_Cliente,
		ID_TipoRedeSocial = @ID_TipoRedeSocial,
		URL = @URL,
		Ativo = @Ativo,
		DataModificado = GETDATE()
	WHERE 
		ID = @ID
	SELECT @@ROWCOUNT AS Retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE OBJECT_ID = object_id('spDeletaRedeSocial'))
BEGIN
	DROP PROCEDURE spDeletaRedeSocial
END
GO

CREATE PROCEDURE spDeletaRedeSocial
(
@ID BIGINT
)
AS
BEGIN TRY
	DELETE FROM tblRedeSocial WHERE ID = @ID
	SELECT @@ROWCOUNT AS retorno
END TRY
BEGIN CATCH
	SELECT 0 AS Retorno, ERROR_MESSAGE() AS Mensagem
END CATCH
GO
