USE [caja18]
GO

/****** Object:  Table [dbo].[caja_18_archivo_carga]    Script Date: 01/04/2013 16:38:38 ******/
SET ANSI_NULLS ON
GO
select * from dbo.caja_18_archivo_carga

select * from caja18.dbo.carga_ejemplo_castigo

/*insert tabla caja 18 cuota */
insert into caja_18_Cuota (roluni, digver, valorcuota, fecven, diasmora, cuotasmorosas)
(select roluni, digver, valorcuota, fecven, diasmora, cuotasmorosas from carga_ejemplo_castigo )


/*muestra datos*/
select distinct Roluni, Digver, 
(select nombre from dbo.caja_18_archivo_nombres where roluni = c.Roluni ) nombre, salcap, Codsuc 

from dbo.carga_ejemplo_castigo c

update dbo.call_list_caja18_1 from 

select * from dbo.call_list_caja18_1 





