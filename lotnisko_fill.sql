-- 1. ModeleSamolotow (10 wierszy)
INSERT INTO ModeleSamolotow (ModelID, NazwaModelu, Producent, LiczbaMiejsc, Zasięg) VALUES
(1, 'Boeing 737-800', 'Boeing', 189, 5600),
(2, 'Airbus A320neo', 'Airbus', 186, 6300),
(3, 'Embraer E175', 'Embraer', 76, 3900),
(4, 'Boeing 787-9', 'Boeing', 290, 14140),
(5, 'Airbus A380', 'Airbus', 555, 15000),
(6, 'ATR 72-600', 'ATR', 72, 1500),
(7, 'Bombardier Q400', 'Bombardier', 90, 2000),
(8, 'Boeing 737 MAX 8', 'Boeing', 178, 6500),
(9, 'Airbus A350-900', 'Airbus', 300, 15000),
(10, 'Cessna 172', 'Cessna', 4, 1200);

-- 2. Samoloty (15 wierszy)
INSERT INTO Samoloty (SamolotID, NumerRejestracyjny, ModelID, DataWprowadzeniaDoSluzby) VALUES
(101, 'SP-LOA', 1, '2015-05-10'),
(102, 'SP-LOB', 1, '2016-11-20'),
(103, 'OE-LCC', 2, '2018-03-01'),
(104, 'D-AICH', 2, '2019-07-15'),
(105, 'PH-NZE', 3, '2017-01-25'),
(106, 'G-EJRJ', 4, '2020-09-01'),
(107, 'F-HTSA', 5, '2012-10-10'),
(108, 'SP-KAS', 1, '2021-04-12'),
(109, 'D-AZUR', 2, '2022-01-05'),
(110, 'SP-QW', 6, '2019-06-18'),
(111, 'SP-RTY', 6, '2019-06-18'),
(112, 'SP-UIO', 7, '2019-06-18'),
(113, 'SP-ASD', 8, '2019-06-18'),
(114, 'SP-FGH', 9, '2019-06-18'),
(115, 'SP-JKL', 10, '2019-06-18');

-- 3. Lotniska (8 wierszy)
INSERT INTO Lotniska (KodLotniska, Nazwa, Miasto, Kraj) VALUES
('WAW', 'Lotnisko Chopina', 'Warszawa', 'Polska'),
('JFK', 'John F. Kennedy Intl. Airport', 'Nowy Jork', 'USA'),
('LHR', 'London Heathrow Airport', 'Londyn', 'Wielka Brytania'),
('CDG', 'Charles de Gaulle Airport', 'Paryż', 'Francja'),
('DXB', 'Dubai Intl. Airport', 'Dubaj', 'ZEA'),
('FRA', 'Frankfurt Airport', 'Frankfurt', 'Niemcy'),
('VIE', 'Vienna Intl. Airport', 'Wiedeń', 'Austria'),
('KRK', 'Kraków Airport', 'Kraków', 'Polska');

-- 4. Trasy (10 wierszy)
INSERT INTO Trasy (TrasaID, LotniskoOdlotu, LotniskoPrzylotu) VALUES
(1, 'WAW', 'JFK'),
(2, 'WAW', 'LHR'),
(3, 'LHR', 'DXB'),
(4, 'CDG', 'WAW'),
(5, 'FRA', 'JFK'),
(6, 'WAW', 'DXB'),
(7, 'KRK', 'VIE'),
(8, 'VIE', 'KRK'),
(9, 'WAW', 'CDG'),
(10, 'LHR', 'FRA');

-- 5. StatusyLotow (5 wierszy)
INSERT INTO StatusyLotow (StatusID, OpisStatusu) VALUES
(1, 'Planowany'),
(2, 'Wystartował'),
(3, 'Opóźniony'),
(4, 'Wylądował'),
(5, 'Anulowany');

