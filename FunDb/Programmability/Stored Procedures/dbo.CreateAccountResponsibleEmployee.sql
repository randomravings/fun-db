CREATE PROCEDURE [dbo].[CreateAccountResponsibleEmployee]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @ReviewDate DATE
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonAccountRelationId UNIQUEIDENTIFIER;

    EXEC [dbo].[CreateAccountRelation] @Ssn, @AccountNo, 'EMPL', @PersonAccountRelationId OUTPUT;

    INSERT INTO [dbo].[PersonAccountRelationResponsible] ([Id], [PersonAccountRelationId], [PersonAccountRelationCode], [ReviewDate])
    VALUES (NEWID(), @PersonAccountRelationId, 'EMPL', @ReviewDate);

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
