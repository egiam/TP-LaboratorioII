
--1) Totales por mes, suministro y tipo suministro.
create or alter proc pa_total_facturacion
@fecha_desde datetime = null,
@fecha_hasta datetime = null,
@tipo varchar (50)= '%'
as
begin
select month (f.fecha) 'Mes', year (f.fecha) 'Año', s.nombre 'Suministro', t.tipo 'Tipo de suministro',
format(sum (d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*(1-descuento))),'c2','es-ar')'Total de facturacion'
--format(sum(d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*(1-descuento)))/count(f.id_factura),'c2','es-ar') 'promedio de facturacion'
from facturas f join detalles_factura d
on f.id_factura = d.id_factura
join suministros s on s.codigo_barra=d.codigo_barra
join tipos_suministro t on t.id_tipo_suministro=s.id_tipo_suministro
join detalles_receta dr on dr.codigo_barra=s.codigo_barra
where f.fecha between @fecha_desde and @fecha_hasta
and t.tipo like '%'+@tipo+'%'
and cod_aprobacion is not null
group by month (f.fecha), year (f.fecha), s.nombre, t.tipo
order by 2,1
end

select * from facturas f
where month(fecha)=8
select * from detalles_factura

--exec pa_total_facturacion '1/1/2021','31/12/2021'

--2) Cantidad de clientes por mes, en cierto año, pasado por parametro y promedio de gastos
create or alter proc pa_clientes_mes
@anio int
as
begin
select datename(month,fecha) 'mes',
year(fecha) 'anio',
count(f.id_cliente) 'cantidad',
format(sum(df.precio_unitario*cantidad*(1-descuento)) / count(f.id_cliente),'c2','es-ar')
'promedio'
from facturas f join clientes c on f.id_cliente = c.id_cliente
join detalles_factura df on f.id_factura = df.id_factura
where year(fecha) = @anio
group by datename(month,fecha), year(fecha)
end
--exec pa_clientes_mes 2021

--3) Se quiere saber la cantidad de facturas, la facturacion total, 
--la fecha de la primer y ultima factura por empleado y cliente, 
--para las facturas de este año que oscilen entre los codigos 1 y 10
--ordenado por vendedor, cantidad de ventas en forma descendente y cliente.
create or alter proc pa_consulta3
as
begin
select e.nombre+' '+e.apellido 'Empleado', c.nombre+' '+c.apellido 'Cliente',
count (f.id_factura) 'Cantidad',
format(sum(cantidad*precio_unitario),'c2','es-ar') 'Total' ,
format(min(f.fecha),'dd/mm/yyyy') 'PrimerFecha',
format(max(f.fecha),'dd/mm/yyyy') 'UltimaFecha'
from empleados e join facturas f on e.id_empleado=f.id_empleado
join detalles_factura df on df.id_factura=f.id_factura
join clientes c on c.id_cliente=f.id_cliente
where year(fecha)=year(getdate()) and f.id_factura between 1 and 10
group by e.nombre+' '+e.apellido, c.nombre+' '+c.apellido
order by 1, 3 desc, 2
end
exec pa_consulta3
--4) Verificar si el cliente tiene obra social, si tiene mostrar los datos de la obra social --NO SE USA
create proc pa_tiene_os
@codigo int = 1
as
begin
declare @tiene int = 0
select @tiene = 1
from clientes c join planes p on c.id_cliente = p.id_plan
where c.id_cliente = @codigo and
c.id_plan is not null
if @tiene = 1
begin
print 'tiene obra social'
select o.nombre 'obra social', p.nombre 'nombre del plan', o.id_obra_social 'codigo os',
p.id_plan 'codigo plan', trim(str(d.descuento*100) + '% en ' + ts.tipo) as 'descuentos en',
l.localidad + ', ' + pr.provincia as 'lugar del descuento',
'desde: ' + convert(varchar,format(fecha_desde,'dd/mm/yyyy'),131) + ' | hasta: ' +
convert(varchar,format(fecha_hasta,'dd/mm/yyyy'),131) as 'fechas -> desde | hasta'
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
select 'no tiene obra social'
end
end
--exec pa_tiene_os 1

