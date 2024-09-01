/* Static Data */
MERGE INTO [dbo].[PersonAccountRelationKind] AS t
USING (VALUES
  ('POWN', 'Primary Owner', 1),
  ('COWN', 'Co Owner', 0),
  ('BENE', 'Beneficiary', 0),
  ('EMPL', 'Associated Employee', 1),
  ('MNGR', 'Managing Employee', 0)
) AS s ([Code], [Name], [Required])
ON t.[Code] = s.[Code]
WHEN MATCHED THEN
  UPDATE SET
    [Name] = s.[Name],
    [Required] = s.[Required]
WHEN NOT MATCHED THEN
  INSERT ([Code], [Name], [Required])
  VALUES (s.[Code], s.[Name], s.[Required])
;
GO

/* Customers */
EXEC [model].[CreatePerson] '100000001', 'John', 'Doe';
EXEC [model].[CreatePerson] '100000002', 'Jane', 'Smith';
EXEC [model].[CreatePerson] '100000003', 'Alice', 'Wonderland';
EXEC [model].[CreatePerson] '100000004', 'Bob', 'Marley';
EXEC [model].[CreatePerson] '100000005', 'Charlie', 'Brown';
EXEC [model].[CreatePerson] '100000006', 'Daisy', 'Duck';
EXEC [model].[CreatePerson] '100000007', 'Allan', 'Buck';
GO

/* Employees */
EXEC [model].[CreatePerson] '200000001', 'Eve', 'Harrington';
EXEC [model].[CreatePerson] '200000002', 'Frank', 'Sinatra';
GO

/* Accounts */
EXEC [model].[CreateAccount] '0000000001', '200000001', '100000001';
EXEC [model].[CreateAccount] '0000000002', '200000001', '100000001';
EXEC [model].[CreateAccount] '0000000003', '200000001', '100000002';
EXEC [model].[CreateAccount] '0000000004', '200000001', '100000003';
EXEC [model].[CreateAccount] '0000000005', '200000001', '100000004';
EXEC [model].[CreateAccount] '0000000006', '200000002', '100000005';
EXEC [model].[CreateAccount] '0000000007', '200000002', '100000005';
EXEC [model].[CreateAccount] '0000000008', '200000002', '100000006';
EXEC [model].[CreateAccount] '0000000009', '200000002', '100000007';
EXEC [model].[CreateAccount] '0000000010', '200000001', '100000007';
GO

/* Add some money into the accounts ... */
EXEC [model].[UpdateAccountBalance] '0000000001', 1000;
EXEC [model].[UpdateAccountBalance] '0000000002', 2000;
EXEC [model].[UpdateAccountBalance] '0000000003', 3000;
EXEC [model].[UpdateAccountBalance] '0000000004', 4000;
EXEC [model].[UpdateAccountBalance] '0000000005', 5000;
EXEC [model].[UpdateAccountBalance] '0000000006', 6000;
EXEC [model].[UpdateAccountBalance] '0000000007', 7000;
EXEC [model].[UpdateAccountBalance] '0000000008', 8000;
EXEC [model].[UpdateAccountBalance] '0000000009', 9000;
EXEC [model].[UpdateAccountBalance] '0000000010', 10000;
GO

/* Account Co-Owners and share */
EXEC [model].[CreateAccountCoOwner] '100000002', '0000000001', 1;
EXEC [model].[CreateAccountCoOwner] '100000003', '0000000001', 1;
EXEC [model].[UpdateAccountShare] '100000001','0000000001', 2;
GO

/* Account Beneficiaries */
EXEC [model].[CreateAccountBeneficiary] '100000004', '0000000001';
GO

/* Account Managers */
EXEC [model].[CreateAccountManager] '200000002', '0000000002';
GO
