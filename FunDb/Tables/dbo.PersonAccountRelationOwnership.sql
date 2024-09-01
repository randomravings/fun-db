/* Share of ownership of a person in an account. */
CREATE TABLE [dbo].[PersonAccountRelationOwnership]
(
  [Id] UNIQUEIDENTIFIER NOT NULL,
  [PersonAccountRelationId] UNIQUEIDENTIFIER NOT NULL,
  [PersonAccountRelationCode] CHAR(4) NOT NULL,
  [Share] INT NOT NULL,
  [SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
  [SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd])
)
WITH (
  SYSTEM_VERSIONING = ON(
    HISTORY_TABLE = [dbo].[PersonAccountRelationOwnership_HISTORY],
    DATA_CONSISTENCY_CHECK = ON
  )
);
GO

/* Primary Key */
ALTER TABLE [dbo].[PersonAccountRelationOwnership]
  ADD CONSTRAINT [PK_PersonAccountRelationOwnership]
  PRIMARY KEY ([PersonAccountRelationId], [PersonAccountRelationCode]);
GO

/* Ensure that the code is valid */
ALTER TABLE [dbo].[PersonAccountRelationOwnership]
  ADD CONSTRAINT [CK_PersonAccountRelationOwnership_Code]
  CHECK ([PersonAccountRelationCode] IN ('POWN', 'COWN'));
GO

/* PersonAccountRelation foreign key, Delete if parent is deleted */
ALTER TABLE [dbo].[PersonAccountRelationOwnership]
  ADD CONSTRAINT [FK_PersonAccountRelationOwnership_PersonAccountRelation]
  FOREIGN KEY ([PersonAccountRelationId], [PersonAccountRelationCode])
  REFERENCES [dbo].[PersonAccountRelation] ([Id], [Code])
  ON DELETE CASCADE;
GO