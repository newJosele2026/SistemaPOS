/* =============================================================================
   SCRIPT DDL - BASE DE DATOS FIREBIRD SQL
   Proyecto: POSIxoraSoft
   Origen: Diagrama Entidad-Relación (POSIxoraSoft-POS.drawio)
   Motor: Firebird 2.5 / 3.0 / 4.0+
   ============================================================================= */

/* -----------------------------------------------------------------------------
   0. CONFIGURACIÓN INICIAL / DOMINIOS
   ----------------------------------------------------------------------------- */
-- En Firebird 3.0+ el tipo BOOLEAN es nativo.
-- Si se utiliza Firebird 2.5 o anterior, descomentar el siguiente dominio:
-- CREATE DOMAIN D_BOOLEAN AS SMALLINT DEFAULT 1 CHECK (VALUE IN (0, 1));

/* -----------------------------------------------------------------------------
   1. GENERADORES / SECUENCIAS
   ----------------------------------------------------------------------------- */
CREATE SEQUENCE GEN_ROL_ID;
CREATE SEQUENCE GEN_USUARIO_ID;
CREATE SEQUENCE GEN_LOGAUDI_USUARIO_ID;
CREATE SEQUENCE GEN_MARCAVEHICULO_ID;
CREATE SEQUENCE GEN_TIPO_VEHICULO_ID;
CREATE SEQUENCE GEN_VEHICULO_ID;
CREATE SEQUENCE GEN_CONTRATO_ID;
CREATE SEQUENCE GEN_CONTRATO_DETALLE_ID;
CREATE SEQUENCE GEN_CLIENTE_ID;
CREATE SEQUENCE GEN_VENTAS_ID;
CREATE SEQUENCE GEN_MOVIMIENTO_ID;
CREATE SEQUENCE GEN_BITACORA_VEHICULO_ID;
CREATE SEQUENCE GEN_MARCAPRODUCTO_ID;
CREATE SEQUENCE GEN_PROVEEDOR_ID;
CREATE SEQUENCE GEN_PRODUCTOS_ID;
CREATE SEQUENCE GEN_STOCK_ID;
CREATE SEQUENCE GEN_PROD_PROV_ID;
CREATE SEQUENCE GEN_BITACORA_PRODUCTOS_ID;
CREATE SEQUENCE GEN_EGRESOS_ID;
CREATE SEQUENCE GEN_TURNO_ID;
CREATE SEQUENCE GEN_ASIGNACION_TURNO_ID;
CREATE SEQUENCE GEN_REGISTRO_ASISTENCIA_ID;

/* -----------------------------------------------------------------------------
   2. CREACIÓN DE TABLAS
   ----------------------------------------------------------------------------- */

-- =============================================================================
-- TABLA: ROL
-- =============================================================================
CREATE TABLE ROL (
    idRol INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_ROL PRIMARY KEY (idRol)
);

-- =============================================================================
-- TABLA: USUARIO
-- =============================================================================
CREATE TABLE USUARIO (
    idUsuario INTEGER NOT NULL,
    nombreCompleto VARCHAR(50) NOT NULL,
    usuario VARCHAR(45) NOT NULL,
    passwordHash VARCHAR(50) NOT NULL,
    horario VARCHAR(2),
    descripcion VARCHAR(120),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    idRol_Rol INTEGER NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (idUsuario)
);

-- =============================================================================
-- TABLA: LOGAUDI_USUARIO
-- =============================================================================
CREATE TABLE LOGAUDI_USUARIO (
    idLogAudi_Usuario BIGINT NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Operacion VARCHAR(3) NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    Detalles VARCHAR(120),
    idUsuario_Usuario INTEGER NOT NULL,
    CONSTRAINT PK_LOGAUDI_USUARIO PRIMARY KEY (idLogAudi_Usuario)
);

-- =============================================================================
-- TABLA: MARCAVEHICULO
-- =============================================================================
CREATE TABLE MARCAVEHICULO (
    idMarcaVehiculo INTEGER NOT NULL,
    codMarca VARCHAR(3) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(50),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_MARCAVEHICULO PRIMARY KEY (idMarcaVehiculo)
);

