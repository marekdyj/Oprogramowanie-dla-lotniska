import streamlit as st
import api_client # Importujemy naszego klienta

st.set_page_config(page_title="Tablica Lotów", layout="wide")

st.header("🛫 Tablica Odlotów i Przylotów")

# Przycisk odświeżania
if st.button("🔄 Odśwież dane"):
    st.cache_data.clear() # Czyścimy cache, żeby pobrać świeże dane

# Pobieranie danych
df_flights = api_client.get_flights()

if not df_flights.empty:
    # Filtrowanie (Bajer dla prowadzącego)
    status_filter = st.multiselect(
        "Filtruj po statusie ID:", 
        options=df_flights['StatusID'].unique(),
        default=df_flights['StatusID'].unique()
    )
    
    filtered_df = df_flights[df_flights['StatusID'].isin(status_filter)]
    
    # Wyświetlenie tabeli
    st.dataframe(
        filtered_df[['NumerLotu', 'DataOdlotu', 'PlanowanaDataPrzylotu', 'StatusID']],
        use_container_width=True,
        hide_index=True
    )
else:
    st.warning("Nie udało się pobrać danych o lotach lub baza jest pusta.")