For IUCN:

MATCH (t:Trait)<-[:trait]-(p:Page),
      (t)-[:supplier]->(r:Resource),
      (t)-[:predicate]->(pred:Term)
WHERE r.resource_id=5
OPTIONAL MATCH (t)-[:object_term]->(obj:Term)
OPTIONAL MATCH (t)-[:normal_units_term]->(units:Term)
OPTIONAL MATCH (lit:Term) WHERE lit.uri = t.literal
RETURN r.resource_id, t.eol_pk, t.resource_ok, t.source, p.page_id, t.scientific_name, pred.uri, pred.name,
       t.object_page_id, obj.uri, obj.name, t.normal_measurement, units.uri, units.name, t.normal_units, t.literal, lit.name
LIMIT 240851

For Pantheria

MATCH (t:Trait)<-[:trait]-(p:Page),
      (t)-[:supplier]->(r:Resource),
      (t)-[:predicate]->(pred:Term)
WHERE r.resource_id=173
OPTIONAL MATCH (t)-[:object_term]->(obj:Term)
OPTIONAL MATCH (t)-[:normal_units_term]->(units:Term)
OPTIONAL MATCH (lit:Term) WHERE lit.uri = t.literal
RETURN r.resource_id, t.eol_pk, t.resource_ok, t.source, p.page_id, t.scientific_name, pred.uri, pred.name,
       t.object_page_id, obj.uri, obj.name, t.normal_measurement, units.uri, units.name, t.normal_units, t.literal, lit.name
LIMIT 103733