-- =============================================================================
-- TABLA: TIPO_VEHICULO
-- =============================================================================
CREATE TABLE TIPO_VEHICULO (
    idTipo_Vehiculo INTEGER NOT NULL,
    codTipo_vehiculo VARCHAR(2) NOT NULL,
    tarifaxMin DOUBLE PRECISION NOT NULL,
    tarifaxCuarta DOUBLE PRECISION NOT NULL,
    logo BLOB SUB_TYPE TEXT,
    descripcion VARCHAR(50),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_TIPO_VEHICULO PRIMARY KEY (idTipo_Vehiculo)
);

-- =============================================================================
-- TABLA: VEHICULO
-- =============================================================================
CREATE TABLE VEHICULO (
    idVehiculo BIGINT NOT NULL,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(4),
    color VARCHAR(20),
    cedula VARCHAR(15),
    nombre VARCHAR(50),
    idTipo_Vehiculo_Tipo_Vehiculo INTEGER NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    idMarca_marca INTEGER NOT NULL,
    linea VARCHAR(20),
    observaciones VARCHAR(150),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_VEHICULO PRIMARY KEY (idVehiculo)
);

-- =============================================================================
-- TABLA: CONTRATO
-- =============================================================================
CREATE TABLE CONTRATO (
    idContrato INTEGER NOT NULL,
    idVehiculo_vehiculo BIGINT NOT NULL,
    valor DOUBLE PRECISION,
    observacion VARCHAR(50),
    FechaInicio TIMESTAMP,
    FechaFin TIMESTAMP,
    repet INTEGER,
    numContrato VARCHAR(15) NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_CONTRATO PRIMARY KEY (idContrato)
);

-- =============================================================================
-- TABLA: CONTRATO_DETALLE
-- =============================================================================
CREATE TABLE CONTRATO_DETALLE (
    idContrato_detalle INTEGER NOT NULL,
    fechaInicio TIMESTAMP,
    fechaFin TIMESTAMP,
    fechapago TIMESTAMP,
    valor DOUBLE PRECISION,
    consec INTEGER,
    idContrato_contrato INTEGER NOT NULL,
    idUsuarioVendedor INTEGER NOT NULL,
    total DOUBLE PRECISION,
    iva DOUBLE PRECISION,
    subtotal DOUBLE PRECISION,
    descuen DOUBLE PRECISION,
    numfac VARCHAR(20),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_CONTRATO_DETALLE PRIMARY KEY (idContrato_detalle)
);

-- =============================================================================
-- TABLA: CLIENTE
-- =============================================================================
CREATE TABLE CLIENTE (
    idClientel INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    identificacion VARCHAR(20) NOT NULL,
    tipoIdentificacion VARCHAR(2),
    descripcion VARCHAR(120),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (idClientel)
);

-- =============================================================================
-- TABLA: VENTAS
-- =============================================================================
CREATE TABLE VENTAS (
    idVentas BIGINT NOT NULL,
    nrocompra VARCHAR(10),
    idCliente INTEGER,
    fechaVenta TIMESTAMP NOT NULL,
    ValoracionC DOUBLE PRECISION,
    cerrado VARCHAR(1) NOT NULL,
    descuentoAC DOUBLE PRECISION,
    cuentaC VARCHAR(20),
    cuentaD VARCHAR(20),
    valorsubAC DOUBLE PRECISION,
    valorIvaAC DOUBLE PRECISION,
    valoradicional DOUBLE PRECISION,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_VENTAS PRIMARY KEY (idVentas)
);

-- =============================================================================
-- TABLA: MOVIMIENTO
-- =============================================================================
CREATE TABLE MOVIMIENTO (
    idMovimiento BIGINT NOT NULL,
    idVentas_ventas BIGINT NOT NULL,
    fechaInicio TIMESTAMP,
    horaInicio VARCHAR(5),
    verifi VARCHAR(20),
    idUsuarioVendedor INTEGER NOT NULL,
    cons VARCHAR(10),
    facseradi VARCHAR(1),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_MOVIMIENTO PRIMARY KEY (idMovimiento)
);

