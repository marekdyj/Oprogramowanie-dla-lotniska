-- Utworzenie Schematu Lotniska (Opcjonalne, zależy od silnika bazy danych)
-- CREATE SCHEMA Lotnisko;
-- SET search_path TO Lotnisko;

-- Tabela 1: Modele Samolotów (Przechowuje specyfikację)
CREATE TABLE ModeleSamolotow (
    ModelID INT PRIMARY KEY,
    NazwaModelu VARCHAR(100) NOT NULL,
    Producent VARCHAR(100),
    LiczbaMiejsc INT NOT NULL,
    Zasięg INT
);

-- Tabela 2: Samoloty (Konkretne egzemplarze samolotów)
CREATE TABLE Samoloty (
    SamolotID INT PRIMARY KEY,
    NumerRejestracyjny VARCHAR(20) UNIQUE NOT NULL,
    ModelID INT NOT NULL,
    DataWprowadzeniaDoSluzby DATE,
    FOREIGN KEY (ModelID) REFERENCES ModeleSamolotow(ModelID)
);

-- Tabela 3: Lotniska (Miejsca odlotu/przylotu)
CREATE TABLE Lotniska (
    KodLotniska CHAR(3) PRIMARY KEY, -- Np. "WAW", "JFK"
    Nazwa VARCHAR(100) NOT NULL,
    Miasto VARCHAR(100),
    Kraj VARCHAR(100)
);

-- Tabela 4: Trasy Lotów
CREATE TABLE Trasy (
    TrasaID INT PRIMARY KEY,
    LotniskoOdlotu CHAR(3) NOT NULL,
    LotniskoPrzylotu CHAR(3) NOT NULL,
    FOREIGN KEY (LotniskoOdlotu) REFERENCES Lotniska(KodLotniska),
    FOREIGN KEY (LotniskoPrzylotu) REFERENCES Lotniska(KodLotniska),
    UNIQUE (LotniskoOdlotu, LotniskoPrzylotu) -- Trasa jest unikalna dla pary lotnisk
);

-- Tabela 5: Statusy Lotów (Lista możliwych statusów)
CREATE TABLE StatusyLotow (
    StatusID INT PRIMARY KEY,
    OpisStatusu VARCHAR(50) UNIQUE NOT NULL -- Np. "Planowany", "Opóźniony", "Wylądował"
);

-- Tabela 6: Loty (Główna tabela z informacjami o konkretnym locie)
CREATE TABLE Loty (
    LotID INT PRIMARY KEY,
    NumerLotu VARCHAR(10) NOT NULL,
    TrasaID INT NOT NULL,
    SamolotID INT NOT NULL,
    DataOdlotu DATETIME NOT NULL,
    PlanowanaDataPrzylotu DATETIME NOT NULL,
    RzeczywistaDataOdlotu DATETIME,
    RzeczywistaDataPrzylotu DATETIME,
    StatusID INT NOT NULL,
    FOREIGN KEY (TrasaID) REFERENCES Trasy(TrasaID),
    FOREIGN KEY (SamolotID) REFERENCES Samoloty(SamolotID),
    FOREIGN KEY (StatusID) REFERENCES StatusyLotow(StatusID)
);

-- Tabela 7: Pasażerowie
CREATE TABLE Pasazerowie (
    PasazerID INT PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    DataUrodzenia DATE,
    Email VARCHAR(100) UNIQUE
);

-- Tabela 8: Bilety/Rezerwacje (Łączy pasażerów z lotami)
CREATE TABLE Rezerwacje (
    RezerwacjaID INT PRIMARY KEY,
    LotID INT NOT NULL,
    PasazerID INT NOT NULL,
    NumerMiejsca VARCHAR(5),
    DataRezerwacji DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (LotID) REFERENCES Loty(LotID),
    FOREIGN KEY (PasazerID) REFERENCES Pasazerowie(PasazerID),
    UNIQUE (LotID, PasazerID) -- Pasażer może mieć tylko jedną rezerwację na dany lot
);

-- Tabela 9: Typy Pracowników (Pilot, Personel Naziemny, Kontroler itp.)
CREATE TABLE TypyPracownikow (
    TypID INT PRIMARY KEY,
    NazwaTypu VARCHAR(50) UNIQUE NOT NULL
);

-- Tabela 10: Pracownicy
CREATE TABLE Pracownicy (
    PracownikID INT PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    TypID INT NOT NULL,
    DataZatrudnienia DATE NOT NULL,
    NumerLicencji VARCHAR(50) UNIQUE, -- Dla Pilotów, Kontrolerów
    FOREIGN KEY (TypID) REFERENCES TypyPracownikow(TypID)
);

-- Tabela 11: Załoga Lotu (Łączy Pracowników z Lotami, dla personelu lotniczego)
CREATE TABLE ZalogaLotu (
    ZalogaLotuID INT PRIMARY KEY,
    LotID INT NOT NULL,
    PracownikID INT NOT NULL,
    RolaWLocie VARCHAR(50), -- Np. "Kapitan", "Drugi Pilot", "Stewardesa"
    FOREIGN KEY (LotID) REFERENCES Loty(LotID),
    FOREIGN KEY (PracownikID) REFERENCES Pracownicy(PracownikID),
    UNIQUE (LotID, PracownikID)
);

-- Tabela 12: Typy Maszyn Obsługi Naziemnej (Wózek bagażowy, Cysterna, Schody)
CREATE TABLE TypyMaszyn (
    TypMaszynyID INT PRIMARY KEY,
    NazwaTypu VARCHAR(100) UNIQUE NOT NULL,
    Opis VARCHAR(255)
);

-- Tabela 13: Maszyny Obsługi Naziemnej (Konkretne maszyny)
CREATE TABLE MaszynyObslugiNaziemnej (
    MaszynaID INT PRIMARY KEY,
    NumerInwentarzowy VARCHAR(50) UNIQUE NOT NULL,
    TypMaszynyID INT NOT NULL,
    Marka VARCHAR(50),
    Model VARCHAR(50),
    RokProdukcji INT,
    Status VARCHAR(50) DEFAULT 'Dostępna', -- Np. "Dostępna", "W Użyciu", "W Naprawie"
    FOREIGN KEY (TypMaszynyID) REFERENCES TypyMaszyn(TypMaszynyID)
);

-- Tabela 14: Przeglądy Techniczne Maszyn (Historia badań technicznych)
CREATE TABLE PrzegladyTechniczne (
    PrzegladID INT PRIMARY KEY,
    MaszynaID INT NOT NULL,
    DataPrzegladu DATE NOT NULL,
    DataNastepnegoPrzegladu DATE,
    Wynik VARCHAR(100) NOT NULL, -- Np. "Pozytywny", "Wymaga Naprawy"
    PrzeprowadzajacyPracownikID INT, -- Pracownik odpowiedzialny za przegląd
    FOREIGN KEY (MaszynaID) REFERENCES MaszynyObslugiNaziemnej(MaszynaID),
    FOREIGN KEY (PrzeprowadzajacyPracownikID) REFERENCES Pracownicy(PracownikID)
);