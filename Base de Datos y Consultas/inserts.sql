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
	Insert into obras_sociales values('Osde')
	Insert into obras_sociales values('Galeno')
	Insert into obras_sociales values('Apross')
	Insert into obras_sociales values('Swiss medical')
	Insert into obras_sociales values('Daspu')
	Insert into obras_sociales values('MET')


select * from planes

	Insert into planes values('Familiar',1)
	Insert into planes values('Individual',2)
	Insert into planes values('Duo',3)
	Insert into planes values('VIP',4)
	insert into planes(nombre, id_obra_social) values('210',5)
	insert into planes(nombre, id_obra_social) values('410',5)
	insert into planes(nombre, id_obra_social) values('510',5)
	insert into planes(nombre, id_obra_social) values('Plata',6)
	insert into planes(nombre, id_obra_social) values('Oro',6)
	insert into planes(nombre, id_obra_social) values('Azul',6)
	insert into planes(nombre, id_obra_social) values('Estándar',7)
	insert into planes(nombre, id_obra_social) values('Premium',7)
	insert into planes(nombre, id_obra_social) values('250',8)
	insert into planes(nombre, id_obra_social) values('650',8)
	insert into planes(nombre, id_obra_social) values('Único',9)
	insert into planes(nombre, id_obra_social) values('200',10)
	insert into planes(nombre, id_obra_social) values('300',10)


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

select * from barrios

	Insert into empresas_logistica values('Marques y Asociados', 9, 1502, 'Alberdi')
	Insert into empresas_logistica values('Falabella',4, 2500, 'Mendoza')
	Insert into empresas_logistica values('Coniferal', 5, 3500, 'Don Bosco')
	Insert into empresas_logistica (nombre, cod_barrio, nro_calle, calle) values ('OCASA', 7, 1010, 'Belgrano')
	Insert into empresas_logistica (nombre, cod_barrio, nro_calle, calle) values ('Andreani', 9, 250, 'Ayacucho')

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

	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log) values ('Ayelén','Allende','25 de Mayo',915,5,'22/11/1989',1,34587842,2,3);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log) values ('Mariela','Lupo','Gral.Alvear',297,1,'15/3/1979',1,28578412,2,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log) values ('Martín','Torres','Santa Rosa',153,1,'11/11/1988',1,33645785,1,3);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log) values ('Florencia','Luque','Ricchieri',3226,4,'05/03/1986',1,32957187,2,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_empresas_log) values ('Juan','Rodriguez','La Rioja',2401,6,'06/3/1975',1,2784124,1,3);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_sucursal) values ('Marcos','Carrizo','Colombres',976,8,'25/01/1979',1,29304215,1,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_sucursal) values ('Leticia','Miranda','Obispo Clara',380,8,'30/07/1983',1,30547812,2,1);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_sucursal) values ('Silvia','Juarez','Murcia',1884,11,'27/12/1984',1,30997245,2,3);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_sucursal) values ('Esteban','Perez','Málaga',1891,11,'14/08/1985',1,31547124,1,2);
	INSERT into empleados (nombre,apellido,calle,nro_calle,cod_barrio,fecha_nac,id_tipo_doc,nro_doc,id_tipo_sexo,id_sucursal) values ('Sebastian','Ledesma','Ovidio Lagos',78,5,'09/02/1985',1,31247847,1,4);


select * from clientes

	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Alonso','Claudio', 'Sarmiento', 1200, 3, 4433223, 2,1,'11/12/1996',1,45);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Álavarez','Marcelo', 'San Juan', 550, 7, 2112122, 1, 4,'10/11/2000',1,10);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Álvarez','Cristina', 'San Roque', 425, 9, 22121112, 3, 2,'25/11/1976',2,52);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Álvarez','Claudio', 'Roure', 900, 4, 987654, 1, 3,'25/2/1979',1,25);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Campos','Raul', 'San Martin', 850, 7, 3456234, 1, 1,'15/2/1996',1,13);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Durán','Carla', 'Belgrano', 850,3, 3467834, 1, 2,'15/5/1976',2,31);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Pérez','María', 'Monserrat', 850,6, 148625, 1, 3,'5/9/1983',2,14);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Zamora','Carlos Luis', 'Manantiales', 850,7, 4865565, 1, 4,'25/1/1989',1,41);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Pérez','Ana', 'Avellaneda', 850,1, 8462451, 1, 1,'25/12/1981',2,45);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Perea','Luis M.', 'Don Bosco', 850,6, 75625855, 1, 2,'31/12/1982',1,12);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Ponce','Carmelo', 'Colon', 850,4, 234565432, 2, 3,'1/1/1984',1,32);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Gales','Julia', 'Colon', 850,4, 74565545, 2, 4,'1/2/1988',2,86);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Suarez','Paola', 'Colon', 850,4, 85555455, 3, 2,'27/6/1985',2,98);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Maranini','Jose', 'Colon', 850,4, 238955432, 2, 1,'7/8/1977',1,65);
	INSERT INTO CLIENTES (APELLIDO, NOMBRE, calle,nro_calle,cod_barrio, nro_doc,id_tipo_doc,id_plan,fecha_nac,id_tipo_sexo,nro_afiliado) VALUES ('Fonceca','Berta', 'Alverdi', 850,2, 4785565, 3, 4,'29/7/1999',2,54);


select * from contactos

	Insert into contactos values('alonsoC@hotmail.com',1,null,2,null,null) --contacto, id_cliente, id_empresas_log, id_tipo_contacto, id_empleado, id_sucursal
	Insert into contactos values('marcos@hotmail.com',null,null,2,6,null)
	Insert into contactos values('ponce@hotmail.com',11,null,2,null,null)
	Insert into contactos values('duran@hotmail.com',6,null,2,null,null)
	Insert into contactos values('fonceca@hotmail.com',15,null,2,null,null)

