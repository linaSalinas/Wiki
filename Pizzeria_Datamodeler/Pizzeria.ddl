-- Generado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   en:        2020-05-24 17:42:09 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE cliente (
    telefono   INTEGER NOT NULL,
    direccion  VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN cliente.telefono IS
    'Telefono del cliente, es el identificador del cliente en el sistema';

COMMENT ON COLUMN cliente.direccion IS
    'Dirección del cliente';

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( telefono );

CREATE TABLE empleado (
    id_empleado           INTEGER NOT NULL,
    id                    INTEGER NOT NULL,
    email                 VARCHAR2(20) NOT NULL,
    telefono              INTEGER NOT NULL,
    cumpleaños            DATE NOT NULL,
    rol                   VARCHAR2(15) NOT NULL,
    empleado_id_empleado  INTEGER NOT NULL
);

ALTER TABLE empleado
    ADD CHECK ( rol IN (
        'Compañero',
        'Jefe'
    ) );

COMMENT ON COLUMN empleado.id_empleado IS
    'Codigo de identificación del empleado en el sistema';

COMMENT ON COLUMN empleado.id IS
    'Identificación del Empleado';

COMMENT ON COLUMN empleado.email IS
    'Email del empleado';

COMMENT ON COLUMN empleado.telefono IS
    'Telefono del empleado';

COMMENT ON COLUMN empleado.cumpleaños IS
    'Fecha de cumpleaños del empleado';

COMMENT ON COLUMN empleado.rol IS
    'Es el rol que ocupa el empleado dentro de la pizzería';

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE jugo (
    sabor    VARCHAR2(15) NOT NULL,
    embase   VARCHAR2(15) NOT NULL,
    endulce  VARCHAR2(15) NOT NULL,
    id_jugo  INTEGER NOT NULL
);

COMMENT ON COLUMN jugo.sabor IS
    'SABOR DE LA PIZZA';

COMMENT ON COLUMN jugo.embase IS
    'ENVACE EN EL QUE SE SIRVE EL JUGO';

COMMENT ON COLUMN jugo.endulce IS
    'EL ELEMENTO CON EL QUE SE VA ENDULZAR EL JUGO';

COMMENT ON COLUMN jugo.id_jugo IS
    'Identificador del jugo en el sistema';

ALTER TABLE jugo ADD CONSTRAINT jugo_pk PRIMARY KEY ( id_jugo );

CREATE TABLE pedido (
    fecha                 DATE NOT NULL,
    id_pedido             INTEGER NOT NULL,
    tipo_servicio         VARCHAR2(15) NOT NULL,
    precio                NUMBER(6, 3) NOT NULL,
    registra_registra_id  NUMBER NOT NULL
);

COMMENT ON COLUMN pedido.fecha IS
    'Fecha en la que se toma el pedido';

COMMENT ON COLUMN pedido.id_pedido IS
    'Identificación unica del pedido en el sistema';

COMMENT ON COLUMN pedido.tipo_servicio IS
    'Tipo del servicio que se brinda al cliente';

CREATE UNIQUE INDEX pedido__idx ON
    pedido (
        registra_registra_id
    ASC );

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE pedido_jugo (
    pedido_id_pedido  INTEGER NOT NULL,
    jugo_id_jugo      INTEGER NOT NULL
);

ALTER TABLE pedido_jugo ADD CONSTRAINT pedido_jugo_pk PRIMARY KEY ( pedido_id_pedido,
                                                                    jugo_id_jugo );

CREATE TABLE pedido_pizza (
    pedido_id_pedido  INTEGER NOT NULL,
    pizza_id_pizza    INTEGER NOT NULL
);

ALTER TABLE pedido_pizza ADD CONSTRAINT pedido_pizza_pk PRIMARY KEY ( pedido_id_pedido,
                                                                      pizza_id_pizza );

CREATE TABLE pedido_tarjeta (
    pedido_id_pedido  INTEGER NOT NULL,
    tarjeta_telefono  INTEGER NOT NULL
);

ALTER TABLE pedido_tarjeta ADD CONSTRAINT pedido_tarjeta_pk PRIMARY KEY ( pedido_id_pedido,
                                                                          tarjeta_telefono );

CREATE TABLE pizza (
    tamaño    VARCHAR2(15) NOT NULL,
    sabor     VARCHAR2(15) NOT NULL,
    id_pizza  INTEGER NOT NULL
);

COMMENT ON COLUMN pizza.tamaño IS
    'Tamaño de la pizza';

COMMENT ON COLUMN pizza.sabor IS
    'Sabor de la pizza';

COMMENT ON COLUMN pizza.id_pizza IS
    'Identificador de la pizza en el sistema';

ALTER TABLE pizza ADD CONSTRAINT pizza_pk PRIMARY KEY ( id_pizza );

CREATE TABLE registra (
    registra_id           NUMBER NOT NULL,
    hora                  DATE NOT NULL,
    empleado_id_empleado  INTEGER NOT NULL,
    cliente_telefono      INTEGER NOT NULL
);

COMMENT ON COLUMN registra.hora IS
    'Representa la hora en la que se toma el pedido';

ALTER TABLE registra ADD CONSTRAINT registra_pk PRIMARY KEY ( registra_id );

CREATE TABLE sobrino (
    cumpleaños        DATE NOT NULL,
    personaje         VARCHAR2(20) NOT NULL,
    nombre            VARCHAR2(20) NOT NULL,
    tarjeta_telefono  INTEGER NOT NULL
);

COMMENT ON COLUMN sobrino.cumpleaños IS
    'Fecha de cumpleaños de la persona';

COMMENT ON COLUMN sobrino.personaje IS
    'Personaje favorito del cliente';

COMMENT ON COLUMN sobrino.nombre IS
    'Nombre del cliente';

CREATE TABLE tarjeta (
    telefono  INTEGER NOT NULL,
    puntos    INTEGER NOT NULL
);

COMMENT ON COLUMN tarjeta.telefono IS
    'Telefono del cliente dueño de la  tarjeta de membresia, es el identificador de la tarjeta en el sistema';

COMMENT ON COLUMN tarjeta.puntos IS
    'Numero de puntos cumulados por el cliente';

ALTER TABLE tarjeta ADD CONSTRAINT tarjeta_pk PRIMARY KEY ( telefono );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE pedido_jugo
    ADD CONSTRAINT pedido_jugo_jugo_fk FOREIGN KEY ( jugo_id_jugo )
        REFERENCES jugo ( id_jugo );

ALTER TABLE pedido_jugo
    ADD CONSTRAINT pedido_jugo_pedido_fk FOREIGN KEY ( pedido_id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE pedido_pizza
    ADD CONSTRAINT pedido_pizza_pedido_fk FOREIGN KEY ( pedido_id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE pedido_pizza
    ADD CONSTRAINT pedido_pizza_pizza_fk FOREIGN KEY ( pizza_id_pizza )
        REFERENCES pizza ( id_pizza );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_registra_fk FOREIGN KEY ( registra_registra_id )
        REFERENCES registra ( registra_id );

ALTER TABLE pedido_tarjeta
    ADD CONSTRAINT pedido_tarjeta_pedido_fk FOREIGN KEY ( pedido_id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE pedido_tarjeta
    ADD CONSTRAINT pedido_tarjeta_tarjeta_fk FOREIGN KEY ( tarjeta_telefono )
        REFERENCES tarjeta ( telefono );

ALTER TABLE registra
    ADD CONSTRAINT registra_cliente_fk FOREIGN KEY ( cliente_telefono )
        REFERENCES cliente ( telefono );

ALTER TABLE registra
    ADD CONSTRAINT registra_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE sobrino
    ADD CONSTRAINT sobrino_tarjeta_fk FOREIGN KEY ( tarjeta_telefono )
        REFERENCES tarjeta ( telefono );

CREATE SEQUENCE registra_registra_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER registra_registra_id_trg BEFORE
    INSERT ON registra
    FOR EACH ROW
    WHEN ( new.registra_id IS NULL )
BEGIN
    :new.registra_id := registra_registra_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             1
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
