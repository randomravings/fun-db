CREATE VIEW [model].[AccountManager]
  AS
SELECT
  [Person].[Ssn],
  [Person].[FirstName],
  [Person].[LastName],
  [Account].[AccountNo],
  [Account].[Balance]
FROM
  [dbo].[Person]
  JOIN [dbo].[PersonAccountRelation]
    ON [Person].[Id] = [PersonAccountRelation].[PersonId]
  JOIN [dbo].[PersonAccountRelationKind]
    ON [PersonAccountRelation].[Code] = [PersonAccountRelationKind].[Code]
  JOIN [dbo].[Account]
    ON [PersonAccountRelation].[AccountId] = [Account].[Id]
WHERE
  [PersonAccountRelation].[Code] = 'MNGR';
