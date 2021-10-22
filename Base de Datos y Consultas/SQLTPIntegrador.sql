
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
	References sexos(id_tipo_sexo)
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



-- Insertar 


--PROVINCIAS
INSERT INTO PROVINCIAS (provincia) VALUES('CORDOBA')
INSERT INTO PROVINCIAS (provincia) VALUES('BUENOS AIRES')
INSERT INTO PROVINCIAS (provincia) VALUES('CATAMARCA')
INSERT INTO PROVINCIAS (provincia) VALUES('CHACO')
INSERT INTO PROVINCIAS (provincia) VALUES('CHUBUT')
INSERT INTO PROVINCIAS (provincia) VALUES('JUJUY')
INSERT INTO PROVINCIAS (provincia) VALUES('CORRIENTES')
INSERT INTO PROVINCIAS (provincia) VALUES('ENTRE RIOS')
INSERT INTO PROVINCIAS (provincia) VALUES('FORMOSA')
INSERT INTO PROVINCIAS (provincia) VALUES('LA PAMPA')
INSERT INTO PROVINCIAS (provincia) VALUES('LA RIOJA')
INSERT INTO PROVINCIAS (provincia) VALUES('MENDOZA')
INSERT INTO PROVINCIAS (provincia) VALUES('MISIONES')
INSERT INTO PROVINCIAS (provincia) VALUES('NEUQUEN')
INSERT INTO PROVINCIAS (provincia) VALUES('RIO NEGRO')
INSERT INTO PROVINCIAS (provincia) VALUES('SALTA')
INSERT INTO PROVINCIAS (provincia) VALUES('SAN JUAN')
INSERT INTO PROVINCIAS (provincia) VALUES('SAN LUIS')
INSERT INTO PROVINCIAS (provincia) VALUES('SANTA CRUZ')
INSERT INTO PROVINCIAS (provincia) VALUES('SANTA FE')
INSERT INTO PROVINCIAS (provincia) VALUES('SANTIAGO DEL ESTERO')
INSERT INTO PROVINCIAS (provincia) VALUES('TIERRA DEL FUEGO')
INSERT INTO PROVINCIAS (provincia) VALUES('TUCUMAN')