-- 6. Loty (20 wierszy - kluczowa tabela)
INSERT INTO Loty (LotID, NumerLotu, TrasaID, SamolotID, DataOdlotu, PlanowanaDataPrzylotu, RzeczywistaDataOdlotu, RzeczywistaDataPrzylotu, StatusID) VALUES
-- Długodystansowe
(1001, 'LO001', 1, 106, '2025-12-05 08:00:00', '2025-12-05 16:30:00', NULL, NULL, 1), -- WAW-JFK (Planowany)
(1002, 'LH450', 5, 107, '2025-12-04 12:00:00', '2025-12-04 18:30:00', '2025-12-04 12:05:00', '2025-12-04 18:25:00', 4), -- FRA-JFK (Wylądował)
(1003, 'EK202', 3, 107, '2025-12-06 20:00:00', '2025-12-07 05:00:00', NULL, NULL, 1), -- LHR-DXB (Planowany)
-- Krótkodystansowe
(1004, 'LO385', 2, 101, '2025-12-05 10:30:00', '2025-12-05 12:30:00', '2025-12-05 11:00:00', NULL, 3), -- WAW-LHR (Opóźniony)
(1005, 'AF126', 4, 103, '2025-12-05 15:00:00', '2025-12-05 17:00:00', '2025-12-05 15:00:00', '2025-12-05 16:55:00', 4), -- CDG-WAW (Wylądował)
(1006, 'LO750', 9, 102, '2025-12-05 18:00:00', '2025-12-05 20:00:00', '2025-12-05 18:05:00', NULL, 2), -- WAW-CDG (Wystartował)
(1007, 'OS501', 7, 105, '2025-12-06 06:00:00', '2025-12-06 07:00:00', NULL, NULL, 1), -- KRK-VIE (Planowany)
(1008, 'BA980', 10, 104, '2025-12-04 22:00:00', '2025-12-05 00:00:00', '2025-12-04 22:00:00', '2025-12-04 23:55:00', 4), -- LHR-FRA (Wylądował)
(1009, 'LO800', 6, 106, '2025-12-07 10:00:00', '2025-12-07 18:00:00', NULL, NULL, 5), -- WAW-DXB (Anulowany)
(1010, 'LO200', 2, 108, '2025-12-05 13:00:00', '2025-12-05 15:00:00', NULL, NULL, 1), -- WAW-LHR
(1011, 'AF301', 9, 109, '2025-12-05 07:30:00', '2025-12-05 09:30:00', NULL, NULL, 1), -- WAW-CDG
(1012, 'LH100', 10, 104, '2025-12-05 14:00:00', '2025-12-05 16:00:00', NULL, NULL, 1), -- LHR-FRA
(1013, 'LO900', 1, 106, '2025-12-06 11:00:00', '2025-12-06 19:30:00', NULL, NULL, 1), -- WAW-JFK
(1014, 'BA400', 2, 102, '2025-12-06 16:00:00', '2025-12-06 18:00:00', NULL, NULL, 1), -- WAW-LHR
(1015, 'LO300', 7, 105, '2025-12-05 19:00:00', '2025-12-05 20:00:00', NULL, NULL, 1), -- KRK-VIE
(1016, 'OS450', 8, 105, '2025-12-05 21:00:00', '2025-12-05 22:00:00', NULL, NULL, 1), -- VIE-KRK
(1017, 'AF444', 4, 109, '2025-12-06 09:00:00', '2025-12-06 11:00:00', NULL, NULL, 1), -- CDG-WAW
(1018, 'LH555', 5, 107, '2025-12-06 13:00:00', '2025-12-06 19:30:00', NULL, NULL, 1), -- FRA-JFK
(1019, 'EK101', 6, 107, '2025-12-06 23:00:00', '2025-12-07 07:00:00', NULL, NULL, 1), -- WAW-DXB
(1020, 'LO500', 2, 101, '2025-12-06 08:00:00', '2025-12-06 10:00:00', NULL, NULL, 1); -- WAW-LHR

