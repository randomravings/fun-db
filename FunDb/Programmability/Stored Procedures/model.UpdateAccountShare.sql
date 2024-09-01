CREATE PROCEDURE [model].[UpdateAccountShare]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @Share INT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonAccountRelationId UNIQUEIDENTIFIER;

    EXEC [dbo].[GetAccountOwnershipRelationId] @Ssn, @AccountNo, @PersonAccountRelationId OUTPUT;

    UPDATE [dbo].[PersonAccountRelationOwnership]
    SET [Share] = @Share
    WHERE [Id] = @PersonAccountRelationId
      AND [Share] <> @Share;

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
