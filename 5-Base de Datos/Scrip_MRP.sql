create database if not exists db_MRP;
USE db_MRP;
-- -----------------------------------------------------
-- Table `mydb`.`TBL_EMPLEADOS_RRHH`
-- -----------------------------------------------------
create table if not exists TBL_EMPLEADO(
  pk_id_empleado 							INT(10) NOT NULL primary key auto_increment
);
create table if not exists TBL_CONTROLCALIDAD(
  pk_id_controlcalidad						int(10) not null primary key auto_increment,
  fk_idordenproduccion_controlcalidad 		int not null,
  fk_idinventario_controlcalidad 			int not null, #porque inventario?
  fk_idresponsable_controlcalidad 			int(10) not null,
  resultado_controlcalidad					varchar(45)
);
create table if not exists TBL_CONTROLPRODUCTO (
  pk_id_controlproducto 					INT(10) NOT NULL primary key auto_increment,
  fk_idordenproduccion_controlproducto 		INT(10) NULL,
  fk_idestadoproduccion_controlproducto		INT(10) NULL,
  resultado_controlproducto					varchar(45)
);
create table if not exists TBL_ESTADOPRODUCCION(
  pk_id_estadoproduccion 					INT(10) NOT NULL primary key auto_increment,
  nombre_estadoproduccion 					VARCHAR(45) NULL,
  duracion_estadoproduccion					VARCHAR(45) NULL
);
create table if not exists TBL_HORAEMPLEADO (
  pk_id_horaempleado						INT(10) NOT NULL primary key auto_increment,
  fk_idempleado_horaempleado				INT(10) NULL,
  tiempo_horaempleado						INT NULL,
  fk_idordenproduccion_horaempleado		INT NULL#porque se necesita orden de produccion?
);
create table if not exists TBL_INVENTARIO (
  pk_id_inventario 							INT(10) NOT NULL primary key auto_increment,
  fk_idmateriaprimainsumo_inventario		INT NULL,
  fk_idtipoinventario_inventario 			INT NULL,
  fecha_inventario							DATE NULL,
  cantidad_inventario						INT NULL
);
create table if not exists TBL_MATERIAPRIMAINSUMO (
  pk_id_materiaprimainsumo 					INT(10) NOT NULL primary key auto_increment,
  nombre_materiaprimainsumo					VARCHAR(45) NULL,
  descripcion_materiaprimainsumo 			VARCHAR(45) NULL,
  marca_materiaprimainsumo 					VARCHAR(45) NULL,
  estado_materiaprimainsumo 				TINYINT(1) NULL,
  precio_materiaprimainsumo 				DOUBLE NULL
);
create table if not exists TBL_ORDENCOMPRA(
  pk_id_ordencompra 						INT(10) NOT NULL primary key auto_increment,
  fk_idmateriaprimainsumos_ordencompra 		INT NULL,
  fechaenvio_ordencompra			 		DATE NULL,
  cantidad_ordencompra 		 				int NULL,
  estado_ordencompra						TINYINT(1) NULL
);
create table if not exists TBL_ORDENPRODUCCION (
  pk_id_ordenproduccion 					INT(10) NOT NULL primary key auto_increment,
  fk_idtipoproducto_idordenproduccion 		INT(10) NULL,
  cantidad_ordenproduccion					INT NULL,
  fecha_ordenproduccion 					VARCHAR(45) NULL,
  estado_ordenproduccion 					TINYINT(1) NULL
);
create table if not exists TBL_PRODUCTODETALLE (
  pk_id_productodetalle 						INT(10) NOT NULL primary key auto_increment,
  fk_idtipoproductoencabezado_productodetalle 	INT NULL,
  fk_idmateriaprimainsumo_productodetalle 		INT NULL,
  cantidad_productodetalle 						INT NULL
);
create table if not exists TBL_TIPOINVENTARIO (
  pk_id_tipoinventario 						INT(10) NOT NULL primary key auto_increment,
  nombre_tipoinventario 					VARCHAR(45) NULL,
  descripcion_tipo_inventario 				VARCHAR(45) NULL
  );  
