CREATE PROCEDURE [dbo].[GetPersonId]
  @Ssn CHAR(9),
  @Id UNIQUEIDENTIFIER OUTPUT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;
  
  SELECT @Id = [Id] FROM [dbo].[Person] WHERE [Ssn] = @Ssn;

  IF @Id IS NULL
  BEGIN
    DECLARE @Message NVARCHAR(100) = 'Person (' + @Ssn + ') not found'
    RAISERROR(@Message, 16, 1);
    RETURN 1;
  END
  RETURN 0
