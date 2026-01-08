import streamlit as st
import api_client
from datetime import date

st.set_page_config(page_title="Pasażerowie", layout="wide")
st.header("👥 Zarządzanie Pasażerami")

tab1, tab2 = st.tabs(["📋 Lista Pasażerów","➕ Dodaj Nowego"])

with tab1:
    df = api_client.get_passengers()
    if not df.empty:
        st.dataframe(df, use_container_width=True)
    else:
        st.info("Brak pasażerów w bazie.")

with tab2:
    st.subheader("Formularz Rejestracji")
    with st.form("add_passenger_form", clear_on_submit=True):
        imie = st.text_input("Imię")
        nazwisko = st.text_input("Nazwisko")
        email = st.text_input("Email")
        data_ur = st.date_input("Data urodzenia", value=date(1990,1,1))
        submitted = st.form_submit_button("Zapisz w bazie")
        if submitted:
            if imie and nazwisko and email:
                payload = {"Imie": imie, "Nazwisko": nazwisko, "Email": email, "DataUrodzenia": str(data_ur)}
                response = api_client.add_passenger(payload)
                if response and response.status_code == 201:
                    st.success("Dodano pasażera")
                else:
                    st.error("Błąd dodawania pasażera")