-- =============================================================================
-- TABLA: BITACORA_VEHICULO
-- =============================================================================
CREATE TABLE BITACORA_VEHICULO (
    idbitacoraVehiculo BIGINT NOT NULL,
    idVehiculo_vehiculo BIGINT NOT NULL,
    idVentas_ventas BIGINT NOT NULL,
    horaInicio VARCHAR(5),
    horafin VARCHAR(5),
    fechainicio TIMESTAMP,
    fechafin TIMESTAMP,
    valor DOUBLE PRECISION,
    total DOUBLE PRECISION,
    verificacion VARCHAR(20),
    idUsuarioVendedor INTEGER NOT NULL,
    consecutivo VARCHAR(20),
    descuento DOUBLE PRECISION,
    formpago VARCHAR(2),
    iva DOUBLE PRECISION,
    totalAdicional DOUBLE PRECISION,
    tipo CHAR(1),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_BITACORA_VEHICULO PRIMARY KEY (idbitacoraVehiculo)
);

-- =============================================================================
-- TABLA: MARCAPRODUCTO
-- =============================================================================
CREATE TABLE MARCAPRODUCTO (
    idmarcaProducto INTEGER NOT NULL,
    nombreMarca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50),
    logo BLOB SUB_TYPE TEXT,
    descripcion VARCHAR(120),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_MARCAPRODUCTO PRIMARY KEY (idmarcaProducto)
);

-- =============================================================================
-- TABLA: PROVEEDOR
-- =============================================================================
CREATE TABLE PROVEEDOR (
    idproveedor INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    identificacion VARCHAR(50),
    tipoIdentificacion VARCHAR(1),
    costos DOUBLE PRECISION,
    descripcion VARCHAR(120),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY (idproveedor)
);

-- =============================================================================
-- TABLA: PRODUCTOS
-- =============================================================================
CREATE TABLE PRODUCTOS (
    idProducto INTEGER NOT NULL,
    idmarcaproducto_marcaproducto INTEGER,
    idproveedor_proveedor INTEGER,
    nombre VARCHAR(50) NOT NULL,
    Imagen BLOB SUB_TYPE TEXT,
    descripcion VARCHAR(120),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (idProducto)
);

-- =============================================================================
-- TABLA: STOCK
-- =============================================================================
CREATE TABLE STOCK (
    idStock BIGINT NOT NULL,
    idProducto INTEGER NOT NULL,
    codigoStock VARCHAR(50),
    codigoBarra VARCHAR(50),
    descripcionNovedad VARCHAR(50),
    precioVenta DOUBLE PRECISION,
    precioCompra DOUBLE PRECISION,
    dtfechaFabricacion TIMESTAMP,
    dtfechaVencimiento TIMESTAMP,
    enExistencia VARCHAR(1),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_STOCK PRIMARY KEY (idStock)
);

-- =============================================================================
-- TABLA: PROD_PROV (Relación Muchos a Muchos: Productos - Proveedor)
-- =============================================================================
CREATE TABLE PROD_PROV (
    idproduc_prov INTEGER NOT NULL,
    idProducto_producto INTEGER,
    idProveedor_proveedor INTEGER,
    nombre VARCHAR(50),
    identificacion VARCHAR(50),
    tipoIdentificacion VARCHAR(1),
    costos DOUBLE PRECISION,
    descripcion VARCHAR(120),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_PROD_PROV PRIMARY KEY (idproduc_prov)
);

-- =============================================================================
-- TABLA: BITACORA_PRODUCTOS
-- =============================================================================
CREATE TABLE BITACORA_PRODUCTOS (
    idbitacoraProductos BIGINT NOT NULL,
    idProductos_producto INTEGER NOT NULL,
    idVentas_ventas BIGINT NOT NULL,
    fechaVenta DOUBLE PRECISION,
    valor DOUBLE PRECISION,
    total DOUBLE PRECISION,
    verificacion VARCHAR(20),
    idUsuarioVendedor INTEGER NOT NULL,
    consecutivo VARCHAR(20),
    descuento DOUBLE PRECISION,
    formpago VARCHAR(2),
    iva DOUBLE PRECISION,
    totalAdicional DOUBLE PRECISION,
    tipo CHAR(1),
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    CONSTRAINT PK_BITACORA_PRODUCTOS PRIMARY KEY (idbitacoraProductos)
);

