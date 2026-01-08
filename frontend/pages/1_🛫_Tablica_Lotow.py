import streamlit as st
import api_client

st.set_page_config(page_title="Tablica Lotów", layout="wide")
st.header("🛫 Tablica Odlotów i Przylotów")

if st.button("🔄 Odśwież dane"):
    st.cache_data.clear()

df = api_client.get_flights()
if not df.empty:
    st.dataframe(df[['NumerLotu','DataOdlotu','PlanowanaDataPrzylotu','StatusID']], use_container_width=True)
else:
    st.warning("Nie udało się pobrać danych o lotach lub baza jest pusta.")
