\connect eol;

DROP TABLE IF EXISTS conservation_status;
DROP TABLE IF EXISTS habitat_iucn;
DROP TABLE IF EXISTS trophic_level;
DROP TABLE IF EXISTS body_mass;
DROP TABLE IF EXISTS pop_density;
DROP TABLE IF EXISTS geog_range;
DROP TABLE IF EXISTS all_pantheria;
DROP TABLE IF EXISTS all_features;

CREATE TABLE conservation_status AS 
(SELECT DISTINCT ON (page_id) 
 page_id, obj_name AS conservation_status
 FROM iucn WHERE pred_name = 'conservation status'
 ORDER BY page_id desc
);

CREATE TABLE habitat_iucn AS 
(SELECT DISTINCT ON (page_id) 
 page_id, name AS habitat
 FROM iucn WHERE pred_name = 'habitat'
 ORDER BY page_id desc
);

CREATE TABLE trophic_level AS 
(SELECT DISTINCT ON (page_id) 
 page_id, name AS trophic_level
 FROM pantheria WHERE pred_name = 'trophic level'
 ORDER BY page_id desc
);

CREATE TABLE body_mass AS (SELECT DISTINCT ON (p1.page_id) p1.page_id, p1.normal_measurement AS body_mass, p1.units_name AS body_mass_units
FROM pantheria p1 
INNER JOIN (SELECT page_id, MAX(normal_measurement) AS MaxPredicate FROM pantheria  WHERE pred_name ='body mass' GROUP BY page_id) p2
ON p1.page_id = p2.page_id
AND p1.pred_name = 'body mass'
AND p1.normal_measurement = MaxPredicate);


CREATE TABLE pop_density AS (SELECT DISTINCT ON (p1.page_id)p1.page_id, p1.normal_measurement AS pop_density, p1.units_name AS pop_density_units
FROM pantheria p1 
INNER JOIN (SELECT page_id, MAX(normal_measurement) AS MaxPredicate FROM pantheria  WHERE pred_name ='human population density' GROUP BY page_id) p2
ON p1.page_id = p2.page_id
AND p1.pred_name = 'human population density'
AND p1.normal_measurement = MaxPredicate);

CREATE TABLE geog_range AS (SELECT DISTINCT ON (p1.page_id)p1.page_id, p1.normal_measurement AS geog_range, p1.units_name AS geog_range_units
FROM pantheria p1 
INNER JOIN (SELECT page_id, MAX(normal_measurement) AS MaxPredicate FROM pantheria  WHERE pred_name ='geographic range (size of area)' GROUP BY page_id) p2
ON p1.page_id = p2.page_id
AND p1.pred_name = 'geographic range (size of area)'
AND p1.normal_measurement = MaxPredicate);

CREATE TABLE all_pantheria AS (    
    WITH big_table1 AS (SELECT pop_density.page_id AS page_id, body_mass, body_mass_units, pop_density, pop_density_units, geog_range, geog_range_units 
    FROM pop_density
    LEFT JOIN body_mass ON body_mass.page_id=pop_density.page_id
    LEFT JOIN geog_range ON pop_density.page_id=geog_range.page_id 
UNION
    SELECT body_mass.page_id AS page_id, body_mass, body_mass_units, pop_density, pop_density_units, geog_range, geog_range_units 
    FROM body_mass
    LEFT JOIN pop_density ON body_mass.page_id=pop_density.page_id
    LEFT JOIN geog_range ON body_mass.page_id=geog_range.page_id 
UNION
    SELECT geog_range.page_id AS page_id, body_mass, body_mass_units, pop_density, pop_density_units, geog_range, geog_range_units 
    FROM geog_range
    LEFT JOIN body_mass ON body_mass.page_id=geog_range.page_id
    LEFT JOIN pop_density ON pop_density.page_id=geog_range.page_id)
    
    SELECT DISTINCT ON (page_id)
    page_id, body_mass, body_mass_units, pop_density, pop_density_units, geog_range, geog_range_units
    FROM big_table1
);

CREATE TABLE all_features AS (
    SELECT conservation_status.page_id, conservation_status, habitat, trophic_level, body_mass, body_mass_units, pop_density, pop_density_units, geog_range, geog_range_units 
    FROM conservation_status
    LEFT JOIN habitat_iucn ON conservation_status.page_id=habitat_iucn.page_id
    LEFT JOIN trophic_level ON conservation_status.page_id=trophic_level.page_id
    INNER JOIN all_pantheria ON conservation_status.page_id=all_pantheria.page_id
);