--Stored Procedures 
-- Basic Procedure 
-- Retrieves all available animals with their details (type, breed, and status).
CREATE PROCEDURE GetAvailableAnimals
AS
BEGIN
    BEGIN TRY
        SELECT 
            A.AnimalID,
            A.AnimalName,
			--Changing the name for clarity
            AT.TypeName AS AnimalType,
            B.BreedName AS Breed,
            S.StatusName AS Status
        FROM 
            Animal A
        INNER JOIN AnimalType AT ON A.AnimalTypeID = AT.AnimalTypeID
        INNER JOIN BreedType B ON A.BreedID = B.BreedID
        INNER JOIN AnimalStatus S ON A.StatusID = S.StatusID
        WHERE 
            S.StatusName = 'Available';
    END TRY
    BEGIN CATCH
        -- Error handling
        PRINT 'Error occurred in GetAvailableAnimals: ';
    END CATCH;
END;
-- Test Case: Existing available animals
EXEC GetAvailableAnimals;
--Whats happening: Its joining mutiple tables because of the FK's, and returning the details of animals with the status 'Available'.



-- Complex Procedure
-- Adds in a new adoption record and updates the animal's status to adopted.
CREATE PROCEDURE AddAdoption
    @AnimalID INT,
    @AdopterID INT,
    @AdoptionDate DATE,
    @AdoptionFeeID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Animal WHERE AnimalID = @AnimalID)
        BEGIN
            PRINT 'Invalid AnimalID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Adopter WHERE AdopterID = @AdopterID)
        BEGIN
            PRINT 'Invalid AdopterID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM AdoptionFee WHERE AdoptionFeeID = @AdoptionFeeID)
        BEGIN
            PRINT 'Invalid AdoptionFeeID';
            RETURN;
        END

        BEGIN TRANSACTION;

		-- First inserting adoption record
        INSERT INTO Adoption (AnimalID, AdopterID, AdoptionDate, AdoptionFeeID)
        VALUES (@AnimalID, @AdopterID, @AdoptionDate, @AdoptionFeeID);

		-- Secondly updating the animals status to 'Adopted'.
        UPDATE Animal
        SET StatusID = (SELECT StatusID FROM AnimalStatus WHERE StatusName = 'Adopted')
        WHERE AnimalID = @AnimalID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback on error
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred in AddAdoption: ';
    END CATCH;
END;
-- Test Case: Adding valid adoption record.
EXEC AddAdoption 
    @AnimalID = 3, 
    @AdopterID = 5, 
    @AdoptionDate = '2024-11-20', 
    @AdoptionFeeID = 2;
-- Whats happening: Its inserting a new adoption record in the adoption table, and updating the animal status to adopted.



-- Advanced Procedure
-- I will be retreieve adoption details from mutiple tables. Such as Adopters information and animals information. 
CREATE PROCEDURE GetAdoptionDetails
    @AdopterID INT
AS
BEGIN
    BEGIN TRY
        -- Input Validation
        IF NOT EXISTS (SELECT 1 FROM Adopter WHERE AdopterID = @AdopterID)
        BEGIN
            PRINT 'Invalid AdopterID';
            RETURN;
        END

        -- Retrieving adoption details
        SELECT 
            A.AnimalName,
            AT.TypeName AS AnimalType,
            B.BreedName AS Breed,
            ADP.FirstName AS AdopterFirstName, 
            ADP.LastName AS AdopterLastName,
            AD.AdoptionDate,
            F.FeeAmount
        FROM 
            Adoption AD
        INNER JOIN Animal A ON AD.AnimalID = A.AnimalID
        INNER JOIN AnimalType AT ON A.AnimalTypeID = AT.AnimalTypeID
        INNER JOIN BreedType B ON A.BreedID = B.BreedID
        INNER JOIN Adopter ADP ON AD.AdopterID = ADP.AdopterID
        INNER JOIN AdoptionFee F ON AD.AdoptionFeeID = F.AdoptionFeeID
        WHERE ADP.AdopterID = @AdopterID;
    END TRY
    BEGIN CATCH
        -- Error handling
        PRINT 'Error occurred in GetAdoptionDetails: ';
    END CATCH;
END;
-- Test Case: Getting details of adopters adoption.
EXEC GetAdoptionDetails @AdopterID = 5;
-- Whats happening: It brings back the animal and adopters details.
--Test case error: Invalid AdopterID
EXEC GetAdoptionDetails @AdopterID = 9999;