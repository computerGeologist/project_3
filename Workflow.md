Workflow for download:
Want mammals only. 
I want to identify traits: Body mass, trophic guild, body length, habitat (Env. EOL only?), latitude, longitude
Pantheria: Mammals only.
Life span?
Conservation status via IUCN.
Geographic Range via Pantheria
Want a data download. 

Test at: 
https://eol.org/service/cypher_form
with low limit, then do bulk download. 

Query in Query.md.



https://github.com/EOL/eol_website/blob/master/doc/trait-schema.md
https://github.com/EOL/eol_website/blob/master/doc/query-examples.md
https://github.com/EOL/eol_website/blob/master/doc/api.md
https://github.com/EOL/eol_website/blob/master/doc/api-access.md

sql tables I want:
IUCN endangered status for all animals, names.
Pantheria: all traits, animals, names. 
EOL: All habitats. 

Size: 100

IUCN Records: 240851
Pantheria Records: 103733

sudo service postgresql start
sudo -u postgres psql -f setup.sql