
create database Farmaceutica
go

use Farmaceutica
go



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


