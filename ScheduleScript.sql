USE [master]
GO
/****** Object:  Database [Schedule]    Script Date: 28.02.2022 14:42:47 ******/
CREATE DATABASE [Schedule]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Schedule', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Schedule.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Schedule_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Schedule_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Schedule] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Schedule].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Schedule] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Schedule] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Schedule] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Schedule] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Schedule] SET ARITHABORT OFF 
GO
ALTER DATABASE [Schedule] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Schedule] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Schedule] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Schedule] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Schedule] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Schedule] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Schedule] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Schedule] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Schedule] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Schedule] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Schedule] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Schedule] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Schedule] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Schedule] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Schedule] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Schedule] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Schedule] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Schedule] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Schedule] SET  MULTI_USER 
GO
ALTER DATABASE [Schedule] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Schedule] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Schedule] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Schedule] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Schedule] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Schedule] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Schedule] SET QUERY_STORE = OFF
GO
USE [Schedule]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Patronymic] [varchar](50) NOT NULL,
	[PrimTeach] [bit] NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherDiscipline]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherDiscipline](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NOT NULL,
	[DisciplineID] [int] NOT NULL,
 CONSTRAINT [PK_TeacherDiscipline] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discipline]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discipline](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Prim] [bit] NOT NULL,
	[ClassFrom] [int] NOT NULL,
	[ClassTo] [int] NOT NULL,
 CONSTRAINT [PK_Discipline] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TeachDisc]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TeachDisc]
AS
SELECT        dbo.TeacherDiscipline.Id, dbo.TeacherDiscipline.TeacherID, dbo.TeacherDiscipline.DisciplineID, dbo.Teacher.Surname + ' ' + LEFT(dbo.Teacher.Name, 1) + '. ' + LEFT(dbo.Teacher.Patronymic, 1) + '.' AS FIO, dbo.Discipline.Title, 
                         dbo.Teacher.PrimTeach, dbo.Discipline.Prim, dbo.Discipline.ClassFrom, dbo.Discipline.ClassTo
FROM            dbo.Teacher INNER JOIN
                         dbo.TeacherDiscipline ON dbo.Teacher.Id = dbo.TeacherDiscipline.TeacherID INNER JOIN
                         dbo.Discipline ON dbo.TeacherDiscipline.DisciplineID = dbo.Discipline.Id
