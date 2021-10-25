
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
Insert into barrios(barrio, cod_localidad) values ('Nva Cba',1)


set dateformat dmy


--Selects

select * from provincias
select * from localidades
select * from barrios
select * from obras_sociales

	Insert into obras_sociales values('Amicos')
	Insert into obras_sociales values('PAMI')
	Insert into obras_sociales values('Juancimes')
	Insert into obras_sociales values('Fabiola')

select * from planes

	Insert into planes values('Familiar',1)
	Insert into planes values('Individual',2)
	Insert into planes values('Duo',3)
	Insert into planes values('VIP',4)

select * from tipo_contactos

	INSERT INTO tipo_contactos(tipo_contacto) values('Celular')
	INSERT INTO tipo_contactos(tipo_contacto) values('E-mail')
	INSERT INTO tipo_contactos(tipo_contacto) values('Instagram')
	INSERT INTO tipo_contactos(tipo_contacto) values('Twitter')
	INSERT INTO tipo_contactos(tipo_contacto) values('Linkedin')
	INSERT INTO tipo_contactos(tipo_contacto) values('Facebook')
	INSERT INTO tipo_contactos(tipo_contacto) values('Fijo')

select * from Sexos

	Insert into Sexos values('Masculino')
	Insert into Sexos values('Femenino')
	Insert into Sexos values('Otro')

select * from empresas_logistica

	Insert into empresas_logistica values('Marques y Asociados', 9, 1502, 'Alberdi')
	Insert into empresas_logistica values('Falabella',4, 2500, 'Mendoza')
	Insert into empresas_logistica values('Coniferal', 5, 3500, 'Don Bosco')

select * from tipos_documento

	Insert into tipos_documento values('DNI')
	Insert into tipos_documento values('Cedula Federal')
	Insert into tipos_documento values('Pasaporte')
	Insert into tipos_documento values('Pasaporte Extranjero')
	Insert into tipos_documento values('Libreta de Enrrolamiento')

select * from sucursales

	Insert into sucursales values(2,1200,'Mancuerdi')
	Insert into sucursales values(4,950,'Avellaneda')
	Insert into sucursales values(7,523,'Manuel Belgrano')
	Insert into sucursales values(1,486,'Montevideo')
	Insert into sucursales values(13,700,'Chacabuco')