-- 7. Pasazerowie (50 wierszy - wymagana duża liczba)
INSERT INTO Pasazerowie (PasazerID, Imie, Nazwisko, DataUrodzenia, Email) VALUES
(2001, 'Anna', 'Kowalska', '1985-05-10', 'anna.kowalska@example.com'),
(2002, 'Piotr', 'Nowak', '1990-01-15', 'piotr.nowak@example.com'),
(2003, 'Ewa', 'Wiśniewska', '1978-11-20', 'ewa.wisniewska@example.com'),
(2004, 'Adam', 'Wójcik', '2000-03-01', 'adam.wojcik@example.com'),
(2005, 'Katarzyna', 'Kowalczyk', '1995-07-07', 'katarzyna.kowalczyk@example.com'),
(2006, 'Marcin', 'Zieliński', '1982-04-22', 'marcin.zielinski@example.com'),
(2007, 'Magdalena', 'Szymańska', '1998-09-11', 'magda.szymanska@example.com'),
(2008, 'Jan', 'Dąbrowski', '1970-06-05', 'jan.dabrowski@example.com'),
(2009, 'Natalia', 'Lewandowska', '1993-12-30', 'natalia.lewandowska@example.com'),
(2010, 'Robert', 'Wójcik', '1988-02-18', 'robert.wojcik@example.com'),
(2011, 'Alicja', 'Kowalska', '1985-05-10', 'alicja.kowalska@example.pl'),
(2012, 'Bartosz', 'Nowak', '1990-01-15', 'bartosz.nowak@example.pl'),
(2013, 'Celina', 'Wiśniewska', '1978-11-20', 'celina.wisniewska@example.pl'),
(2014, 'Dariusz', 'Wójcik', '2000-03-01', 'dariusz.wojcik@example.pl'),
(2015, 'Eliza', 'Kowalczyk', '1995-07-07', 'eliza.kowalczyk@example.pl'),
(2016, 'Filip', 'Zieliński', '1982-04-22', 'filip.zielinski@example.pl'),
(2017, 'Grażyna', 'Szymańska', '1998-09-11', 'grazyna.szymanska@example.pl'),
(2018, 'Henryk', 'Dąbrowski', '1970-06-05', 'henryk.dabrowski@example.pl'),
(2019, 'Irena', 'Lewandowska', '1993-12-30', 'irena.lewandowska@example.pl'),
(2020, 'Jacek', 'Wójcik', '1988-02-18', 'jacek.wojcik@example.pl'),
(2021, 'Kinga', 'Zając', '1980-01-01', 'kinga.zajac@example.com'),
(2022, 'Lech', 'Kaczmarek', '1991-02-02', 'lech.kaczmarek@example.com'),
(2023, 'Monika', 'Krawczyk', '1975-03-03', 'monika.krawczyk@example.com'),
(2024, 'Norbert', 'Piotrowski', '2001-04-04', 'norbert.piotrowski@example.com'),
(2025, 'Olga', 'Grabowska', '1996-05-05', 'olga.grabowska@example.com'),
(2026, 'Paweł', 'Górski', '1983-06-06', 'pawel.gorski@example.com'),
(2027, 'Renata', 'Jankowska', '1997-07-07', 'renata.jankowska@example.com'),
(2028, 'Szymon', 'Mazur', '1971-08-08', 'szymon.mazur@example.com'),
(2029, 'Teresa', 'Klimek', '1994-09-09', 'teresa.klimek@example.com'),
(2030, 'Urszula', 'Bąk', '1989-10-10', 'urszula.bak@example.com'),
(2031, 'Wojciech', 'Duda', '1984-11-11', 'wojciech.duda@example.com'),
(2032, 'Xenia', 'Lis', '1999-12-12', 'xenia.lis@example.com'),
(2033, 'Yvone', 'Różycka', '1976-01-13', 'yvone.rozycka@example.com'),
(2034, 'Zenon', 'Kruk', '2002-02-14', 'zenon.kruk@example.com'),
(2035, 'Anastazja', 'Kubiak', '1992-03-15', 'anastazja.kubiak@example.com'),
(2036, 'Barnaba', 'Ziółkowski', '1987-04-16', 'barnaba.ziolkowski@example.com'),
(2037, 'Cecylia', 'Gajda', '1981-05-17', 'cecylia.gajda@example.com'),
(2038, 'Damian', 'Jaworski', '1996-06-18', 'damian.jaworski@example.com'),
(2039, 'Estera', 'Wróbel', '1974-07-19', 'estera.wrobel@example.com'),
(2040, 'Feliks', 'Stępień', '1990-08-20', 'feliks.stepien@example.com'),
(2041, 'Grażyna', 'Pawlak', '1986-09-21', 'grazyna.pawlak@example.com'),
(2042, 'Hubert', 'Walczak', '1993-10-22', 'hubert.walczak@example.com'),
(2043, 'Igor', 'Baran', '1979-11-23', 'igor.baran@example.com'),
(2044, 'Judyta', 'Michalak', '2003-12-24', 'judyta.michalak@example.com'),
(2045, 'Karol', 'Czarnecki', '1988-01-25', 'karol.czarnecki@example.com'),
(2046, 'Lena', 'Kozłowska', '1995-02-26', 'lena.kozlowska@example.com'),
(2047, 'Michał', 'Włodarczyk', '1977-03-27', 'michal.wlodarczyk@example.com'),
(2048, 'Nadia', 'Krzemińska', '1991-04-28', 'nadia.krzeninska@example.com'),
(2049, 'Oskar', 'Jasiński', '1982-05-29', 'oskar.jasinski@example.com'),
(2050, 'Patrycja', 'Mazurek', '1998-06-30', 'patrycja.mazurek@example.com');