--LOCALIDADES
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CORDOBA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CARLOS PAZ',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ADELIA MARIA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ALTA GRACIA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('AGUA DE ORO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('AGUA DEL TALA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('AGUA PINTADA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ALEJANDRO ROCA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ARIAS',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ARROYO CABRAL',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ARROYO LA HIGUERA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('ASCOCHINGA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BAJO DE FERNANDEZ',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BAJO DEL CARMEN',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BAJO GRANDE',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BAJO HONDO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BAJO LINDO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BARRIO DEAN FUNES',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BARRIO LA FERIA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('BO FLORES GUARNICION AEREA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAJON DEL RIO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CALASUYA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAMPO BANDILLO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAMPO LOS ZORROS',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CANDELARIA SUR',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAPILLA DE SITON',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAPILLA LA ESPERANZA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CASAS VEJAS',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CASEROS ESTE',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAÑADA DE CUEVAS',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAÑADA DEL TALA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CAÑADA VERDE',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CERRO PELADO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CHARACATO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CHAÑARIACO',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CHIPITIN',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CHUA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('CHURQUI CAÑADA',1)
INSERT INTO LOCALIDADES (localidad, cod_provincia) VALUES('COLAZO',1)


--BARRIOS
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('CENTRO',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('ALTO ALBERDI',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('OBSERVATORIO',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('JARDIN',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('GENERAL PAZ',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('PUEYRREDON',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('PARQUE HORIZONTE',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('SAN MARTIN',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('SAN VICENTE',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('JUNIOR',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('MAIPU',1)
INSERT INTO BARRIOS(barrio, cod_localidad) VALUES ('PANAMERICANO',1)

--tipos contactos
INSERT INTO tipo_contactos(tipo_contacto) values('Celular')
INSERT INTO tipo_contactos(tipo_contacto) values('E-mail')
INSERT INTO tipo_contactos(tipo_contacto) values('Instagram')
INSERT INTO tipo_contactos(tipo_contacto) values('Twitter')
INSERT INTO tipo_contactos(tipo_contacto) values('Linkedin')
INSERT INTO tipo_contactos(tipo_contacto) values('Facebook')
INSERT INTO tipo_contactos(tipo_contacto) values('Fijo')


--Clientes  --LE FALTA DATOS
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('ALONSO','CLAUDIO', 'Sarmiento', 1200, 3, 4433223, 2);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('ALVAREZ','MARCELO', 'San Juan', 550, 7, 2112122, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('ALVAREZ','CRISTINA', 'San Roque', 425, 9, 22121112, 3);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('ALVAREZ','CLAUDIO', 'Roure', 900, 4, 987654, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('CAMPOS','RAUL', 'San Martin', 850, 7, 3456234, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('DURAN','CARLA', 'Belgrano', 850,3, 3467834, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('PEREZ','MARIA', 'Monserrat', 850,6, 148625, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('ZAMORA','CARLOS LUIS', 'Manantiales', 850,7, 4865565, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('PEREZ','ANA', 'Avellaneda', 850,1, 8462451, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('PEREA','LUIS M.', 'Don Bosco', 850,6, 75625855, 1);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('PONCE','CARMELO', 'Colon', 850,4, 234565432, 2);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('GALES','JULIA', 'Colon', 850,4, 74565545, 2);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('SUAREZ','PAOLA', 'Colon', 850,4, 85555455, 3);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('MARANINI','JOSE', 'Colon', 850,4, 238955432, 2);
INSERT INTO CLIENTES (apellido,nombre,calle,nro_calle,cod_barrio,nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo) VALUES ('FONCECA','BERTA', 'Alverdi', 850,2, 4785565, 3);


--contactos --FALTAN DATOS
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('154784247',1,15,null);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('lupom@gmail.com',2,null,2);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('@cris.alvarez',3,9,null);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('@m.alvarez',4,2,null);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('158479254',1,null,5);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('j.gales@hotmail.com',2,12,null);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('4579821',7,null,7);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('155248475',1,null,3);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('rcampos@gmail.com',2,5,null);
insert into contactos (contacto,id_tipo_contacto,id_cliente,id_empleado,id_empresas_log,id_sucursal) values('156123421',1,null,8);



--facturas

set dateformat dmy

insert into facturas(fecha,id_cliente,id_empleado) values('16/12/2018',7,1)
insert into facturas(fecha,id_cliente,id_empleado) values('26/06/2020',6,2)
insert into facturas(fecha,id_cliente,id_empleado) values('18/02/2021',5,1)
insert into facturas(fecha,id_cliente,id_empleado) values('13/09/2015',4,2)
insert into facturas(fecha,id_cliente,id_empleado) values('19/03/2019',3,1)
insert into facturas(fecha,id_cliente,id_empleado) values('09/10/2020',2,2)
insert into facturas(fecha,id_cliente,id_empleado) values('03/10/2021',1,1)
insert into facturas(fecha,id_cliente,id_empleado) values('29/07/2015',4,2)
insert into facturas(fecha,id_cliente,id_empleado) values('07/08/2016',1,1)
insert into facturas(fecha,id_cliente,id_empleado) values('31/12/2020',7,2)


--detalles
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(2,1,5480.00,30)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(3,2,3590.00,23)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(4,3,10980.00,3)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(5,4,1580.00,4)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(6,5,2290.00,45)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(7,6,4500.00,2)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(8,7,12570.00,1)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(9,8,15740.00,22)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(10,9,7250.00,11)
insert into detalles_factura(id_factura,codigo_barra,precio_unitario,cantidad,descuento,reembolsado) values(1,10,6780.00,12)



--drop database Farmaceutica

-- Consultas





