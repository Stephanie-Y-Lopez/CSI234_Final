--Sample data for tables:
--Animal Table
INSERT INTO Animal (AnimalName, Age, AnimalTypeID, BreedID, StatusID, StaffID) 
VALUES 
-- Dogs
('Buddy', 3, 1, 1, 1, 1),
('Max', 5, 1, 2, 1, 2),
('Bella', 2, 1, 3, 1, 3),
('Lucy', 1, 1, 4, 2, 4),
('Charlie', 6, 1, 5, 1, 5),
('Daisy', 4, 1, 6, 1, 6),
('Rocky', 7, 1, 7, 1, 7),
('Luna', 8, 1, 8, 3, 8),
('Coco', 2, 1, 9, 2, 1),
('Ruby', 1, 1, 10, 1,2),
-- Cats 
('Mittens', 12, 2, 11, 1, 3),
('Simba', 9, 2, 12, 2, 4),
('Leo', 3, 2, 13, 1, 5),
('Nala', 5, 2, 14, 2, 6),
('Shadow', 4, 2, 15, 1, 7),
('Whiskers', 7, 2, 16, 3, 8),
('Ginger', 6, 2, 17, 2, 1),
('Oliver', 8, 2, 18, 1, 2),
('Socks', 2, 2, 19, 3, 3),
('Mochi', 1, 2, 20, 1, 4),
-- Rabbits
('Thumper', 3, 3, 21, 1, 5),
('Oreo', 2, 3, 22, 1, 6),
('Snowball', 1, 3, 23, 2, 7),
('Cotton', 4, 3, 24, 3, 8),
('Hoppy', 5, 3, 25, 1, 1),
('Flopsy', 2, 3, 26, 1, 2),
('Clover', 3, 3, 27, 2, 3),
('Bunbun', 1, 3, 28, 1, 4),
-- Guinea Pigs
('Peanut', 2, 4, 29, 1, 5),
('Hazel', 1, 4, 30, 3, 6),
('Mocha', 4, 4, 31, 1, 7),
('Latte', 5, 4, 32, 1, 8),
('Brownie', 3, 4, 33, 2, 1),
('Marble', 2, 4, 34, 1, 2),
('Cinnamon', 4, 4, 35, 1, 3),
('Choco', 6, 4, 36, 2, 4),
-- Birds
('Tweety', 7, 5, 37, 1, 1),
('Kiwi', 3, 5, 38, 1, 2),
('Sunny', 1, 5, 39, 1, 3),
('Mango', 2, 5, 40, 2, 4),
('Peach', 4, 5, 41, 1, 5),
('Cleo', 6, 5, 42, 2, 6),
('Robin', 5, 5, 43, 1, 7),
('Skye', 3, 5, 44, 3, 8);

--AnimalType
INSERT INTO AnimalType (TypeName) 
VALUES 
('Dog'), 
('Cat'), 
('Rabbit'),
('Guinea Pig'),
('Bird');

--BreedType
INSERT INTO BreedType (BreedName, AnimalTypeID)
VALUES 
--Dog Breeds
('Labrador', 1), 
('Golden Retriever', 1), 
('German Shepherd', 1), 
('Poodle', 1), 
('Bulldog', 1), 
('Beagle',1), 
('Rottweiler', 1), 
('Dachshund', 1), 
('Boxer', 1), 
('Husky', 1), 
('Great Dane', 1), 
('Doberman Pinscher', 1), 
('Shih Tzu', 1), 
('Border Collie', 1), 
('Australian Shepherd', 1), 
('Chihuahua', 1), 
('Pembroke Welsh Corgi', 1), 
('Maltese', 1), 
('French Bulldog', 1), 
('Yorkshire Terrier', 1),
('Mutt', 1),
--Cat Breeds
('Persian', 2), 
('Maine Coon', 2), 
('Siamese', 2), 
('Ragdoll', 2), 
('Bengal', 2), 
('British Shorthair', 2), 
('Sphynx', 2),
('Unknown', 2),
--Rabbit Breeds
('Holland Lop', 3), 
('Netherland Dwarf', 3), 
('Flemish Giant', 3), 
('Lionhead', 3), 
('Mini Rex', 3), 
('English Angora', 3), 
('Californian', 3),
('Unknown', 3),
--Guinea Pig Breeds
('American', 4), 
('Abyssinian', 4), 
('Peruvian', 4), 
('Texel', 4), 
('Silkie', 4), 
('Teddy', 4), 
('Skinny Pig', 4),
('Unknown', 4),
--Bird Breeds
('Budgerigar', 5), 
('Cockatiel', 5), 
('Lovebird', 5), 
('Canary', 5), 
('Zebra Finch', 5), 
('Conure', 5), 
('Unknown', 5);

--AnimalStatus Table
INSERT INTO AnimalStatus (StatusName) 
VALUES 
('Available'), 
('Adopted'), 
('Under Care');

