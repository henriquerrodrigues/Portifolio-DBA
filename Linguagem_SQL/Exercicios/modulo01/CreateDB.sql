/*
Autor: Henrique Rodrigues
Data: 2026-08-13
Descrição: Criando novo Database ExerciciosBD
Versão: 1.0
Histórico:
1.0 - CREATE DATABASE
*/

USE master;
GO

CREATE DATABASE ExerciciosBD


USE ExerciciosBD;
GO

CREATE TABLE dbo.Departamento(
	DepartamentoID INT NOT NULL ,
	Departamento VARCHAR(100),
	Descricao VARCHAR(100) NULL,

	CONSTRAINT PK_Departamento  PRIMARY KEY (DepartamentoID),
);

--SELECT * FROM dbo.Departamento

CREATE TABLE dbo.Funcionario(
	FuncionarioID INT NOT NULL,
	Nome VARCHAR(100),
	CPF VARCHAR(14),
	Sexo VARCHAR(20) NULL,
	EstadoCivil VARCHAR(20) NULL,
	DepartamentoID INT NULL,

	CONSTRAINT PK_Funcionario PRIMARY KEY (FuncionarioID),
	CONSTRAINT CPF UNIQUE (CPF),
	CONSTRAINT DepartamentoID Foreign Key (DepartamentoID)
	REFERENCES dbo.Departamento(DepartamentoID)
);

--SELECT * FROM dbo.Funcionario

CREATE TABLE dbo.Dependente(
	DependenteID INT NOT NULL,
	Nome VARCHAR(100),
	DataNascimento date NULL,
	Sexo VARCHAR(20) NULL,
	Tipo VARCHAR(14),
	FuncionarioID INT,

	CONSTRAINT PK_Dependente PRIMARY KEY (DependenteID),
	CONSTRAINT FK_Funcionario FOREIGN KEY (FuncionarioID)
	REFERENCES dbo.Funcionario(FuncionarioID)
);