-- 8. Rezerwacje (60 wierszy)
-- Duża liczba rezerwacji dla demonstracji relacji Loty:Pasazerowie
INSERT INTO Rezerwacje (RezerwacjaID, LotID, PasazerID, NumerMiejsca) VALUES
(3001, 1001, 2001, '1A'), (3002, 1001, 2002, '1B'), (3003, 1001, 2003, '2C'), (3004, 1001, 2004, '2D'),
(3005, 1002, 2005, '10A'), (3006, 1002, 2006, '10B'), (3007, 1002, 2007, '11C'), (3008, 1002, 2008, '11D'),
(3009, 1003, 2009, '30F'), (3010, 1003, 2010, '31A'), (3011, 1003, 2011, '31B'),
(3012, 1004, 2012, '5A'), (3013, 1004, 2013, '5B'), (3014, 1004, 2014, '6C'), (3015, 1004, 2015, '6D'),
(3016, 1005, 2016, '15F'), (3017, 1005, 2017, '16A'), (3018, 1005, 2018, '16B'), (3019, 1005, 2019, '17C'),
(3020, 1006, 2020, '22A'), (3021, 1006, 2021, '22B'), (3022, 1006, 2022, '23C'),
(3023, 1007, 2023, '1D'), (3024, 1007, 2024, '1F'), (3025, 1007, 2025, '2A'),
(3026, 1008, 2026, '18D'), (3027, 1008, 2027, '18F'), (3028, 1008, 2028, '19A'), (3029, 1008, 2029, '19B'),
(3030, 1010, 2030, '7C'), (3031, 1010, 2031, '7D'), (3032, 1010, 2032, '8A'), (3033, 1010, 2033, '8B'), (3034, 1010, 2034, '9C'),
(3035, 1011, 2035, '10C'), (3036, 1011, 2036, '10D'), (3037, 1011, 2037, '11A'), (3038, 1011, 2038, '11B'),
(3039, 1012, 2039, '12C'), (3040, 1012, 2040, '12D'),
(3041, 1013, 2041, '1A'), (3042, 1013, 2042, '1B'), (3043, 1013, 2043, '2A'), (3044, 1013, 2044, '2B'),
(3045, 1014, 2045, '3C'), (3046, 1014, 2046, '3D'), (3047, 1014, 2047, '4A'), (3048, 1014, 2048, '4B'),
(3049, 1015, 2049, '1A'), (3050, 1015, 2050, '1B'),
(3051, 1016, 2001, '2A'), (3052, 1016, 2002, '2B'),
(3053, 1017, 2003, '3C'), (3054, 1017, 2004, '3D'), (3055, 1017, 2005, '4A'),
(3056, 1018, 2006, '14A'), (3057, 1018, 2007, '14B'),
(3058, 1019, 2008, '20A'), (3059, 1019, 2009, '20B'),
(3060, 1020, 2010, '15C');

-- 9. TypyPracownikow (5 wierszy)
INSERT INTO TypyPracownikow (TypID, NazwaTypu) VALUES
(1, 'Pilot'),
(2, 'Personel Pokładowy'),
(3, 'Mechanik Lotniczy'),
(4, 'Obsługa Naziemna (Cargo)'),
(5, 'Kontroler Ruchu Lotniczego');

