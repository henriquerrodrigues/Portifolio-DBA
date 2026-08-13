/*
Autor: Henrique Rodrigues
Data: 2026-08-13
Descrição: Restaurando Banco de Dados AdventureWorks
Versão: 1.0
Histórico:
1.0 - Restore do BD
*/

RESTORE FILELISTONLY FROM DISK = 'c:\Backup\AdventureWorksLT2022.bak';

RESTORE DATABASE AdventureWorks FROM DISK = 'C:\Backup\AdventureWorksLT2022.bak' WITH recovery, stats =2, 
MOVE 'AdventureWorksLT2022_Data' TO 'C:\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\AdventureWorks.mdf',
MOVE 'AdventureWorksLT2022_Log' TO 'C:\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\AdventureWorks_log.ldf';

ALTER AUTHORIZATION ON DATABASE::AdventureWorks TO sa 

-- sempre que alteramos o Compatibility Level a Microsoft recomentar executar uma att geral das estatísticas do banco
use AdventureWorks 
go 
exec SP_UPDATESTATS 