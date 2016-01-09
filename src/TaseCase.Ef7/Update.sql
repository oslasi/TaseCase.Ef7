IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK_HistoryRow] PRIMARY KEY ([MigrationId])
    );

GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyStamp] nvarchar(max),
    [Name] nvarchar(256),
    [NormalizedName] nvarchar(256),
    CONSTRAINT [PK_IdentityRole] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [AccessFailedCount] int NOT NULL,
    [ConcurrencyStamp] nvarchar(max),
    [Email] nvarchar(256),
    [EmailConfirmed] bit NOT NULL,
    [LockoutEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset,
    [NormalizedEmail] nvarchar(256),
    [NormalizedUserName] nvarchar(256),
    [PasswordHash] nvarchar(max),
    [PhoneNumber] nvarchar(max),
    [PhoneNumberConfirmed] bit NOT NULL,
    [SecurityStamp] nvarchar(max),
    [TwoFactorEnabled] bit NOT NULL,
    [UserName] nvarchar(256),
    CONSTRAINT [PK_ApplicationUser] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(max),
    [ClaimValue] nvarchar(max),
    [RoleId] nvarchar(450),
    CONSTRAINT [PK_IdentityRoleClaim<string>] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityRoleClaim<string>_IdentityRole_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id])
);

GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(max),
    [ClaimValue] nvarchar(max),
    [UserId] nvarchar(450),
    CONSTRAINT [PK_IdentityUserClaim<string>] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityUserClaim<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id])
);

GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max),
    [UserId] nvarchar(450),
    CONSTRAINT [PK_IdentityUserLogin<string>] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_IdentityUserLogin<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id])
);

GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_IdentityUserRole<string>] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_IdentityUserRole<string>_IdentityRole_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]),
    CONSTRAINT [FK_IdentityUserRole<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id])
);

GO

CREATE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]);

GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

GO

CREATE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'00000000000000_CreateIdentitySchema', N'7.0.0-rc1-16348');

GO

ALTER TABLE [AspNetRoleClaims] DROP CONSTRAINT [FK_IdentityRoleClaim<string>_IdentityRole_RoleId];

GO

ALTER TABLE [AspNetUserClaims] DROP CONSTRAINT [FK_IdentityUserClaim<string>_ApplicationUser_UserId];

GO

ALTER TABLE [AspNetUserLogins] DROP CONSTRAINT [FK_IdentityUserLogin<string>_ApplicationUser_UserId];

GO

ALTER TABLE [AspNetUserRoles] DROP CONSTRAINT [FK_IdentityUserRole<string>_IdentityRole_RoleId];

GO

ALTER TABLE [AspNetUserRoles] DROP CONSTRAINT [FK_IdentityUserRole<string>_ApplicationUser_UserId];

GO

CREATE TABLE [Category] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(max),
    CONSTRAINT [PK_Category] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Product] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(max),
    [Price] decimal(18, 2) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [ProductCategory] (
    [CategoryId] uniqueidentifier NOT NULL,
    [ProductId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_ProductCategory] PRIMARY KEY ([CategoryId], [ProductId]),
    CONSTRAINT [FK_ProductCategory_Category_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ProductCategory_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE
);

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'AspNetUserLogins') AND [c].[name] = N'UserId');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserLogins] DROP CONSTRAINT [' + @var0 + ']');
ALTER TABLE [AspNetUserLogins] ALTER COLUMN [UserId] nvarchar(450) NOT NULL;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'AspNetUserClaims') AND [c].[name] = N'UserId');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserClaims] DROP CONSTRAINT [' + @var1 + ']');
ALTER TABLE [AspNetUserClaims] ALTER COLUMN [UserId] nvarchar(450) NOT NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'AspNetRoleClaims') AND [c].[name] = N'RoleId');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [AspNetRoleClaims] DROP CONSTRAINT [' + @var2 + ']');
ALTER TABLE [AspNetRoleClaims] ALTER COLUMN [RoleId] nvarchar(450) NOT NULL;

GO

ALTER TABLE [AspNetRoleClaims] ADD CONSTRAINT [FK_IdentityRoleClaim<string>_IdentityRole_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE;

GO

ALTER TABLE [AspNetUserClaims] ADD CONSTRAINT [FK_IdentityUserClaim<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

GO

ALTER TABLE [AspNetUserLogins] ADD CONSTRAINT [FK_IdentityUserLogin<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

GO

ALTER TABLE [AspNetUserRoles] ADD CONSTRAINT [FK_IdentityUserRole<string>_IdentityRole_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE;

GO

ALTER TABLE [AspNetUserRoles] ADD CONSTRAINT [FK_IdentityUserRole<string>_ApplicationUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20160108201425_v1', N'7.0.0-rc1-16348');

GO

