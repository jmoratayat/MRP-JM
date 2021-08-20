#Nov 9 HRM
create database if not exists db_clc9nov;
use db_clc9nov;
#CONSULTAS-INTELIGENTES----------------------------------------------------------------------------
create table if not exists CONSULTA_INTELIGENTE (
  pk_id_consulta_inteligente 					int not null,
  nombre_consulta_inteligente 					varchar(100) null,
  contenido_consulta_inteligente 				varchar(250) null,
  primary key (pk_id_consulta_inteligente)
);
alter table CONSULTA_INTELIGENTE change pk_id_consulta_inteligente pk_id_consulta_inteligente int(11) not null auto_increment;
#SEGURIDAD-----------------------------------------------------------------------------------------
create table if not exists LOGIN(
	pk_id_login 						int(10) not null primary key auto_increment,
    usuario_login 						varchar(45),
    contraseña_login 					varchar(45),
    nombreCompleto_login				varchar(100),
    estado_login						int(2)
);
create table if not exists MODULO(
	pk_id_modulo 						int(10)not null auto_increment,
    nombre_modulo 						varchar(30)not null,
    descripcion_modulo 					varchar(50)not null,
    estado_modulo 						int(1)not null,
    primary key(pk_id_modulo),
    key(pk_id_modulo)
);
create table if not exists APLICACION(
	pk_id_aplicacion 					int(10)not null auto_increment,
    fk_id_modulo 						int(10)not null,
    nombre_aplicacion 					varchar(40)not null,
    descripcion_aplicacion 				varchar(45)not null,
    estado_aplicacion 					int(1)not null,
    primary key(pk_id_aplicacion),
    key(pk_id_aplicacion)
);
alter table APLICACION add constraint fk_aplicacion_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists PERFIL(
	pk_id_perfil						int(10) not null primary key auto_increment,
    nombre_perfil						varchar(50),
    descripcion_perfil					varchar(100),
    estado_perfil						int(2)
);
create table if not exists PERMISO(
	pk_id_permiso						int(10) not null primary key auto_increment,
    insertar_permiso					boolean,
    modificar_permiso					boolean,
    eliminar_permiso					boolean,
    consultar_permiso					boolean,
    imprimir_permiso					boolean
);
create table if not exists APLICACION_PERFIL(
	pk_id_aplicacion_perfil				int(10) not null primary key auto_increment,
    fk_idaplicacion_aplicacion_perfil	int(10),
    fk_idperfil_aplicacion_perfil		int(10),
    fk_idpermiso_aplicacion_perfil		int(10)
);
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_aplicacion foreign key (fk_idaplicacion_aplicacion_perfil) references APLICACION(pk_id_aplicacion)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_perfil foreign key (fk_idperfil_aplicacion_perfil) references PERFIL(pk_id_perfil)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_permiso foreign key (fk_idpermiso_aplicacion_perfil) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists PERFIL_USUARIO(
	pk_id_perfil_usuario				int(10) not null primary key auto_increment,
    fk_idusuario_perfil_usuario			int(10),
    fk_idperfil_perfil_usuario			int(10)
);
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_login foreign key(fk_idusuario_perfil_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_perfil foreign key (fk_idperfil_perfil_usuario) references PERFIL(pk_id_perfil) on delete restrict on update cascade;

create table if not exists APLICACION_USUARIO(
	pk_id_aplicacion_usuario			int(10) not null primary key auto_increment,
    fk_idlogin_aplicacion_usuario		int(10),
    fk_idaplicacion_aplicacion_usuario	int(10),
    fk_idpermiso_aplicacion_usuario		int(10)
);
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_login foreign key(fk_idlogin_aplicacion_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_aplicacion foreign key (fk_idaplicacion_aplicacion_usuario) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_permiso foreign key(fk_idpermiso_aplicacion_usuario) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists BITACORA(
	pk_id_bitacora						int(10) not null primary key auto_increment, #pk
    fk_idusuario_bitacora				int(10),
    fk_idaplicacion_bitacora			int(10),
    fechahora_bitacora					varchar(50),
    direccionhost_bitacora				varchar(20),
    nombrehost_bitacora					varchar(20),
    accion_bitacora						varchar(250)
);
CREATE TABLE IF NOT EXISTS DETALLE_BITACORA (
    pk_id_detalle_bitacora 				INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idbitacora_detalle_bitacora 		INT(10),
    querryantigua_detalle_bitacora 		VARCHAR(50),
    querrynueva_detalle_bitacora 		VARCHAR(50)
);
alter table BITACORA add constraint fk_login_bitacora foreign key (fk_idusuario_bitacora) references LOGIN (pk_id_login) on delete restrict on update cascade;
alter table BITACORA add constraint fk_aplicacion_bitacora foreign key (fk_idaplicacion_bitacora) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table DETALLE_BITACORA add constraint fk_bitacora_detallebitacora foreign key(fk_idbitacora_detalle_bitacora) references BITACORA(pk_id_bitacora) on delete restrict on update cascade;

#REPORTEADOR---------------------------------------------------------------------------------------
create table if not exists REPORTE(
	pk_id_reporte 						int(10)not null auto_increment,
    nombre_reporte 						varchar(40)not null,
    ruta_reporte 						varchar(100)not null,
    estado_reporte 						int(1)not null,
    primary key(pk_id_reporte),
    key(pk_id_reporte)
);
create table if not exists REPORTE_MODULO(
	fk_id_reporte 						int(10)not null ,
    fk_id_modulo 						int(10)not null,
    estado_reporte_modulo 				int(1)not null,
    primary key(fk_id_reporte,fk_id_modulo),
    key(fk_id_reporte,fk_id_modulo)
);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo_reportes foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists REPORTE_APLICATIVO(
	fk_id_reporte 						int(10)not null,
    fk_id_aplicacion 					int(10)not null,
    fk_id_modulo 						int(10)not null,
    estado_reporte_aplicativo 			int(1)not null,
    primary key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo),
    key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo)
);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_reporte foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);
alter table REPORTE_APLICATIVO add constraint fk_report_aplicativo foreign key(fk_id_aplicacion) references APLICACION(pk_id_aplicacion);

##MODULOS------------------------------------------------------------------------------------------
###HRM---------------------------------------------------------------------------------------------
create table if not exists GENERO (
  pk_id_genero 									int not null,
  nombre_genero 								varchar(45) null,
  primary key (pk_id_genero)
  );
create table if not exists ESTADO_CIVIL (
  pk_id_estado_civil 							int not null,
  nombre_estado_civil 							varchar(45) null,
  primary key (pk_id_estado_civil)
);  
create table if not exists LICENCIA_CONDUCCION (
  pk_id_licencia_conduccion 					int not null,
  tipo_licencia_conduccion 						varchar(45) null,
  primary key (pk_id_licencia_conduccion)
);
create table if not exists HORARIO (
  pk_id_horario 								int not null,
  nombre_horario 								varchar(45) null,
  descripcion_horario 							varchar(45) null,
  primary key (pk_id_horario)
);
create table if not exists PUESTO (
  pk_id_puesto 									int not null,
  nombre_puesto 								varchar(45) null,
  salario_puesto 								double,
  fk_id_horario_puesto 							int null,
  primary key (pk_id_puesto)
);
alter table PUESTO add constraint fk_horario_puesto foreign key (fk_id_horario_puesto) references HORARIO (pk_id_horario) on delete restrict on update cascade;

create table if not exists DEPARTAMENTO_EMPRESARIAL (
  pk_id__departamento_empresarial 				int not null,
  nombre_departamento_empresarial 				varchar(150) null,
  primary key (pk_id__departamento_empresarial)
);

create table if not exists EMPLEADO (
pk_id_empleado int not null,
nombre1_empleado varchar(45) null,
nombre2_empleado varchar(45) null,
apellido1_empleado varchar(45) null,
apellido2_empleado varchar(45) null,
fecha_nacimiento_empleado varchar(10) null,
dpi_empleado int(15) null,
fk_id_genero_empleado int null,
fk_id_estado_civil_empleado int null,
email_empleado varchar(125) null,
telefono_empleado int null,
numero_iggs_empleado int null,
fk_id_licencia_conducir_empleado int null,
fk_id_puesto_empleado int null,
cuenta_bancaria_empleado int null,
fk_id_departamento_empresarial_empleado int null,
estado_empleado varchar(25) null,
primary key (pk_id_empleado)
);

