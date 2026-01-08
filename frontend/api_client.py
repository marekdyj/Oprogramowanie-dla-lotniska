import requests
import pandas as pd

API_URL = "http://127.0.0.1:8000"

def fetch_data(endpoint):
    """Pomocnicza funkcja do pobierania danych (GET)"""
    try:
        response = requests.get(f"{API_URL}/{endpoint}/")
        if response.status_code == 200:
            return response.json()
        else:
            return []
    except Exception as e:
        print(f"Błąd połączenia: {e}")
        return []

def get_flights():
    data = fetch_data("flights")
    if data:
        df = pd.DataFrame(data)
        # Formatowanie dat
        df['DataOdlotu'] = pd.to_datetime(df['DataOdlotu']).dt.strftime('%Y-%m-%d %H:%M')
        df['PlanowanaDataPrzylotu'] = pd.to_datetime(df['PlanowanaDataPrzylotu']).dt.strftime('%Y-%m-%d %H:%M')
        return df
    return pd.DataFrame()

def get_passengers():
    data = fetch_data("passengers")
    if data:
        return pd.DataFrame(data)
    return pd.DataFrame()

def add_passenger(payload):
    """Wysyłanie danych (POST)"""
    try:
        response = requests.post(f"{API_URL}/passengers/", json=payload)
        return response
    except Exception as e:
        return None