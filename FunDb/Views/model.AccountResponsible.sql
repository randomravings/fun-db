CREATE VIEW [model].[AccountResponsible]
  AS
SELECT
  [Person].[Ssn],
  [Person].[FirstName],
  [Person].[LastName],
  [Account].[AccountNo],
  [Account].[Balance],
  [PersonAccountRelationResponsible].[ReviewDate]
FROM
  [dbo].[Person]
  JOIN [dbo].[PersonAccountRelation]
    ON [Person].[Id] = [PersonAccountRelation].[PersonId]
  JOIN [dbo].[PersonAccountRelationKind]
    ON [PersonAccountRelation].[Code] = [PersonAccountRelationKind].[Code]
  JOIN [dbo].[PersonAccountRelationResponsible]
    ON [PersonAccountRelation].[Id] = [PersonAccountRelationResponsible].[PersonAccountRelationId]
  JOIN [dbo].[Account]
    ON [PersonAccountRelation].[AccountId] = [Account].[Id]
WHERE
  [PersonAccountRelation].[Code] = 'EMPL';
