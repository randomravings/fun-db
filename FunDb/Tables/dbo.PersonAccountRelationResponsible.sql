/* Share of ownership of a person in an account. */
CREATE TABLE [dbo].[PersonAccountRelationResponsible]
(
  [Id] UNIQUEIDENTIFIER NOT NULL,
  [PersonAccountRelationId] UNIQUEIDENTIFIER NOT NULL,
  [PersonAccountRelationCode] CHAR(4) NOT NULL,
  [ReviewDate] DATE NOT NULL,
  [SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
  [SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd])
)
WITH (
  SYSTEM_VERSIONING = ON(
    HISTORY_TABLE = [dbo].[PersonAccountRelationResponsible_HISTORY],
    DATA_CONSISTENCY_CHECK = ON
  )
);
GO

/* Primary Key */
ALTER TABLE [dbo].[PersonAccountRelationResponsible]
  ADD CONSTRAINT [PK_PersonAccountRelationResponsible]
  PRIMARY KEY ([PersonAccountRelationId], [PersonAccountRelationCode]);
GO

/* Ensure that the code is valid */
ALTER TABLE [dbo].[PersonAccountRelationResponsible]
  ADD CONSTRAINT [CK_PersonAccountRelationResponsible_Code]
  CHECK ([PersonAccountRelationCode] = 'EMPL');
GO

/* PersonAccountRelation foreign key, Delete if parent is deleted */
ALTER TABLE [dbo].[PersonAccountRelationResponsible]
  ADD CONSTRAINT [FK_PersonAccountRelationResponsible_PersonAccountRelation]
  FOREIGN KEY ([PersonAccountRelationId], [PersonAccountRelationCode])
  REFERENCES [dbo].[PersonAccountRelation] ([Id], [Code])
  ON DELETE CASCADE;
GO