-- =============================================================================
-- TABLA: EGRESOS
-- =============================================================================
CREATE TABLE EGRESOS (
    idEgresosl INTEGER NOT NULL,
    idUsuario_usuario INTEGER NOT NULL,
    motivo VARCHAR(120),
    valor DOUBLE PRECISION,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_EGRESOS PRIMARY KEY (idEgresosl)
);

-- =============================================================================
-- TABLA: TURNO
-- =============================================================================
CREATE TABLE TURNO (
    idturno INTEGER NOT NULL,
    codigo_Turno VARCHAR(15),
    nombre_Turno VARCHAR(50),
    hora_inicio TIME,
    hora_fin TIME,
    horas_Totales DECIMAL(4, 2),
    margen_Error_Min INTEGER,
    aplica_Festivos BOOLEAN,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_TURNO PRIMARY KEY (idturno)
);

-- =============================================================================
-- TABLA: ASIGNACION_TURNO
-- =============================================================================
CREATE TABLE ASIGNACION_TURNO (
    idasignacion_turno BIGINT NOT NULL,
    idUsuario_usuario INTEGER NOT NULL,
    idturno_turno INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(1) NOT NULL,
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_ASIGNACION_TURNO PRIMARY KEY (idasignacion_turno)
);

-- =============================================================================
-- TABLA: REGISTRO_ASISTENCIA
-- =============================================================================
CREATE TABLE REGISTRO_ASISTENCIA (
    idregistro_asistencia_turno BIGINT NOT NULL,
    idasignacion_turno BIGINT NOT NULL,
    idturno_turno INTEGER NOT NULL,
    fecha DATE NOT NULL,
    hora_entrada TIME,
    hora_salida TIME,
    hora_trabajadas DECIMAL(4, 2),
    estado_asistencia VARCHAR(25),
    bActivo BOOLEAN DEFAULT TRUE NOT NULL,
    dtFechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_REGISTRO_ASISTENCIA PRIMARY KEY (idregistro_asistencia_turno)
);

/* -----------------------------------------------------------------------------
   3. CLAVES FORÁNEAS (RELACIONES)
   ----------------------------------------------------------------------------- */

-- USUARIO -> ROL
ALTER TABLE USUARIO 
    ADD CONSTRAINT FK_USUARIO_ROL 
    FOREIGN KEY (idRol_Rol) REFERENCES ROL(idRol)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- LOGAUDI_USUARIO -> USUARIO
ALTER TABLE LOGAUDI_USUARIO 
    ADD CONSTRAINT FK_LOGAUDI_USUARIO 
    FOREIGN KEY (idUsuario_Usuario) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- VEHICULO -> TIPO_VEHICULO
