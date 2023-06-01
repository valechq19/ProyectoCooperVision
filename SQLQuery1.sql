
USE master;

DROP DATABASE IF EXISTS AccessRequests;
CREATE DATABASE AccessRequests;

USE AccessRequests;
-- Creación tabla de supervisores
CREATE TABLE Supervisor (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del registro
"Name" varchar(30) NOT NULL, -- Nombre del supervisor
LastName varchar(30) NOT NULL, -- Apellido del supervisor
Email varchar(40) NOT NULL); -- Correo del supervisor


-- Creación tabla de posiciones
CREATE TABLE Position (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la posición/puesto
Position varchar(30) NOT NULL); -- Nombre de la posición


-- Creación tabla de estados (de las solicitudes)
CREATE TABLE "Status" (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del estado
"Status" varchar(30) NOT NULL); -- Nombre del estado


-- Creación tabla de sistemas
CREATE TABLE "Application" (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del sistema
"Application" varchar(30) NOT NULL); -- Nombre del sistema


-- Creación tabla de sedes
CREATE TABLE Headquarter (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la sede
Headquarter varchar(2) NOT NULL); -- Abreviatura de la sede



-- Creación tabla aprobadores
CREATE TABLE Approver (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del aprobador
"Name" varchar(30) NOT NULL, -- Nombre del supervisor
LastName varchar(30) NOT NULL, -- Apellido del supervisor
Email varchar(40) NOT NULL, -- Correo del supervisor
IdHeadquarter bigint NOT NULL -- Sede donde labora el aprobador (CR o PR)
CONSTRAINT FkHeadquarter FOREIGN KEY (IdHeadquarter) REFERENCES Headquarter (ID)); -- Llave foránea del id de la sede


-- Creación tabla de empleados
CREATE TABLE Employee (
ID bigint PRIMARY KEY, -- Id/Número del empleado. Se ingresa al hacer la solicitud
Employee varchar(30) NOT NULL, -- Nombre del empleado
LastName1 varchar(30) NOT NULL, -- Primer apellido del empleado
LastName2 varchar(30) NOT NULL); -- Segundo apellido del empleado


-- Creación tabla de solicitudes
CREATE TABLE Request (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la solicitud
IdEmployee bigint, -- Id/Número de empleado
IdPosition bigint, -- Id de la posición/puesto
RequestDate datetime, -- Fecha en que se realiza la solicitud
IdSupervisor bigint, -- Id del supervisor que realiza la solicitud
CONSTRAINT FkEmployee FOREIGN KEY (IdEmployee) REFERENCES Employee (ID), -- Llave foránea del número de empleado
CONSTRAINT FkPosition FOREIGN KEY (IdPosition) REFERENCES Position (ID), -- Llave foránea del id de la posición
CONSTRAINT FkSupervisor FOREIGN KEY (IdSupervisor) REFERENCES Supervisor (ID) -- Llave foránea del id del supervisor
);


-- Creación tabla de accesos o permisos

CREATE TABLE Access (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del acceso
Access varchar(30) NOT NULL, -- Nombre del acceso
IdApplication bigint NOT NULL, -- Id del sistema al que pertenece el acceso
"Level" varchar(30) NOT NULL, -- Nivel al que pertenece el acceso
IdApprover bigint NOT NULL, -- Id del aprobador del acceso o permiso
CONSTRAINT FkApplication FOREIGN KEY (IdApplication) REFERENCES "Application" (ID), -- Llave foránea del id del sistema
CONSTRAINT FkApprover FOREIGN KEY (IdApprover) REFERENCES Approver (ID)); -- Llave foránea del id del aprobador del permiso



-- Creación tabla de relación accesos-posiciones
CREATE TABLE AccessPosition(
IdPosition bigint, -- Id de la posición/puesto. Hay accesos (como el de correo electrónico) que no están relacionados a una posición específica
IdAccess bigint NOT NULL, -- Id del acceso solicitado
CONSTRAINT FkPosition2 FOREIGN KEY (IdPosition) REFERENCES Position (ID), -- Llave foránea del id de la posición
CONSTRAINT FkAccess FOREIGN KEY (IdAccess) REFERENCES Access (ID)); -- Llave foránea del id del acceso


-- Creación tabla de relación accesos-solicitud
CREATE TABLE AccessRequested (
IdRequest bigint NOT NULL, -- Id de la solicitud
IdAccess bigint NOT NULL, -- Id del acceso solicitado
IdStatus bigint NOT NULL, -- Id del estado en que se encuentra la solicitud
UpdateDate datetime, -- Fecha en la que se acepta o deniega el permiso
Comments varchar(200), -- Comentarios que puede que haga el aprobador
CONSTRAINT FkRequest FOREIGN KEY (IdRequest) REFERENCES Request (ID), -- Llave foránea del id de la solicitud
CONSTRAINT FkAccess2 FOREIGN KEY (IdAccess) REFERENCES Access (ID), -- Llave foránea del id del acceso
CONSTRAINT FkStatus FOREIGN KEY (IdStatus) REFERENCES "Status" (ID)); -- Llave foránea del id del estado


