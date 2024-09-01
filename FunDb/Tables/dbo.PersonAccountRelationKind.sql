/* 
  PersonAccountRelationKind table is used to store the different kinds of relations between a person and an account.
  For example, a person can be an owner of an account, a co-owner, a beneficiary, etc.
*/  
CREATE TABLE [dbo].[PersonAccountRelationKind]
(
  [Code] CHAR(4) NOT NULL,
  [Name] NVARCHAR(100) NOT NULL,
  [Required] BIT NOT NULL,
  [SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
  [SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd])
)
WITH (
  SYSTEM_VERSIONING = ON (
    HISTORY_TABLE = [dbo].[PersonAccountRelationKind_HISTORY],
    DATA_CONSISTENCY_CHECK = ON
  )
)
GO

/* Primary Key */
ALTER TABLE [dbo].[PersonAccountRelationKind]
  ADD CONSTRAINT [PK_PersonAccountRelationKind]
  PRIMARY KEY ([Code]);
GO


/* Unique Name */
ALTER TABLE [dbo].[PersonAccountRelationKind]
  ADD CONSTRAINT [UQ_PersonAccountRelationKind]
  UNIQUE ([Name]);
GO
