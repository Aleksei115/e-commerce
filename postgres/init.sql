-- -- Crear la base de datos ecommerce
-- CREATE DATABASE ecommerce;

-- Conectarse a la base de datos ecommerce
\c ecommerce

-- Crear la tabla Usuario
CREATE TABLE usuario (
    id_usuario VARCHAR(64) PRIMARY KEY,
    nombre_usuario VARCHAR(20) UNIQUE,
    password VARCHAR(16),
    nombre VARCHAR(60),
    calle VARCHAR(50),
    numero INTEGER,
    cp VARCHAR(15),
    colonia VARCHAR(30)
);

-- Crear la tabla cuenta_bancaria
CREATE TABLE cuenta_bancaria (
    numero_cuenta VARCHAR(22) PRIMARY KEY,
    banco VARCHAR(20),
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('credito', 'debito')),
    preferida BOOLEAN,
    id_usuario VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Crear la tabla Carrito_compras
CREATE TABLE carrito_compras (
    id_carrito VARCHAR(64) PRIMARY KEY,
    fecha DATE,
    id_usuario VARCHAR(22),
    vclock VARCHAR(120),
    comprado BOOLEAN,
    activo BOOLEAN,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Crear la tabla Inventario
CREATE TABLE inventario (
    id_producto VARCHAR(64) PRIMARY KEY,
    cantidad INTEGER
);


-- Importar datos en la tabla Usuario
COPY usuario(id_usuario, nombre_usuario, password, nombre, calle, numero, cp, colonia)
FROM '/docker-entrypoint-initdb.d/usuarios.csv'
DELIMITER ','
CSV HEADER;

-- Importar datos en la tabla cuenta_bancaria
COPY cuenta_bancaria(numero_cuenta, banco, tipo_cuenta, preferida,id_usuario)
FROM '/docker-entrypoint-initdb.d/cuentas_bancarias.csv'
DELIMITER ','
CSV HEADER;


-- -- Importar datos en la tabla Carrito_compras
-- COPY carrito_compras(id_carrito, fecha, numero_cuenta)
-- FROM '/docker-entrypoint-initdb.d/carrito_compras.csv'
-- DELIMITER ','
-- CSV HEADER;


-- Importar datos en la tabla Inventario
COPY inventario(id_producto, cantidad)
FROM '/docker-entrypoint-initdb.d/inventario.csv'
DELIMITER ','
CSV HEADER;

-- -- Incluir el script para importar datos
-- \i '/docker-entrypoint-initdb.d/import_data.sql'