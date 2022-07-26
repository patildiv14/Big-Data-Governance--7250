
/****** Object:  Database [Class_MetaData]    Script Date: 4/9/2022 3:08:10 PM ******/

CREATE DATABASE [Class_MetaData]


USE [Class_MetaData]
GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Attribute](
	[AttributeId] [int] NOT NULL,
	[AttributeName] [varchar](45) NOT NULL,
	[AttributeType] [varchar](45) NULL,
	[DatabaseName] [varchar](45) NOT NULL,
	[EntityName] [varchar](45) NOT NULL,
	[AttributeDataType_AttributeDataTypeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[AttributeDataType]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[AttributeDataType](
	[AttributeDataTypeId] [int] NOT NULL,
	[AttributeDataTypeValue] [varchar](45) NULL,
	[AttributeDataTypeRange] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeDataTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[BusinessTerm]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[BusinessTerm](
	[BusinessID] [int] NOT NULL,
	[BusinessTerms] [varchar](45) NOT NULL,
	[BusinessTermsDescription] [varchar](800) NULL,
	[DataType] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[BusinessTerm_has_Attribute]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[BusinessTerm_has_Attribute](
	[BusinessTerm_BusinessID] [int] NOT NULL,
	[Attribute_AttributeId] [int] NOT NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[Database]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Database](
	[DatabaseId] [int] NOT NULL,
	[DatabaseName] [varchar](45) NOT NULL,
	[DbOwner] [varchar](45) NULL,
	[DbSize] [float] NULL,
	[DbCreationDate] [date] NULL,
	[NoofUsers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DatabaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[Database_has_Attribute]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Database_has_Attribute](
	[Database_DatabaseId] [int] NOT NULL,
	[Attribute_AttributeId] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Table [dbo].[Entitiy]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Entitiy](
	[EntitiyId] [int] NOT NULL,
	[EntitiyName] [varchar](45) NOT NULL,
	[EntitiyCreationDate] [date] NULL,
	[EntitiyDescription] [varchar](200) NULL,
	[EntitiyCreatedBy] [varchar](45) NULL,
	[DatabaseName] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EntitiyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[Entitiy_has_Attribute]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Entitiy_has_Attribute](
	[Entitiy_EntitiyId] [int] NOT NULL,
	[Attribute_AttributeId] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Table [dbo].[Entitiy_has_Database]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Entitiy_has_Database](
	[Entitiy_EntitiyId] [int] NOT NULL,
	[Database_DatabaseId] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Table [dbo].[Entitiy_has_Relations]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Entitiy_has_Relations](
	[Entitiy_EntitiyId] [int] NOT NULL,
	[Relations_RelationID] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Table [dbo].[Relations]    Script Date: 4/9/2022 3:08:11 PM ******/

CREATE TABLE [dbo].[Relations](
	[RelationID] [int] NOT NULL,
	[EntityName1] [varchar](45) NOT NULL,
	[Relation] [varchar](1000) NOT NULL,
	[EntityName2] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


---Data Insertion Queries for Bridge Tables. Run this queeries after you import the data from excel.

--[BusinessTerm_has_Attribute]
Truncate Table [dbo].[BusinessTerm_has_Attribute];
Insert into [BusinessTerm_has_Attribute] 
select A.BusinessID, B.AttributeId from BusinessTerm A
join Attribute B
on A.BusinessTerms = B.AttributeName;

--[Database_has_Attribute]
Truncate Table [dbo].[Database_has_Attribute];
Insert into [Database_has_Attribute] 
select A.DatabaseId, B.AttributeId  from [Database] A
join Attribute B
on A.DatabaseName = B.DatabaseName;

--[dbo].[Entitiy_has_Attribute]
Truncate Table [dbo].Entitiy_has_Attribute;
Insert into [Entitiy_has_Attribute] 
select A.EntitiyId, B.AttributeId  from [Entitiy] A
join Attribute B
on A.EntitiyName = B.EntityName;

--[dbo].[Entitiy_has_Database]
Truncate Table [dbo].Entitiy_has_Database;
Insert into Entitiy_has_Database 
select A.EntitiyId, B.DatabaseId  from [Entitiy] A
join [Database] B
on A.DatabaseName = B.DatabaseName;

--[dbo].[Entitiy_has_Relations]
Truncate Table [dbo].Entitiy_has_Relations;
Insert into Entitiy_has_Relations 
select A.EntitiyId, B.RelationID  from [Entitiy] A
join [Relations] B
on A.EntitiyName = B.EntityName1
join [Entitiy] C
on B.EntityName2 = C.EntitiyName
where A.EntitiyName != C.EntitiyName;



