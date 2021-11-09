

select id_plan, p.nombre 'Plan', os.nombre 'Obra Social' from planes p join obras_sociales os on p.id_obra_social = os.id_obra_social

select	id_cliente Codigo, 
		apellido+', '+c.nombre Cliente, 
		tipo_doc+': '+str(nro_doc) Documento, 
		barrio, calle+', '+str(nro_calle) Direccion, 
		nro_afiliado, 
		p.nombre+' - '+os.nombre,
		fecha_nac Nacimiento,
		s.tipo
from	clientes c join tipos_documento td on c.id_tipo_doc = td.id_tipo_doc
		join barrios b on c.cod_barrio = b.cod_barrio
		join planes p on c.id_plan = p.id_plan
		join obras_sociales os on p.id_obra_social = os.id_obra_social
		join Sexos s on c.id_tipo_sexo = s.id_tipo_sexo



--
select id_empleado Codigo, e.apellido+', '+e.nombre Empleado, tipo_doc+': '+str(nro_doc) Documento, barrio, e.calle+', '+str(e.nro_calle) Direccion, fecha_nac Nacimiento, el.nombre Logistica
from empleados e join tipos_documento td on e.id_tipo_doc = td.id_tipo_doc join barrios b on e.cod_barrio = b.cod_barrio join empresas_logistica el on e.id_empresas_log = el.id_empresas_log

--
select s.id_sucursal Codigo,  b.barrio, calle+', '+str(nro_calle) Direccion
from sucursales s join barrios b on s.cod_barrio = b.cod_barrio

-- Sexos
select * from sexos

--Medicos
select id_medico Codigo, apellido+', '+ nombre Medico, matricula from medicos m 

-- tipo_documento
select * from tipos_documento

-- entregas_suministro
select id_entrega_suministro Codigo, fecha, e.apellido+', '+e.nombre Empleado
from entrega_suministro es join empleados e on es.id_empleado = e.id_empleado

-- detalle entrega
select id_detalle_entrega Codigo, id_entrega_suministro 'Codigo de Entrega', s.nombre Suministro, cantidad
from detalles_entregas de join suministros s on de.codigo_barra = s.codigo_barra

-- recetas
select id_receta Codigo, m.apellido+', '+m.nombre Medico, c.apellido+', '+c.nombre Cliente, Diagnostico, Fecha
from recetas r join medicos m on r.id_medico = m.id_medico join clientes c on r.id_cliente = c.id_cliente

-- detalles receta
select id_detalle_receta Codigo, id_receta 'Codigo de Receta', s.nombre Suministro, cantidad, cod_aprobacion 'Codigo de Aprobacion'
from detalles_receta dr join suministros s on dr.codigo_barra = s.codigo_barra

-- factura
select id_factura Codigo, c.apellido+', '+c.nombre Cliente, Fecha, e.apellido+', '+e.nombre Empleado
from facturas f join clientes c on f.id_cliente = c.id_cliente join empleados e on f.id_empleado = e.id_empleado

-- detalle factura
select id_detalle_factura Codigo, id_factura 'Codigo de Factura', precio_unitario 'Precio por Unidad', Cantidad, Descuento, Reembolsado, s.nombre Suministro
from detalles_factura df join suministros s on df.codigo_barra = s.codigo_barra

-- suministros 
select codigo_barra Codigo, s.Nombre, Descripcion, venta_libre, Precio, tipo, stock_minimo 'Stock Minimo', Stock
from suministros s join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro

-- tipo suministros
select * from tipos_suministro

-- descuentos
select id_descuento Codigo, Tipo, Descuento, fecha_desde 'Desde', fecha_hasta Hasta, Localidad, p.Nombre+' - '+os.nombre 'Plan'
from descuentos d join tipos_suministro ts on d.id_tipo_suministro = ts.id_tipo_suministro join localidades l on d.cod_localidad = l.cod_localidad join planes p on d.id_plan = p.id_plan join obras_sociales os on p.id_obra_social = os.id_obra_social

--sucursales suministros
select id_sucursal_suministro Codigo, s.nombre Suministro, id_sucursal 'Codigo de Sucursal', ss.stock_minimo 'Stock Minimo', ss.Stock
from sucursales_suministros ss join suministros s on ss.codigo_barra = s.codigo_barra 

