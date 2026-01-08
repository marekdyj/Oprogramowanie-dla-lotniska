from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date

class PassengerBase(BaseModel):
    Imie: str
    Nazwisko: str
    Email: Optional[EmailStr] = None
    DataUrodzenia: Optional[date] = None

class PassengerCreate(PassengerBase):
    pass

class PassengerResponse(PassengerBase):
    PasazerID: int

    class Config:
        from_attributes = True