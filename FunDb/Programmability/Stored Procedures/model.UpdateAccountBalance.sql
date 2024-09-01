CREATE PROCEDURE [model].[UpdateAccountBalance]
  @AccountNo CHAR(10),
  @Balance DECIMAL(38, 5)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    DECLARE @Id UNIQUEIDENTIFIER = NULL;
  
    EXEC [dbo].[GetAccountId] @AccountNo, @Id OUTPUT;

    UPDATE [dbo].[Account]
    SET [Balance] = @Balance
    WHERE [Id] = @Id
      AND [Balance] <> @Balance;

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