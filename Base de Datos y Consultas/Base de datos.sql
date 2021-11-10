
create database Farmaceutica
go

use Farmaceutica
go


-- Data Base

create table provincias
(
	cod_provincia int identity(1,1)
	Constraint pk_cod_prov primary key (cod_provincia),
	provincia varchar(75)
)

create table localidades
(
	cod_localidad int identity(1,1)
	Constraint pk_cod_loc primary key (cod_localidad),
	localidad varchar(75),
	cod_provincia int
	Constraint fk_loc_prov foreign key (cod_provincia)
	references provincias (cod_provincia)
)

create table barrios
(
	cod_barrio int identity(1,1)
	Constraint pk_cod_barrio primary key (cod_barrio),
	barrio varchar(75),
	cod_localidad int
	Constraint fk_barrio_loc foreign key (cod_localidad)
	references localidades (cod_localidad)
)

create table obras_sociales
(
	id_obra_social int identity(1,1) primary key,
	nombre varchar(100)
)

create table planes
(
	id_plan int identity(1,1) primary key,
	nombre varchar(100),
	id_obra_social int
	Constraint fk_plan_obra foreign key (id_obra_social)
	References obras_sociales(id_obra_social)
)

create table empresas_logistica
(
	id_empresas_log int identity(1,1) primary key,
	nombre varchar(100),
	cod_barrio int foreign key
	References barrios(cod_barrio),
	nro_calle int,
	calle varchar(100)
)

create table Sexos
(
	id_tipo_sexo int identity(1,1) primary key,
	tipo varchar(100)
)

create table medicos
(
	id_medico int identity(1,1) primary key,
	nombre varchar(100),
	apellido varchar(100),
	matricula varchar(100)
)

create table tipos_documento
(
	id_tipo_doc int identity(1,1) primary key,
	tipo_doc varchar(100)
)

create table clientes
(
	id_cliente int identity(1,1) primary key,
	nombre varchar(100),
	apellido varchar(100),
	cod_barrio int foreign key
	References barrios(cod_barrio),
	nro_calle int,
	calle varchar(100),
	id_tipo_doc int foreign key
	References tipos_documento(id_tipo_doc),
	nro_doc int,
	id_plan int foreign key
	References planes(id_plan),
	fecha_nac datetime,
	id_tipo_sexo int foreign key
	References sexos(id_tipo_sexo),
	nro_afiliado int
)

create table tipo_contactos
(
	id_tipo_contacto int identity(1,1) primary key,
	tipo_contacto varchar(100)
)

create table sucursales
(
	id_sucursal int identity(1,1) primary key,
	cod_barrio int foreign key
	References barrios(cod_barrio),
	nro_calle int,
	calle varchar(100)
)

create table empleados
(
	id_empleado int identity(1,1) primary key,
	nombre varchar(100),
	apellido varchar(100),
	cod_barrio int foreign key
	References barrios(cod_barrio),
	nro_calle int,
	calle varchar(100),
	id_tipo_doc int foreign key
	References tipos_documento(id_tipo_doc),
	nro_doc int,
	fecha_nac datetime,
	id_tipo_sexo int foreign key
	References sexos(id_tipo_sexo),
	id_empresas_log int foreign key
	References empresas_logistica(id_empresas_log),
	id_sucursal int foreign key
	References sucursales(id_sucursal)
)

create table contactos
(
	id_contacto int identity(1,1) primary key,
	contacto varchar(100),
	id_cliente int foreign key
	References clientes(id_cliente),
	id_empresas_log int foreign key
	References empresas_logistica(id_empresas_log),
	id_tipo_contacto int foreign key
	References tipo_contactos(id_tipo_contacto),
	id_empleado int foreign key
	References empleados(id_empleado),
	id_sucursal int foreign key
	References sucursales(id_sucursal)
)

--Muchos a muchos entre sucursales y contactos
--create table sucursal_contacto
--(
--	id_sucursal_contacto int identity(1,1) primary key,
--	id_contacto int foreign key
--	References contactos(id_contacto),
--	id_sucursal int foreign key
--	References sucursales(id_sucursal)
--)

create table tipos_suministro
(
	id_tipo_suministro int identity(1,1) primary key,
	tipo varchar(100)
)

create table suministros
(
	codigo_barra int identity(1,1) primary key,
	nombre varchar(100),
	descripcion varchar(150),
	venta_libre bit, --bit = 1,0 / Como boleano 1 = true - 0 = false
	precio decimal(10,2),
	id_tipo_suministro int foreign key
	References tipos_suministro(id_tipo_suministro),
	stock_minimo int,
	stock int
)

create table sucursales_suministros
(
	id_sucursal_suministro int identity(1,1) primary key,
	id_sucursal int foreign key
	References sucursales(id_sucursal),
	codigo_barra int foreign key
	References suministros(codigo_barra),
	stock int,
	stock_minimo int
)

create table facturas
(
	id_factura int identity(1,1) primary key,
	id_cliente int foreign key
	References clientes(id_cliente),
	fecha datetime,
	id_empleado int foreign key
	References empleados(id_empleado)
)

create table detalles_factura
(
	id_detalle_factura int identity(1,1) primary key,
	id_factura int foreign key
	References facturas(id_factura),
	precio_unitario decimal(10,2),
	cantidad int,
	descuento decimal(5,3),
	reembolsado bit, --Bool
	codigo_barra int foreign key
	References suministros(codigo_barra)
)

create table recetas
(
	id_receta int identity(1,1) primary key,
	id_medico int foreign key
	References medicos(id_medico),
	id_cliente int foreign key
	References clientes(id_cliente),
	diagnostico varchar(150),
	fecha datetime,
	id_factura int foreign key
	References facturas(id_factura)
)

create table detalles_receta
(
	id_detalle_receta int identity(1,1) primary key,
	id_receta int foreign key
	References recetas(id_receta),
	codigo_barra int foreign key
	References suministros(codigo_barra),
	cantidad int,
	cod_aprobacion int
)

create table entrega_suministro
(
	id_entrega_suministro int identity(1,1) primary key,
	fecha datetime,
	id_empleado int foreign key
	References empleados(id_empleado),
	id_sucursal int foreign key
	References sucursales(id_sucursal)
)

create table detalles_entregas
(
	id_detalle_entrega int identity(1,1) primary key,
	id_entrega_suministro int foreign key
	References entrega_suministro(id_entrega_suministro),
	codigo_barra int foreign key
	References suministros(codigo_barra),
	cantidad int
)

create table descuentos
(
	id_descuento int identity(1,1) primary key,
	id_tipo_suministro int foreign key
	References tipos_suministro(id_tipo_suministro),
	descuento decimal(5,3),
	fecha_desde datetime,
	fecha_hasta datetime,
	cod_localidad int foreign key
	References localidades(cod_localidad),
	id_plan int foreign key
	References planes(id_plan)
)



--drop database Farmaceutica
