alter table EMPLEADO add constraint fk_genero_empleado1 foreign key (fk_id_genero_empleado) references GENERO(pk_id_genero) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_estado_civil_empleado foreign key (fk_id_estado_civil_empleado) references ESTADO_CIVIL (pk_id_estado_civil) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_licencia_conducir_empleado foreign key (fk_id_licencia_conducir_empleado) references LICENCIA_CONDUCCION (pk_id_licencia_conduccion) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_puesto_empleado foreign key (fk_id_puesto_empleado) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_departamento_empresarial_empleado foreign key (fk_id_departamento_empresarial_empleado) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade;
#alter table EMPLEADO add constraint fk_horario_empleado foreign key (fk_id_horario_empleado) references HORARIO (pk_id_horario) on delete restrict on update cascade;

create table if not exists TIPO_BAJA(
	pk_id_tipo_baja								int not null,
    nombre_tipo_baja							varchar(10),
    primary key(pk_id_tipo_baja)
);
create table if not exists BAJA( 
	pk_id_baja 					int not null, 
	fk_id_empleado_baja 		int null, 
	fk_id_tipo_baja 			int null, 
	prestaciones_baja 			double null, 
	tiempo_laborado_baja 		varchar (200) null, 
	fecha_despido_baja 			varchar(10), 
	causa_bajas 				varchar(200), 
	primary key(pk_id_baja) 
);
alter table BAJA add constraint fk_bajas_empleado foreign key (fk_id_empleado_baja) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table BAJA add constraint fk_tipo_bajas foreign key (fk_id_tipo_baja) references TIPO_BAJA (pk_id_tipo_baja) on delete restrict on update cascade;

create table if not exists ASCENSO(
	pk_id_ascenso								int not null,
    fk_id_empleado_ascenso						int null,
    fecha_ascenso								varchar(10),
    fk_puesto_anterior_ascenso					int not null,
    fk_departamento_anterior_ascenso			int null,
    salario_anterior_ascenso					double null,
    fk_puesto_nuevo_ascenso						int null,
    fk_departamento_nuevo_ascenso				int null,
    salario_nuevo_ascenso						double null,
    primary key(pk_id_ascenso)
);
alter table ASCENSO add constraint fk_ascenso_empleado foreign key (fk_id_empleado_ascenso) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_puesto_anterior foreign key (fk_puesto_anterior_ascenso) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_depto_anterior foreign key (fk_departamento_anterior_ascenso) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade; 
alter table ASCENSO add constraint fk_ascenso_puesto_nuevo foreign key (fk_puesto_nuevo_ascenso) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_depto_nuevo foreign key (fk_departamento_nuevo_ascenso) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade;

create table if not exists CURSO (
  pk_id_curso 									int not null,
  nombre_curso 									varchar(45) null,
  capacitador_curso 							varchar(45) null,
  primary key (pk_id_curso)
  );
create table if not exists ENCABEZADO_CAPACITACION (
  pk_id_encabezado_capacitacion 				int not null,
  nombre_encabezado_capacitacion 				varchar(45) null,
  fecha_inicio_encabezado_capacitacion 			varchar(10) null,
  fecha_fin_encabezado_capacitacion 			varchar(10) null,
  fk_id_curso_encabezado_capacitacion 			int null,
  primary key (pk_id_encabezado_capacitacion)
);
alter table ENCABEZADO_CAPACITACION add constraint fk_curso_encabezado_capacitacion foreign key (fk_id_curso_encabezado_capacitacion) references CURSO (pk_id_curso) on delete restrict on update cascade;

create table if not exists ENCABEZADO_COMPETENCIA(
	pk_id_encabezado_competencia				int not null,
    fk_id_empleado_encabezado_competencia		int null,
    fecha_inicio_encabezado_competencia			varchar(10)null,
    fecha_fin_encabezado_competencia			varchar(10)null,
    primary key(pk_id_encabezado_competencia)
);
alter table ENCABEZADO_COMPETENCIA add constraint fk_empleado_encabezado_competencia foreign key (fk_id_empleado_encabezado_competencia) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade; 

create table if not exists TIPO_COMPETENCIA (
  pk_id_tipo_competencia 						int not null,
  nombre_competencia 							varchar(150) null,
  primary key (pk_id_tipo_competencia)
);
create table if not exists COMPETENCIA_DESARROLLO (
  pk_id_competencia_desarrollo 					int not null,
  fk_id_encabezado_competencia 					int not null,
  fk_id_tipo_competencia_desarrollo		 		int null,
  resultado_competencia_desarrollo			 	int null,
  primary key (pk_id_competencia_desarrollo)
);
alter table COMPETENCIA_DESARROLLO add constraint fk_encabezado_competencia foreign key (fk_id_encabezado_competencia) references ENCABEZADO_COMPETENCIA (pk_id_encabezado_competencia) on delete restrict on update cascade; 
alter table COMPETENCIA_DESARROLLO add constraint fk_tipo_competencia_desarrollo foreign key (fk_id_tipo_competencia_desarrollo) references TIPO_COMPETENCIA (pk_id_tipo_competencia) on delete restrict on update cascade; 

create table if not exists FORMACION_ACADEMICA (
  pk_id_formacion_academica 					int not null,
  nombre_formacion_academica 					varchar(50) null,
  primary key (pk_id_formacion_academica)
);
create table if not exists TIPO_ENTREVISTA (
  pk_id_tipo_entrevista 						int not null,
  nombre_tipo_entrevista 						varchar(45) null,
  primary key (pk_id_tipo_entrevista)
);
create table if not exists RECLUTAMIENTO (
 pk_id_reclutamiento int not null, 
 fk_id_nivel_estudio_reclutamiento int null, 
 nombre1_reclutamiento varchar(45) null, 
 nombre2_reclutamiento varchar(45) null, 
 apellido1_reclutamiento varchar(45) null, 
 apellido2_reclutamiento varchar(45) null, 
 fecha_nacimiento_reclutamiento varchar(10) null, 
 dpi_reclutamiento int(15) null, 
 fk_id_genero_reclutamiento int null, 
 fk_id_estado_civil_reclutamiento int null, 
 email_reclutamiento varchar(125) null, 
 telefono_reclutamiento int null, 
 numero_igss_reclutamiento int null, 
 fk_id_licencia_conducir_reclutamiento int null, 
 fk_id_puesto_reclutamiento int null, 
 estado_reclutado_entrevista varchar(25) null, 
 nombre_profesion varchar(125), 
 fk_id_departamento_empresarial_reclutamiento int null, 
 primary key (pk_id_reclutamiento)
);

alter table RECLUTAMIENTO add constraint fk_nivel_estudio_reclutamiento foreign key (fk_id_nivel_estudio_reclutamiento) references FORMACION_ACADEMICA (pk_id_formacion_academica) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_genero_reclutamiento foreign key (fk_id_genero_reclutamiento) references GENERO (pk_id_genero) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_estado_civil_reclutamiento foreign key (fk_id_estado_civil_reclutamiento) references ESTADO_CIVIL (pk_id_estado_civil) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_licencia_conducir_reclutamiento foreign key (fk_id_licencia_conducir_reclutamiento) references LICENCIA_CONDUCCION (pk_id_licencia_conduccion) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_puesto_reclutamiento foreign key (fk_id_puesto_reclutamiento) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_departamento_empresarial_reclutamiento foreign key (fk_id_departamento_empresarial_reclutamiento) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade;
#alter table RECLUTAMIENTO add constraint fk_horario_reclutamiento foreign key (fk_id_horario_reclutamiento) references HORARIO (pk_id_horario) on delete restrict on update cascade;

create table if not exists DIRECCION(
	pk_id_direccion 							int not null,
    departamento_direccion 						varchar(45),
    zona_direccion 								varchar(7),
    municipio_direccion 						varchar(100),
    residencia_direccion						varchar(45),
    fk_empleado_direccion						int null,
    fk_reclutamiento_direccion					int null,
    primary key(pk_id_direccion)
);
alter table DIRECCION add constraint fk_empleado_direccion foreign key (fk_empleado_direccion) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table DIRECCION add constraint fk_reclutamiento_direccion foreign key (fk_reclutamiento_direccion) references RECLUTAMIENTO (pk_id_reclutamiento) on delete restrict on update cascade;

create table if not exists CAPACITACION (
  pk_id_capacitacion 							int not null,
  fk_id_encabezado_capacitacion 				int null,
  fk_id_empleado_capacitacion 					int null,
  resultado_capacitacion 						varchar(5) null,
  primary key (pk_id_capacitacion)
);
alter table CAPACITACION add constraint fk_encabezado_capacitacion foreign key (fk_id_encabezado_capacitacion) references ENCABEZADO_CAPACITACION (pk_id_encabezado_capacitacion) on delete restrict on update cascade;
alter table CAPACITACION add constraint fk_empleado_capacitacion foreign key (fk_id_empleado_capacitacion) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;

