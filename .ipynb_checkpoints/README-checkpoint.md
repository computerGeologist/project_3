# Classifying Species

This code iucn_download.csv and pantheria_download.csv into features.

# Results

The predictions of this model can be viewed with streamlit run dashboard.py

# Outline of Files

Query.md: This file contains two Cypher queries. Run each of them individually at https://eol.org/service/cypher_form while logged in with an appropriate access token, choosing to download the results as csv's. Rename them appropriately and move them into this directory.

setup.sql: Run this in the same directory as iucn_download.csv and pantheria_download.csv; it will set up sql tables appropriately. 

SQL_based_model.ipynb: Run this file to query the SQL and build a model. It pickles the resulting model in model.p.

dashboard.py: Run this file in the same directory as model.p and iucn_status.png with streamlit to view the model.