-- 10. Pracownicy (20 wierszy)
INSERT INTO Pracownicy (PracownikID, Imie, Nazwisko, TypID, DataZatrudnienia, NumerLicencji) VALUES
-- Piloci
(4001, 'Krzysztof', 'Mazur', 1, '2005-01-10', 'PL98765'),
(4002, 'Joanna', 'Błysk', 1, '2010-05-15', 'PL54321'),
(4003, 'Tomasz', 'Orzeł', 1, '2018-08-01', 'PL12345'),
(4004, 'Marta', 'Kruk', 1, '2020-03-20', 'PL11223'),
-- Personel Pokładowy
(4005, 'Alicja', 'Wesoła', 2, '2019-02-01', NULL),
(4006, 'Paweł', 'Smutny', 2, '2021-06-10', NULL),
(4007, 'Ewelina', 'Górska', 2, '2022-11-11', NULL),
(4008, 'Rafał', 'Niski', 2, '2017-04-04', NULL),
-- Mechanicy Lotniczy
(4009, 'Józef', 'Techniczny', 3, '2000-10-01', 'MT9001'),
(4010, 'Michał', 'Naprawa', 3, '2015-12-12', 'MT9002'),
(4011, 'Anna', 'Maszynista', 3, '2023-01-20', 'MT9003'),
-- Obsługa Naziemna
(4012, 'Łukasz', 'Bagażowy', 4, '2016-03-01', NULL),
(4013, 'Beata', 'Tankowanie', 4, '2019-09-09', NULL),
(4014, 'Kamil', 'Holowanie', 4, '2020-05-05', NULL),
(4015, 'Sebastian', 'Utrzymanie', 4, '2021-08-15', NULL),
-- Kontrolerzy Ruchu
(4016, 'Monika', 'Wieża', 5, '2008-07-20', 'ATC001'),
(4017, 'Cezary', 'Radar', 5, '2014-11-25', 'ATC002'),
(4018, 'Dominika', 'Kontrola', 5, '2020-02-14', 'ATC003'),
(4019, 'Borys', 'Koordynator', 5, '2012-04-01', 'ATC004'),
(4020, 'Adrianna', 'Bezpieczna', 5, '2024-01-01', 'ATC005');

-- 11. ZalogaLotu (25 wierszy - 2-4 pracowników na loty)
INSERT INTO ZalogaLotu (ZalogaLotuID, LotID, PracownikID, RolaWLocie) VALUES
-- Lot 1001 (WAW-JFK)
(5001, 1001, 4001, 'Kapitan'),
(5002, 1001, 4002, 'Drugi Pilot'),
(5003, 1001, 4005, 'Stewardesa'),
(5004, 1001, 4006, 'Steward'),
-- Lot 1002 (FRA-JFK)
(5005, 1002, 4003, 'Kapitan'),
(5006, 1002, 4004, 'Drugi Pilot'),
(5007, 1002, 4007, 'Stewardesa'),
-- Lot 1004 (WAW-LHR)
(5008, 1004, 4001, 'Kapitan'),
(5009, 1004, 4008, 'Stewardesa'),
-- Lot 1005 (CDG-WAW)
(5010, 1005, 4002, 'Kapitan'),
(5011, 1005, 4005, 'Stewardesa'),
(5012, 1005, 4006, 'Steward'),
-- Lot 1006 (WAW-CDG)
(5013, 1006, 4003, 'Kapitan'),
(5014, 1006, 4007, 'Stewardesa'),
(5015, 1006, 4008, 'Stewardesa'),
-- Lot 1007 (KRK-VIE)
(5016, 1007, 4004, 'Kapitan'),
(5017, 1007, 4005, 'Stewardesa'),
-- Lot 1010 (WAW-LHR)
(5018, 1010, 4001, 'Kapitan'),
(5019, 1010, 4006, 'Steward'),
(5020, 1010, 4007, 'Stewardesa'),
-- Lot 1015 (KRK-VIE)
(5021, 1015, 4002, 'Kapitan'),
(5022, 1015, 4005, 'Stewardesa'),
-- Lot 1016 (VIE-KRK)
(5023, 1016, 4003, 'Kapitan'),
(5024, 1016, 4008, 'Stewardesa'),
-- Lot 1020 (WAW-LHR)
(5025, 1020, 4004, 'Kapitan');

