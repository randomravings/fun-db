CREATE PROCEDURE [dbo].[DeleteAccountRelation]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @Code CHAR(4)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @Id UNIQUEIDENTIFIER = NULL

    EXEC [dbo].[GetPersonAccountRelationId] @Ssn, @AccountNo, @Code, @Id OUTPUT

    DELETE [dbo].[PersonAccountRelation]
    FROM [dbo].[PersonAccountRelation]
    JOIN [dbo].[PersonAccountRelationKind]
      ON [dbo].[PersonAccountRelation].[Code] = [dbo].[PersonAccountRelationKind].[Code]
    WHERE [dbo].[PersonAccountRelation].[Id] = @Id
      AND [dbo].[PersonAccountRelationKind].[Code] = @Code
      AND [dbo].[PersonAccountRelationKind].[Required] = 0

    IF @@ROWCOUNT = 0
    BEGIN
      RAISERROR('Cannot delete a required Relation', 16, 1);
      RETURN 1;
    END

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
