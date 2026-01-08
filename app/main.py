from fastapi import FastAPI
from app.routers import passengers
from app.core.database import engine, Base

app = FastAPI(
    title="System Zarządzania Lotniskiem",
    description="API do obsługi lotów i pasażerów",
    version="1.0.0"
)

# Tworzenie tabel przy starcie (tylko dla celów deweloperskich)
@app.on_event("startup")
async def init_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

app.include_router(passengers.router)

@app.get("/")
async def root():
    return {"message": "Witamy w systemie lotniskowym v1"}