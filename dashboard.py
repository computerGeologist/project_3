import pickle
import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
scaler, model1, model2 = pickle.load(open("model.p", "rb"))

#

st.write('''
# Predicting the status of mammals
''')

st.write('''
The IUCN Redlist classifies species in one of seven categories to assess the pressures acting on them. It is used to inform conservation actions to prevent extinctions. Their goal for the end of 2020 is to have assessed 160,000 species, up from 120,000 at the start of the year.

''')
#st.image('./iucn_status.png', use_column_width=True)
img_pad1, image, img_pad2 = st.beta_container().beta_columns([2, 7, 2])
image.image('./iucn_status.png', use_column_width=True)

st.write('''
These assessments are based on a large number of factors and pressures that a species could experience, such as habitat loss, pollution, and invasive species. In order to reduce this load, this model focuses on screening out species that are not at risk, dividing species that are NT(Near Threatened) or LC(Least Concern) from those that are more likely to be under threat. These two groups make up slightly over half of all species in the IUCN data download.

In order to make predictions on species status, animal attributes were provided by PanTHERIA, a dataset of ecological and geographical traits of all known mammals compiled from the literature. As a result, this model was trained almost purely on mammals.
''')

st.write("# Prediction")

section_1 = st.beta_container()
col11, col12= section_1.beta_columns([10, 2])

section_2 = st.beta_container()
col21, col22= section_1.beta_columns([10, 2])

section_2 = st.beta_container()
col31, col32= section_1.beta_columns([10, 2])


#Input section
body_weight =col11.number_input("Adult Body Mass", step=0.000001, format = '%g')*1000
pop_density = col21.number_input("Human Population Density in range")
geog_range = col31.number_input("Geographic Range", format = '%g')*1000000

col12.markdown("<font color='white'> spacing</font>", unsafe_allow_html=True)
col12.markdown("kg")
col22.markdown("<font color='white' size = 1 em> spacing</font>  \n Humans per square km", unsafe_allow_html=True)
col32.markdown("<font color='white'> spacing</font>", unsafe_allow_html=True)
col32.markdown("km^2")

trophic_level = st.selectbox('Eating Habits', ['Unknown',"Carnivore","Herbivore", "Omnivore"])
habitat = st.selectbox('Habitat', ["Terrestrial", "Freshwater", "Marine"])

#model_selector = st.selectbox('Preferred Model Training', ["ADASYN", "Base"])
#st.write("ADASYN has greater precision for non-endangered species, but worse for endangered species.")

carnivore = trophic_level=="Carnivore"
herbivore = trophic_level=="Herbivore"
omnivore = trophic_level=="Omnivore"

freshwater = habitat=="Freshwater"
marine = habitat=="Marine"
terrestrial = habitat=="Terrestrial"


features = [[pop_density, geog_range, body_weight, carnivore, herbivore, omnivore, freshwater, marine, terrestrial]]
features2 = scaler.transform(features)

ans = model2.predict(features2)[0]

if ans ==2:
    st.write("# Prediction: Not Endangered")
    #if model_selector=="ADASYN":
    st.write("This species is probably not endangered! Less than 10% of all species the model labeled in this way were actually vulnerable, endangered, critically endangered, or extinct.")
    #else:
        #st.write("This species is probably not endangered! Less than 15% of all species the model labeled in this way were actually vulnerable, endangered, critically endangered, or extinct.")
if ans==0:
    st.write("# Prediction: Potentially Endangered")
    #if model_selector=="ADASYN":
    st.write("This species might be endangered! 57% of the species this model classifies as 'vulnerable or worse' actually are vulnerable, endangered, critically endangered, or extinct; this species requires a survey to estimate its true status.")
    #else:


st.write('''
# Caveats

This data was trained using records from PanTHERIA and the IUCN redlist, as provided by the Encyclopedia of Life at eol.com. It was trained primarily using mammalian data, and will be inaccurate for other animal groups.
''')
