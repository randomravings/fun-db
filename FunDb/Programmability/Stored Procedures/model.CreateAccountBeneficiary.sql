CREATE PROCEDURE [model].[CreateAccountBeneficiary]
  @Ssn CHAR(9),
  @AccountNo CHAR(10)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @PersonAccountRelationId UNIQUEIDENTIFIER;

    EXEC [dbo].[CreateAccountRelation] @Ssn, @AccountNo, 'BENE', @PersonAccountRelationId OUTPUT;

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