create table if not exists FALTA (
  pk_id_falta 									int not null,
  nombre_falta 									varchar(45) null,
  descripción_falta 							varchar(45) null,
  primary key (pk_id_falta)
);
create table if not exists FALTA_EMPLEADO (
  pk_id_falta_empleado 							int not null,
  fk_id_empleado_falta_empleado 				int null,
  fk_id_tipo_falta_empleado 					int null,
  fecha_falta_empleado 							varchar(10) null
);
alter table FALTA_EMPLEADO add constraint fk_empleado_falta foreign key (fk_id_empleado_falta_empleado)references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table FALTA_EMPLEADO add constraint fk_tipo_falta foreign key (fk_id_tipo_falta_empleado) references FALTA (pk_id_falta) on delete restrict on update cascade;

create table if not exists ENCABEZADO_NOMINA (
  pk_id_encabezado_nomina 						int not null,
  nombre_encabezado_nomina 						varchar(45) null,
  fecha_inicio_encabezado_nomina 				varchar(10) null,
  fecha_fin_encabezado_nomina 					varchar(10) null,
  primary key (pk_id_encabezado_nomina)
);
create table if not exists PERCEPCION (
  pk_id_percepcion 								int not null,
  nombre_percepcion 							varchar(45) null,
  monto_percepcion 								double null,
  descripcion_percepcion 						varchar(150) null,
  primary key (pk_id_percepcion)
);
create table if not exists DEDUCCION (
  pk_id_deduccion 								int not null,
  nombre_deduccion 								varchar(45) null,
  monto_deduccion 								double null,
  descripcion_deduccion 						varchar(150) null,
  primary key (pk_id_deduccion)
);
create table if not exists DETALLE_NOMINA (
  pk_id_detalle_nomina 							int not null,
  fk_id_encabezado_detalle_nomina 				int null,
  fk_id_empleado_detalle_nomina 				int null,
  fk_id_percepciones_detalle_nomina 			int null,
  fk_id_deducciones_detalle_nomina 				int null,
  salario_base_detalle_nomina 					double null,
  primary key (pk_id_detalle_nomina)
);
alter table DETALLE_NOMINA add constraint fk_encabezado_detalle_nomina foreign key (fk_id_encabezado_detalle_nomina) references ENCABEZADO_NOMINA (pk_id_encabezado_nomina) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_emplado_detalle_nomina foreign key (fk_id_empleado_detalle_nomina) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_percepcion_detalle_nomina foreign key (fk_id_percepciones_detalle_nomina) references PERCEPCION (pk_id_percepcion) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_deduccion_detalle_nomina foreign key (fk_id_deducciones_detalle_nomina) references DEDUCCION (pk_id_deduccion) on delete restrict on update cascade;

create table if not exists ENTREVISTA ( 
	pk_id_entrevista 						int not null, 
	fk_id_empleado_entrevista		 		int null, 
	fk_id_reclutamiento_entrevista 			int null, 
	fk_id_tipo_entrevista 					int null, 
	resultado_entrevista 					varchar(55) null, 
	comentarios_entrevistador_entrevista 	varchar(200) null, 
	primary key (pk_id_entrevista) 
);
alter table ENTREVISTA add constraint fk_empleado_entrevista foreign key (fk_id_empleado_entrevista) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table ENTREVISTA add constraint fk_reclutamiento_entrevista foreign key (fk_id_reclutamiento_entrevista) references RECLUTAMIENTO (pk_id_reclutamiento) on delete restrict on update cascade;
alter table ENTREVISTA add constraint fk_tipo_entrevista foreign key (fk_id_tipo_entrevista) references TIPO_ENTREVISTA (pk_id_tipo_entrevista) on delete restrict on update cascade;

CREATE TABLE IF NOT EXISTS CONTROL_ASISTENCIA (
  pk_id_control_asistencia 							INT NOT NULL,
  fk_id_control_asistencia_empleado 				INT NULL,
  fk_id_control_asistencia_encabezado_nomina		INT NULL,
  dias_laborados 									INT NULL,
  dias_ausente_justificados							INT NULL, 
  dias_ausente_injustificados						INT NULL,
  PRIMARY KEY (pk_id_control_asistencia)
);
alter table CONTROL_ASISTENCIA add CONSTRAINT fk_control_asistencia_empleado FOREIGN KEY (fk_id_control_asistencia_empleado) REFERENCES EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table CONTROL_ASISTENCIA add CONSTRAINT fk_control_asistencia_encabezado_nomina FOREIGN KEY (fk_id_control_asistencia_encabezado_nomina) REFERENCES ENCABEZADO_NOMINA (pk_id_encabezado_nomina) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS CONTROL_HORAS (
  pk_id_control_horas								INT NOT NULL,
  fk_id_control_horas_empleado 						INT NULL,
  fk_id_control_horas_encabezado_nomina				INT NULL,
  horas_hordinarias									DOUBLE NULL,
  horas_extra										DOUBLE NULL, 
  PRIMARY KEY (pk_id_control_horas)
);
alter table CONTROL_HORAS add CONSTRAINT fk_control_horas_empleado FOREIGN KEY (fk_id_control_horas_empleado) REFERENCES EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table CONTROL_HORAS add CONSTRAINT fk_control_horas_encabezado_nomina FOREIGN KEY (fk_id_control_horas_encabezado_nomina) REFERENCES ENCABEZADO_NOMINA (pk_id_encabezado_nomina) ON DELETE RESTRICT ON UPDATE CASCADE;

###FRM---------------------------------------------------------------------------------------------
create table if not exists BANCO (
pk_id_banco 						int(11) NOT NULL,
nombre_banco 						varchar(50) ,
estado_banco 						tinyint(4)
);
alter table BANCO add primary key (pk_id_banco);

create table if not exists TIPO_MONEDA (
pk_id_tipo_moneda 					int(11) not null,
moneda_tipo_moneda 					varchar(45),
simbolo_tipo_moneda 				varchar(2),
descripcion_tipo_moneda				varchar(75) ,
estado_tipo_moneda 					tinyint(4)
);
alter table TIPO_MONEDA add primary key (pk_id_tipo_moneda);

create table if not exists PROPIETARIO(
pk_id_propietario 					int(11) not null,
nombre_propietario 					varchar(45),
descripcion_propietario 			varchar(75),
estado_propietario 					tinyint(4)
);
alter table PROPIETARIO add primary key (pk_id_propietario);

create table if not exists CUENTA_BANCARIA (
pk_id_numero_cuenta_bancaria 		int(11) not null,
fk_id_banco 						int(11) not null,
fk_id_propietario 					int(11) not null,
fk_id_tipo_moneda 					int(11) not null,
saldo_cuenta_bancaria 				double,
fecha_apertura_cuenta_bancaria 		datetime,
estado_apertura_cuenta_bancaria 	tinyint(4)
);
alter table CUENTA_BANCARIA add primary key (pk_id_numero_cuenta_bancaria),add key fk_cuenta_bancaria_banco (fk_id_banco), add key fk_cuenta_bancaria_propietario (fk_id_propietario), add key fk_cuenta_bancaria_tipomoneda (fk_id_tipo_moneda);
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_banco foreign key (fk_id_banco) references BANCO (pk_id_banco)on delete no action on update no action;
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_propietario foreign key (fk_id_propietario) references PROPIETARIO (pk_id_propietario)on delete no action on update no action;
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_tipomoneda foreign key (fk_id_tipo_moneda) references TIPO_MONEDA (pk_id_tipo_moneda)on delete no action on update no action;

create table if not exists TIPO_CUENTA_CONTABLE (
pk_id_tipo_cuenta_contable 			int(11) not null,
nombre_tipo_cuenta_contable 		varchar(75)
);
alter table TIPO_CUENTA_CONTABLE add primary key(pk_id_tipo_cuenta_contable);

create table if not exists CUENTA_CONTABLE(
pk_id_cuenta_contable 				int(11) not null,
nombre_cuenta_contable 				varchar(75),
nivel_cuenta_contable 				int(11) ,
fk_cuenta_padre_cuenta_contable 	int(11),
saldo_anterior_cuenta_contable 		double ,
saldo_actual_cuenta_contable 		double ,
cargo_mes_cuenta_contable 			double ,
abono_mes_cuenta_contable 			double ,
cargo_acumulado_cuenta_contable 	double ,
abono_acumulado_cuenta_contable 	double ,
estado_cuenta_contable 				tinyint(4) ,
fk_id_tipo_cuenta_contable 			int(11) not null
);
alter table CUENTA_CONTABLE add primary key (pk_id_cuenta_contable), add key fk_cuenta_padre_cuenta_hijo (fk_cuenta_padre_cuenta_contable), add key fk_tipo_cuenta_cuenta_contable (fk_id_tipo_cuenta_contable);
alter table CUENTA_CONTABLE add constraint fk_cuenta_padre_cuenta_hijo foreign key (fk_cuenta_padre_cuenta_contable) references CUENTA_CONTABLE(pk_id_cuenta_contable)on delete no action on update no action;
alter table CUENTA_CONTABLE add constraint fk_tipo_cuenta_contable foreign key (fk_id_tipo_cuenta_contable) references TIPO_CUENTA_CONTABLE(pk_id_tipo_cuenta_contable)on delete no action on update no action;


