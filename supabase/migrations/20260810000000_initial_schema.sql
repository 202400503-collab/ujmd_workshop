-- Migración inicial: estructura de base de datos del caso Sivar Express

CREATE TABLE IF NOT EXISTS departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS municipio (
    id_municipio SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    id_departamento INTEGER NOT NULL REFERENCES departamento(id_departamento)
);

CREATE TABLE IF NOT EXISTS cliente (
    dui_cliente VARCHAR PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    telefono VARCHAR NOT NULL,
    direccion_linea1 VARCHAR NOT NULL,
    id_municipio INTEGER NOT NULL REFERENCES municipio(id_municipio)
);

CREATE TABLE IF NOT EXISTS producto (
    id_producto VARCHAR PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    precio_actual NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS repartidor (
    id_repartidor VARCHAR PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    placa_vehiculo VARCHAR NOT NULL,
    tipo_vehiculo VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido INTEGER PRIMARY KEY,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dui_cliente VARCHAR NOT NULL REFERENCES cliente(dui_cliente),
    id_repartidor VARCHAR NOT NULL REFERENCES repartidor(id_repartidor),
    costo_envio NUMERIC NOT NULL,
    metodo_pago VARCHAR NOT NULL,
    estado_pedido VARCHAR NOT NULL,
    sucursal_origen VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS detalle_pedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL REFERENCES pedido(id_pedido),
    id_producto VARCHAR NOT NULL REFERENCES producto(id_producto),
    cantidad INTEGER NOT NULL,
    precio_unitario_historico NUMERIC NOT NULL
);
