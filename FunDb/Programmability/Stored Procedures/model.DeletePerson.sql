﻿CREATE PROCEDURE [model].[DeletePerson]
  @Ssn CHAR(9)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY
    DECLARE @Id UNIQUEIDENTIFIER = NULL;
  
    EXEC [dbo].[GetPersonId] @Ssn, @Id OUTPUT;

    DELETE FROM [dbo].[Person]
    WHERE [Id] = @Id;

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    IF XACT_STATE() = -1
      ROLLBACK TRANSACTION;
    THROW;
    IF XACT_STATE() = 1
      COMMIT TRANSACTION;
    THROW;
  END CATCH
