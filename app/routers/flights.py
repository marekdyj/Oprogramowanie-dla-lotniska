from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from app.core.database import get_db
from app.repositories.flight_repo import FlightRepository
from app.schemas.flight_schema import FlightResponse

router = APIRouter(prefix="/flights", tags=["Flights"])

@router.get("/", response_model=List[FlightResponse])
async def read_flights(db: AsyncSession = Depends(get_db)):
    repo = FlightRepository(db)
    return await repo.get_all_flights()

@router.get("/status/{status_id}", response_model=List[FlightResponse])
async def read_flights_by_status(status_id: int, db: AsyncSession = Depends(get_db)):
    repo = FlightRepository(db)
    return await repo.get_flights_by_status(status_id)