create table if not exists TRANSACCION (
pk_id_transaccion 					int(11) not null,
fk_id_numero_cuenta_bancaria 		int(11) not null,
fecha_transaccion 					datetime ,
fk_id_tipo_transaccion 				int(11) not null,
fk_id_tipo_moneda 					int(11) not null,
monto_transaccion 					double ,
descripcion_transaccion 			varchar(75)
) ;
alter table TRANSACCION add primary key (pk_id_transaccion), add key fk_transaccion_numero_cuenta (fk_id_numero_cuenta_bancaria), add key fk_transaccion_tipo_transaccion (fk_id_tipo_transaccion), add key fk_transaccion_tipo_moneda (fk_id_tipo_moneda);
alter table TRANSACCION add constraint fk_encabezado_transaccion_numero_cuenta foreign key (fk_id_numero_cuenta_bancaria) references CUENTA_BANCARIA (pk_id_numero_cuenta_bancaria)on delete no action on update no action;

create table if not exists TIPO_TRANSACCION (
pk_id_tipo_transaccion 				int(11) not null,
nombre_tipo_transaccion 			varchar(45) ,
descripcion_tipo_transaccion 		varchar(75) ,
estado_tipo_transaccion 			tinyint(4)
) ;
alter table TIPO_TRANSACCION add primary key (pk_id_tipo_transaccion);
alter table TRANSACCION add constraint fk_transaccion_id_tipo_moneda foreign key (fk_id_tipo_moneda ) references TIPO_MONEDA (pk_id_tipo_moneda )on delete no action on update no action;
alter table TRANSACCION add constraint fk_transaccion_tipo_transaccion foreign key (fk_id_tipo_transaccion) references TIPO_TRANSACCION (pk_id_tipo_transaccion)on delete no action on update no action;


create table if not exists SALDO_HISTORICO (
pk_id_cuenta_contable 				int(11) not null,
pk_fecha_saldo_historico 			datetime not null,
monto_saldo_historico 				double,
cargo_saldo_hostorico 				double,
abono_saldo_historico				double
);
alter table SALDO_HISTORICO add primary key (pk_id_cuenta_contable, pk_fecha_saldo_historico);
alter table SALDO_HISTORICO add constraint fk_saldo_cuenta_contable foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;


create table if not exists POLIZA_ENCABEZADO (
pk_poliza_encabezado 				int(11) not null,
fecha_poliza_encabezado 			datetime,
descripcion_poliza_encabezado 		varchar(75) ,
estado_poliza_encabezado 			tinyint(4) ,
total_poliza_encabezado 			double
);
alter table POLIZA_ENCABEZADO add primary key (pk_poliza_encabezado);

create table if not exists POLIZA_DETALLE (
pk_poliza_encabezado 				int(11) not null,
pk_id_cuenta_contable 				int(11) NOT NULL,
monto_poliza_detalle 				double ,
debe_poliza_detalle 				tinyint(4)
);
alter table POLIZA_DETALLE add primary key (pk_poliza_encabezado,pk_id_cuenta_contable);
alter table POLIZA_DETALLE add constraint fk_poliza_detalle_poliza_encabezado foreign key (pk_poliza_encabezado) references POLIZA_ENCABEZADO (pk_poliza_encabezado)on delete no action on update no action;
alter table POLIZA_DETALLE add constraint fk_poliza_detalle_cuenta foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;

create table if not exists PETICION_POLIZA (
pk_id_peticion_poliza int(11) not null,
concepto_peticion_poliza varchar(30),
fecha_peticion_poliza datetime,
descripcion_peticion_poliza varchar(100),
monto_peticion_poliza double,
fk_pk_poliza_encabezado int(11),
estado_peticion_poliza int(2)
);
alter table PETICION_POLIZA add primary key (pk_id_peticion_poliza);

create table if not exists BALANCE_ENCABEZADO (
pk_id_balance_encabezado 					int(11) not null,
descripcion_balance_encabezado 				varchar(75) ,
fecha_creacion_balance_encabezado 			datetime ,
total_debe_haber_balance_encabezado 		double ,
total_deudor_acreedor_balance_encabezado 	double
);
alter table BALANCE_ENCABEZADO add primary key (pk_id_balance_encabezado);

create table if not exists BALANCE_DETALLE (
pk_id_balance_encabezado 			int(11) not null,
pk_id_cuenta_contable 				int(11) not null,
debe_balance_detalle 				double ,
haber_balance_detalle 				double ,
deudor_balance_detalle 				double ,
acreedor_balance_detalle 			double
) ;
alter table BALANCE_DETALLE add primary key (pk_id_balance_encabezado), add key fk_balance_detalle_cuenta (pk_id_cuenta_contable);
alter table BALANCE_DETALLE add constraint fk_balance_encabezado_detalle foreign key (pk_id_balance_encabezado) references BALANCE_ENCABEZADO (pk_id_balance_encabezado)on delete no action on update no action;
alter table BALANCE_DETALLE add constraint fk_balance_detalle_cuenta_contable foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;

###SCM---------------------------------------------------------------------------------------------
create table DEPARTAMENTO(
	pk_id_departamento int(10)not null auto_increment,
    nombre_departamento varchar(30)not null,
    descripcion_departamento varchar(45)not null,
    estado_departamento int(1)not null,
    primary key(pk_id_departamento),
    key(pk_id_departamento)
);
create table MUNICIPIO(
	pk_id_municipio int(10)not null auto_increment,
    fk_id_departamento int(10)not null,
    nombre_municipio varchar(30)not null,
    descripcion_municipio varchar(45)not null,
    estado_municipio int(1)not null,
    primary key(pk_id_municipio),
    key(pk_id_municipio)
);
alter table MUNICIPIO add constraint fk_municipio_departamento foreign key(fk_id_departamento) references DEPARTAMENTO(pk_id_departamento);

create table BODEGA(
	pk_id_bodega int(10)not null auto_increment,
    fk_id_municipio int(10)not null,
    descripcion_bodega varchar(45)not null,
    dimensiones_bodega double(5,2)not null,
    direccion_bodega varchar(45)not null,
    telefono_bodega int(8)not null,
    estado_bodega int(1)not null,
    primary key(pk_id_bodega),
    key(pk_id_bodega)
);
alter table BODEGA add constraint fk_bodega_municipio foreign key(fk_id_municipio) references MUNICIPIO(pk_id_municipio);

create table LINEA_PRODUCTO(
	pk_id_linea_producto int(10)not null auto_increment,
    nombre_linea_producto varchar(25)not null,
    descripcion_linea_producto varchar(50) not null,
    estado_linea_producto int(1) not null,
    primary key(pk_id_linea_producto),
    key(pk_id_linea_producto)
);
create table CATEGORIA_PRODUCTO(
	pk_id_categoria_producto int(10) not null auto_increment,
    nombre_categoria_producto varchar(35)not null,
    descripcion_categoria_producto varchar(60)not null,
    estado_categoria_producto int(1)not null,
    primary key(pk_id_categoria_producto),
    key(pk_id_categoria_producto)
);
create table PRODUCTO(
	pk_id_producto int(10)not null auto_increment,
    fk_id_linea_producto int(10)not null,
    fk_id_categoria_producto int(10)not null,
    nombre_producto varchar(50)not null,
    precio_producto double(12,2)not null,
    medida_producto double(5,2)not null,
    descripcion_producto varchar(45)not null,
    estado_producto int(1)not null,
    primary key(pk_id_producto),
    key(pk_id_producto)
);
alter table PRODUCTO add constraint fk_producto_lineaProducto foreign key(fk_id_linea_producto) references LINEA_PRODUCTO(pk_id_linea_producto);
alter table PRODUCTO add constraint fk_producto_categoriaProducto foreign key(fk_id_categoria_producto) references CATEGORIA_PRODUCTO(pk_id_categoria_producto);

create table EXISTENCIA(
	pk_id_existencia int(10)not null auto_increment,
    fk_id_bodega int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_existencia int(10)not null,
    estado_existencia int(1)not null,
    primary key(pk_id_existencia),
    key(pk_id_existencia)
);
alter table EXISTENCIA add constraint fk_inventario_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);
alter table EXISTENCIA add constraint fk_inventario_bodega foreign key(fk_id_bodega) references BODEGA(pk_id_bodega);

