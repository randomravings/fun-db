CREATE PROCEDURE [dbo].[GetAccountId]
  @AccountNo CHAR(10),
  @Id UNIQUEIDENTIFIER OUTPUT
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;
  
  SELECT @Id = [Id] FROM [dbo].[Account] WHERE [AccountNo] = @AccountNo;

  IF @Id IS NULL
  BEGIN
    DECLARE @Message NVARCHAR(100) = 'Account (' + @AccountNo + ') not found'
    RAISERROR(@Message, 16, 1);
    RETURN 1;
  END
  RETURN 0
