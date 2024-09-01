CREATE PROCEDURE [model].[CreatePerson]
  @Ssn CHAR(9),
  @FirstName NVARCHAR(100),
  @LastName NVARCHAR(100)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    INSERT INTO [dbo].[Person] ([Id], [Ssn], [FirstName], [LastName])
    VALUES (NEWID(), @Ssn, @FirstName, @LastName);

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