create table INVENTARIO(
	pk_id_inventario int(10)not null auto_increment,
    fk_id_producto int(10)not null,
    cantidad_inventario int(10)not null,
    estado_inventario int(1)not null,
    primary key(pk_id_inventario),
    key(pk_id_inventario)
);
alter table INVENTARIO add constraint fk_total_inventario foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table PAIS(
	pk_id_pais int(10)not null auto_increment,
    nombre_pais varchar(40)not null,
    capital_pais varchar(40)not null,
    estado_pais int(1)not null,
    primary key(pk_id_pais),
    key(pk_id_pais)
);
create table PROVEEDOR(
	pk_id_proveedor int(10)not null auto_increment,
    fk_id_pais int(10)not null,
    razon_social_proveedor varchar(45)not null,
    representante_legal_proveedor varchar(45) not null,
    nit_proveedor varchar(20)not null,
    estado_proveedor int(1)not null,
    primary key(pk_id_proveedor),
    key(pk_id_proveedor)
);
alter table PROVEEDOR add constraint fk_proveedor_pais foreign key(fk_id_pais) references PAIS(pk_id_pais);

create table TELEFONO_PROVEEDOR(
	pk_id_telefono_proveedor int(10)not null auto_increment,
    fk_id_proveedor int(10)not null,
    telefono_telefono_proveedor varchar(20)not null,
    estado_telefono_proveedor int(1)not null,
    primary key(pk_id_telefono_proveedor),
    key(pk_id_telefono_proveedor)
);
alter table TELEFONO_PROVEEDOR add constraint fk_proveedor_telefono foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table CORREO_PROVEEDOR(
	pk_id_correo_proveedor int(10)not null auto_increment,
    fk_id_proveedor int(10)not null,
    correo_correo_proveedor varchar(50)not null,
    estado_correo_proveedor int(1)not null,
    primary key(pk_id_correo_proveedor),
    key(pk_id_correo_proveedor)
);
alter table CORREO_PROVEEDOR add constraint fk_proveedor_correo foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table ENCARGADO_BODEGA(
	pk_id_encargado_bodega int(10)not null auto_increment,
    fk_id_empleado int(10)not null,
    fk_id_bodega int(10)not null,
    estado_encargado_bodega int(1)not null,
    primary key(pk_id_encargado_bodega),
    key(pk_id_encargado_bodega)
);
alter table ENCARGADO_BODEGA add constraint fk_empleado_bodega foreign key(fk_id_bodega) references BODEGA(pk_id_bodega);

create table COMPRA_ENCABEZADO(
	pk_id_compra_encabezado int(10)not null,
    fk_id_proveedor int(10)not null,
    estado_proceso_encabezado_compra int(1)not null,
    fec_compra_encabezado_compra datetime not null,
    total_compra_encabezado_compra double(12,2) not null,
    estado_encabezado_compra int(1)not null,
    primary key(pk_id_compra_encabezado),
    key(pk_id_compra_encabezado)
);
alter table COMPRA_ENCABEZADO add constraint fk_compra_proveedor foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table COMPRA_DETALLE(
	fk_id_compra_encabezado int(10)not null,
	cod_linea_compra_detalle int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_compra_detalle int(10)not null,
    precio_unitario_compra_detalle double(8,2)not null,
    subtotal_compra_detalle double(12,2)not null,
    estado_compra_detalle int(1)not null,
    primary key(fk_id_compra_encabezado,cod_linea_compra_detalle),
    key(fk_id_compra_encabezado,cod_linea_compra_detalle)
);
alter table COMPRA_DETALLE add constraint fk_compra_detalle foreign key(fk_id_compra_encabezado) references COMPRA_ENCABEZADO(pk_id_compra_encabezado);
alter table COMPRA_DETALLE add constraint fk_compra_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table FABRICA(
	pk_id_fabrica int(10)not null auto_increment,
    fk_id_municipio int(10)not null,
    dimensiones_fabrica double(5,2)not null,
    direccion_fabrica varchar(45)not null,
    telefono_fabrica int(8)not null,
    descripcion_fabrica varchar(45)not null,
    estado_fabrica int(1)not null,
    primary key(pk_id_fabrica),
    key(pk_id_fabrica)
);
alter table FABRICA add constraint fk_fabrica_municipio foreign key(fk_id_municipio) references MUNICIPIO(pk_id_municipio);

create table PEDIDO_ENCABEZADO(
	pk_id_pedido_encabezado int(10)not null,
    fk_id_fabrica int(10)not null,
    estado_proceso_pedido_encabezado int(1)not null,
    fec_pedido_pedido_encabezado datetime not null,
    total_pedido_encabezado double(12,2) not null,
    estado_pedido_encabezado int(1)not null,
    primary key(pk_id_pedido_encabezado),
    key(pk_id_pedido_encabezado)
);
alter table PEDIDO_ENCABEZADO add constraint fk_pedido_fabrica foreign key(fk_id_fabrica) references FABRICA(pk_id_fabrica);

create table PEDIDO_DETALLE(
	fk_id_pedido_encabezado int(10)not null,
	cod_linea_pedido_detalle int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_pedido_detalle int(10)not null,
    precio_unitario_pedido_detalle double(8,2)not null, /*Precio dado por fábrica*/
    subtotal_pedido_detalle double(12,2)not null,
    estado_pedido_detalle int(1)not null,
    primary key(fk_id_pedido_encabezado,cod_linea_pedido_detalle),
    key(fk_id_pedido_encabezado,cod_linea_pedido_detalle)
);
alter table PEDIDO_DETALLE add constraint fk_encabezado_pedido foreign key(fk_id_pedido_encabezado) references PEDIDO_ENCABEZADO(pk_id_pedido_encabezado);
alter table PEDIDO_DETALLE add constraint fk_pedido_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table MARCA (
	pk_id_marca int(10)not null auto_increment,
	descripcion_marca varchar(45)not null,
	estado_marca int(1)not null,
	primary key(pk_id_marca),
	key(pk_id_marca)
);
create table VEHICULO (
  pk_id_vehiculo int(10)not null auto_increment,
  fk_id_marca int (10) not null,
  placa_vehiculo varchar(45)not null,
  modelo_vehiculo varchar(45)not null,
  color_vehiculo varchar(45)not null,
  anio_vehiculo  varchar(45)not null,
  tipo_combustible_vehiculo varchar(45)not null,
  estado_vehiculo int(1)not null,
  primary key(pk_id_vehiculo),
  key(pk_id_vehiculo)
);
alter table VEHICULO add constraint fk_vehiculo_marca foreign key(fk_id_marca) references MARCA (pk_id_marca);

create table RUTA(
	pk_id_ruta int(10)not null auto_increment,
    origen_ruta varchar(40) not null,
    destino_ruta varchar(40)not null,
    descripcion_ruta varchar(45)not null,
    estado_ruta int(1)not null,
    primary key(pk_id_ruta),
    key(pk_id_ruta)
);
create table TIPO_MOVIMIENTO(
	pk_id_tipo_movimiento int(10)not null,
    nombre_tipo_movimiento varchar(45)not null,
    signo_tipo_movimiento varchar(1),
    estado_tipo_movimiento int(1)not null,
	primary key(pk_id_tipo_movimiento),
    key(pk_id_tipo_movimiento)
);
create table MOVIMIENTO_INVENTARIO(
	pk_id_movimiento_inventario int(10)not null,
    fecha_movimiento_inventario datetime not null,
    fk_id_tipo_movimiento int(10)not null,
    fk_id_ruta int(10) null,
    fk_id_vehiculo int(10) null,
    documento_asociado_movimiento_inventario int(10) null,
    descripcion_movimiento_inventario varchar(50) not null,
	primary key(pk_id_movimiento_inventario),
    key(pk_id_movimiento_inventario)
);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_tipo foreign key(fk_id_tipo_movimiento) references TIPO_MOVIMIENTO(pk_id_tipo_movimiento);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_ruta foreign key(fk_id_ruta) references RUTA(pk_id_ruta);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_vehiculo foreign key(fk_id_vehiculo) references VEHICULO(pk_id_vehiculo);

create table MOVIMIENTO_INVENTARIO_DETALLE(
	pk_id_movimiento_inventario_detalle int(10)not null,
    fk_id_movimiento_inventario int(10)not null,
    fk_id_producto int(10)not null,
	cantidad_inventario_detalle int(8)not null,
	primary key(pk_id_movimiento_inventario_detalle),
    key(pk_id_movimiento_inventario_detalle)
);
alter table MOVIMIENTO_INVENTARIO_DETALLE add constraint fk_mov_inventario_detalle_mov foreign key(fk_id_movimiento_inventario) references MOVIMIENTO_INVENTARIO(pk_id_movimiento_inventario);
alter table MOVIMIENTO_INVENTARIO_DETALLE add constraint fk_mov_inventario_detalle_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

