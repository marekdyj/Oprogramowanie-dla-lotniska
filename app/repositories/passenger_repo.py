from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.models import Passenger
from app.schemas.passenger_schema import PassengerCreate

class PassengerRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all(self, skip: int = 0, limit: int = 100):
        stmt = select(Passenger).offset(skip).limit(limit)
        result = await self.db.execute(stmt)
        return result.scalars().all()

    async def create(self, passenger_data: PassengerCreate):
        new_passenger = Passenger(
            Imie=passenger_data.Imie,
            Nazwisko=passenger_data.Nazwisko,
            Email=passenger_data.Email,
            DataUrodzenia=passenger_data.DataUrodzenia
        )
        self.db.add(new_passenger)
        await self.db.commit()
        await self.db.refresh(new_passenger)
        return new_passenger