CREATE PROCEDURE [dbo].[GetPersonAccountRelationId]
  @Ssn CHAR(9),
  @AccountNo CHAR(10),
  @Code CHAR(4),
  @Id UNIQUEIDENTIFIER OUTPUT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  SELECT @Id = [PersonAccountRelation].[Id]
  FROM [dbo].[PersonAccountRelation]
  JOIN [dbo].[Person]
    ON [Person].[Id] = [PersonAccountRelation].[PersonId]
  JOIN [dbo].[Account]
    ON [PersonAccountRelation].[AccountId] = [Account].[Id]
  WHERE [Person].[Ssn] = @Ssn
    AND [Account].[AccountNo] = @AccountNo
    AND [PersonAccountRelation].[Code] = @Code;

  IF @Id IS NULL
  BEGIN
    DECLARE @Message NVARCHAR(255) = 'Person (' + @Ssn + ') to Account (' + @AccountNo + ') Relation (' + @Code + ') not found'
    RAISERROR(@Message, 16, 1);
    RETURN 1;
  END
  RETURN 0