ALTER TABLE VEHICULO 
    ADD CONSTRAINT FK_VEHICULO_TIPO 
    FOREIGN KEY (idTipo_Vehiculo_Tipo_Vehiculo) REFERENCES TIPO_VEHICULO(idTipo_Vehiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- VEHICULO -> MARCAVEHICULO
ALTER TABLE VEHICULO 
    ADD CONSTRAINT FK_VEHICULO_MARCA 
    FOREIGN KEY (idMarca_marca) REFERENCES MARCAVEHICULO(idMarcaVehiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- CONTRATO -> VEHICULO
ALTER TABLE CONTRATO 
    ADD CONSTRAINT FK_CONTRATO_VEHICULO 
    FOREIGN KEY (idVehiculo_vehiculo) REFERENCES VEHICULO(idVehiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- CONTRATO_DETALLE -> CONTRATO
ALTER TABLE CONTRATO_DETALLE 
    ADD CONSTRAINT FK_CONTRATODET_CONTRATO 
    FOREIGN KEY (idContrato_contrato) REFERENCES CONTRATO(idContrato)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- CONTRATO_DETALLE -> USUARIO (Vendedor)
ALTER TABLE CONTRATO_DETALLE 
    ADD CONSTRAINT FK_CONTRATODET_USUARIO 
    FOREIGN KEY (idUsuarioVendedor) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- VENTAS -> CLIENTE
ALTER TABLE VENTAS 
    ADD CONSTRAINT FK_VENTAS_CLIENTE 
    FOREIGN KEY (idCliente) REFERENCES CLIENTE(idClientel)
    ON UPDATE CASCADE ON DELETE SET NULL;

-- MOVIMIENTO -> VENTAS
ALTER TABLE MOVIMIENTO 
    ADD CONSTRAINT FK_MOVIMIENTO_VENTAS 
    FOREIGN KEY (idVentas_ventas) REFERENCES VENTAS(idVentas)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- MOVIMIENTO -> USUARIO (Vendedor)
ALTER TABLE MOVIMIENTO 
    ADD CONSTRAINT FK_MOVIMIENTO_USUARIO 
    FOREIGN KEY (idUsuarioVendedor) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- BITACORA_VEHICULO -> VEHICULO
ALTER TABLE BITACORA_VEHICULO 
    ADD CONSTRAINT FK_BITVEH_VEHICULO 
    FOREIGN KEY (idVehiculo_vehiculo) REFERENCES VEHICULO(idVehiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- BITACORA_VEHICULO -> VENTAS
ALTER TABLE BITACORA_VEHICULO 
    ADD CONSTRAINT FK_BITVEH_VENTAS 
    FOREIGN KEY (idVentas_ventas) REFERENCES VENTAS(idVentas)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- BITACORA_VEHICULO -> USUARIO (Vendedor)
ALTER TABLE BITACORA_VEHICULO 
    ADD CONSTRAINT FK_BITVEH_USUARIO 
    FOREIGN KEY (idUsuarioVendedor) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- PRODUCTOS -> MARCAPRODUCTO
ALTER TABLE PRODUCTOS 
    ADD CONSTRAINT FK_PRODUCTOS_MARCA 
    FOREIGN KEY (idmarcaproducto_marcaproducto) REFERENCES MARCAPRODUCTO(idmarcaProducto)
    ON UPDATE CASCADE ON DELETE SET NULL;

-- PRODUCTOS -> PROVEEDOR
ALTER TABLE PRODUCTOS 
    ADD CONSTRAINT FK_PRODUCTOS_PROVEEDOR 
    FOREIGN KEY (idproveedor_proveedor) REFERENCES PROVEEDOR(idproveedor)
    ON UPDATE CASCADE ON DELETE SET NULL;

-- STOCK -> PRODUCTOS
ALTER TABLE STOCK 
    ADD CONSTRAINT FK_STOCK_PRODUCTOS 
    FOREIGN KEY (idProducto) REFERENCES PRODUCTOS(idProducto)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- PROD_PROV -> PRODUCTOS
ALTER TABLE PROD_PROV 
    ADD CONSTRAINT FK_PRODPROV_PRODUCTOS 
    FOREIGN KEY (idProducto_producto) REFERENCES PRODUCTOS(idProducto)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- PROD_PROV -> PROVEEDOR
ALTER TABLE PROD_PROV 
    ADD CONSTRAINT FK_PRODPROV_PROVEEDOR 
    FOREIGN KEY (idProveedor_proveedor) REFERENCES PROVEEDOR(idproveedor)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- BITACORA_PRODUCTOS -> PRODUCTOS
ALTER TABLE BITACORA_PRODUCTOS 
    ADD CONSTRAINT FK_BITPROD_PRODUCTOS 
    FOREIGN KEY (idProductos_producto) REFERENCES PRODUCTOS(idProducto)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- BITACORA_PRODUCTOS -> VENTAS
ALTER TABLE BITACORA_PRODUCTOS 
    ADD CONSTRAINT FK_BITPROD_VENTAS 
    FOREIGN KEY (idVentas_ventas) REFERENCES VENTAS(idVentas)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- BITACORA_PRODUCTOS -> USUARIO (Vendedor)
ALTER TABLE BITACORA_PRODUCTOS 
    ADD CONSTRAINT FK_BITPROD_USUARIO 
    FOREIGN KEY (idUsuarioVendedor) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- EGRESOS -> USUARIO
ALTER TABLE EGRESOS 
    ADD CONSTRAINT FK_EGRESOS_USUARIO 
    FOREIGN KEY (idUsuario_usuario) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- ASIGNACION_TURNO -> USUARIO
ALTER TABLE ASIGNACION_TURNO 
    ADD CONSTRAINT FK_ASIGTURNO_USUARIO 
    FOREIGN KEY (idUsuario_usuario) REFERENCES USUARIO(idUsuario)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- ASIGNACION_TURNO -> TURNO
ALTER TABLE ASIGNACION_TURNO 
    ADD CONSTRAINT FK_ASIGTURNO_TURNO 
    FOREIGN KEY (idturno_turno) REFERENCES TURNO(idturno)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- REGISTRO_ASISTENCIA -> ASIGNACION_TURNO
ALTER TABLE REGISTRO_ASISTENCIA 
    ADD CONSTRAINT FK_REGASIST_ASIGTURNO 
    FOREIGN KEY (idasignacion_turno) REFERENCES ASIGNACION_TURNO(idasignacion_turno)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- REGISTRO_ASISTENCIA -> TURNO
ALTER TABLE REGISTRO_ASISTENCIA 
    ADD CONSTRAINT FK_REGASIST_TURNO 
    FOREIGN KEY (idturno_turno) REFERENCES TURNO(idturno)
    ON UPDATE CASCADE ON DELETE RESTRICT;

/* -----------------------------------------------------------------------------
   4. DISPARADORES (TRIGGERS) PARA AUTOINCREMENTO DE CLAVES PRIMARIAS
   ----------------------------------------------------------------------------- */
SET TERM ^ ;

CREATE OR ALTER TRIGGER TRG_ROL_BI FOR ROL
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idRol IS NULL OR NEW.idRol <= 0) THEN
        NEW.idRol = NEXT VALUE FOR GEN_ROL_ID;
END^

CREATE OR ALTER TRIGGER TRG_USUARIO_BI FOR USUARIO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idUsuario IS NULL OR NEW.idUsuario <= 0) THEN
        NEW.idUsuario = NEXT VALUE FOR GEN_USUARIO_ID;
END^

CREATE OR ALTER TRIGGER TRG_LOGAUDI_USUARIO_BI FOR LOGAUDI_USUARIO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idLogAudi_Usuario IS NULL OR NEW.idLogAudi_Usuario <= 0) THEN
        NEW.idLogAudi_Usuario = NEXT VALUE FOR GEN_LOGAUDI_USUARIO_ID;
END^

CREATE OR ALTER TRIGGER TRG_MARCAVEHICULO_BI FOR MARCAVEHICULO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idMarcaVehiculo IS NULL OR NEW.idMarcaVehiculo <= 0) THEN
        NEW.idMarcaVehiculo = NEXT VALUE FOR GEN_MARCAVEHICULO_ID;
