
select cod_barrio, barrio, localidad from localidades l join barrios b on b.cod_localidad = l.cod_localidad

set dateformat dmy

--1) Totales y promedio de facturación mensual con filtros (rango de fechas, tipo de suministros, autorizados por obra social)
Create PROC pa_total_facturacion
	@fecha_desde datetime = null,
	@fecha_hasta datetime = null,
	@tipo varchar (50)= '%'
AS
begin
SELECT month (f.fecha) 'Mes',
       year (f.fecha) 'Año',
       s.nombre 'Suministro',
       t.tipo 'Tipo de suministro',
       format(sum (d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*(1-descuento))),'c2','es-Ar')'Total de facturacion',
       format(sum(d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*(1-descuento)))/ count(f.id_factura),'c2','es-Ar') 'Promedio de facturacion'
     FROM facturas f join detalles_factura d
     ON f.id_factura = d.id_factura
      join suministros s on s.codigo_barra=d.codigo_barra
      join tipos_suministro t on t.id_tipo_suministro=s.id_tipo_suministro
      join detalles_receta dr on dr.codigo_barra=s.codigo_barra
     WHERE f.fecha between @fecha_desde and @fecha_hasta
      and t.tipo like '%'+@tipo+'%'
      and cod_aprobacion is not null
     GROUP BY month (f.fecha), year (f.fecha), s.nombre,t.tipo
     ORDER BY 2,1
end

exec pa_total_facturacion '1/1/2021','31/12/2021','Paracetamol'

--2) Cantidad de clientes por mes, en cierto año, pasado por parametro y promedio de gastos
create proc pa_clientes_mes
    @anio int
as
begin
    select  month(fecha) 'Mes',
            year(fecha) 'Año',
            count(f.id_cliente) 'Cantidad',
            format(sum(df.precio_unitario*cantidad*(1-descuento)) / count(f.id_cliente),'c2','es-Ar') 'Promedio Gastos'
    from facturas f join clientes c on f.id_cliente = c.id_cliente
                    join detalles_factura df on f.id_factura = df.id_factura
    where year(fecha) = @anio
    group by month(fecha), year(fecha)
end
exec pa_clientes_mes 2021

--3) SE QUIERE SABER LA CANTIDAD DE FACTURAS, LA FACTURACION TOTAL, LA FECHA DE LA PRIMER Y ULTIMA FACTURA POR EMPLEADO
--Y CLIENTE, PARA LAS FACTURAS DE ESTE AÑO QUE OSCILEN ENTRE LOS CODIGOS 1 Y 10
--ORDENE POR VENDEDOR,CANTIDAD DE VENTAS EN FORMA DESCENDENTE Y CLIENTE.
SELECT  E.NOMBRE+' '+E.APELLIDO 'EMPLEADO', C.NOMBRE+' '+C.APELLIDO 'CLIENTE',
        COUNT (F.id_factura) 'CANTIDAD',
        format(SUM(CANTIDAD*PRECIO_UNITARIO),'c2','es-Ar') 'TOTAL' ,
         format(MIN(F.FECHA),'dd/MM/yyyy') 'PRIMERA',
       format(MAX(F.FECHA),'dd/MM/yyyy') 'ULTIMA'
FROM EMPLEADOS E JOIN FACTURAS F ON E.id_empleado=F.id_empleado
                      JOIN detalles_factura DF ON DF.id_factura=F.id_factura
                      JOIN CLIENTES C ON C.id_cliente=F.id_cliente
WHERE YEAR(FECHA)=YEAR(GETDATE()) AND F.id_factura BETWEEN 1 AND 10
GROUP BY E.NOMBRE+' '+E.APELLIDO, C.NOMBRE+' '+C.APELLIDO
ORDER BY 1, 3 DESC, 2

--4) Verificar si el cliente tiene obra social, si tiene mostrar los datos de la obra social
create proc pa_tiene_OS
	@codigo int = 1
as
begin
	declare @tiene int = 0
	select @tiene = 1
	from clientes c join planes p on c.id_cliente = p.id_plan
	where	c.id_cliente = @codigo and
			c.id_plan is not null

	if @tiene = 1
	begin
		print 'Tiene obra social'
		--exec pa_datos_OS
		select	o.nombre 'Obra Social', p.nombre 'Nombre del plan', o.id_obra_social 'Codigo OS', p.id_plan 'Codigo Plan',
				trim(str(d.descuento*100) + '% en ' + ts.tipo) as 'Descuentos en',  
				l.localidad + ', ' + pr.provincia as 'Lugar del descuento',
				'Desde: ' + convert(varchar,format(fecha_desde,'dd/MM/yyyy'),131) + ' | Hasta: ' + convert(varchar,format(fecha_hasta,'dd/MM/yyyy'),131) as 'Fechas -> Desde | Hasta'
		from clientes c join planes p on c.id_plan = p.id_plan
						join obras_sociales o on p.id_obra_social = o.id_obra_social
						join descuentos d on p.id_plan = d.id_plan
						join localidades l on d.cod_localidad = l.cod_localidad
						join provincias pr on l.cod_provincia = pr.cod_provincia
						join tipos_suministro ts on d.id_tipo_suministro = ts.id_tipo_suministro
		where c.id_cliente = @codigo
	end
	else
	begin
		select 'No tiene obra social'
	end
