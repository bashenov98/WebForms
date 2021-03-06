USE [JYSAN]
GO
/****** Object:  Table [dbo].[Entities]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entities](
	[EntityID] [int] IDENTITY(1,1) NOT NULL,
	[Bin] [varchar](12) NOT NULL,
	[CreatedAt] [date] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[ChangedAt] [date] NULL,
	[ChangedBy] [varchar](20) NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Entities] PRIMARY KEY CLUSTERED 
(
	[EntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[Iin] [varchar](12) NOT NULL,
	[CreatedAt] [date] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[ChangedAt] [date] NULL,
	[ChangedBy] [varchar](20) NULL,
	[FirstName] [varchar](20) NOT NULL,
	[MiddleName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[EntityID] [int] NOT NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Entities] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entities] ([EntityID])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Entities]
GO
/****** Object:  StoredProcedure [dbo].[EntityCreateOrUpdate]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EntityCreateOrUpdate]
@EntityID int,
@Bin varchar(20),
@Name varchar(20),
@CreatedBy varchar(20)
AS
BEGIN
IF (@EntityID=0)
	BEGIN
	INSERT INTO Entities(Bin, CreatedAt, CreatedBy, Name)
	VALUES(@Bin, GETDATE(), @CreatedBy, @Name)
	END
ELSE
	BEGIN
	UPDATE Entities
	SET
		Bin = @Bin,
		ChangedAt = GETDATE(),
		ChangedBy = @CreatedBy,
		Name = @Name
	END
END
GO
/****** Object:  StoredProcedure [dbo].[EntityDeleteById]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EntityDeleteById]
@EntityID int
AS
	BEGIN
	DELETE FROM Entities
	WHERE EntityID = @EntityID
	END
GO
/****** Object:  StoredProcedure [dbo].[EntityViewAll]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EntityViewAll]
AS
	BEGIN
	SELECT * FROM Entities
	END
GO
/****** Object:  StoredProcedure [dbo].[EntityViewById]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EntityViewById]
@EntityID int
AS
	BEGIN
	SELECT * FROM Entities
	WHERE EntityID = @EntityID
	END
GO
/****** Object:  StoredProcedure [dbo].[PeopleViewAll]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PeopleViewAll]
AS
	BEGIN
	SELECT *
	FROM People
	END
GO
/****** Object:  StoredProcedure [dbo].[PersonCreateOrUpdate]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonCreateOrUpdate]
@PersonID int,
@Iin varchar(12),
@FirstName varchar(20),
@MiddleName varchar(20),
@LastName varchar(20),
@EntityID int,
@CreatedBy varchar(20)
AS
BEGIN
IF(@PersonID=0)
	BEGIN
	INSERT INTO People(Iin, CreatedAt, CreatedBy, FirstName, MiddleName, LastName, EntityID)
	VALUES (@Iin, GETDATE(), @CreatedBy, @FirstName, @MiddleName, @LastName, @EntityID)
	END
ELSE
	BEGIN
	UPDATE People
	SET
		Iin = @Iin,
		ChangedAt = GETDATE(),
		ChangedBy = @CreatedBy,
		FirstName = @FirstName,
		MiddleName = @MiddleName,
		LastName = @LastName,
		EntityID = @EntityID
	WHERE PersonID = @PersonID
	END

END
GO
/****** Object:  StoredProcedure [dbo].[PersonDeleteById]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonDeleteById]
@PersonID int
AS
	BEGIN
	DELETE FROM People 
	WHERE PersonID = @PersonID
	END
GO
/****** Object:  StoredProcedure [dbo].[PersonViewById]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PersonViewById]
@PersonID int
AS
	BEGIN
	SELECT * FROM People 
	WHERE PersonID = @PersonID
	END
GO
/****** Object:  StoredProcedure [dbo].[ViewContactsOfEntity]    Script Date: 25.08.2020 12:21:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ViewContactsOfEntity]
@EntityID int
AS
	BEGIN
	SELECT * FROM People
	WHERE EntityID = @EntityID
	END
GO
