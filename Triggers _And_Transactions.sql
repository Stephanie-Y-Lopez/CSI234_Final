-- Triggers and transactions
-- AFTER UPDATE Trigger
-- This trigger logs updates made to the Animal table into an AdoptionHistory table.
CREATE TRIGGER trig_AfterAnimalUpdate
ON Animal
AFTER UPDATE
AS
BEGIN
    BEGIN TRY
        -- Adding new values to the AdoptionHistory table with ChangeDate and user_ tracking.
        INSERT INTO AdoptionHistory (AdoptionID, HistoryDetails, ChangeDate, user_)
        SELECT 
            NULL,  -- Didnt call for AdoptionID because I am only working with the rows effected by the insert and delete statements in the animal table.
			-- The d stands for delete while the i stands for insert in front of the table row names.
            CONCAT('AnimalID: ', d.AnimalID, ' was updated from ', 
                   'Name: ', d.AnimalName, ' to ', i.AnimalName),
            GETDATE(),  -- ChangeDate as the current timestamp
            SYSTEM_USER  -- user_ field capturing the current system user
        FROM 
            deleted d
        INNER JOIN 
            inserted i ON d.AnimalID = i.AnimalID;
    END TRY
    BEGIN CATCH
        -- Error handling
        PRINT 'Error occurred in trig_AfterAnimalUpdate.';
    END CATCH;
END;
-- Test Case: Updates animals name.
UPDATE Animal SET AnimalName = 'Buddy' WHERE AnimalID = 2;
--Whats happening: It logs the update into the AdoptionHistory table.



-- AFTER DELETE Trigger
-- This trigger logs deletions into the AdoptionHistory table and changes the animal status.
CREATE TRIGGER trig_AfterAnimalDelete
ON Animal
AFTER DELETE
AS
BEGIN
    BEGIN TRY
        -- Logs the deletion details into AdoptionHistory table
        INSERT INTO AdoptionHistory (AdoptionID, HistoryDetails, ChangeDate, user_)
        SELECT 
            NULL,  -- No AdoptionID needed since it's a delete
            CONCAT('AnimalID: ', d.AnimalID, ' with name ', d.AnimalName, ' was deleted.'),
             GETDATE(),  -- ChangeDate as the current timestamp
            SYSTEM_USER  -- user_ field capturing the current system user
        FROM 
            deleted d;
    END TRY
    BEGIN CATCH
        -- Error handling
        PRINT 'Error occurred in trig_AfterAnimalDelete.';
    END CATCH;
END;
-- Test Case: Delete an animal
DELETE FROM Animal WHERE AnimalID = 4;
--Whats happening: It logs the deletion into the AdoptionHistory table with the animals details.



--Rocursion prevention for triggers.
IF TRIGGER_NESTLEVEL() > 1 RETURN;


-- INSTEAD OF DELETE Trigger
-- This trigger prevents deletion of AnimalType if it is associated with any animals.
CREATE TRIGGER trig_InsteadOfAnimalTypeDelete
ON AnimalType
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Animal WHERE AnimalTypeID IN (SELECT AnimalTypeID FROM deleted))
        BEGIN
            -- Error detected if there are animals associated with the AnimalType
			-- For proper error handling I looked up online suggestion and added the 16 and 1. The 16 stands for a user level error while, the 1 helps identify the specific error.
            RAISERROR('Cannot delete AnimalType as there are associated animals.', 16, 1);
            ROLLBACK TRANSACTION;
        END
        ELSE
        BEGIN
            -- Proceeding with deletion if no associated animals are found
            DELETE FROM AnimalType WHERE AnimalTypeID IN (SELECT AnimalTypeID FROM deleted);
        END
    END TRY
    BEGIN CATCH
        -- Error handling
        PRINT 'Error occurred in trig_InsteadOfAnimalTypeDelete.';
        ROLLBACK TRANSACTION;
    END CATCH;
END;
-- Test Case: Prevent deletion
DELETE FROM AnimalType WHERE AnimalTypeID = 1;
-- Whats happening: Its checking if any animals are associated with the AnimalTypeID.
-- Test case error: Delete an unused AnimalType
DELETE FROM AnimalType WHERE AnimalTypeID = 5;