end


exec pa_tiene_OS 1
--5)Se quiere saber el precio promedio de medicamento, el total recaudado en medicamentos de venta libre, por obra social en los que lo recaudado fue superior a lo recaudado en medicamentos que no sean de venta libre

create proc pa_med_os
as
begin
	SELECT	ts.tipo 'Medicamento', str(pl.id_obra_social) + ' ' + os.nombre 'Obra Social',
			format(AVG (s.precio),'c2','es-Ar') 'Precio Promedio',
			format(SUM (df.precio_unitario*df.cantidad*(1-df.descuento)),'c2','es-Ar') 'Importe Total'
	FROM Suministros s JOIN detalles_factura df ON s.codigo_barra = df.codigo_barra
					join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro
					JOIN Descuentos d ON ts.id_tipo_suministro = d.id_tipo_suministro
					JOIN Planes pl ON d.id_plan = pl.id_plan
					join obras_sociales os on pl.id_obra_social = os.id_obra_social
	WHERE s.venta_libre = 1
	GROUP BY pl.id_obra_social, ts.tipo, os.nombre
	HAVING	SUM (df.precio_unitario*df.cantidad*(1-df.descuento)) > 
			(SELECT sum(det.precio_unitario*cantidad*(1-det.descuento))
			 FROM Suministros su JOIN detalles_factura det ON su.codigo_barra = det.codigo_barra
			 WHERE su.venta_libre = 0
			 group by su.codigo_barra) 
			 or
			 (SELECT sum(det.precio_unitario*cantidad*(1-det.descuento))
			 FROM Suministros su JOIN detalles_factura det ON su.codigo_barra = det.codigo_barra
			 WHERE su.venta_libre = 0
			 group by su.codigo_barra) is null
end

exec pa_med_os


--6) Emitir un listado con los datos de los médicos que no registran ninguna receta desde un año en particular que se ingresará por parámetro.


create proc pa_medico_año
  @año int 
as
  select  nombre + space(2) + apellido 'nombre médico', matricula 'matricula'
     from    medicos  
     where    id_medico not in (select re.id_medico
  			          from recetas re
		                        where year(fecha) >= @año)

-- exec pa_medico_año @año = 2019



--7)Cantidades de afiliados por obra social que realizaron compras, y total de descuentos aplicados
--filtrando aquellas obras sociales que tengan como minimo la cantidad de afiliados indicado por parametro
create proc pa_clie_Osocial
@min_cant_afiliados int=0
as
begin
    select o.nombre 'Obra Social', count(c.id_cliente) 'Cantidad de afiliados',
	format(sum(df.descuento*precio_unitario*cantidad),'c2','es-Ar')'Descuento total aplicado'	
    from clientes c join planes p on c.id_plan = p.id_plan
                    join obras_sociales o on p.id_obra_social = o.id_obra_social
					join facturas f on f.id_cliente=c.id_cliente
					join detalles_factura df on df.id_factura=f.id_factura
    group by o.nombre
	having  count(c.id_cliente)>=@min_cant_afiliados
end
exec pa_clie_Osocial 1

--8) Listado que muestre el monto maximo, minimo y total que gasto cada cliente el mes pasado, pero solo donde
--el importe total gastado sea menor a $10000
create proc pa_mes_pas
as
begin
	select	c.nombre + ' ' + c.apellido Cliente, 
			format(max(df.precio_unitario*cantidad*(1-descuento)),'c2','es-Ar') 'Monto Maximo', 
			format(min(df.precio_unitario*cantidad*(1-descuento)),'c2','es-Ar') 'Monto Minimo',
			format(sum(df.precio_unitario*cantidad*(1-descuento)),'c2','es-Ar') 'Monto Total'
	from	detalles_factura df join facturas f on df.id_factura = f.id_factura
			join clientes c on f.id_cliente = c.id_cliente
	where datediff(month,fecha,getdate()) = 1
	group by c.nombre + ' ' + c.apellido
	having sum(df.precio_unitario*cantidad*(1-descuento)) < 10000
end

exec pa_mes_pas

clientes
