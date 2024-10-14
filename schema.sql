-- -------------------------------------------------------------
--
-- Database: postgres
-- Generation Time: 2024-10-14 11:44:36.8960
-- -------------------------------------------------------------


DROP VIEW IF EXISTS "inventory"."geography_columns";


DROP VIEW IF EXISTS "inventory"."geometry_columns";


DROP TABLE IF EXISTS "inventory"."customers";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS inventory.customers_id_seq;

-- Table Definition
CREATE TABLE "inventory"."customers" (
    "id" int4 NOT NULL DEFAULT nextval('inventory.customers_id_seq'::regclass),
    "first_name" varchar(255) NOT NULL,
    "last_name" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "inventory"."geom";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS inventory.geom_id_seq;

-- Table Definition
CREATE TABLE "inventory"."geom" (
    "id" int4 NOT NULL DEFAULT nextval('inventory.geom_id_seq'::regclass),
    "g" inventory.geometry NOT NULL,
    "h" inventory.geometry,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "inventory"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS inventory.orders_id_seq;

-- Table Definition
CREATE TABLE "inventory"."orders" (
    "id" int4 NOT NULL DEFAULT nextval('inventory.orders_id_seq'::regclass),
    "order_date" date NOT NULL,
    "purchaser" int4 NOT NULL,
    "quantity" int4 NOT NULL,
    "product_id" int4 NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "inventory"."products";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS inventory.products_id_seq;

-- Table Definition
CREATE TABLE "inventory"."products" (
    "id" int4 NOT NULL DEFAULT nextval('inventory.products_id_seq'::regclass),
    "name" varchar(255) NOT NULL,
    "description" varchar(512),
    "weight" float8,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "inventory"."products_on_hand";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "inventory"."products_on_hand" (
    "product_id" int4 NOT NULL,
    "quantity" int4 NOT NULL,
    PRIMARY KEY ("product_id")
);

DROP TABLE IF EXISTS "inventory"."spatial_ref_sys";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "inventory"."spatial_ref_sys" (
    "srid" int4 NOT NULL CHECK ((srid > 0) AND (srid <= 998999)),
    "auth_name" varchar(256),
    "auth_srid" int4,
    "srtext" varchar(2048),
    "proj4text" varchar(2048),
    PRIMARY KEY ("srid")
);

CREATE VIEW "inventory"."geography_columns" AS ;
CREATE VIEW "inventory"."geometry_columns" AS ;


-- Indices
CREATE UNIQUE INDEX customers_email_key ON inventory.customers USING btree (email);
ALTER TABLE "inventory"."orders" ADD FOREIGN KEY ("purchaser") REFERENCES "inventory"."customers"("id");
ALTER TABLE "inventory"."orders" ADD FOREIGN KEY ("product_id") REFERENCES "inventory"."products"("id");
ALTER TABLE "inventory"."products_on_hand" ADD FOREIGN KEY ("product_id") REFERENCES "inventory"."products"("id");