select * from empleados

	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('AYELÉN','ALLENDE','25 de Mayo',915,5,'22/11/1989',1,34587842,2,3,5);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('MARIELA','LUPO','Gral.Alvear',297,1,'15/3/1979',1,28578412,2,1,2);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('MARTÍN','TORRES','Santa Rosa',153,1,'11/11/1988',1,33645785,1,3,2);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('FLORENCIA','LUQUE','Ricchieri',3226,4,'05/03/1986',1,32957187,2,1,4);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('JUAN','RODRIGUEZ','La Rioja',2401,6,'06/3/1975',1,2784124,1,3,5);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('MARCOS','CARRIZO','Colombres',976,8,'25/01/1979',1,29304215,1,2,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('LETICIA','MIRANDA','Obispo Clara',380,8,'30/07/1983',1,30547812,2,1,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('SILVIA','JUAREZ','Murcia',1884,11,'27/12/1984',1,30997245,2,3,3);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('ESTEBAN','PEREZ','Málaga',1891,11,'14/08/1985',1,31547124,1,2,2);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log,id_sucursal) values ('SEBASTIAN','LEDESMA','Ovidio Lagos',78,5,'09/02/1985',1,31247847,1,2,4);


select * from clientes

	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('ALONSO','CLAUDIO', 'Sarmiento', 1200, 3, 4433223, 2,1,'11/12/1996',1,45);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('ALVAREZ','MARCELO', 'San Juan', 550, 7, 2112122, 1, 4,'10/11/2000',1,10);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('ALVAREZ','CRISTINA', 'San Roque', 425, 9, 22121112, 3, 2,'25/11/1976',2,52);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('ALVAREZ','CLAUDIO', 'Roure', 900, 4, 987654, 1, 3,'25/2/1979',1,25);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('CAMPOS','RAUL', 'San Martin', 850, 7, 3456234, 1, 1,'15/2/1996',1,13);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('DURAN','CARLA', 'Belgrano', 850,3, 3467834, 1, 2,'15/5/1976',2,31);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('PEREZ','MARIA', 'Monserrat', 850,6, 148625, 1, 3,'5/9/1983',2,14);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('ZAMORA','CARLOS LUIS', 'Manantiales', 850,7, 4865565, 1, 4,'25/1/1989',1,41);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('PEREZ','ANA', 'Avellaneda', 850,1, 8462451, 1, 1,'25/12/1981',2,45);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('PEREA','LUIS M.', 'Don Bosco', 850,6, 75625855, 1, 2,'31/12/1982',1,12);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('PONCE','CARMELO', 'Colon', 850,4, 234565432, 2, 3,'1/1/1984',1,32);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('GALES','JULIA', 'Colon', 850,4, 74565545, 2, 4,'1/2/1988',2,86);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('SUAREZ','PAOLA', 'Colon', 850,4, 85555455, 3, 2,'27/6/1985',2,98);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('MARANINI','JOSE', 'Colon', 850,4, 238955432, 2, 1,'7/8/1977',1,65);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('FONCECA','BERTA', 'Alverdi', 850,2, 4785565, 3, 4,'29/7/1999',2,54);


select * from contactos

	Insert into contactos values('alonsoC@hotmail.com',1,null,null,null,null) --contacto, id_cliente, id_empresas_log, id_tipo_contacto, id_empleado, id_sucursal
	Insert into contactos values('marcos@hotmail.com',null,null,null,6,null)
	Insert into contactos values('ponce@hotmail.com',11,null,null,null,null)
	Insert into contactos values('duran@hotmail.com',6,null,null,null,null)
	Insert into contactos values('fonceca@hotmail.com',15,null,null,null,null)


select * from medicos

	Insert into medicos values('Juan','Alfonso',555)
	Insert into medicos values('Esteban','Vitrivich',655)
	Insert into medicos values('Maria','Bettos',111)
	Insert into medicos values('Monica','Gates',222)
	Insert into medicos values('Emanuel','Garcia',331)

select * from entrega_suministro

	insert into entrega_suministro values('15/10/2021',2,3)
	insert into entrega_suministro values('16/10/2021',3,4)
	insert into entrega_suministro values('18/10/2021',8,2)
	insert into entrega_suministro values('24/10/2021',6,1)

select * from tipos_suministro

	Insert into tipos_suministro values('Paracetamol')
	Insert into tipos_suministro values('Ibuprofeno')
	Insert into tipos_suministro values('Corticas')
	Insert into tipos_suministro values('Dexalergin')
	Insert into tipos_suministro values('Aspirin')

select * from suministros

	Insert into suministros values('Paracetamol','Tafirol, de 1 g. Comprimido.',1,199.99,1,20,50)
	Insert into suministros values('Ibuprofeno','Walgreens, de 200 mg. Comprimido.',1,299.99,2,20,50)
	Insert into suministros values('Dexalergin','Teva, Dexametasona 0,25 mg, Clorfeniramina 2 mg. Comprimido.',1,99.99,3,10,30)


select * from detalles_entregas

	Insert into detalles_entregas values(1,1,20)
	Insert into detalles_entregas values(2,2,20)
	Insert into detalles_entregas values(3,3,10)

select * from facturas

	Insert into facturas values(2,'15/10/2021',3)
	Insert into facturas values(4,'16/10/2021',5)
	Insert into facturas values(1,'18/10/2021',2)

select * from detalles_factura

	Insert into detalles_factura values(1,150,2,0.05,0,1)
	Insert into detalles_factura values(1,150,3,0.04,0,1)
	Insert into detalles_factura values(1,150,5,0.06,0,1)
	Insert into detalles_factura values(1,150,1,0.09,0,1)
	Insert into detalles_factura values(2,200,4,0.07,1,3)
	Insert into detalles_factura values(3,250,1,0.1,0,2)

select * from recetas

	Insert into recetas values(1,2,'Dolor del Cuerpo','15/10/2021',1)
	Insert into recetas values(2,3,'Dolor de Cabeza','16/10/2021',2)
	Insert into recetas values(3,5,'Dolor de Panza','18/10/2021',3)

select * from detalles_receta

	Insert into detalles_receta values(1,1,2,1)
	Insert into detalles_receta values(1,1,4,1)
	Insert into detalles_receta values(1,1,5,1)
	Insert into detalles_receta values(1,1,1,1)
	Insert into detalles_receta values(2,2,2,2)
	Insert into detalles_receta values(3,3,1,3)

set dateformat dmy

select * from descuentos

	Insert into descuentos values(1,0.1,'1/1/2021','31/12/2021',1,1)
	Insert into descuentos values(2,0.1,'1/1/2021','31/12/2021',2,2)
	Insert into descuentos values(3,0.1,'1/1/2021','31/12/2021',3,3)
	Insert into descuentos values(4,0.1,'1/1/2021','31/12/2021',4,4)
	Insert into descuentos values(3,0.1,'1/1/2021','31/12/2021',5,3)
	Insert into descuentos values(2,0.1,'1/1/2021','31/12/2021',6,2)
	Insert into descuentos values(1,0.1,'1/1/2021','31/12/2021',7,1)

select * from sucursales_suministros


--drop database Farmaceutica

-- Consultas

--Noe
--1) Totales y promedio de facturación mensual con filtros (rango de fechas, tipo de suministros, autorizados o no por obra social)
alter PROC pa_total_facturacion
	@fecha_desde datetime = null,
	@fecha_hasta datetime = null,
	@tipo varchar (50)= '%',
	@codigo int = null
