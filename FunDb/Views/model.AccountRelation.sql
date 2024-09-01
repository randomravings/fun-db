CREATE VIEW [model].[AccountRelation]
  AS
SELECT
  [Person].[Ssn],
  [Person].[FirstName],
  [Person].[LastName],
  [Account].[AccountNo],
  [Account].[Balance],
  [PersonAccountRelationKind].[Code] AS [RelationCode],
  [PersonAccountRelationKind].[Name] AS [Relation]
FROM
  [dbo].[Person]
  JOIN [dbo].[PersonAccountRelation]
    ON [Person].[Id] = [PersonAccountRelation].[PersonId]
  JOIN [dbo].[PersonAccountRelationKind]
    ON [PersonAccountRelation].[Code] = [PersonAccountRelationKind].[Code]
  JOIN [dbo].[Account]
    ON [PersonAccountRelation].[AccountId] = [Account].[Id]
