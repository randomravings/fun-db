CREATE PROCEDURE [dbo].[CreateAccountRelation]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @Code CHAR(4),
  @PersonAccountRelationId UNIQUEIDENTIFIER OUTPUT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonId UNIQUEIDENTIFIER = NULL;
    DECLARE @AccountId UNIQUEIDENTIFIER = NULL;
  
    EXEC [dbo].[GetPersonId] @Ssn, @PersonId OUTPUT;
    EXEC [dbo].[GetAccountId] @AccountNo, @AccountId OUTPUT;

    SET @PersonAccountRelationId = NEWID();
    INSERT INTO [dbo].[PersonAccountRelation] ([Id], [PersonId], [AccountId], [Code])
    VALUES (@PersonAccountRelationId, @PersonId, @AccountId, @Code);

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