create table if not exists TBL_TIPOPRODUCTOENCABEZADO (
  pk_id_tipoproductoencabezado	 			INT(10) NOT NULL primary key auto_increment,
  nombre_tipoproductoencabezado 			VARCHAR(45) NULL,
  descripcion_tipoproductoencabezado 		VARCHAR(45) NULL,
  precio_tipoproductoencabezado 			DOUBLE NULL
  );

alter table TBL_CONTROLCALIDAD add constraint fk_TBL_CONTROLCALIDAD_TBL_ORDENPRODUCCION1 foreign key (fk_idordenproduccion_controlcalidad) references TBL_ORDENPRODUCCION (pk_id_ordenproduccion)on delete no action on update no action;
alter table TBL_CONTROLCALIDAD add constraint fk_TBL_CONTROLCALIDAD_TBL_INVENTARIO1 foreign key (fk_idinventario_controlcalidad) references TBL_INVENTARIO (pk_id_inventario) on delete no action on update no action;
alter table TBL_CONTROLCALIDAD add constraint fk_TBL_EMPLEADOS_TBL_CONTROLCALIDAD1 foreign key (fk_idresponsable_controlcalidad) references TBL_EMPLEADO (pk_id_empleado)on delete no action on update no action; 

alter table TBL_CONTROLPRODUCTO add constraint fk_TBL_CONTROLPRODUCTO_TBL_ORDENPRODUCCION1 foreign key (fk_idordenproduccion_controlproducto) references TBL_ORDENPRODUCCION (pk_id_ordenproduccion)on delete no action on update no action;
alter table TBL_CONTROLPRODUCTO add constraint fk_TBL_CONTROLPRODUCTO_TBL_ESTADOPRODUCCION foreign key (fk_idestadoproduccion_controlproducto) references TBL_ESTADOPRODUCCION (pk_id_estadoproduccion) on delete no action on update no action;

alter table TBL_HORAEMPLEADO add constraint fk_TBL_HORAEMPLEADO_TBL_EMPLEADO foreign key (fk_idempleado_horaempleado)references TBL_EMPLEADO (Pk_id_empleado) on delete no action on update no action;
alter table TBL_HORAEMPLEADO add constraint fk_TBL_HORAEMPLEADO_TBL_ORDENPRODUCCION1 foreign key (fk_idordenproduccion_horaempleado) references TBL_ORDENPRODUCCION (pk_id_ordenproduccion) on delete no action on update no action;

alter table TBL_INVENTARIO add constraint fk_TBL_INVENTARIO_TBL_MATERIAPRIMAINSUMO foreign key (fk_idmateriaprimainsumo_inventario) references TBL_MATERIAPRIMAINSUMO (pk_id_materiaprimainsumo) on delete no action on update no action;
alter table TBL_INVENTARIO add constraint fk_TBL_INVENTARIO_TBL_TIPOINVENTARIO foreign key (fk_idtipoinventario_inventario) references TBL_TIPOINVENTARIO(pk_id_tipoinventario) on delete no action on update no action;

alter table TBL_ORDENCOMPRA add constraint fk_TBL_ORDENCOMPRA_TBL_MATERIAPRIMAINSUMO foreign key (fk_idmateriaprimainsumos_ordencompra) references TBL_MATERIAPRIMAINSUMO (pk_id_materiaprimainsumo) on delete no action on update no action;

alter table TBL_ORDENPRODUCCION add constraint fk_TBL_ORDENPRODUCCION_TBL_TIPOINVENTARIO foreign key (fk_idtipoproducto_idordenproduccion) references TBL_TIPOINVENTARIO (pk_id_tipoinventario) on delete no action on update no action;

alter table TBL_PRODUCTODETALLE add constraint fk_TBL_PRODUCTODETALLE_TBL_TIPOPRODUCTOENCABEZADO foreign key (fk_idtipoproductoencabezado_productodetalle) references TBL_TIPOPRODUCTOENCABEZADO(pk_id_tipoproductoencabezado) on delete no action on update no action;
alter table TBL_PRODUCTODETALLE add constraint fk_TBL_PRODUCTODETALLE_TBL_MATERIAPRIMAINSUMO foreign key (fk_idmateriaprimainsumo_productodetalle) references TBL_MATERIAPRIMAINSUMO(pk_id_materiaprimainsumo) on delete no action on update no action;
