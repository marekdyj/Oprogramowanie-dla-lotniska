import streamlit as st

st.set_page_config(
    page_title="Airport Manager",
    page_icon="✈️",
    layout="wide"
)

st.title("✈️ System Zarządzania Lotniskiem")

st.markdown("""
### Witamy w panelu administracyjnym.
Aplikacja została zbudowana w architekturze mikroserwisów.
            
**Wybierz moduł z menu po lewej stronie:**
- **Tablica Lotów**: Podgląd bieżących operacji lotniczych.
- **Pasażerowie**: Zarządzanie bazą klientów i rezerwacjami.

---
*Status systemu:* 🟢 **Online** (Połączono z API: http://127.0.0.1:8000)
""")

# Opcjonalnie: dashboard ze statystykami
col1, col2, col3 = st.columns(3)
col1.metric("Liczba Lotów Dzisiaj", "12", "+2")
col2.metric("Odprawieni Pasażerowie", "1,240", "-5%")
col3.metric("Opóźnienia", "3", "Uwaga")