###MRP---------------------------------------------------------------------------------------------
create table if not exists MATERIA_PRIMA(
    pk_id_materia_prima						int not null primary key auto_increment,
    fk_id_producto_materia_prima			int null,
    cantidad								int,
    estado_materia_prima					int
);
alter table MATERIA_PRIMA add constraint fk_materia_prima_producto foreign key (fk_id_producto_materia_prima) references PRODUCTO(pk_id_producto) on delete no action on update no action;

create table if not exists CONTROL_CALIDAD(#Falta una relacion 2.0
  pk_id_control_calidad						int(10) not null primary key auto_increment,
  fk_id_pedido_encabezado_control_calidad 	int not null,
  fk_id_empleado_control_calidad 			int(10) not null,-- responsable
  resultado_control_calidad					varchar(45),
  estado_control_calidad					int(2)
);
alter table CONTROL_CALIDAD add constraint fk_CONTROL_CALIDAD_PEDIDO_ENCABEZADO foreign key (fk_id_pedido_encabezado_control_calidad) references PEDIDO_ENCABEZADO (pk_id_pedido_encabezado)on delete no action on update no action;
#alter table CONTROL_CALIDAD add constraint fk_EMPLEADO_CONTROL_CALIDAD foreign key (fk_id_empleado_control_calidad) references EMPLEADO (pk_id_empleado)on delete no action on update no action;

create table if not exists ESTADO_PRODUCCION(
  pk_id_estado_produccion 					int(10) not null primary key auto_increment,
  nombre_estado_produccion 					varchar(45) null,
  duracion_estado_produccion				varchar(45) null,
  estado_estado_produccion					tinyint(1) null
);
create table if not exists CONTROL_PRODUCTO (
  pk_id_control_producto 					int(10) not null primary key auto_increment,
  fk_id_pedido_encabezado_control_producto 	int(10) null,
  fk_id_estado_produccion_control_producto	int(10) null,
  resultado_control_producto				varchar(45),
  estado_control_producto					int(2)
);
alter table CONTROL_PRODUCTO add constraint fk_CONTROL_PRODUCTO_ORDEN_PRODUCCION1 foreign key (fk_id_pedido_encabezado_control_producto) references PEDIDO_ENCABEZADO (pk_id_pedido_encabezado)on delete no action on update no action;
alter table CONTROL_PRODUCTO add constraint fk_CONTROL_PRODUCTO_ESTADO_PRODUCCION foreign key (fk_id_estado_produccion_control_producto) references ESTADO_PRODUCCION (pk_id_estado_produccion) on delete no action on update no action;

create table if not exists HORA_EMPLEADO (#Falta relacion con empleado
  pk_id_hora_empleado						int(10) not null primary key auto_increment,
  fk_id_empleado_hora_empleado				int(10) null,
  fk_id_pedido_encabezado_hora_empleado		int null,#porque se necesita orden de produccion?
  fecha_hora_empleado						date,
  estado_hora_empleado						tinyint(1)
);
alter table HORA_EMPLEADO add constraint fk_HORA_EMPLEADO_ORDEN_PRODUCCION1 foreign key (fk_id_pedido_encabezado_hora_empleado) references PEDIDO_ENCABEZADO (pk_id_pedido_encabezado) on delete no action on update no action;

create table if not exists DETALLE_HORA_EMPLEADO(
	pk_id_detalle_hora_empleado				int(10) not null primary key auto_increment,
    fk_id_hora_empleado_detalle				int(10),
    descripcion_detalle_hora_empleado		varchar(250),
    tiempo_detalle_hora_empleado			double,
    estado_detalle_hora_empleado			tinyint(1)
);
alter table DETALLE_HORA_EMPLEADO add constraint fk_HORA_EMPLEADO_DETALLE_HORA_EMPLEADO foreign key (fk_id_hora_empleado_detalle) references HORA_EMPLEADO(pk_id_hora_empleado) on delete no action on update no action;

create table if not exists ORDEN_COMPRA(
  pk_id_orden_compra 						int(10) not null primary key auto_increment,
  fk_id_producto_orden_compra			 	int null,
  fecha_envio_orden_compra			 		date null,
  cantidad_orden_compra 		 			int null,
  estado_orden_compra						tinyint(1) null
);
alter table ORDEN_COMPRA add constraint fk_ORDEN_COMPRA_PRODUCTO1 foreign key (fk_id_producto_orden_compra) references PRODUCTO (pk_id_producto) on delete no action on update no action;
alter table ORDEN_COMPRA modify fecha_envio_orden_compra varchar(50);

create table if not exists RECETAS_ENCABEZADO(
	pk_id_receta_encabezado			 			int(10) not null primary key auto_increment,
    descripcion_receta_encabezado				varchar(100),
	fk_id_producto_receta_encabezado			int(10),
	estado_encabezado_receta 						tinyint(1) null
);
alter table RECETAS_ENCABEZADO add constraint fk_recetas_encabezado_productos foreign key (fk_id_producto_receta_encabezado) references PRODUCTO (pk_id_producto) on delete no action on update no action;

create table if not exists DETALLE_RECETA(
   pk_id_detalle_detalle_receta 				int(10) not null primary key auto_increment,
   fk_id_receta_encabezado_detalle				int(10),
   fk_id_estado_produccion_detalle_receta		int(10), 
   fk_id_producto_detalle_receta				int(10),					
   cantidad_detalle_receta					    double,
   costo_unitario_detalle_receta  				double,
   estado_detalle_receta						tinyint(10)
);
alter table DETALLE_RECETA add constraint fk_detalle_receta_encabezado foreign key (fk_id_receta_encabezado_detalle) references RECETAS_ENCABEZADO (pk_id_receta_encabezado);
alter table DETALLE_RECETA add constraint fk_estado_produccion_detalle foreign key (fk_id_estado_produccion_detalle_receta) references ESTADO_PRODUCCION (pk_id_estado_produccion);
alter table DETALLE_RECETA add constraint fk_producto_detalle foreign key (fk_id_producto_detalle_receta) references PRODUCTO (pk_id_producto);

create table if not exists PRODUCTO_TERMINADO(
	pk_id_producto_terminado 					int(10) not null primary key auto_increment,
    fk_id_producto_producto_terminado			int(10) null,
    cantidad_producto_terminado					int null,
    estado_producto_terminado					tinyint
);
alter table PRODUCTO_TERMINADO add constraint fk_producto_terminado_producto foreign key (fk_id_producto_producto_terminado) references PRODUCTO(pk_id_producto);


