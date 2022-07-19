USE caja18 
GO

set ansi_nulls on
go 
set QUOTED_IDENTIFIER ON
GO

--CREATE PROCEDURE SP_INSERTA_CORRELATIVO_CUOTAS AS

--BORRA DATOS TABLA
truncate table dbo.caja_18_Cuota

--declaracion tabla temporal

declare @tabla table
(
numero int,
roluni float,
Foliox float,
valorcuota nvarchar(255) ,
fecven float,  
cuotasmorosas nvarchar(255))


--variables
declare @cont integer
set @cont=1

-- toma valor de rut anterior para comparar
declare @rut_ant as nvarchar(255)
declare @roluni as float 
declare @Foliox as float
declare @valorcuota as nvarchar(255) 
declare @fecven as float 
declare @cuotasmorosas as nvarchar(255)

--declaracion datos cursor
declare datos cursor for 
select Foliox,Roluni,Valorcuota, Fecven, Cuotasmorosas 
from caja18.dbo.carga_ejemplo_castigo 
group by Foliox,Roluni,Valorcuota, Fecven, Cuotasmorosas
order by Roluni
open datos

-- Avanzamos un registro y cargamos en las variables los valores encontrados en el primer registro

fetch next from datos
into @Foliox,@Roluni,@Valorcuota, @Fecven, @Cuotasmorosas
while @@FETCH_STATUS = 0
begin

--actualiza tabla cuota
if @rut_ant <> @roluni
set @cont=1

insert into @tabla 
select  @cont,@Foliox,@Roluni,@Valorcuota,@Fecven,@Cuotasmorosas

--avanzamos siguiente registro

set  @rut_ant = @roluni
fetch next from datos 
into @Foliox,@Roluni,@Valorcuota,@Fecven,@Cuotasmorosas
set @cont = @cont+1
end

--cerrado de cursor
close datos
deallocate datos

--insercion de registros en TABLA Cuota

insert into dbo.caja_18_Cuota(numero,Foliox,Roluni,Valorcuota,Fecven,Cuotasmorosas)
select numero,CAST(CAST(foliox as int) as nvarchar(255)),CAST(CAST(roluni  as int) as nvarchar(255)),Valorcuota,CAST(CAST(fecven as int) as nvarchar(255)),Cuotasmorosas from @tabla


select * from caja_18_Cuota

select * from dbo.carga_ejemplo_castigo

INSERT INTO carga_ejemplo_castigo__ (Foliox,Roluni,Digver,"COD SUC",Rutemp,Dvremp,Codsuc,Rutav1,Digav1,Rutav2,Digav2,Avaemp,Agenci,Numdiv,Amorti,Intere,Segdes,Valorcuota,Fecven,Diasmora,Tramo,Plazox,Cuotasmorosas,Salcap,Sistemaorigen,Cuotasislas,Tipoxx,Tasain,"INT MES EN CURSO","SEGURO PREPAGO",ESTADO,"TIPO DE MORA","FOLIO + NUMDIV",ASIGNACION,Culpa,Provisionmora)
VALUES ('521016901','2222222','6','0','521310','K','0','5948952','6','0','NULL','0','521','36','29809','738','0','30547','20121010','51','2','36','1','29809','COB','0','627','2,45','0','0','0','mora blanda','52101690136','RECOLINE','Afiliado','4888')

