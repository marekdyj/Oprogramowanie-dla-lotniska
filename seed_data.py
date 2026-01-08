import asyncio
import os
from sqlalchemy import text
from app.core.database import engine, Base

# IMPORTUJEMY WSZYSTKIE MODELE (Teraz również HR i Maszyny)
from app.models.models import (
    AircraftModel, Aircraft, Airport, Route, 
    FlightStatus, Flight, Passenger, Booking,
    EmployeeType, Employee, FlightCrew, 
    MachineType, GroundMachine, TechnicalReview
)

async def seed_database():
    print("🚀 Rozpoczynam wypełnianie bazy danych...")

    # 1. Reset bazy
    if os.path.exists("lotnisko.db"):
        try:
            os.remove("lotnisko.db")
            print("🗑️  Usunięto starą bazę danych.")
        except PermissionError:
            print("⚠️  Nie można usunąć pliku bazy. Zamknij inne programy!")
            return

    # 2. Tworzenie tabel
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
        print("🛠️  Utworzono kompletną strukturę tabel.")

    # 3. Wypełnianie danymi
    try:
        with open("lotnisko_fill.sql", "r", encoding="utf-8") as file:
            sql_content = file.read()

        statements = sql_content.split(';')

        async with engine.begin() as conn:
            for statement in statements:
                if statement.strip():
                    await conn.execute(text(statement))
        
        print("✅ Baza danych została w 100% wypełniona!")
        
    except Exception as e:
        print(f"❌ Wystąpił błąd: {e}")

    finally:
        await engine.dispose()
        print("🏁 Połączenie zamknięte.")

if __name__ == "__main__":
    asyncio.run(seed_database())