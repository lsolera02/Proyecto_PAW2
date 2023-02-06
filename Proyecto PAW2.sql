CREATE DATABASE Lumincondo_DB;
USE Lumincondo_DB;
/*
USE master;
DROP DATABASE Lumincondo_DB;
*/

CREATE TABLE TiposUsuarios (
							ID INT NOT NULL, /*PK*/
							tipoUsuario VARCHAR(20) NOT NULL,
							PRIMARY KEY (ID)
							);/*#1*/

CREATE TABLE EstadoIncidencia (
								IDEstado INT NOT NULL, /*PK*/
								TipoEstado VARCHAR(20) NOT NULL,
								PRIMARY KEY (IDEstado)
								);/*#2*/

CREATE TABLE TipoInformacion (
								IDTipoInfo INT NOT NULL, /*PK*/
								tipoInfo VARCHAR(20)NOT NULL,
								PRIMARY KEY (IDTipoInfo)
								);/*#3*/

CREATE TABLE Espacios (
						IDEspacio INT NOT NULL, /*PK*/
						descripcion VARCHAR(25) NOT NULL,
						PRIMARY KEY (IDEspacio)
						);/*#4*/

CREATE TABLE EstadoResidencia (
								IDEstadoResidencia INT NOT NULL, /*PK*/
								IDResidencia INT NOT NULL, /*FK*/
								estado VARCHAR(25) NOT NULL,
								PRIMARY KEY (IDEstadoResidencia)
								);/*#5*/

CREATE TABLE GestionRubrosCobros (
									IDRubro INT NOT NULL, /*PK*/
									descripcion VARCHAR(20) NOT NULL,
									monto MONEY NOT NULL,
									PRIMARY KEY (IDRubro)
									);/*#6*/
/*CAMBIAR NOMBRES DE FKS*/
CREATE TABLE Usuarios (
						ID INT NOT NULL, /*PK*/ 
						nombre VARCHAR(25) NOT NULL, 
						contrasenna VARCHAR(25) NOT NULL, 
						IDTipoUsuario INT NOT NULL, /*FK*/ 
						email VARCHAR(50) NOT NULL, 
						estado BIT NOT NULL, 
						telefono INT NOT NULL,
						PRIMARY KEY (ID),
						CONSTRAINT FK_Usuarios_IDTipoUsuario FOREIGN KEY (IDTipoUsuario) REFERENCES TiposUsuarios(ID)
						);/*#7*/

CREATE TABLE ReporteIncidencias (
									IDIncidencia INT NOT NULL, /*PK*/
									IDEstado INT NOT NULL, /*FK*/
									IDUsuario INT NOT NULL, /*FK*/
									descripcion VARCHAR(50) NOT NULL, /*
									evidencias foto*/ 
									PRIMARY KEY (IDIncidencia),
									CONSTRAINT FK_ReporteIncidencias_IDEstado FOREIGN KEY (IDEstado) REFERENCES EstadoIncidencia(IDEstado),
									CONSTRAINT FK_ReporteIncidencias_IDUsuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(ID)
									);

CREATE TABLE Informacion (
							IDInformacion INT NOT NULL, /*PK*/
							IDTipoInfo INT NOT NULL, /*FK*/
							fechaPulicacion DATE NOT NULL,
							descripcion VARCHAR(20) NOT NULL,/*
							adjuntos foto NOT NULL*/
							PRIMARY KEY (IDInformacion),
							CONSTRAINT FK_Informacion_IDTipoInfo FOREIGN KEY (IDTipoInfo) REFERENCES TipoInformacion(IDTipoInfo)
							);

