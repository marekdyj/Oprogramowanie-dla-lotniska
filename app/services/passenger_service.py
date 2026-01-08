from sqlalchemy.ext.asyncio import AsyncSession
from app.repositories.passenger_repo import PassengerRepository
from app.schemas.passenger_schema import PassengerCreate

class PassengerService:
    def __init__(self, db: AsyncSession):
        self.repo = PassengerRepository(db)

    async def get_passengers(self, skip: int, limit: int):
        return await self.repo.get_all(skip, limit)

    async def register_passenger(self, data: PassengerCreate):
        return await self.repo.create(data)