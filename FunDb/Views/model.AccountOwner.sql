CREATE VIEW [model].[AccountOwner]
  AS
SELECT
  [Person].[Ssn],
  [Person].[FirstName],
  [Person].[LastName],
  [Account].[AccountNo],
  [Account].[Balance],
  [PersonAccountRelationKind].[Code] AS [RelationCode],
  [PersonAccountRelationKind].[Name] AS [Relation],
  CONVERT(DECIMAL(5, 2), ROUND((
      CONVERT(FLOAT, [PersonAccountRelationOwnership].[Share]) /
      SUM([PersonAccountRelationOwnership].[Share]) OVER (PARTITION BY [Account].[Id])
    ) * 100,
    2
  )) AS [Share]
FROM
  [dbo].[Person]
  JOIN [dbo].[PersonAccountRelation]
    ON [Person].[Id] = [PersonAccountRelation].[PersonId]
  JOIN [dbo].[PersonAccountRelationKind]
    ON [PersonAccountRelation].[Code] = [PersonAccountRelationKind].[Code]
  JOIN [dbo].[PersonAccountRelationOwnership]
    ON [PersonAccountRelation].[Id] = [PersonAccountRelationOwnership].[PersonAccountRelationId]
  JOIN [dbo].[Account]
    ON [PersonAccountRelation].[AccountId] = [Account].[Id]
WHERE
      [PersonAccountRelation].[Code] = 'POWN'
  OR  [PersonAccountRelation].[Code] = 'COWN';