END^

CREATE OR ALTER TRIGGER TRG_TIPO_VEHICULO_BI FOR TIPO_VEHICULO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idTipo_Vehiculo IS NULL OR NEW.idTipo_Vehiculo <= 0) THEN
        NEW.idTipo_Vehiculo = NEXT VALUE FOR GEN_TIPO_VEHICULO_ID;
END^

CREATE OR ALTER TRIGGER TRG_VEHICULO_BI FOR VEHICULO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idVehiculo IS NULL OR NEW.idVehiculo <= 0) THEN
        NEW.idVehiculo = NEXT VALUE FOR GEN_VEHICULO_ID;
END^

CREATE OR ALTER TRIGGER TRG_CONTRATO_BI FOR CONTRATO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idContrato IS NULL OR NEW.idContrato <= 0) THEN
        NEW.idContrato = NEXT VALUE FOR GEN_CONTRATO_ID;
END^

CREATE OR ALTER TRIGGER TRG_CONTRATO_DETALLE_BI FOR CONTRATO_DETALLE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idContrato_detalle IS NULL OR NEW.idContrato_detalle <= 0) THEN
        NEW.idContrato_detalle = NEXT VALUE FOR GEN_CONTRATO_DETALLE_ID;
END^

CREATE OR ALTER TRIGGER TRG_CLIENTE_BI FOR CLIENTE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idClientel IS NULL OR NEW.idClientel <= 0) THEN
        NEW.idClientel = NEXT VALUE FOR GEN_CLIENTE_ID;
