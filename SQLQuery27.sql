USE [caja_18]
GO

/****** Object:  StoredProcedure [dbo].[sp_Importar_BDEXCEL]    Script Date: 01/03/2013 17:41:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER procedure sp_Importar_BDEXCEL as

declare @query varchar(max)

set @query =

-- carga datos
' BULK INSERT caja_18_archivo_carga ' +
' FROM' +  'C:\BASE\ARCHIVOCARGA' + '.XLSX' + '[ARCHIVOCARGA$]' +'; ' 
+


-- carga datos del dia en Cliente
'INSERT into Cliente' + '(RolUni, RutCliente, DeudaTotal, SalCap)' + ' ' +
'select (Roluni, Rutemp, Valorcuota, Salcap)' +
--'from caja_18_archivo_carga'


--print(@query)
--exec(@query)

BULK INSERT caja_18_archivo_carga
FROM 'C:\BASE\ARCHIVOCARGA.TXT';

INSERT INTO CLIENTE (RolUni, RutCliente, DeudaTotal, SalCap)
SELECT Roluni, Rutemp, Valorcuota, Salcap
FROM caja_18_archivo_carga

GO