-- Prueba drop-down
CREATE TABLE AccessPrueba (
PositionPru varchar(30) NOT NULL,
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del acceso
Access varchar(30) NOT NULL, -- Nombre del acceso
Application varchar(30) NOT NULL, -- Id del sistema al que pertenece el acceso
"Level" varchar(30) NOT NULL, -- Nivel al que pertenece el acceso
); 

-- Inserts

-- Prueba drop-down
--Posición  1--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry Operator','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','EBR Wet TO', 'EBR', 'EBRWTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry Operator','Wet Lot Creation', 'WLC', 'WLC');

--Posición  2--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry MultiSkill','EBR Wet PT', 'EBR', 'EBRWPT');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry MultiSkill','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry MultiSkill','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry MultiSkill','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry MultiSkill','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry MultiSkill','Wet Lot Creation', 'WLC', 'WLC');

--Posición  3--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry PST1','Dry Lot Creation', 'DLC', 'DLC');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry PST1','EBR Dry Direct Labor', 'EBR', 'EBRDDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry PST1','EBR Dry Mechanic', 'EBR', 'EBRDME');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry PST1','EBR Dry Tech Operator', 'EBR', 'EBRDTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level") 
VALUES ('Dry PST1','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST1','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST1','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');

--Posición  4--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','Dry Lot Creation', 'DLC', 'DLC');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','EBR Dry Direct Labor', 'EBR', 'EBRDDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','EBR Dry Mechanic', 'EBR', 'EBRDME');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','EBR Dry Tech Operator', 'EBR', 'EBRDTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST2','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');

--Posición  5--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','Dry Lot Creation', 'DLC', 'DLC');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','EBR Dry Direct Labor', 'EBR', 'EBRDDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','EBR Dry Mechanic', 'EBR', 'EBRDME');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','EBR Dry Team Leader', 'EBR', 'EBRDTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','EBR Dry Tech Operator', 'EBR', 'EBRDTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','EBR Operator for Reporrts', 'EBR', 'EBROPER');	
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Dry PST3','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');


--Posición  6--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','Dry Lot Creation', 'DLC', 'DLC');	
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','EBR Dry Direct Labor', 'EBR', 'EBRDDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','EBR Dry Mechanic', 'EBR', 'EBRDME');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet Operator','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');

--Posición  7--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','Dry Lot Creation', 'DLC', 'DLC');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','EBR Dry Direct Labor', 'EBR', 'EBRDDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','EBR Dry Mechanic', 'EBR', 'EBRDME');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet MultiSkill','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
	
--Posición  8--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','EBR Wet TO', 'EBR', 'EBRWTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST1','Wet Lot Creation', 'WLC', 'WLC');

--Posición  9--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','EBR Wet DL', 'EBR', 'EBRWDL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','EBR Wet PT', 'EBR', 'EBRWPT');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');	
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST2','Wet Lot Creation', 'WLC', 'WLC');

--Posición  10--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','EBR Operator for Reporrts', 'EBR', 'EBROPER');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','EBR Reports', 'EBR', 'EBRREPORTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','EBR Wet Team Leader', 'EBR', 'EBRWTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','EBR Wet TO', 'EBR', 'EBRWTO');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','Toggle door status bit', 'SCANBAG', 'SCANBAGTGL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('Wet PST3','Wet Lot Creation', 'WLC', 'WLC');

--Posición  11--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','Dry Lot Creation', 'DLC', 'DLC');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','EBR Dry Team Leader', 'EBR', 'EBRDTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','EBR SUPERVISOR', 'EBR', 'EBRSUPERVISOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','EBR Wet Team Leader', 'EBR', 'EBRWTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','Toggle door status bit', 'SCANBAG', 'SCANBAGTGL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Process Flow Lead','Wet Lot Creation', 'WLC', 'WLC');

--Posición  12--
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','EBR ALL Access', 'EBR', 'EBRALL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','EBR Dry Team Leader', 'EBR', 'EBRDTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','EBR SUPERVISOR', 'EBR', 'EBRSUPERVISOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','EBR Wet Team Leader', 'EBR', 'EBRWTL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','ELECTRONIC BATCH RECORD', 'EBR', 'EBR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','Get Lots', 'GETLOTS', 'GETLOTS');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','Open Delenser Feeder Manually', 'SCANBAG', 'SCANBAGDOOR');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','SCANBAG', 'SCANBAG', 'SCANBAG');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','Toggle door status bit', 'SCANBAG', 'SCANBAGTGL');
INSERT INTO AccessPrueba(PositionPru,Access,Application,"Level")
VALUES ('MFG Lead','Wet Lot Creation', 'WLC', 'WLC');