--5) Se quiere saber el precio promedio de medicamento, el total recaudado en medicamentos --NO SE USA
--de venta libre, por obra social en los que lo recaudado fue superior a lo recaudado 
--en medicamentos que no sean de venta libre
create proc pa_med_os
as
begin
select ts.tipo 'medicamento', str(pl.id_obra_social) + ' ' + os.nombre 'obra social',
format(avg (s.precio),'c2','es-ar') 'precio promedio',
format(sum (df.precio_unitario*df.cantidad*(1-df.descuento)),'c2','es-ar') 'importe total'
from suministros s join detalles_factura df on s.codigo_barra = df.codigo_barra
join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro
join descuentos d on ts.id_tipo_suministro = d.id_tipo_suministro
join planes pl on d.id_plan = pl.id_plan
join obras_sociales os on pl.id_obra_social = os.id_obra_social
where s.venta_libre = 1
group by pl.id_obra_social, ts.tipo, os.nombre
having sum (df.precio_unitario*df.cantidad*(1-df.descuento)) >
(select sum(det.precio_unitario*cantidad*(1-det.descuento))
from suministros su
join detalles_factura det on su.codigo_barra = det.codigo_barra
where su.venta_libre = 0
group by su.codigo_barra)
or
		(select sum(det.precio_unitario*cantidad*(1-det.descuento))
		from suministros su
		join detalles_factura det on su.codigo_barra = det.codigo_barra
		where su.venta_libre = 0
		group by su.codigo_barra) is null
		end
--exec pa_med_os
--6) Emitir un listado con los datos de los médicos que no registran ninguna receta desde un año --NO SE USA
--en particular que se ingresará por parámetro.
create proc pa_medico_año
@año int
as
select nombre + space(2) + apellido 'nombre médico', matricula 'matricula'
from medicos
where id_medico not in (select re.id_medico
						from recetas re
						where year(fecha) >= @año)
-- exec pa_medico_año @año = 2019

--7) Cantidades de afiliados por obra social que realizaron compras, y total de --CONSULTA 4
--descuentos aplicados filtrando aquellas obras sociales que tengan como mínimo la cantidad
--de afiliados indicado por parámetro
create or alter proc pa_clie_osocial
@min_cant_afiliados int=0
as
begin
select o.nombre 'obraSocial', count(c.id_cliente) 'cantidadAfiliados',
format(sum(df.descuento*precio_unitario*cantidad),'c2','es-ar')'descuentoAplicado'
from clientes c join planes p on c.id_plan = p.id_plan
join obras_sociales o on p.id_obra_social = o.id_obra_social
join facturas f on f.id_cliente=c.id_cliente
join detalles_factura df on df.id_factura=f.id_factura
group by o.nombre
having count(c.id_cliente)>=@min_cant_afiliados
order by 1
end

--exec pa_clie_osocial 1

--8) Listado que muestre el monto máximo, mínimo y total que gastó cada cliente el mes pasado,
--pero solo donde el importe total gastado sea menor a $10000
create or alter proc pa_mes_pas
as
begin
select c.nombre + ' ' + c.apellido cliente,
max(df.precio_unitario*cantidad*(1-descuento))'montoMaximo',
min(df.precio_unitario*cantidad*(1-descuento)) 'montoMinimo',
sum(df.precio_unitario*cantidad*(1-descuento)) 'montoTotal'
from detalles_factura df join facturas f on df.id_factura = f.id_factura
join clientes c on f.id_cliente = c.id_cliente
where datediff(month,fecha,getdate()) = 1
group by c.nombre + ' ' + c.apellido
having sum(df.precio_unitario*cantidad*(1-descuento)) < 10000
end
--exec pa_mes_pas