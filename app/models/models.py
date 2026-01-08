from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Date
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.core.database import Base
from datetime import datetime, date
from typing import Optional

# 1. Modele Samolotow
class AircraftModel(Base):
    __tablename__ = "ModeleSamolotow"
    ModelID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NazwaModelu: Mapped[str] = mapped_column(String(100))
    Producent: Mapped[str] = mapped_column(String(100))
    LiczbaMiejsc: Mapped[int] = mapped_column(Integer)
    Zasieg: Mapped[int] = mapped_column("Zasięg", Integer)

# 2. Samoloty
class Aircraft(Base):
    __tablename__ = "Samoloty"
    SamolotID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NumerRejestracyjny: Mapped[str] = mapped_column(String(20), unique=True)
    ModelID: Mapped[int] = mapped_column(ForeignKey("ModeleSamolotow.ModelID"))
    DataWprowadzeniaDoSluzby: Mapped[Optional[date]] = mapped_column(Date)

# 3. Lotniska
class Airport(Base):
    __tablename__ = "Lotniska"
    KodLotniska: Mapped[str] = mapped_column(String(3), primary_key=True)
    Nazwa: Mapped[str] = mapped_column(String(100))
    Miasto: Mapped[str] = mapped_column(String(100))
    Kraj: Mapped[str] = mapped_column(String(100))

# 4. Trasy
class Route(Base):
    __tablename__ = "Trasy"
    TrasaID: Mapped[int] = mapped_column(Integer, primary_key=True)
    LotniskoOdlotu: Mapped[str] = mapped_column(ForeignKey("Lotniska.KodLotniska"))
    LotniskoPrzylotu: Mapped[str] = mapped_column(ForeignKey("Lotniska.KodLotniska"))

# 5. Statusy
class FlightStatus(Base):
    __tablename__ = "StatusyLotow"
    StatusID: Mapped[int] = mapped_column(Integer, primary_key=True)
    OpisStatusu: Mapped[str] = mapped_column(String(50))

# 6. Loty
class Flight(Base):
    __tablename__ = "Loty"
    LotID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NumerLotu: Mapped[str] = mapped_column(String(10))
    TrasaID: Mapped[int] = mapped_column(ForeignKey("Trasy.TrasaID"))
    SamolotID: Mapped[int] = mapped_column(ForeignKey("Samoloty.SamolotID"))
    StatusID: Mapped[int] = mapped_column(ForeignKey("StatusyLotow.StatusID"))
    DataOdlotu: Mapped[datetime] = mapped_column(DateTime)
    PlanowanaDataPrzylotu: Mapped[datetime] = mapped_column(DateTime)
    RzeczywistaDataOdlotu: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)
    RzeczywistaDataPrzylotu: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)
    
    status = relationship("FlightStatus")
    rezerwacje = relationship("Booking", back_populates="lot")

# 7. Pasazerowie
class Passenger(Base):
    __tablename__ = "Pasazerowie"
    PasazerID: Mapped[int] = mapped_column(Integer, primary_key=True)
    Imie: Mapped[str] = mapped_column(String(50))
    Nazwisko: Mapped[str] = mapped_column(String(50))
    DataUrodzenia: Mapped[Optional[date]] = mapped_column(Date)
    Email: Mapped[Optional[str]] = mapped_column(String(100), unique=True)
    
    rezerwacje = relationship("Booking", back_populates="pasazer")

# 8. Rezerwacje
class Booking(Base):
    __tablename__ = "Rezerwacje"
    RezerwacjaID: Mapped[int] = mapped_column(Integer, primary_key=True)
    LotID: Mapped[int] = mapped_column(ForeignKey("Loty.LotID"))
    PasazerID: Mapped[int] = mapped_column(ForeignKey("Pasazerowie.PasazerID"))
    NumerMiejsca: Mapped[str] = mapped_column(String(5), nullable=True)
    
    pasazer = relationship("Passenger", back_populates="rezerwacje")
    lot = relationship("Flight", back_populates="rezerwacje")

# --- NOWE TABELE (HR i Techniczne) ---

# 9. Typy Pracownikow
class EmployeeType(Base):
    __tablename__ = "TypyPracownikow"
    TypID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NazwaTypu: Mapped[str] = mapped_column(String(50), unique=True)

# 10. Pracownicy
class Employee(Base):
    __tablename__ = "Pracownicy"
    PracownikID: Mapped[int] = mapped_column(Integer, primary_key=True)
    Imie: Mapped[str] = mapped_column(String(50))
    Nazwisko: Mapped[str] = mapped_column(String(50))
    TypID: Mapped[int] = mapped_column(ForeignKey("TypyPracownikow.TypID"))
    DataZatrudnienia: Mapped[date] = mapped_column(Date)
    NumerLicencji: Mapped[Optional[str]] = mapped_column(String(50), nullable=True)

# 11. Zaloga Lotu
class FlightCrew(Base):
    __tablename__ = "ZalogaLotu"
    ZalogaLotuID: Mapped[int] = mapped_column(Integer, primary_key=True)
    LotID: Mapped[int] = mapped_column(ForeignKey("Loty.LotID"))
    PracownikID: Mapped[int] = mapped_column(ForeignKey("Pracownicy.PracownikID"))
    RolaWLocie: Mapped[str] = mapped_column(String(50))

# 12. Typy Maszyn
class MachineType(Base):
    __tablename__ = "TypyMaszyn"
    TypMaszynyID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NazwaTypu: Mapped[str] = mapped_column(String(100), unique=True)
    Opis: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)

# 13. Maszyny Obslugi Naziemnej
class GroundMachine(Base):
    __tablename__ = "MaszynyObslugiNaziemnej"
    MaszynaID: Mapped[int] = mapped_column(Integer, primary_key=True)
    NumerInwentarzowy: Mapped[str] = mapped_column(String(50), unique=True)
    TypMaszynyID: Mapped[int] = mapped_column(ForeignKey("TypyMaszyn.TypMaszynyID"))
    Marka: Mapped[Optional[str]] = mapped_column(String(50))
    Model: Mapped[Optional[str]] = mapped_column(String(50))
    RokProdukcji: Mapped[Optional[int]] = mapped_column(Integer)
    Status: Mapped[Optional[str]] = mapped_column(String(50), default='Dostępna')

# 14. Przeglady Techniczne
class TechnicalReview(Base):
    __tablename__ = "PrzegladyTechniczne"
    PrzegladID: Mapped[int] = mapped_column(Integer, primary_key=True)
    MaszynaID: Mapped[int] = mapped_column(ForeignKey("MaszynyObslugiNaziemnej.MaszynaID"))
    DataPrzegladu: Mapped[date] = mapped_column(Date)
    DataNastepnegoPrzegladu: Mapped[Optional[date]] = mapped_column(Date)
    Wynik: Mapped[str] = mapped_column(String(100))
    PrzeprowadzajacyPracownikID: Mapped[Optional[int]] = mapped_column(ForeignKey("Pracownicy.PracownikID"))