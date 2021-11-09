

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

--



