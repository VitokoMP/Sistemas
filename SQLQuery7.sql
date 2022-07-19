USE [caja_18] 
GO
/****** Object:  StoredProcedure [dbo].[SP_12_POBLA_DIRECCIONES_COMERCIAL]    Script Date: 01/03/2013 12:52:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE sp_13_POBLA_CAMPOS111 AS 

declare @QUERY varchar(max)
declare @trab_sitrel varchar(max)
DECLARE @Rol_unico VARCHAR(MAX)
declare @Rut_Cliente varchar(max)
declare @DeudaTotal varchar(max)
declare @SalCap varchar (max)
declare @CONT int 

set @CONT=1
WHILE (@CONT)<6
BEGIN

set @Rol_unico = (select Roluni from caja_18_archivo_carga  where @Rol_unico =  ( +10 ))
set @Rut_Cliente = (select Rutemp  from caja_18_archivo_carga where @Rut_Cliente =  (@CONT +10 ))
set @DeudaTotal = (select Salcap from caja_18_archivo_carga where @DeudaTotal =  (@CONT +10 ))
set @SalCap = (select Valorcuota from caja_18_archivo_carga where @SalCap =  (@CONT +10 ))


set @Query=

'UPDATE cliente ' +
' SET ' +  @Rol_unico + ' = a.DIRECCION, ' +
 @Rut_Cliente + ' = a.TIPO_DIRECCIONES,' +
 @DeudaTotal + ' = a.DESCRIPCION_COMUNA' +
 @SalCap + ' = a.DESCRIPCION_COMUNA' +
 
' from CARGA_LOS_HEROES.dbo.TB_Paso_direcciones a ' +
' where SUBSTRING(CARGA_LOS_HEROES.dbo.TB_ASIGNACION.RUT_EMPRESA_EPP,1,len(CARGA_LOS_HEROES.dbo.TB_ASIGNACION.RUT_EMPRESA_EPP)-1) = a.rut ' +
' and cast(a.nro as nvarchar) = ' + '''' + @cont + ''''

set @CONT=@CONT+1
exec(@Query)
--PRINT(@Query)
END
