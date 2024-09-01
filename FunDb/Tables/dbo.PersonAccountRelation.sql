/* PersonAccountRelation table */
CREATE TABLE [dbo].[PersonAccountRelation]
(
  [Id] UNIQUEIDENTIFIER NOT NULL,
  [PersonId] UNIQUEIDENTIFIER NOT NULL,
  [AccountId] UNIQUEIDENTIFIER NOT NULL,
  [Code] CHAR(4) NOT NULL,
  [SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
  [SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd])
)
WITH (
  SYSTEM_VERSIONING = ON(
    HISTORY_TABLE = [dbo].[PersonAccountRelation_HISTORY],
    DATA_CONSISTENCY_CHECK = ON
  )
);
GO

/* Primary Key only one type of relation ship per account per type */
ALTER TABLE [dbo].[PersonAccountRelation]
  ADD CONSTRAINT [PK_PersonAccountRelation]
  PRIMARY KEY ([Id]);
GO

/* Alternative Key for side cart table relations */
CREATE UNIQUE NONCLUSTERED INDEX [AK_PersonAccountRelation]
  ON [dbo].[PersonAccountRelation] ([Id], [Code]);
GO

/* Person foreign key */
ALTER TABLE [dbo].[PersonAccountRelation]
  ADD CONSTRAINT [FK_PersonAccountRelation_Person]
  FOREIGN KEY ([PersonId])
  REFERENCES [dbo].[Person]([Id]);
GO

/* Account foreign key */
ALTER TABLE [dbo].[PersonAccountRelation]
  ADD CONSTRAINT [FK_PersonAccountRelation_Account]
  FOREIGN KEY ([AccountId])
  REFERENCES [dbo].[Account]([Id]);
GO

/* PersonAccountRelationKind foreign key */
ALTER TABLE [dbo].[PersonAccountRelation]
  ADD CONSTRAINT [FK_PersonAccountRelation_PersonAccountRelationKind]
  FOREIGN KEY ([Code])
  REFERENCES [dbo].[PersonAccountRelationKind]([Code]);
GO

/* Non overlapping relations */
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UniquePersonAccountRelation]
  ON [dbo].[PersonAccountRelation] ([PersonId], [AccountId])
  WHERE [Code] IN ('POWN', 'COWN', 'EMPL');
GO
