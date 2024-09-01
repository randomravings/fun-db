CREATE PROCEDURE [model].[DeleteAccountBeneficiary]
  @Ssn CHAR(9),
  @AccountNo CHAR(10)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonAccountRelationId UNIQUEIDENTIFIER;

    EXEC [dbo].[GetPersonAccountRelationId] @Ssn, @AccountNo, 'BENE', @PersonAccountRelationId OUTPUT;

    DELETE FROM [dbo].[PersonAccountRelation]
    WHERE [PersonAccountRelation].[Id] = @PersonAccountRelationId;

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
