CREATE PROCEDURE [model].[CreateAccountCoOwner]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @Share INT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonAccountRelationId UNIQUEIDENTIFIER;

    EXEC [dbo].[CreateAccountRelation] @Ssn, @AccountNo, 'COWN', @PersonAccountRelationId OUTPUT;

    INSERT INTO [dbo].[PersonAccountRelationOwnership] ([Id], [PersonAccountRelationId], [PersonAccountRelationCode], [Share])
  VALUES (NEWID(), @PersonAccountRelationId, 'COWN', @Share);

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