-- 12. TypyMaszyn (5 wierszy)
INSERT INTO TypyMaszyn (TypMaszynyID, NazwaTypu, Opis) VALUES
(6001, 'Wózek Bagażowy', 'Do transportu bagażu między terminalem a samolotem'),
(6002, 'Cysterna Paliwowa', 'Do tankowania samolotów'),
(6003, 'Schody Pasażerskie', 'Ruchome schody do wejścia na pokład (dla mniejszych maszyn)'),
(6004, 'Holownik Pchający (Pushback)', 'Do wypychania samolotu ze stanowiska postojowego'),
(6005, 'Taśmociąg do Ładunku', 'Do załadunku i rozładunku cargo');

-- 13. MaszynyObslugiNaziemnej (15 wierszy)
INSERT INTO MaszynyObslugiNaziemnej (MaszynaID, NumerInwentarzowy, TypMaszynyID, Marka, Model, RokProdukcji, Status) VALUES
(7001, 'BG-001', 6001, 'Toyota', 'Towmaster', 2018, 'Dostępna'),
(7002, 'BG-002', 6001, 'Toyota', 'Towmaster', 2019, 'W Użyciu'),
(7003, 'CN-010', 6002, 'Iveco', 'FuelMaster 10K', 2015, 'Dostępna'),
(7004, 'CN-011', 6002, 'Iveco', 'FuelMaster 10K', 2020, 'W Naprawie'),
(7005, 'SC-050', 6003, 'TLD', 'GroundStep', 2021, 'Dostępna'),
(7006, 'SC-051', 6003, 'TLD', 'GroundStep', 2022, 'Dostępna'),
(7007, 'HB-100', 6004, 'Goldhofer', 'AST-2', 2017, 'W Użyciu'),
(7008, 'HB-101', 6004, 'Goldhofer', 'AST-2', 2023, 'Dostępna'),
(7009, 'TC-200', 6005, 'Cargotec', 'LoadAll', 2018, 'Dostępna'),
(7010, 'TC-201', 6005, 'Cargotec', 'LoadAll', 2019, 'Dostępna'),
(7011, 'BG-003', 6001, 'Toyota', 'Towmaster', 2020, 'Dostępna'),
(7012, 'CN-012', 6002, 'Iveco', 'FuelMaster 10K', 2021, 'Dostępna'),
(7013, 'SC-052', 6003, 'TLD', 'GroundStep', 2023, 'Dostępna'),
(7014, 'HB-102', 6004, 'Goldhofer', 'AST-2', 2024, 'Dostępna'),
(7015, 'TC-202', 6005, 'Cargotec', 'LoadAll', 2020, 'W Użyciu');

-- 14. PrzegladyTechniczne (15 wierszy - historia badań)
INSERT INTO PrzegladyTechniczne (PrzegladID, MaszynaID, DataPrzegladu, DataNastepnegoPrzegladu, Wynik, PrzeprowadzajacyPracownikID) VALUES
-- Maszyna 7001 (Wózek)
(8001, 7001, '2025-10-01', '2026-04-01', 'Pozytywny', 4009),
-- Maszyna 7004 (Cysterna - W Naprawie)
(8002, 7004, '2025-11-15', '2026-05-15', 'Wymaga Naprawy', 4010),
(8003, 7004, '2025-06-01', '2025-11-15', 'Pozytywny', 4011),
-- Maszyna 7007 (Holownik)
(8004, 7007, '2025-09-20', '2026-03-20', 'Pozytywny', 4009),
(8005, 7007, '2025-03-20', '2025-09-20', 'Pozytywny', 4010),
-- Nowsze przeglądy dla innych maszyn
(8006, 7002, '2025-11-28', '2026-05-28', 'Pozytywny', 4011),
(8007, 7003, '2025-11-05', '2026-05-05', 'Pozytywny', 4009),
(8008, 7005, '2025-10-15', '2026-04-15', 'Pozytywny', 4010),
(8009, 7006, '2025-09-01', '2026-03-01', 'Pozytywny', 4011),
(8010, 7008, '2025-11-01', '2026-05-01', 'Pozytywny', 4009),
(8011, 7009, '2025-10-10', '2026-04-10', 'Pozytywny', 4010),
(8012, 7010, '2025-09-15', '2026-03-15', 'Pozytywny', 4011),
(8013, 7011, '2025-11-20', '2026-05-20', 'Pozytywny', 4009),
(8014, 7012, '2025-10-25', '2026-04-25', 'Pozytywny', 4010),
(8015, 7013, '2025-11-30', '2026-05-30', 'Pozytywny', 4011);