from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware # <--- IMPORT 1
from app.routers import passengers, flights
from app.core.database import engine, Base

app = FastAPI(
    title="System Zarządzania Lotniskiem",
    description="Backend API",
    version="1.0.0"
)

# --- KONFIGURACJA CORS (DODAJ TO) ---
origins = [
    "http://localhost:8501", # Port Streamlita (Frontend)
    "http://127.0.0.1:8501",
    "*" # Opcjonalnie: zezwól wszystkim (tylko na dev)
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # W produkcji podaje się konkretne domeny, na dev "*" jest ok
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# ------------------------------------

# Tworzenie tabel przy starcie (tylko dla celów deweloperskich)
@app.on_event("startup")
async def init_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

app.include_router(passengers.router)
app.include_router(flights.router)

@app.get("/")
async def root():
    return {"message": "Witamy w systemie lotniskowym v1"}