END^

CREATE OR ALTER TRIGGER TRG_VENTAS_BI FOR VENTAS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idVentas IS NULL OR NEW.idVentas <= 0) THEN
        NEW.idVentas = NEXT VALUE FOR GEN_VENTAS_ID;
END^

CREATE OR ALTER TRIGGER TRG_MOVIMIENTO_BI FOR MOVIMIENTO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idMovimiento IS NULL OR NEW.idMovimiento <= 0) THEN
        NEW.idMovimiento = NEXT VALUE FOR GEN_MOVIMIENTO_ID;
END^

CREATE OR ALTER TRIGGER TRG_BITACORA_VEHICULO_BI FOR BITACORA_VEHICULO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idbitacoraVehiculo IS NULL OR NEW.idbitacoraVehiculo <= 0) THEN
        NEW.idbitacoraVehiculo = NEXT VALUE FOR GEN_BITACORA_VEHICULO_ID;
END^

CREATE OR ALTER TRIGGER TRG_MARCAPRODUCTO_BI FOR MARCAPRODUCTO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idmarcaProducto IS NULL OR NEW.idmarcaProducto <= 0) THEN
        NEW.idmarcaProducto = NEXT VALUE FOR GEN_MARCAPRODUCTO_ID;
END^

CREATE OR ALTER TRIGGER TRG_PROVEEDOR_BI FOR PROVEEDOR
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idproveedor IS NULL OR NEW.idproveedor <= 0) THEN
        NEW.idproveedor = NEXT VALUE FOR GEN_PROVEEDOR_ID;
END^

CREATE OR ALTER TRIGGER TRG_PRODUCTOS_BI FOR PRODUCTOS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idProducto IS NULL OR NEW.idProducto <= 0) THEN
        NEW.idProducto = NEXT VALUE FOR GEN_PRODUCTOS_ID;
END^

CREATE OR ALTER TRIGGER TRG_STOCK_BI FOR STOCK
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idStock IS NULL OR NEW.idStock <= 0) THEN
        NEW.idStock = NEXT VALUE FOR GEN_STOCK_ID;
END^

CREATE OR ALTER TRIGGER TRG_PROD_PROV_BI FOR PROD_PROV
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idproduc_prov IS NULL OR NEW.idproduc_prov <= 0) THEN
        NEW.idproduc_prov = NEXT VALUE FOR GEN_PROD_PROV_ID;
END^

CREATE OR ALTER TRIGGER TRG_BITACORA_PRODUCTOS_BI FOR BITACORA_PRODUCTOS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idbitacoraProductos IS NULL OR NEW.idbitacoraProductos <= 0) THEN
        NEW.idbitacoraProductos = NEXT VALUE FOR GEN_BITACORA_PRODUCTOS_ID;
END^

CREATE OR ALTER TRIGGER TRG_EGRESOS_BI FOR EGRESOS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idEgresosl IS NULL OR NEW.idEgresosl <= 0) THEN
        NEW.idEgresosl = NEXT VALUE FOR GEN_EGRESOS_ID;
END^

CREATE OR ALTER TRIGGER TRG_TURNO_BI FOR TURNO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idturno IS NULL OR NEW.idturno <= 0) THEN
        NEW.idturno = NEXT VALUE FOR GEN_TURNO_ID;
END^

CREATE OR ALTER TRIGGER TRG_ASIGNACION_TURNO_BI FOR ASIGNACION_TURNO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idasignacion_turno IS NULL OR NEW.idasignacion_turno <= 0) THEN
        NEW.idasignacion_turno = NEXT VALUE FOR GEN_ASIGNACION_TURNO_ID;
END^

CREATE OR ALTER TRIGGER TRG_REGISTRO_ASISTENCIA_BI FOR REGISTRO_ASISTENCIA
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.idregistro_asistencia_turno IS NULL OR NEW.idregistro_asistencia_turno <= 0) THEN
        NEW.idregistro_asistencia_turno = NEXT VALUE FOR GEN_REGISTRO_ASISTENCIA_ID;
END^

SET TERM ; ^

-- Fin del script