--Position
INSERT INTO Position(Position) 
VALUES ('Dry Operator');
INSERT INTO Position(Position) 
VALUES ('Dry MultiSkill');
INSERT INTO Position(Position) 
VALUES ('Dry PST1');
INSERT INTO Position(Position) 
VALUES ('Dry PST2');
INSERT INTO Position(Position) 
VALUES ('Dry PST3');
INSERT INTO Position(Position) 
VALUES ('Wet Operator');
INSERT INTO Position(Position) 
VALUES ('Wet MultiSkill');
INSERT INTO Position(Position) 
VALUES ('Wet PST1');
INSERT INTO Position(Position) 
VALUES ('Wet PST2');
INSERT INTO Position(Position) 
VALUES ('Wet PST3');
INSERT INTO Position(Position) 
VALUES ('MFG Process Flow Lead');
INSERT INTO Position(Position) 
VALUES ('MFG Lead');

select * from Application

--Application
INSERT INTO Application("Application") 
VALUES ('WLC');
INSERT INTO Application("Application") 
VALUES ('DLC');
INSERT INTO Application("Application") 
VALUES ('EBR');
INSERT INTO Application("Application") 
VALUES ('GETLOTS');
INSERT INTO Application("Application") 
VALUES ('SCANBAG');
select * from Headquarter

--Headquarter
INSERT INTO Headquarter(Headquarter) 
VALUES ('CR');
INSERT INTO Headquarter(Headquarter) 
VALUES ('PR');

--Approver
INSERT INTO Approver("Name",LastName,Email,IdHeadquarter) 
VALUES ('Valeria','Chacon','vchacongv@gmail.com', 1);

--Access
INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Close S.O.', 1, 'WLCSOCLOSE', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('DLC MoldMaintenance', 2, 'DLCMM', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Dry Lot Creation', 2, 'DLC', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR ALL Access', 3, 'EBRALL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Dry Direct Labor', 3, 'EBRDDL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Dry Mechanic', 3, 'EBRDME', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Dry Quality Operator', 3, 'EBRDQO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Dry Team Leader', 3, 'EBRDTL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Dry Tech Operator', 3, 'EBRDTO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Manage Instructions', 3, 'EBRINST', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Operator for Reporrts', 3, 'EBROPER', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR QA Final Operator', 3, 'EBRQOP', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR QA Final Quality Operator', 3, 'EBRQQO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR QA Final Team Leader', 3, 'EBRQTL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR QO for Reports', 3, 'EBRQA', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Reports', 3, 'EBRREPORTS', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Sterilization Operator', 3, 'EBRSOP', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Sterilization Quality Operator', 3, 'EBRSQO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Sterilization Team Leader', 3, 'EBRSTL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR SUPERVISOR', 3, 'EBRSUPERVISOR', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Wet DL', 3, 'EBRWDL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Wet PT', 3, 'EBRWPT', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Wet Quality', 3, 'EBRWQO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Wet Team Leader', 3, 'EBRWTL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('EBR Wet TO', 3, 'EBRWTO', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('ELECTRONIC BATCH RECORD', 3, 'EBR', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Get Lots', 4, 'GETLOTS', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Get Lots Add QC Data', 4, 'GETLOTSADD', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Open Delenser Feeder Manually', 5, 'SCANBAGDOOR', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Remove Dry Lot - Negative Issue', 1, 'WLCNEGISSUE', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Scan Bag Settings', 5, 'SCANBAGSTT', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('SCANBAG', 5, 'SCANBAG', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Toggle door status bit', 5, 'SCANBAGTGL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Use Not Validated Insert', 2, 'DLCNOTVAL', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('Wet Lot Creation', 1, 'WLC', 1);

INSERT INTO Access(Access,IdApplication,"Level",IdApprover) 
VALUES ('WLC Settings', 1, 'WLCSETTING', 1);


-- Access Position

-- Dry Operator
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,25);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (1,35);

-- Dry MultiSkill
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,21);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,22);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (2,35);

-- Dry PST1
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,5);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,6);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,9);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (3,26);

-- Dry PST2
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,5);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,6);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,9);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (4,26);

-- Dry PST3
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,5);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,6);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,8);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,9);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (5,26);

-- Wet Operator
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,5);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,6);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (6,26);

-- Wet MultiSkill
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,5);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,6);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (7,26);

-- Wet PST1
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,25);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (8,35);

-- Wet PST2
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,21);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,22);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (9,35);

-- Wet PST3
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,11);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,16);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,24);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,25);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,33);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (10,35);

-- MFG Process Flow Lead
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,8);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,20);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,24);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,33);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (11,35);

-- MFG Lead
INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,3);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,4);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,8);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,20);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,24);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,26);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,27);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,29);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,32);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,33);

INSERT INTO AccessPosition(IdPosition,IdAccess) 
VALUES (12,35);


-- Procedure

CREATE PROCEDURE [dbo].[ConsultarPositions]

AS 
BEGIN
	SELECT AccessPrueba.Access,AccessPrueba.Application, AccessPrueba."Level"
    FROM AccessPrueba
    
	END
	GO
