from pydantic import BaseModel
from datetime import datetime
from typing import Optional

# To co wysyłamy/odbieramy (baza)
class FlightBase(BaseModel):
    NumerLotu: str
    DataOdlotu: datetime
    PlanowanaDataPrzylotu: datetime
    StatusID: int

# Do aktualizacji (np. opóźnienie)
class FlightUpdate(BaseModel):
    RzeczywistaDataOdlotu: Optional[datetime] = None
    StatusID: Optional[int] = None

# To co widzi użytkownik (odpowiedź API)
class FlightResponse(FlightBase):
    LotID: int
    # Możemy tu dodać nazwy lotnisk, jeśli zrobimy joiny,
    # ale na start wystarczą podstawowe dane.
    
    class Config:
        from_attributes = True