GO
/****** Object:  Table [dbo].[ClassNum]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassNum](
	[Id] [int] NOT NULL,
	[MaxHours] [int] NOT NULL,
	[MaxLessons] [int] NOT NULL,
 CONSTRAINT [PK_ClassNum] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ClassView]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ClassView]
AS
SELECT        dbo.Class.Id, dbo.Class.ClassID, dbo.Class.Title, dbo.ClassNum.MaxHours, dbo.ClassNum.MaxLessons
FROM            dbo.Class INNER JOIN
                         dbo.ClassNum ON dbo.Class.ClassID = dbo.ClassNum.Id
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WeekId] [int] NOT NULL,
	[Num] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[TeacherDisciplineID] [int] NOT NULL,
	[CabinetNum] [int] NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[WarningLessons]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WarningLessons]
AS
SELECT        dbo.Class.Title, COUNT(dbo.Schedule.Num) AS CountLessons, dbo.ClassNum.MaxHours
FROM            dbo.Class INNER JOIN
                         dbo.ClassNum ON dbo.Class.ClassID = dbo.ClassNum.Id INNER JOIN
                         dbo.Schedule ON dbo.Class.Id = dbo.Schedule.ClassID
GROUP BY dbo.Class.Title, dbo.ClassNum.MaxHours
HAVING        (COUNT(dbo.Schedule.Num) > dbo.ClassNum.MaxHours)
GO
/****** Object:  Table [dbo].[CabDisc]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CabDisc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisciplineID] [int] NOT NULL,
	[CabinetNum] [int] NOT NULL,
 CONSTRAINT [PK_CabDisc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cabinet]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cabinet](
	[Num] [int] NOT NULL,
	[Sport] [bit] NOT NULL,
	[Trud] [bit] NOT NULL,
	[Info] [bit] NOT NULL,
	[Prim] [bit] NOT NULL,
 CONSTRAINT [PK_Cabinet] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Week]    Script Date: 28.02.2022 14:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Week](
	[Id] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Week] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CabDisc] ON 

INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (1, 9, 101)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (2, 9, 102)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (3, 18, 103)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (4, 18, 104)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (5, 18, 105)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (6, 18, 106)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (7, 21, 107)
INSERT [dbo].[CabDisc] ([Id], [DisciplineID], [CabinetNum]) VALUES (8, 21, 108)
SET IDENTITY_INSERT [dbo].[CabDisc] OFF
GO
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (101, 1, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (102, 1, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (103, 0, 1, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (104, 0, 1, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (105, 0, 1, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (106, 0, 1, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (107, 0, 0, 1, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (108, 0, 0, 1, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (109, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (110, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (111, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (112, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (201, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (202, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (203, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (204, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (205, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (206, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (207, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (208, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (209, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (210, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (211, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (212, 0, 0, 0, 1)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (301, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (302, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (303, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (304, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (305, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (306, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (307, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (308, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (309, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (310, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (311, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (312, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (401, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (402, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (403, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (404, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (405, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (406, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (407, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (408, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (409, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (410, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (411, 0, 0, 0, 0)
INSERT [dbo].[Cabinet] ([Num], [Sport], [Trud], [Info], [Prim]) VALUES (412, 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (1, 1, N'1А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (2, 1, N'1Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (3, 2, N'2А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (4, 2, N'2Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (5, 3, N'3А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (6, 3, N'3Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (7, 4, N'4А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (8, 4, N'4Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (9, 5, N'5А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (10, 5, N'5Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (11, 6, N'6А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (12, 6, N'6Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (13, 7, N'7А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (14, 7, N'7Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (15, 8, N'8А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (16, 8, N'8Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (17, 9, N'9А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (18, 9, N'9Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (19, 10, N'10А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (20, 10, N'10Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (21, 11, N'11А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (22, 11, N'11Б')
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (1, 20, 4)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (2, 23, 5)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (3, 23, 5)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (4, 23, 5)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (5, 29, 6)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (6, 30, 6)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (7, 32, 7)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (8, 33, 7)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (9, 33, 7)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (10, 34, 7)
INSERT [dbo].[ClassNum] ([Id], [MaxHours], [MaxLessons]) VALUES (11, 34, 7)
GO
SET IDENTITY_INSERT [dbo].[Discipline] ON 

INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (1, N'Чистописание', 1, 1, 1)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (2, N'Чтение', 1, 1, 4)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (3, N'Труд', 1, 1, 4)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (4, N'Природоведение', 1, 1, 5)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (5, N'Математика', 1, 1, 6)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (6, N'Музыка', 0, 1, 7)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (7, N'ИЗО', 0, 1, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (8, N'Русский язык', 1, 1, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (9, N'Физкультура', 0, 1, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (10, N'Родной язык', 0, 2, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (11, N'ОРКСЭ', 0, 4, 5)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (12, N'Ин. Яз.', 0, 4, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (13, N'Граждановедение', 0, 5, 7)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (14, N'Краеведение', 0, 5, 7)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (15, N'История', 0, 5, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (16, N'Литература', 0, 5, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (17, N'ОБЖ', 0, 5, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (18, N'Технология', 0, 5, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (19, N'География', 0, 6, 10)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (20, N'Биология', 0, 6, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (21, N'Информатика', 0, 6, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (22, N'Обществознание', 0, 6, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (23, N'Черчение', 0, 7, 8)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (24, N'Алгебра', 0, 7, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (25, N'Геометрия', 0, 7, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (26, N'Физика', 0, 7, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (27, N'Химия', 0, 8, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (28, N'Естествознание', 0, 10, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (29, N'Основы экономики', 0, 10, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (30, N'Правоведение', 0, 10, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (31, N'Философия', 0, 10, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (32, N'Экология', 0, 10, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (33, N'Астрономия', 0, 11, 11)
INSERT [dbo].[Discipline] ([Id], [Title], [Prim], [ClassFrom], [ClassTo]) VALUES (34, N'НВП', 0, 11, 11)
SET IDENTITY_INSERT [dbo].[Discipline] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1, 1, 1, 1, 77, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (2, 1, 2, 1, 10, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (3, 1, 1, 2, 95, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (4, 1, 2, 18, 34, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (5, 1, 1, 3, 104, 208)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (6, 1, 1, 4, 120, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (9, 1, 1, 5, 114, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (10, 1, 3, 1, 88, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (11, 1, 4, 1, 74, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (24, 2, 1, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (25, 2, 2, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (26, 2, 3, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (27, 2, 4, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (28, 3, 1, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (29, 3, 2, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (30, 3, 3, 1, 76, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (31, 3, 4, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (36, 5, 1, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (37, 5, 2, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (38, 5, 3, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (39, 5, 4, 1, 77, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (42, 4, 2, 1, 76, 206)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (1, N'Лебедева', N'Анастасия', N'Тимофеевна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (2, N'Громова', N'Диана', N'Романовна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (3, N'Безруков', N'Марк', N'Михайлович', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (4, N'Кузьмина', N'Амалия', N'Андреевна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (5, N'Бычкова', N'Вероника', N'Данииловна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (6, N'Нечаев', N'Владислав', N'Робертович', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (7, N'Голубева', N'Алиса', N'Данииловна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (8, N'Власова', N'Мария', N'Степановна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (9, N'Григорьева', N'Алиса', N'Станиславовна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (10, N'Захаров', N'Никита', N'Львович', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (11, N'Иванова', N'Ника', N'Германовна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (12, N'Алексеев', N'Виктор', N'Леонидович', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (13, N'Кузьмин', N'Пётр', N'Ярославович', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (14, N'Чернышева', N'Мелания', N'Фёдоровна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (15, N'Зайцева', N'Ярослава', N'Егоровна', 1)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (16, N'Степанова', N'Ева', N'Матвеевна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (17, N'Зиновьев', N'Дмитрий', N'Артёмович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (18, N'Крылов', N'Дмитрий', N'Захарович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (19, N'Бочаров', N'Даниил', N'Леонидович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (20, N'Березина', N'Софья', N'Владимировна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (21, N'Иванова', N'Кира', N'Матвеевна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (22, N'Семенова', N'Ева', N'Сергеевна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (23, N'Астафьев', N'Ярослав', N'Романович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (24, N'Павлов', N'Юрий', N'Александрович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (25, N'Савельев', N'Арсений', N'Кириллович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (26, N'Соколова', N'Виктория', N'Романовна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (27, N'Жуков', N'Никита', N'Егорович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (28, N'Иванов', N'Артём', N'Тимофеевич', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (29, N'Фадеева', N'Алия', N'Тимофеевна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (30, N'Новиков', N'Алексей', N'Дмитриевич', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (31, N'Ефимов', N'Арсений', N'Олегович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (32, N'Дроздов', N'Георгий', N'Денисович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (33, N'Никитин', N'Фёдор', N'Германович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (34, N'Соловьев', N'Савва', N'Максимович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (35, N'Никитина', N'Василиса', N'Максимовна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (36, N'Иванов', N'Денис', N'Александрович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (37, N'Гришин', N'Максим', N'Сергеевич', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (38, N'Данилова', N'Анна', N'Александровна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (39, N'Субботина', N'Серафима', N'Егоровна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (40, N'Федорова', N'Милана', N'Максимовна', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (41, N'Хохлов', N'Михаил', N'Сергеевич', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (42, N'Бондарев', N'Виталий', N'Ярославович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (43, N'Спиридонов', N'Иван', N'Максимович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (44, N'Соболев', N'Иван', N'Иванович', 0)
INSERT [dbo].[Teacher] ([Id], [Surname], [Name], [Patronymic], [PrimTeach]) VALUES (45, N'Кузнецов', N'Сергей', N'Никитич', 0)
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[TeacherDiscipline] ON 

INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (1, 1, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (2, 2, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (3, 3, 7)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (4, 4, 9)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (5, 5, 10)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (6, 6, 11)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (7, 7, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (8, 8, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (9, 9, 7)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (10, 10, 9)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (11, 11, 10)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (12, 12, 11)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (13, 13, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (14, 14, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (15, 15, 7)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (16, 16, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (17, 16, 20)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (18, 16, 19)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (19, 16, 27)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (20, 17, 12)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (21, 18, 12)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (22, 19, 12)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (23, 20, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (24, 21, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (25, 22, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (26, 22, 24)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (27, 22, 25)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (28, 23, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (29, 23, 7)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (30, 24, 7)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (31, 24, 6)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (32, 25, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (33, 25, 10)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (34, 26, 9)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (35, 26, 18)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (36, 27, 10)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (37, 27, 31)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (38, 28, 11)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (39, 28, 9)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (40, 29, 12)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (41, 30, 13)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (42, 30, 30)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (43, 31, 14)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (44, 32, 15)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (45, 32, 22)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (46, 32, 11)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (47, 33, 16)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (48, 34, 17)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (49, 34, 18)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (50, 34, 23)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (51, 35, 19)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (52, 35, 21)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (53, 36, 20)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (54, 36, 27)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (55, 37, 21)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (56, 38, 23)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (57, 38, 30)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (58, 39, 24)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (59, 39, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (60, 40, 25)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (61, 40, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (62, 41, 26)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (63, 41, 33)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (64, 42, 27)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (65, 42, 20)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (66, 43, 28)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (67, 43, 32)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (68, 44, 29)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (69, 44, 22)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (70, 45, 30)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (71, 45, 34)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (72, 45, 13)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (73, 1, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (74, 2, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (75, 3, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (76, 4, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (77, 5, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (78, 6, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (79, 7, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (80, 8, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (81, 9, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (82, 10, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (83, 11, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (84, 12, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (85, 13, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (86, 14, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (87, 15, 1)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (88, 1, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (89, 2, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (90, 3, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (91, 4, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (92, 5, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (93, 6, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (94, 7, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (95, 8, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (96, 9, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (97, 10, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (98, 11, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (99, 12, 2)
GO
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (100, 13, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (101, 14, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (102, 15, 2)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (103, 1, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (104, 2, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (105, 3, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (106, 4, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (107, 5, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (108, 6, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (109, 7, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (110, 8, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (111, 9, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (112, 10, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (113, 11, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (114, 12, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (115, 13, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (116, 14, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (117, 15, 3)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (118, 1, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (119, 2, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (120, 3, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (121, 4, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (122, 5, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (123, 6, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (124, 7, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (125, 8, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (126, 9, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (127, 10, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (128, 11, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (129, 12, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (130, 13, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (131, 14, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (132, 15, 4)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (133, 1, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (134, 2, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (135, 3, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (136, 4, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (137, 5, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (138, 6, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (139, 7, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (140, 8, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (141, 9, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (142, 10, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (143, 11, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (144, 12, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (145, 13, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (146, 14, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (147, 15, 5)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (148, 1, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (149, 2, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (150, 3, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (151, 4, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (152, 5, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (153, 6, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (154, 7, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (155, 8, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (156, 9, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (157, 10, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (158, 11, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (159, 12, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (160, 13, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (161, 14, 8)
INSERT [dbo].[TeacherDiscipline] ([Id], [TeacherID], [DisciplineID]) VALUES (162, 15, 8)
SET IDENTITY_INSERT [dbo].[TeacherDiscipline] OFF
GO
INSERT [dbo].[Week] ([Id], [Title]) VALUES (1, N'Понедельник')
INSERT [dbo].[Week] ([Id], [Title]) VALUES (2, N'Вторник')
INSERT [dbo].[Week] ([Id], [Title]) VALUES (3, N'Среда')
INSERT [dbo].[Week] ([Id], [Title]) VALUES (4, N'Четверг')
INSERT [dbo].[Week] ([Id], [Title]) VALUES (5, N'Пятница')
GO
ALTER TABLE [dbo].[Cabinet] ADD  CONSTRAINT [DF_Cabinet_Sport]  DEFAULT ((0)) FOR [Sport]
GO
ALTER TABLE [dbo].[Cabinet] ADD  CONSTRAINT [DF_Cabinet_Trud]  DEFAULT ((0)) FOR [Trud]
GO
ALTER TABLE [dbo].[Cabinet] ADD  CONSTRAINT [DF_Cabinet_Info]  DEFAULT ((0)) FOR [Info]
GO
ALTER TABLE [dbo].[Cabinet] ADD  CONSTRAINT [DF_Cabinet_Prim]  DEFAULT ((0)) FOR [Prim]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF_Teacher_PrimTeach]  DEFAULT ((0)) FOR [PrimTeach]
GO
ALTER TABLE [dbo].[CabDisc]  WITH CHECK ADD  CONSTRAINT [FK_CabDisc_Cabinet] FOREIGN KEY([CabinetNum])
REFERENCES [dbo].[Cabinet] ([Num])
GO
ALTER TABLE [dbo].[CabDisc] CHECK CONSTRAINT [FK_CabDisc_Cabinet]
GO
ALTER TABLE [dbo].[CabDisc]  WITH CHECK ADD  CONSTRAINT [FK_CabDisc_Discipline] FOREIGN KEY([DisciplineID])
REFERENCES [dbo].[Discipline] ([Id])
GO
ALTER TABLE [dbo].[CabDisc] CHECK CONSTRAINT [FK_CabDisc_Discipline]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_ClassNum] FOREIGN KEY([ClassID])
REFERENCES [dbo].[ClassNum] ([Id])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_ClassNum]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Cabinet] FOREIGN KEY([CabinetNum])
REFERENCES [dbo].[Cabinet] ([Num])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Cabinet]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([Id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Class]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_TeacherDiscipline] FOREIGN KEY([TeacherDisciplineID])
REFERENCES [dbo].[TeacherDiscipline] ([Id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_TeacherDiscipline]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Week] FOREIGN KEY([WeekId])
REFERENCES [dbo].[Week] ([Id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Week]
GO
ALTER TABLE [dbo].[TeacherDiscipline]  WITH CHECK ADD  CONSTRAINT [FK_TeacherDiscipline_Discipline] FOREIGN KEY([DisciplineID])
REFERENCES [dbo].[Discipline] ([Id])
GO
ALTER TABLE [dbo].[TeacherDiscipline] CHECK CONSTRAINT [FK_TeacherDiscipline_Discipline]
GO
ALTER TABLE [dbo].[TeacherDiscipline]  WITH CHECK ADD  CONSTRAINT [FK_TeacherDiscipline_Teacher] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([Id])
GO
ALTER TABLE [dbo].[TeacherDiscipline] CHECK CONSTRAINT [FK_TeacherDiscipline_Teacher]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Class"
            Begin Extent = 
               Top = 208
               Left = 29
               Bottom = 321
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ClassNum"
            Begin Extent = 
               Top = 175
               Left = 264
               Bottom = 288
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ClassView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ClassView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[27] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Teacher"
            Begin Extent = 
               Top = 182
               Left = 36
               Bottom = 334
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TeacherDiscipline"
            Begin Extent = 
               Top = 223
               Left = 256
               Bottom = 335
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Discipline"
            Begin Extent = 
               Top = 193
               Left = 457
               Bottom = 340
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 960
         Width = 1125
         Width = 2925
         Width = 1755
         Width = 600
         Width = 1020
         Width = 570
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TeachDisc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TeachDisc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[12] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Class"
            Begin Extent = 
               Top = 209
               Left = 242
               Bottom = 322
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ClassNum"
            Begin Extent = 
               Top = 208
               Left = 449
               Bottom = 321
               Right = 623
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Schedule"
            Begin Extent = 
               Top = 160
               Left = 13
               Bottom = 327
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WarningLessons'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WarningLessons'
GO
USE [master]
GO
ALTER DATABASE [Schedule] SET  READ_WRITE 
GO