AS
begin
SELECT month (f.fecha) 'Mes',
       year (f.fecha) 'Año',
       s.nombre 'Suministro',
       t.tipo 'Tipo de suministro',
       sum (d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*descuento))'Total de facturacion',
       sum(d.precio_unitario*d.cantidad-(d.precio_unitario*d.cantidad*descuento)) / count(f.id_factura) 'Promedio de facturacion'
     FROM facturas f join detalles_factura d
     ON f.id_factura = d.id_factura
      join suministros s on s.codigo_barra=d.codigo_barra
      join tipos_suministro t on t.id_tipo_suministro=s.id_tipo_suministro
      join detalles_receta dr on dr.codigo_barra=s.codigo_barra
     WHERE f.fecha between @fecha_desde and @fecha_hasta
      and s.nombre like '%'+@tipo+'%'
      and cod_aprobacion = @codigo
     GROUP BY month (f.fecha), year (f.fecha), s.nombre,t.tipo
     ORDER BY 2,1
end

exec pa_total_facturacion '1/1/2021','31/12/2021','Paracetamol',1


--Eze
-- Cantidad de clientes con cierta obra social
create proc pa_clie_Osocial
as
begin
	select o.nombre 'Obra Social', count(c.id_cliente) Cantidad
	from clientes c join planes p on c.id_plan = p.id_plan
					join obras_sociales o on p.id_obra_social = o.id_obra_social
	group by o.nombre
end

-- Cantidad de clientes por mes en cierto año pasado por parametro y promedio de gastos en cada mes x cliente
alter proc pa_clientes_mes
	@anio int
as
begin
	select	MONTH(fecha) Mes, 
			year(fecha) Año, 
			count(c.id_cliente) Cantidad, 
			sum(df.precio_unitario*cantidad-(df.precio_unitario*cantidad*descuento)) / count(c.id_cliente) 'Promedio Gastos'
	from facturas f join clientes c on f.id_cliente = c.id_cliente
					join detalles_factura df on f.id_factura = df.id_factura
	where year(fecha) = @anio
	group by year(fecha), month(fecha)
end

exec pa_clientes_mes 2021


-- Suministros mas solicitadas, y verificar el stock total de cada uno
create proc pa_suministros_stock
as
begin
	select top 10 ts.tipo Suministro, count(s.id_tipo_suministro) Cantidad, sum(stock) 'Stock total'
	from suministros s join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro
	group by ts.tipo
	order by Cantidad desc	
end


-- Verificar si el cliente tiene obra social, si tiene mostrar los datos de la obra social
alter proc pa_tiene_OS
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



-- 






-- Facu

--SE QUIERE SABER LA CANTIDAD DE FACTURAS, LA FACTURACION TOTAL, LA FECHA DE LA PRIMER Y ULTIMA FACTURA POR EMPLEADO
--Y CLIENTE, PARA LAS FACTURAS DE ESTE AÑO QUE OSCILEN ENTRE LOS CODIGOS 10 Y 100
--ORDENE POR VENDEDOR,CANTIDAD DE VENTAS EN FORMA DESCENDENTE Y CLIENTE.
SELECT	E.NOMBRE+' '+E.APELLIDO EMPLEADO, C.NOMBRE+' '+C.APELLIDO CLIENTE,
		COUNT (F.id_factura) CANTIDAD, 
		SUM(CANTIDAD*PRECIO_UNITARIO) TOTAL , 
		MIN(F.FECHA) PRIMERA, 
		MAX(F.FECHA) ULTIMA