--Staff Table
INSERT INTO Staff (FirstName, LastName, PositionID) 
VALUES 
('Mia', 'Mendez', 2), 
('Nelly', 'Montez', 3), 
('Yessica', 'Gon', 3),
('Yolis', 'Chavoya', 1),
('Pedro', 'Lopez', 5),
('Oswaldo', 'Perez', 3),
('Yolanda', 'Gonzeles', 1),
('Diana', 'Vanessa', 4),
('Alex', 'Zambrano', 4),
('Nico', 'Nem', 6),
('Meryln', 'Rose', 2),
('Jimmy', 'Horn', 7);

--StaffPosition Table
INSERT INTO StaffPosition (PositionName)
VALUES
('Veterinarian'),
('Veterinarian Assistant'),
('CareTaker'),
('Trainer'),
('Adoption Manager'),
('Receptionist'),
('Volunteer');

--AnimalStaff (Bridge table)
INSERT INTO AnimalStaff (AnimalID, StaffID)
VALUES
-- Dogs
(2, 1),  --Buddy: Veterinarian
(2, 2),  --Buddy: Veterinarian Assistant
(3, 3),  --Max: Caretaker
(4, 4),  --Bella: Trainer
(5, 3),  --Lucy: Caretaker
(6, 1),  --Charlie: Veterinarian
(7, 2),  --Daisy: Veterinarian Assistant
(8, 3),  --Rocky: Caretaker
(9, 4),  --Luna: Trainer
(10, 2), --Coco: Veterinarian Assistant
(11, 3), --Ruby: Caretaker
-- Cats
(12, 1), --Mittens: Veterinarian
(13, 2), --Simba: Veterinarian Assistant
(14, 3), --Leo: Caretaker
(15, 4), --Nala: Trainer
(16, 1), --Shadow: Veterinarian
(17, 2), --Whiskers: Veterinarian Assistant
(18, 3), --Ginger: Caretaker
(19, 4), --Oliver: Trainer
(20, 2), --Socks: Veterinarian Assistant
(21, 3), --Mochi: Caretaker
-- Rabbits
(22, 1), --Thumper: Veterinarian
(23, 2), --Oreo: Veterinarian Assistant
(24, 3), --Snowball: Caretaker
(25, 4), --Cotton: Trainer
(26, 1), --Hoppy: Veterinarian
(27, 2), --Flopsy: Veterinarian Assistant
(28, 3), --Clover: Caretaker
(29, 4), --Bunbun: Trainer
-- Guinea Pigs
(30, 1), --Peanut: Veterinarian
(31, 2), --Hazel: Veterinarian Assistant
(32, 3), --Mocha: Caretaker
(33, 4), --Latte: Trainer
(34, 1), --Brownie: Veterinarian
(35, 2), --Marble: Veterinarian Assistant
(36, 3), --Cinnamon: Caretaker
(37, 4), --Choco: Trainer
-- Birds
(38, 1), --Tweety: Veterinarian
(39, 2), --Kiwi: Veterinarian Assistant
(40, 3), --Sunny: Caretaker
(41, 4), --Mango: Trainer
(42, 1), --Peach: Veterinarian
(43, 2), --Cleo: Veterinarian Assistant
(44, 3), --Robin: Caretaker
(45, 4); --Skye: Trainer

--Adopter Table
INSERT INTO Adopter (FirstName, LastName, Address, PhoneNumber, Email) 
VALUES 
('Michael', 'Brown', '123 Main St, Cityville', '555-1234', 'michael.brown@example.com'), 
('Sarah', 'Lee', '456 Oak St, Townsville', '555-5678', 'sarah.lee@example.com'),
('Anna', 'Taylor', '789 Elm St, Villagetown', '555-7890', 'anna.taylor@example.com'),
('James', 'Clark', '101 Maple Ave, Metropolis', '555-1011', 'james.clark@example.com'),
('Emily', 'Johnson', '202 Oak Lane, Greenfield', '555-2022', 'emily.johnson@example.com');

--Adoption Table (Bridge Table)
INSERT INTO Adoption (AnimalID, AdopterID, AdoptionDate, AdoptionFeeID) 
VALUES 
(11, 1, '2023-11-01', 1), 
(21, 2, '2023-11-05', 2),
(37, 3, '2024-11-10', 3),
(11, 4, '2024-11-12', 1),
(21, 5, '2024-11-15', 2);

--AdoptionFee Table
INSERT INTO AdoptionFee (FeeAmount, AnimalTypeID) 
VALUES 
(125.00, 1), 
(75.00, 2), 
(100.00, 3),
(75.00, 4),
(150.00, 5);

--AdoptionHistory Table
INSERT INTO AdoptionHistory (AdoptionID, HistoryDetails, ChangeDate, User_) 
VALUES 
(4, 'Mittens was adopted by Michael Brown on 2023-11-01.', '2023-11-01 10:00:00', 'admin'), 
(5, 'Thumper was adopted by Sarah Lee on 2023-11-05.', '2023-11-05 14:30:00', 'admin'),
(6, 'Tweety was adopted by Anna Taylor on 2024-11-10.', '2024-11-10 09:15:00', 'admin'),
(7, 'Thumper was adopted by James Clark on 2024-11-12.', '2024-11-12 16:45:00', 'admin'),
(8, 'Mittens was adopted by Emily Johnson on 2024-11-15.', '2024-11-15 13:20:00', 'admin');