--delete from contactos

select * from medicos

	Insert into medicos values('Juan','Alfonso',555)
	Insert into medicos values('Esteban','Vitrivich',655)
	Insert into medicos values('Maria','Bettos',111)
	Insert into medicos values('Monica','Gates',222)
	Insert into medicos values('Emanuel','Garcia',331)
	Insert into medicos (nombre, apellido, matricula) values ('Mariela','Gómez',301)
	Insert into medicos (nombre, apellido, matricula) values ('Omar','Fernández',301)

select * from sucursales
select * from entrega_suministro

	insert into entrega_suministro values('15/10/2021',2,3)
	insert into entrega_suministro values('16/10/2021',3,4)
	insert into entrega_suministro values('18/10/2021',1,2)
	insert into entrega_suministro (fecha, id_empleado, id_sucursal )values('09/11/2021',4,1)
	insert into entrega_suministro (fecha, id_empleado, id_sucursal )values('09/11/2021',5,3)
	insert into entrega_suministro (fecha, id_empleado, id_sucursal )values('09/11/2021',5,1)
	insert into entrega_suministro (fecha, id_empleado, id_sucursal )values('09/11/2021',5,1)

	select * from empleados

select * from tipos_suministro

	Insert into tipos_suministro values('Medicamento')
	Insert into tipos_suministro values('Artículo de limpieza')
	Insert into tipos_suministro values('Higiene personal')
	Insert into tipos_suministro values('Estética')
	Insert into tipos_suministro values('Electro')

select * from suministros

	Insert into suministros values('Paracetamol','Tafirol, de 1 g. Comprimido.',1,199.99,1,20,50)
	Insert into suministros values('Ibuprofeno','Walgreens, de 200 mg. Comprimido.',1,299.99,1,20,50)
	Insert into suministros values('Dexalergin','Teva, Dexametasona 0,25 mg, Clorfeniramina 2 mg. Comprimido.',1,99.99,1,10,30)
	insert into suministros (nombre, descripcion, venta_libre, precio, id_tipo_suministro, stock_minimo, stock) values('Balanza','Balanza personal',1,5000,5,15,20)
	insert into suministros (nombre, descripcion, venta_libre, precio, id_tipo_suministro, stock_minimo, stock) values('Tensiómetro','Tensiómetro personal',1,8000,5,10,11)

	insert into suministros (nombre, descripcion, venta_libre, precio, id_tipo_suministro, stock_minimo, stock) values('Crema Facial','Crema hidratante',1,1000,4,9,11)
	insert into suministros (nombre, descripcion, venta_libre, precio, id_tipo_suministro, stock_minimo, stock) values('Crema de manos','Crema hidratante para manos',1,8000,4,12,18)
	
	insert into suministros (nombre, descripcion, venta_libre, precio, id_tipo_suministro, stock_minimo, stock) values('Desodorate Axe','Desodorante corporal',1,170,3,20,50)

	
	select * from entrega_suministro
	select * from suministros
select * from detalles_entregas

	Insert into detalles_entregas values(1,1,20)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (1,1,30)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (1,2,15)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (1,3,25)

	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (2,4,5)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (2,5,2)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (2,6,10)

	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (3,7,9)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (3,8,20)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (3,1,10)


	insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (4,7,9)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (4,8,20)

	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (5,1,10)

	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (6,1,30)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (6,2,15)
	Insert into detalles_entregas (id_entrega_suministro, codigo_barra, cantidad) values (7,3,25)

	

select * from facturas
select * from clientes
select * from empleados

	Insert into facturas values(2,'15/10/2021',6)
	Insert into facturas values(4,'16/10/2021',7)
	Insert into facturas values(1,'18/10/2021',8)
	Insert into facturas(id_cliente, fecha, id_empleado) values(1,'19/10/2021',9)
	insert into facturas values(3,'11/9/2021',10)
	Insert into facturas(id_cliente, fecha, id_empleado) values(5,'19/09/2021',6)
	Insert into facturas(id_cliente, fecha, id_empleado) values(7,'13/08/2021',8)


	select * from suministros
select * from detalles_factura

	Insert into detalles_factura values(1,150,2,0.05,0,1)
	Insert into detalles_factura values(1,150,3,0.04,0,1)
	Insert into detalles_factura values(1,150,5,0.06,0,1)
	Insert into detalles_factura values(2,150,1,0.09,0,1)
	Insert into detalles_factura values(2,200,4,0.07,1,3)
	Insert into detalles_factura values(3,250,1,0.1,0,2)
	Insert into detalles_factura(id_factura, precio_unitario, cantidad, descuento, reembolsado, codigo_barra) values(4,350,1,0.1,0,2)
	insert into detalles_factura values(4,225,4,0.2,0,2)
	Insert into detalles_factura(id_factura, precio_unitario, cantidad, descuento, reembolsado, codigo_barra) values(6,400,2,0.1,0,2)
	Insert into detalles_factura(id_factura, precio_unitario, cantidad, descuento, reembolsado, codigo_barra) values(6,1000,3,0.1,0,3)
	Insert into detalles_factura(id_factura, precio_unitario, cantidad, descuento, reembolsado, codigo_barra) values(7,500,4,0.1,0,1)

	Insert into detalles_factura(id_factura, precio_unitario, cantidad, descuento, reembolsado, codigo_barra) values(1,170,2,0.05,0,8)


select * from suministros
select * from recetas

select * from clientes


-----
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
