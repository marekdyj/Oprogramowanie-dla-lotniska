from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from app.core.database import get_db
from app.services.passenger_service import PassengerService
from app.schemas.passenger_schema import PassengerCreate, PassengerResponse

router = APIRouter(prefix="/passengers", tags=["Passengers"])

@router.get("/", response_model=List[PassengerResponse])
async def read_passengers(skip: int = 0, limit: int = 10, db: AsyncSession = Depends(get_db)):
    service = PassengerService(db)
    return await service.get_passengers(skip, limit)

@router.post("/", response_model=PassengerResponse)
async def create_passenger(passenger: PassengerCreate, db: AsyncSession = Depends(get_db)):
    service = PassengerService(db)
    return await service.register_passenger(passenger)