CREATE TABLE GestionReservas (
								IDReserva INT NOT NULL, /*PK*/
								IDUsuario INT NOT NULL, /*FK*/
								IDEspacio INT NOT NULL, /*FK*/
								fecha DATE NOT NULL,
								horaInicio TIME NOT NULL,
								horaFinal TIME NOT NULL,
								estado BIT NOT NULL,
								PRIMARY KEY (IDReserva),
								CONSTRAINT FK_GestionReservas_IDUsuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(ID),
								CONSTRAINT FK_GestionReservas_IDEspacio FOREIGN KEY (IDEspacio) REFERENCES Espacios(IDEspacio)
								);

CREATE TABLE GestionResidencias (
									IDResidencia INT NOT NULL, /*PK*/
									IDUsuario INT NOT NULL, /*FK*/
									cantPersonas INT NOT NULL,
									IDEstadoResidencia INT NOT NULL, /*FK*/
									annoInicio DATE NOT NULL,
									cantCarros INT NOT NULL,
									PRIMARY KEY (IDResidencia),
									CONSTRAINT FK_GestionResidencias_IDUsuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(ID),
									CONSTRAINT FK_GestionResidencias_IDEstadoResidencia FOREIGN KEY (IDEstadoResidencia) REFERENCES EstadoResidencia(IDEstadoResidencia),
									);

CREATE TABLE Carros (
						IDPlaca VARCHAR(10) NOT NULL,/*PK*/
						IDResidencia INT NOT NULL, /*FK*/
						modelo VARCHAR(15) NOT NULL,
						PRIMARY KEY (IDPlaca),
						CONSTRAINT FK_Carros_IDResidencia FOREIGN KEY (IDResidencia) REFERENCES GestionResidencias(IDResidencia)
						);

CREATE TABLE PersonasResidentes (
									IDCedula INT NOT NULL, /*PK*/
									IDResidencia INT NOT NULL, /*FK*/
									nombre VARCHAR(50) NOT NULL,
									PRIMARY KEY (IDCedula),
									CONSTRAINT FK_PersonasResidentes_IDResidencia FOREIGN KEY (IDResidencia) REFERENCES GestionResidencias(IDResidencia)
									);

CREATE TABLE GestionPlanCobros (
									IDPlan INT NOT NULL, /*PK*/
									IDRubro INT NOT NULL, /*FK*/
									descripcion VARCHAR(25) NOT NULL,
									PRIMARY KEY (IDPlan),
									CONSTRAINT FK_GestionPlanCobros_IDRubro FOREIGN KEY (IDRubro) REFERENCES GestionRubrosCobros(IDRubro)
									);

CREATE TABLE GestionAsignacionPlanes (
										IDAsignacion INT NOT NULL, /*PK*/
										IDResidencia INT NOT NULL, /*FK*/
										IDPlan INT NOT NULL, /*FK*/
										fechaAsignacion DATE NOT NULL,
										estadoPago BIT NOT NULL,
										PRIMARY KEY (IDAsignacion),
										CONSTRAINT FK_GestionAsignacionPlanes_IDResidencia FOREIGN KEY (IDResidencia) REFERENCES GestionResidencias(IDResidencia),
										CONSTRAINT FK_GestionAsignacionPlanes_IDPlan FOREIGN KEY (IDPlan) REFERENCES GestionPlanCobros(IDPlan)
										);

CREATE TABLE Rubros_Planes (
								IDPlan INT NOT NULL,
								IDRubro INT NOT NULL
								CONSTRAINT FK_Rubros_Planes_IDRubro FOREIGN KEY (IDRubro) REFERENCES GestionRubrosCobros(IDRubro),
								CONSTRAINT FK_Rubros_Planes_IDPlan FOREIGN KEY (IDPlan) REFERENCES GestionPlanCobros(IDPlan)
								);

/*CREATE TABLE GestionDeudas (
								IDDeuda INT NOT NULL, /*PK*/
								IDAsignacion INT NOT NULL, /*FK*/
								PRIMARY KEY (IDDeuda),
								CONSTRAINT FK_GestionDeudas_IDAsignacion FOREIGN KEY (IDAsignacion) REFERENCES GestionAsignacionPlanes(IDAsignacion)
								);*/