FROM EMPLEADOS E JOIN FACTURAS F ON E.id_empleado=F.id_empleado
                      JOIN detalles_factura DF ON DF.id_factura=F.id_factura 
                      JOIN CLIENTES C ON C.id_cliente=F.id_cliente
WHERE YEAR(FECHA)=YEAR(GETDATE()) AND F.id_factura BETWEEN 10 AND 100
GROUP BY E.NOMBRE+' '+E.APELLIDO, C.NOMBRE+' '+C.APELLIDO
ORDER BY 1, 3 DESC, 2

--SE DESEA OBTENER UN LISTADO ORDENADO ALFABETICAMENTE POR APELLIDO Y NOMBRE
--DONDE SE MUESTREN PRIMERO LOS EMPLEADOS Y LUEGO LOS CLIENTES, MOSTRANDO TAMBIEN EL BARRIO
--DE LOS CLIENTES QUE COMIENCEN CON NUMEROS DE AFILIADO CONOCIDOS Y LOS VENDEDORES
--QUE TUVIERON VENTAS EN EL PRESENTE AÑO
--ORDENAR POR NOMBRE COMPLETO 
SELECT C.id_cliente AS CODIGO, C.NOMBRE+' '+C.APELLIDO CLIENTE,
       B.BARRIO, 'CLIENTE' AS TIPO
FROM CLIENTES C JOIN BARRIOS B ON B.COD_BARRIO=C.COD_BARRIO
WHERE C.nro_afiliado is NOT NULL
UNION
SELECT E.id_empleado AS CODIGO, E.NOMBRE+' '+E.APELLIDO VENDEDOR, 
       B.BARRIO, 'EMPLEADO' AS TIPO
FROM EMPLEADOS E JOIN BARRIOS B ON B.COD_BARRIO=E.COD_BARRIO
     JOIN FACTURAS F ON F.id_empleado = E.id_empleado
WHERE YEAR(FECHA)=YEAR(GETDATE())
ORDER BY 2 DESC


-- Lauti

-- Ruben
--Se quiere saber el precio promedio de medicamento, el total recaudado en medicamentos de venta libre, por obra social en los que lo recaudado fue superior a lo recaudado en medicamentos que no sean de venta libre

SELECT	ts.tipo 'Medicamento', str(pl.id_obra_social) + ' ' + os.nombre 'Obra Social',
		AVG (s.precio) 'Precio Promedio',
		SUM (df.precio_unitario*cantidad-(df.precio_unitario*cantidad*df.descuento)) 'Importe Total'
FROM Suministros s JOIN detalles_factura df ON s.codigo_barra = df.codigo_barra
				join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro
				JOIN Descuentos d ON ts.id_tipo_suministro = d.id_tipo_suministro
				JOIN Planes pl ON d.id_plan = pl.id_plan
				join obras_sociales os on pl.id_obra_social = os.id_obra_social
WHERE s.venta_libre = 1
GROUP BY pl.id_obra_social, ts.tipo, os.nombre
HAVING	SUM (df.precio_unitario*cantidad-(df.precio_unitario*cantidad*df.descuento)) > 
		(SELECT sum(det.precio_unitario*cantidad-(det.precio_unitario*cantidad*det.descuento))
         FROM Suministros su JOIN detalles_factura det ON su.codigo_barra = det.codigo_barra
         WHERE su.venta_libre = 0
		 group by su.codigo_barra) 
		 or
		 (SELECT sum(det.precio_unitario*cantidad-(det.precio_unitario*cantidad*det.descuento))
         FROM Suministros su JOIN detalles_factura det ON su.codigo_barra = det.codigo_barra
         WHERE su.venta_libre = 0
		 group by su.codigo_barra) is null


-- Emitir un listado con los datos de los médicos que no registran ninguna receta desde un año en particular que se ingresará por parámetro.


alter proc PA_Medico_Año
	@año int 
as
	select    m.id_medico 'Id Medico',
			m.nombre + SPACE(2) + m.apellido 'Nombre Médico'
	from    medicos m JOIN recetas r ON m.id_medico = r.id_medico
	where    r.id_medico not in (SELECT re.id_medico
								 FROM recetas re
								 WHERE year(fecha) <= @año)


exec PA_Medico_Año @año = 2019














