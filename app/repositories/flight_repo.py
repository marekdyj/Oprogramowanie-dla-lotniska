from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.models import Flight, FlightStatus

class FlightRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all_flights(self, limit: int = 50):
        # Pobieramy loty razem ze statusem (Eager Loading)
        stmt = select(Flight).limit(limit)
        result = await self.db.execute(stmt)
        return result.scalars().all()

    async def get_flights_by_status(self, status_id: int):
        stmt = select(Flight).where(Flight.StatusID == status_id)
        result = await self.db.execute(stmt)
        return result.scalars().all()