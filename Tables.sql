USE ShelterAdoptionAgency

CREATE TABLE Animal (
AnimalID INT PRIMARY KEY IDENTITY(1,1),
AnimalName NVARCHAR(100) NOT NULL,
Age INT NOT NULL CHECK (Age >= 0),
AnimalTypeID INT NOT NULL FOREIGN KEY REFERENCES AnimalType(AnimalTypeID),
BreedID INT NOT NULL FOREIGN KEY REFERENCES BreedType(BreedID),
StatusID INT NOT NULL FOREIGN KEY REFERENCES AnimalStatus(StatusID),
StaffID INT NOT NULL FOREIGN KEY REFERENCES Staff(StaffID)
);


CREATE TABLE AnimalType (
AnimalTypeID INT PRIMARY KEY IDENTITY(1,1),
TypeName NVARCHAR(50) NOT NULL
);


CREATE TABLE BreedType (
BreedID INT PRIMARY KEY IDENTITY(1,1),
BreedName NVARCHAR(50) NOT NULL,
AnimalTypeID INT FOREIGN KEY REFERENCES AnimalType(AnimalTypeID)
);


CREATE TABLE AnimalStatus (
StatusID INT PRIMARY KEY IDENTITY(1,1),
StatusName NVARCHAR(50) NOT NULL
);


CREATE TABLE Staff (
StaffID INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
PositionID INT FOREIGN KEY REFERENCES StaffPosition(PositionID)
);


CREATE TABLE StaffPosition (
PositionID INT PRIMARY KEY IDENTITY(1,1),
PositionName NVARCHAR(50) NOT NULL
);


--Bridge Table! (For Many-To-Many) relationship between Animal-Staff.
CREATE TABLE AnimalStaff (
AnimalStaffID INT PRIMARY KEY IDENTITY(1,1),
AnimalID INT NOT NULL FOREIGN KEY REFERENCES Animal(AnimalID),
StaffID INT NOT NULL FOREIGN KEY REFERENCES Staff(StaffID)
);


CREATE TABLE Adopter (
AdopterID INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Address NVARCHAR(250) NOT NULL,
PhoneNumber NVARCHAR(15) NOT NULL,
Email NVARCHAR(100) NOT NULL
);


--This table is also a bridge table. For the (Many-To-Many) relationship between Adoption-Animal.
CREATE TABLE Adoption (
AdoptionID INT PRIMARY KEY IDENTITY(1,1),
AnimalID INT NOT NULL FOREIGN KEY REFERENCES Animal(AnimalID),
AdoptionDate DATE NOT NULL,
AdopterID INT NOT NULL FOREIGN KEY REFERENCES Adopter(AdopterID),
AdoptionFeeID INT FOREIGN KEY REFERENCES AdoptionFee(AdoptionFeeID)
);


CREATE TABLE AdoptionFee (
AdoptionFeeID INT PRIMARY KEY IDENTITY(1,1),
FeeAmount DECIMAL(5,2) NOT NULL,
AnimalTypeID INT NOT NULL FOREIGN KEY REFERENCES AnimalType(AnimalTypeID)
);


--Made changes to this table to meet the requirments of triggers and transactions task 2.
CREATE TABLE AdoptionHistory (
AdoptionHistoryID INT PRIMARY KEY IDENTITY(1,1),
AdoptionID INT NOT NULL FOREIGN KEY REFERENCES Adoption(AdoptionID),
HistoryDetails NVARCHAR(3000) NOT NULL,
ChangeDate DATETIME DEFAULT GETDATE(), --Timestamp added
User_ NVARCHAR(100) --Tracks the user making the change.
);