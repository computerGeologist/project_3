CREATE DATABASE eol;

\connect eol; 

CREATE TABLE iucn(
    resource_id INT,
    eol_pk TEXT,
    resource_ok TEXT,
    source TEXT,
    page_id INT,
    scientific_name TEXT,
    pred_uri TEXT,
    pred_name TEXT,
    obj_uri TEXT,
    obj_name TEXT,
    literal TEXT,
    name TEXT
);

CREATE TABLE pantheria(
    resource_id INT,
    eol_pk TEXT,
    resource_ok TEXT,
    source TEXT,
    page_id INT,
    scientific_name TEXT,
    pred_uri TEXT,
    pred_name TEXT,
    object_page_id INT,
    obj_uri TEXT,
    obj_name TEXT,
    normal_measurement FLOAT,
    units_uri TEXT,
    units_name TEXT,
    t_normal_units TEXT,
    literal TEXT,
    name TEXT
);

TRUNCATE TABLE iucn;

TRUNCATE TABLE pantheria;

\copy iucn FROM 'iucn_download.csv' DELIMITER ',' CSV HEADER;
\copy pantheria FROM 'pantheria_download.csv' DELIMITER ',' CSV HEADER;