###CRM---------------------------------------------------------------------------------------------
-- -----------------------------------------------------
-- Table `clc_erp`.`CLIENTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTES` (
`pk_id_cliente` INT NOT NULL AUTO_INCREMENT,
`nit_cliente` VARCHAR(45) NULL,
`fecha` DATETIME NULL,
`nombre_cliente` VARCHAR(45) NULL,
`apellido_cliente` VARCHAR(45) NULL,
`telefono` VARCHAR(45) NULL,
`estado` VARCHAR(45) NULL,
`correo_cliente` VARCHAR(45) NULL,
`direccion_cliente` VARCHAR(45) NULL,
PRIMARY KEY (`pk_id_cliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`CONTROL_EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CONTROL_EMPLEADO` (
`pk_id_control` INT NOT NULL AUTO_INCREMENT,
`horas_extras_de_trabajo` VARCHAR(45) NULL,
`comisiones_ventas` VARCHAR(45) NULL,
`fk_id_venta` INT NOT NULL,
`fk_id_empleado` INT NOT NULL,
PRIMARY KEY (`pk_id_control`),
INDEX `fk_CONTROL_EMPLEADO_EMPLEADOS HRM1_idx` (`fk_id_empleado` ASC) ,
CONSTRAINT `fk_CONTROL_EMPLEADO_EMPLEADOS HRM1`
FOREIGN KEY (`fk_id_empleado`)
REFERENCES `EMPLEADO` (`pk_id_empleado`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `clc_erp`.`TIPO_VENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TIPO_VENTA` (
`pk_id_tipo_venta` INT NOT NULL AUTO_INCREMENT,
`nombre` VARCHAR(45) NULL,
PRIMARY KEY (`pk_id_tipo_venta`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`TIPO_CUENTA_POR_COBRAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TIPO_CUENTA_POR_COBRAR` (
`pk_id_tipo_cuenta` INT NOT NULL AUTO_INCREMENT,
`nombre_cuenta` VARCHAR(45) NULL,
PRIMARY KEY (`pk_id_tipo_cuenta`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`FACTURAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FACTURAS` (
`pk_id_factura` INT NOT NULL AUTO_INCREMENT,
`fk_id_empleado` INT NOT NULL,
`fk_id_cliente` INT NOT NULL,
`fk_id_tipo_venta` INT NOT NULL,
`fecha_factura` DATETIME NULL,
`total_factura` VARCHAR(45) NULL,
PRIMARY KEY (`pk_id_factura`),
INDEX `fk_FACTURAS_TIPO_VENTA1_idx` (`fk_id_tipo_venta` ASC) ,
INDEX `fk_FACTURAS_CLIENTES1_idx` (`fk_id_cliente` ASC) ,
INDEX `fk_FACTURAS_EMPLEADOS HRM1_idx` (`fk_id_empleado` ASC) ,
CONSTRAINT `fk_FACTURAS_TIPO_VENTA1`
FOREIGN KEY (`fk_id_tipo_venta`)
REFERENCES `TIPO_VENTA` (`pk_id_tipo_venta`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_FACTURAS_CLIENTES1`
FOREIGN KEY (`fk_id_cliente`)
REFERENCES `CLIENTES` (`pk_id_cliente`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_FACTURAS_EMPLEADO`
FOREIGN KEY (`fk_id_empleado`)
REFERENCES `EMPLEADO` (`pk_id_empleado`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `clc_erp`.`MOVIMIENTO_CUENTA_POR_COBRAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MOVIMIENTO_CUENTA_POR_COBRAR` (
`pk_id_movimiento_cuenta` INT NOT NULL AUTO_INCREMENT,
`fecha` DATETIME NULL,
`fk_id_tipo_cuenta` INT NOT NULL,
`fk_id_cliente` INT NOT NULL,
`fk_id_factura` INT NOT NULL,
`saldo_cuenta` FLOAT NULL,
PRIMARY KEY (`pk_id_movimiento_cuenta`),
INDEX `fk_MOVIMIENTO_CUENTA_POR_COBRAR_CLIENTES1_idx` (`fk_id_cliente` ASC) ,
INDEX `fk_MOVIMIENTO_CUENTA_POR_COBRAR_TIPO_CUENTA_POR_COBRAR1_idx` (`fk_id_tipo_cuenta` ASC) ,
INDEX `fk_MOVIMIENTO_CUENTA_POR_COBRAR_FACTURAS1_idx` (`fk_id_factura` ASC) ,
CONSTRAINT `fk_MOVIMIENTO_CUENTA_POR_COBRAR_CLIENTES1`
FOREIGN KEY (`fk_id_cliente`)
REFERENCES `CLIENTES` (`pk_id_cliente`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_MOVIMIENTO_CUENTA_POR_COBRAR_TIPO_CUENTA_POR_COBRAR1`
FOREIGN KEY (`fk_id_tipo_cuenta`)
REFERENCES `TIPO_CUENTA_POR_COBRAR` (`pk_id_tipo_cuenta`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_MOVIMIENTO_CUENTA_POR_COBRAR_FACTURAS1`
FOREIGN KEY (`fk_id_factura`)
REFERENCES `FACTURAS` (`pk_id_factura`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`DETALLES_VENTA_EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DETALLES_VENTA_EMPLEADO` (
`fk_id_venta` INT NOT NULL AUTO_INCREMENT,
`fk_id_empleado` INT NOT NULL,
PRIMARY KEY (`fk_id_venta`, `fk_id_empleado`),
INDEX `fk_VENTAS_has_EMPLEADOS HRM_EMPLEADOS HRM1_idx` (`fk_id_empleado` ASC) ,
CONSTRAINT `fk_VENTAS_has_EMPLEADOS HRM_EMPLEADOS HRM1`
FOREIGN KEY (`fk_id_empleado`)
REFERENCES `EMPLEADO` (`pk_id_empleado`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`DETALLE_FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DETALLE_FACTURA` (
`fk_id_factura` INT NOT NULL,
`fk_id_producto` INT NOT NULL,
`DETALLE_FACTURAcol` VARCHAR(45) NULL,
`cantidad` INT NULL,
`descuento` FLOAT NULL,
`subtotal` FLOAT NULL,
`sub_total_descuento` FLOAT NULL,
PRIMARY KEY (`fk_id_factura`),
INDEX `fk_VENTAS_has_FACTURAS_FACTURAS1_idx` (`fk_id_factura` ASC) ,
INDEX `fk_DETALLE_FACTURA_PRODUCTO_SCM1_idx` (`fk_id_producto` ASC) ,
CONSTRAINT `fk_VENTAS_has_FACTURAS_FACTURAS1`
FOREIGN KEY (`fk_id_factura`)
REFERENCES `FACTURAS` (`pk_id_factura`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_DETALLE_FACTURA_PRODUCTO_SCM1`
FOREIGN KEY (`fk_id_producto`)
REFERENCES `PRODUCTO` (`pk_id_producto`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`COTIZACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COTIZACION` (
`pk_id_cotizacion` INT NOT NULL AUTO_INCREMENT,
`fk_id_cliente` INT NOT NULL,
`fecha_cotizacion` DATE NULL,
`total_cotizacion` VARCHAR(45) NULL,
`estado_cotizacion` VARCHAR(45) NULL,
PRIMARY KEY (`pk_id_cotizacion`),
INDEX `fk_COTIZACION_CLIENTES1_idx` (`fk_id_cliente` ASC) ,
CONSTRAINT `fk_COTIZACION_CLIENTES1`
FOREIGN KEY (`fk_id_cliente`)
REFERENCES `CLIENTES` (`pk_id_cliente`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clc_erp`.`DETALLE_COTIZACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DETALLE_COTIZACION` (
`fk_id_cotizacion` INT NOT NULL,
`fk_id_producto` INT NOT NULL,
`cantidad_producto` INT NULL,
`precio_producto` FLOAT NULL,
`subtotal_producto` FLOAT NULL,
`descuento_producto` FLOAT NULL,
`subtotal_descuento` FLOAT NULL,
PRIMARY KEY (`fk_id_cotizacion`, `fk_id_producto`),
INDEX `fk_COTIZACION_has_PRODUCTO_SCM_PRODUCTO_SCM1_idx` (`fk_id_producto` ASC) ,
INDEX `fk_COTIZACION_has_PRODUCTO_SCM_COTIZACION1_idx` (`fk_id_cotizacion` ASC) ,
CONSTRAINT `fk_COTIZACION_has_PRODUCTO_SCM_COTIZACION1`
FOREIGN KEY (`fk_id_cotizacion`)
REFERENCES `COTIZACION` (`pk_id_cotizacion`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_COTIZACION_has_PRODUCTO_SCM_PRODUCTO_SCM1`
FOREIGN KEY (`fk_id_producto`)
REFERENCES `PRODUCTO` (`pk_id_producto`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

#####RELACIONES-ENTRE-MODULOS----------------------------------------------------------------------
####RELACIONES-HRM---------------------------------------------------------------------------------
####RELACIONES-FRM---------------------------------------------------------------------------------
####RELACIONES-SCM---------------------------------------------------------------------------------
alter table ENCARGADO_BODEGA add constraint fk_empleado_encargado foreign key(fk_id_empleado) references EMPLEADO (pk_id_empleado);

####RELACIONES-MRP---------------------------------------------------------------------------------
#alter table CONTROL_CALIDAD add constraint fk_EMPLEADOS_CONTROLCALIDAD1 foreign key (fk_id_responsable_control_calidad) references EMPLEADO (pk_id_empleado)on delete no action on update no action; 
alter table HORA_EMPLEADO add constraint fk_HORAEMPLEADO_EMPLEADO foreign key (fk_id_empleado_hora_empleado)references EMPLEADO (pk_id_empleado) on delete no action on update no action;

####RELACIONES-CRM---------------------------------------------------------------------------------
#alter table VENTAS add constraint fk_VENTAS_PRODUCTO_SCM1 foreign key (fk_id_producto) references PRODUCTO(pk_id_producto) on delete no action on update no action;
#alter table DETALLES_VENTA_EMPLEADO add constraint `fk_VENTAS_has_EMPLEADOS HRM_EMPLEADOS HRM1` FOREIGN KEY (`fk_id_empleado`) REFERENCES EMPLEADO (`pk_id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION;
#alter table control_empleado add CONSTRAINT `fk_CONTROL_EMPLEADO_EMPLEADOS HRM1` FOREIGN KEY (`fk_id_empleado`) REFERENCES EMPLEADO (`pk_id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION;
#alter table pedidos_especiales add CONSTRAINT `fk_PEDIDOS_ESPECIALES_EMPLEADOS HRM1` FOREIGN KEY (`fk_id_empleado`) REFERENCES EMPLEADO (`pk_id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

######ALTER-TABLES-RELACIONALES--------------------------------------------------------------------
#####ALTER-TABLES-MODULOS--------------------------------------------------------------------------
#####ALTER-TABLES-HRM------------------------------------------------------------------------------
ALTER TABLE CURSO DROP `capacitador_curso`;
ALTER TABLE CURSO ADD `fk_id_empleado_curso` INT(11) NULL DEFAULT NULL AFTER `nombre_curso`;
ALTER TABLE CURSO ADD `detalle_curso` VARCHAR(128) NULL DEFAULT NULL AFTER `fk_id_empleado_curso`;
ALTER TABLE CURSO ADD CONSTRAINT fk_empleado_curso FOREIGN KEY (fk_id_empleado_curso) REFERENCES EMPLEADO (pk_id_empleado) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE ENCABEZADO_CAPACITACION ADD `horas_encabezado_capacitacion` INT(2) NOT NULL AFTER `fk_id_curso_encabezado_capacitacion`;
ALTER TABLE ENCABEZADO_CAPACITACION DROP `nombre_encabezado_capacitacion`;
######DATOS--------------------------------------------------------------------
######SEGURIDAD--------------------------------------------------------------------
INSERT INTO login VALUES 
('1', 'sistema', 'bi0PL96rbxVRPKJQsLJJAg==', 'Usuario de prueba', '1'),
('2', 'bjsican', '0FOYy5u5h0djKjzCYqfvkg==', 'Billy Sican', '1'),
('3', 'bmaza', 'xTfsC3/XR/CVyDvNr1Fs+g==', 'Bryan Mazariegos', '1'),
('4', 'jsican', 'jsican', 'Jeshua Sican', '0'),
('5', 'jmorataya', '123', 'Julio Morataya', '0'),
('6', 'admin', 'T+4Ai6O3CR0kJYxCgXy2jA==', 'Administrador', '1');


INSERT INTO `modulo` VALUES (1,'Seguridad','Aplicaciones de seguridad',1),(2,'Consultas','Consultas Inteligentes',1),
(3,'Reporteador','Aplicaciones de Reporteador',1),(4,'HRM','Aplicaciones de Recursos Humanos',1),
(5,'FRM','Aplicaciones de Finanzas',1),(6,'SCM','Aplicaciones Control de Inventario',1),(7,'MRP','Aplicaciones de Produccion',1),
(8,'CRM','Aplicaciones de Ventas',1);

INSERT INTO perfil VALUES 
('1', 'Admin', 'Administracion del programa', '1'),
('2', 'Sistema', 'Administrador del sistema', '1'),
('3', 'Digitador', 'Digitador para Cuentas', '1'),
('4', 'Consultor', 'Unicamente consultas ', '1'),
('5', 'Reportes', 'Ingreso y consultas de reportes', '1'),
('6', 'Pruebas', 'pruebas', '1'),
('7', 'Administrador', 'Administrador del MRP', '1');


INSERT INTO aplicacion VALUES 
('1', '1', 'Login', 'Ventana de Ingreso', '1'),
('2', '1', 'Mantenimiento Usuario', 'Mantenimientos de usuario', '1'),
('3', '1', 'Mantenimiento Aplicacion', 'ABC de las Aplicaciones', '1'),
('4', '1', 'Mantenimiento Perfil', 'ABC de perfiles', '1'),
('5', '1', 'Asignacion de Aplicaciones a Perfil', 'Asignacion Aplicacion y perfil', '1'),
('6', '1', 'Asignacaion de Aplicaciones', 'Asignacion especificas a un usuario', '1'),
('7', '1', 'Consulta Aplicacion', 'Mantenimiento de Aplicaciones', '1'),
('8', '1', 'Agregar Modulo', 'Mantenimientos de Modulos', '1'),
('9', '1', 'Consultar Perfil', 'Consultas de perfiles disponibles', '1'),
('10', '1', 'Permisos', 'Asignar permisos a perfiles y aplicaciones', '1'),
('11', '1', 'Cambio de Contraseña', 'Cambia las contraseñas', '1'),
('2301', '6', 'Linea Producto', 'lINEA', '1'),
('2302', '6', 'Categoria Producto', 'Categoria', '1'),
('2303', '6', 'Producto', 'Producto', '1'),
('2304', '6', 'Departamento', 'Deptos', '1'),
('2305', '6', 'Municipio', 'Muni depto', '1'),
('2306', '6', 'Ruta', 'Rutas', '1'),
('2307', '6', 'Proveedores', 'Nada', '1'),
('2308', '6', 'Telefono Proveedor', 'Telefonos ', '1'),
('2309', '6', 'Correo Proveedor', 'Correos', '1'),
('2310', '6', 'Pais', 'Pais de Proveedor', '1'),
('2311', '6', 'Marca', 'Contiene la Marca de Vehiculos', '1'),
('2312', '6', 'Vehiculo', 'Vehiculos usados para traslados', '1'),
('2313', '6', 'Bodega', 'Localizacion de bodegas', '1'),
('2314', '6', 'Encargado Bodega', 'Empleado dentro del area de bodegas', '1'),
('2315', '6', 'Tipo de Movimiento', 'Movimientos de Inventarios', '1'),
('2316', '6', 'Compras y Pedidos', 'Gestión de Órdenes de Compra y Pedido', '1'),
('2318', '6', 'Fabrica', 'Fabrica', '1'),
('3301', '7', 'MDI MRP', 'Ventana Principal MRP', '1'),
('3302', '7', 'Mantenimiento Producto', 'Mantenimiento de los productos', '1'),
('3303', '7', 'Mantenimiento de Categoria de produccion', 'Mantenimiento de Categoria de productos', '1'),
('3304', '7', 'Mantenimiento de Estado de Produccion', 'Mantenimiento de Estados de  produccion', '1'),
('3305', '7', 'Mantenimiento de Linea de produccion MRP', 'Mantenimiento de MRP para linea de producto', '1'),
('3306', '7', 'Mantenimiento de Encabezado de receta', 'Mantenimiento de MRP de reseta ', '1'),
('3307', '7', 'Mantenimiento de Detalle de Receta', 'Mantenimiento del detalle de la receta', '1'),
('3308', '7', 'Proceso Resepcion de pedidos especiales', 'Proceso para ingreso de pedidos', '1');



INSERT INTO permiso VALUES 
('1', '1', '1', '1', '1', '1'),
('2', '1', '0', '0', '1', '1'),
('3', '1', '1', '1', '0', '0'),
('4', '1', '1', '1', '1', '1'),
('5', '1', '1', '1', '1', '1'),
('6', '1', '1', '1', '1', '1'),
('7', '1', '1', '1', '1', '1'),
('8', '1', '0', '1', '0', '0'),
('9', '1', '1', '0', '0', '0'),
('10', '1', '1', '0', '0', '0'),
('11', '1', '1', '1', '1', '1'),
('12', '0', '0', '0', '1', '0'),
('13', '0', '0', '0', '1', '0'),
('14', '0', '0', '0', '0', '0'),
('15', '1', '0', '0', '1', '0'),
('16', '0', '0', '0', '0', '0'),
('17', '1', '1', '0', '0', '0'),
('18', '1', '1', '1', '1', '1'),
('19', '0', '1', '0', '0', '0'),
('20', '1', '1', '0', '0', '0'),
('21', '1', '1', '1', '0', '0');


INSERT INTO aplicacion_perfil VALUES 
('1', '1', '1', '1'),
('2', '4', '1', '2'),
('3', '5', '1', '3'),
('4', '2', '1', '4'),
('5', '3', '1', '5'),
('6', '6', '1', '6'),
('7', '8', '1', '7'),
('8', '2', '3', '8'),
('9', '3', '3', '9'),
('10', '4', '3', '11'),
('11', '2', '4', '12'),
('12', '8', '4', '13'),
('13', '8', '5', '15'),
('14', '8', '7', '21');

INSERT INTO aplicacion_usuario VALUES 
('1', '1', '4', '1'),
('2', '1', '5', '2'),
('3', '1', '6', '3'),
('4', '3', '8', '10'),
('5', '4', '6', '14'),
('6', '5', '5', '16'),
('7', '5', '2', '17'),
('8', '6', '3302', '18'),
('9', '6', '2', '19'),
('10', '6', '3', '20');

INSERT	INTO perfil_usuario VALUES
(1 , 1, 1),
(2 , 3,	3),
(4 , 4,	1),
(5, 5, 5);

############# Triggers MRP ------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER ACONTROLPEDIDO BEFORE UPDATE ON pedido_encabezado
FOR EACH ROW
BEGIN
    IF (NEW.estado_proceso_pedido_encabezado = 4)  THEN BEGIN
   
   INSERT INTO control_producto 
(fk_id_pedido_encabezado_control_producto, fk_id_estado_produccion_control_producto, resultado_control_producto, estado_control_producto) 
VALUES (new.pk_id_pedido_encabezado , new.estado_proceso_pedido_encabezado," ", 1);

    END; END IF;
END$$
DELIMITER ;

