CREATE PROCEDURE [model].[CreateAccount]
  @AccountNo CHAR(10),
  @Responsible CHAR(9),
  @Owner CHAR(9)
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;
  BEGIN TRY

    INSERT INTO [dbo].[Account] ([Id], [AccountNo], [Balance])
    VALUES (NEWID(), @AccountNo, 0);

    DECLARE @DefaultReviewDate DATE = DATEADD(yy, 1, GETDATE());
    EXEC [dbo].[CreateAccountResponsibleEmployee] @Responsible, @AccountNo, @DefaultReviewDate;

    DECLARE @DefaultShare INT = 1;
    EXEC [dbo].[CreateAccountPrimaryOwner] @Owner, @AccountNo , @DefaultShare;

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
