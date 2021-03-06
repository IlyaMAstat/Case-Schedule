USE [master]
GO
/****** Object:  Database [Schedule]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Teacher]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[TeacherDiscipline]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Discipline]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  View [dbo].[TeachDisc]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[ClassNum]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Class]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  View [dbo].[ClassView]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Schedule]    Script Date: 22.03.2022 3:25:14 AM ******/
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
	[CabinetNum] [int] NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[WarningLessons]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  View [dbo].[ScheduleView]    Script Date: 22.03.2022 3:25:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScheduleView]
AS
SELECT        dbo.Schedule.WeekId, dbo.Schedule.Num AS LessonNum, dbo.Class.Title AS ClassTitle, dbo.Schedule.CabinetNum, dbo.TeacherDiscipline.Id AS TeachDiscId, dbo.TeacherDiscipline.TeacherID, 
                         dbo.TeacherDiscipline.DisciplineID, dbo.Teacher.Surname + ' ' + LEFT(dbo.Teacher.Name, 1) + '. ' + LEFT(dbo.Teacher.Patronymic, 1) + '.' AS FIO, dbo.Discipline.Title
FROM            dbo.Schedule INNER JOIN
                         dbo.TeacherDiscipline ON dbo.Schedule.TeacherDisciplineID = dbo.TeacherDiscipline.Id INNER JOIN
                         dbo.Teacher ON dbo.TeacherDiscipline.TeacherID = dbo.Teacher.Id INNER JOIN
                         dbo.Discipline ON dbo.TeacherDiscipline.DisciplineID = dbo.Discipline.Id INNER JOIN
                         dbo.Class ON dbo.Schedule.ClassID = dbo.Class.Id
GO
/****** Object:  Table [dbo].[CabDisc]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Cabinet]    Script Date: 22.03.2022 3:25:14 AM ******/
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
/****** Object:  Table [dbo].[Week]    Script Date: 22.03.2022 3:25:14 AM ******/
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
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (3, 2, N'2А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (5, 3, N'3А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (6, 3, N'3Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (7, 4, N'4А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (9, 5, N'5А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (11, 6, N'6А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (13, 7, N'7А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (15, 8, N'8А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (16, 8, N'8Б')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (17, 9, N'9А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (19, 10, N'10А')
INSERT [dbo].[Class] ([Id], [ClassID], [Title]) VALUES (21, 11, N'11А')
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

INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (700, 1, 1, 1, 118, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (701, 1, 2, 1, 73, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (702, 1, 3, 1, 73, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (703, 1, 4, 1, 1, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (708, 1, 1, 3, 2, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (709, 1, 2, 3, 36, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (710, 1, 3, 3, 3, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (711, 1, 4, 3, 28, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (712, 1, 5, 3, 135, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (718, 1, 1, 5, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (719, 1, 2, 5, 28, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (720, 1, 3, 5, 31, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (721, 1, 4, 5, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (723, 1, 1, 6, 13, 212)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (724, 1, 2, 6, 93, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (725, 1, 3, 6, 108, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (726, 1, 4, 6, 10, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (727, 1, 5, 6, 123, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (729, 1, 2, 7, 94, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (730, 1, 3, 7, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (731, 1, 4, 7, 33, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (732, 1, 5, 7, 21, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (738, 1, 1, 9, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (739, 1, 2, 9, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (740, 1, 3, 9, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (741, 1, 4, 9, 43, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (742, 1, 5, 9, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (743, 1, 6, 9, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (750, 1, 1, 11, 45, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (751, 1, 2, 11, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (752, 1, 3, 11, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (753, 1, 4, 11, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (754, 1, 5, 11, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (755, 1, 6, 11, 18, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (762, 1, 1, 13, 50, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (763, 1, 2, 13, 31, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (764, 1, 3, 13, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (765, 1, 4, 13, 60, 404)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (766, 1, 5, 13, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (767, 1, 6, 13, 62, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (776, 1, 1, 15, 19, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (777, 1, 2, 15, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (778, 1, 3, 15, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (779, 1, 4, 15, 62, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (780, 1, 5, 15, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (781, 1, 6, 15, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (782, 1, 7, 15, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (783, 1, 1, 16, 56, 112)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (784, 1, 2, 16, 50, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (785, 1, 3, 16, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (786, 1, 4, 16, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (787, 1, 5, 16, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (788, 1, 6, 16, 44, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (789, 1, 7, 16, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (791, 1, 2, 17, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (792, 1, 3, 17, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (793, 1, 4, 17, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (794, 1, 5, 17, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (795, 1, 6, 17, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (796, 1, 7, 17, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (804, 1, 1, 19, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (805, 1, 2, 19, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (806, 1, 3, 19, 67, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (807, 1, 4, 19, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (808, 1, 5, 19, 30, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (809, 1, 6, 19, 58, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (810, 1, 7, 19, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (818, 1, 1, 21, 54, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (819, 1, 2, 21, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (820, 1, 3, 21, 55, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (821, 1, 4, 21, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (822, 1, 5, 21, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (823, 1, 6, 21, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (832, 2, 1, 1, 31, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (833, 2, 2, 1, 133, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (834, 2, 3, 1, 88, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (835, 2, 4, 1, 31, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (840, 2, 1, 3, 90, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (841, 2, 2, 3, 33, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (842, 2, 3, 3, 2, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (843, 2, 4, 3, 135, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (850, 2, 1, 5, 107, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (851, 2, 2, 5, 2, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (852, 2, 3, 5, 3, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (853, 2, 4, 5, 122, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (855, 2, 1, 6, 123, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (856, 2, 2, 6, 15, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (857, 2, 3, 6, 9, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (858, 2, 4, 6, 15, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (860, 2, 1, 7, 20, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (861, 2, 2, 7, 20, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (862, 2, 3, 7, 15, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (863, 2, 4, 7, 20, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (870, 2, 1, 9, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (871, 2, 2, 9, 41, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (872, 2, 3, 9, 35, 105)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (873, 2, 4, 9, 61, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (874, 2, 5, 9, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (875, 2, 6, 9, 22, 303)
GO
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (882, 2, 1, 11, 59, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (883, 2, 2, 11, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (884, 2, 3, 11, 61, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (885, 2, 4, 11, 59, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (886, 2, 5, 11, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (887, 2, 6, 11, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (894, 2, 1, 13, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (895, 2, 2, 13, 28, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (896, 2, 3, 13, 30, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (897, 2, 4, 13, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (898, 2, 5, 13, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (899, 2, 6, 13, 30, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (908, 2, 1, 15, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (909, 2, 2, 15, 30, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (910, 2, 3, 15, 64, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (911, 2, 4, 15, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (912, 2, 5, 15, 60, 407)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (913, 2, 6, 15, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (915, 2, 1, 16, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (916, 2, 2, 16, 54, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (917, 2, 3, 16, 56, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (918, 2, 4, 16, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (919, 2, 5, 16, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (920, 2, 6, 16, 64, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (922, 2, 1, 17, 27, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (923, 2, 2, 17, 45, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (924, 2, 3, 17, 49, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (925, 2, 4, 17, 26, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (926, 2, 5, 17, 54, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (927, 2, 6, 17, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (937, 2, 2, 19, 19, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (938, 2, 3, 19, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (939, 2, 4, 19, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (940, 2, 5, 19, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (941, 2, 6, 19, 62, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (942, 2, 7, 19, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (950, 2, 1, 21, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (951, 2, 2, 21, 66, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (952, 2, 3, 21, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (953, 2, 4, 21, 37, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (954, 2, 5, 21, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (955, 2, 6, 21, 70, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (956, 2, 7, 21, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (964, 3, 1, 1, 1, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (965, 3, 2, 1, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (966, 3, 3, 1, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (967, 3, 4, 1, 28, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (972, 3, 1, 3, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (973, 3, 2, 3, 135, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (974, 3, 3, 3, 5, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (975, 3, 4, 3, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (976, 3, 5, 3, 36, 202)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (982, 3, 1, 5, 3, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (983, 3, 2, 5, 29, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (984, 3, 3, 5, 29, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (985, 3, 4, 5, 122, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (986, 3, 5, 5, 137, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (987, 3, 1, 6, 138, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (988, 3, 2, 6, 11, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (989, 3, 3, 6, 93, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (990, 3, 4, 6, 13, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (991, 3, 5, 6, 15, 204)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (992, 3, 1, 7, 38, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (993, 3, 2, 7, 36, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (994, 3, 3, 7, 139, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (995, 3, 4, 7, 2, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (996, 3, 5, 7, 28, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1002, 3, 1, 9, 49, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1003, 3, 2, 9, 41, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1004, 3, 3, 9, 44, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1005, 3, 4, 9, 41, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1006, 3, 5, 9, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1007, 3, 6, 9, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1014, 3, 1, 11, 31, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1015, 3, 2, 11, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1016, 3, 3, 11, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1017, 3, 4, 11, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1018, 3, 5, 11, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1019, 3, 6, 11, 43, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1026, 3, 1, 13, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1027, 3, 2, 13, 18, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1028, 3, 3, 13, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1029, 3, 4, 13, 31, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1030, 3, 5, 13, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1031, 3, 6, 13, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1032, 3, 7, 13, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1040, 3, 1, 15, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1041, 3, 2, 15, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1042, 3, 3, 15, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1043, 3, 4, 15, 45, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1044, 3, 5, 15, 56, 408)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1045, 3, 6, 15, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1047, 3, 1, 16, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1048, 3, 2, 16, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1049, 3, 3, 16, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1050, 3, 4, 16, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1051, 3, 5, 16, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1052, 3, 6, 16, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1053, 3, 7, 16, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1054, 3, 1, 17, 44, 310)
GO
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1055, 3, 2, 17, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1056, 3, 3, 17, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1057, 3, 4, 17, 55, 108)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1058, 3, 5, 17, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1059, 3, 6, 17, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1060, 3, 7, 17, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1068, 3, 1, 19, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1069, 3, 2, 19, 58, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1070, 3, 3, 19, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1071, 3, 4, 19, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1072, 3, 5, 19, 64, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1073, 3, 6, 19, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1074, 3, 7, 19, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1082, 3, 1, 21, 62, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1083, 3, 2, 21, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1084, 3, 3, 21, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1085, 3, 4, 21, 32, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1086, 3, 5, 21, 19, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1087, 3, 6, 21, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1088, 3, 7, 21, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1096, 4, 1, 1, 31, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1097, 4, 2, 1, 1, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1098, 4, 3, 1, 133, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1099, 4, 4, 1, 73, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1104, 4, 1, 3, 135, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1105, 4, 2, 3, 105, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1106, 4, 3, 3, 90, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1107, 4, 4, 3, 90, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1108, 4, 5, 3, 5, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1114, 4, 1, 5, 107, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1115, 4, 2, 5, 5, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1116, 4, 3, 5, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1117, 4, 4, 5, 92, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1118, 4, 5, 5, 29, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1119, 4, 1, 6, 93, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1120, 4, 2, 6, 108, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1121, 4, 3, 6, 138, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1122, 4, 4, 6, 13, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1123, 4, 5, 6, 93, 206)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1124, 4, 1, 7, 20, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1125, 4, 2, 7, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1126, 4, 3, 7, 124, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1127, 4, 4, 7, 2, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1128, 4, 5, 7, 40, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1134, 4, 1, 9, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1135, 4, 2, 9, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1136, 4, 3, 9, 16, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1137, 4, 4, 9, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1138, 4, 5, 9, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1139, 4, 6, 9, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1146, 4, 1, 11, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1147, 4, 2, 11, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1148, 4, 3, 11, 44, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1149, 4, 4, 11, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1150, 4, 5, 11, 61, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1151, 4, 6, 11, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1158, 4, 1, 13, 35, 104)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1159, 4, 2, 13, 60, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1160, 4, 3, 13, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1161, 4, 4, 13, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1162, 4, 5, 13, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1163, 4, 6, 13, 62, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1164, 4, 7, 13, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1172, 4, 1, 15, 18, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1173, 4, 2, 15, 27, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1174, 4, 3, 15, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1175, 4, 4, 15, 58, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1176, 4, 5, 15, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1177, 4, 6, 15, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1178, 4, 7, 15, 32, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1179, 4, 1, 16, 49, 105)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1180, 4, 2, 16, 54, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1181, 4, 3, 16, 62, 112)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1182, 4, 4, 16, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1183, 4, 5, 16, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1184, 4, 6, 16, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1185, 4, 7, 16, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1186, 4, 1, 17, 55, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1187, 4, 2, 17, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1188, 4, 3, 17, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1189, 4, 4, 17, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1190, 4, 5, 17, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1191, 4, 6, 17, 55, 108)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1192, 4, 7, 17, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1200, 4, 1, 19, 64, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1201, 4, 2, 19, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1202, 4, 3, 19, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1203, 4, 4, 19, 60, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1204, 4, 5, 19, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1205, 4, 6, 19, 26, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1206, 4, 7, 19, 22, 303)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1214, 4, 1, 21, 66, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1215, 4, 2, 21, 23, 304)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1216, 4, 3, 21, 71, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1217, 4, 4, 21, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1218, 4, 5, 21, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1219, 4, 6, 21, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1220, 4, 7, 21, 37, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1228, 5, 1, 1, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1229, 5, 2, 1, 73, 201)
GO
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1230, 5, 3, 1, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1231, 5, 4, 1, 133, 201)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1236, 5, 1, 3, 105, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1237, 5, 2, 3, 11, 211)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1238, 5, 3, 3, 135, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1239, 5, 4, 3, 135, 203)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1246, 5, 1, 5, 92, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1247, 5, 2, 5, 92, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1248, 5, 3, 5, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1249, 5, 4, 5, 30, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1250, 5, 5, 5, 31, 205)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1251, 5, 1, 6, 111, 212)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1252, 5, 2, 6, 9, 212)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1253, 5, 3, 6, 15, 212)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1254, 5, 4, 6, 13, 212)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1256, 5, 1, 7, 124, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1257, 5, 2, 7, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1258, 5, 3, 7, 94, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1259, 5, 4, 7, 21, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1260, 5, 5, 7, 124, 207)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1266, 5, 1, 9, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1267, 5, 2, 9, 39, 101)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1268, 5, 3, 9, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1269, 5, 4, 9, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1270, 5, 5, 9, 21, 302)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1278, 5, 1, 11, 31, 110)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1279, 5, 2, 11, 59, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1280, 5, 3, 11, 52, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1281, 5, 4, 11, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1282, 5, 5, 11, 25, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1283, 5, 6, 11, 43, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1290, 5, 1, 13, 34, 102)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1291, 5, 2, 13, 43, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1292, 5, 3, 13, 50, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1293, 5, 4, 13, 24, 305)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1294, 5, 5, 13, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1295, 5, 6, 13, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1304, 5, 1, 15, 40, 308)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1305, 5, 2, 15, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1306, 5, 3, 15, 62, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1307, 5, 4, 15, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1308, 5, 5, 15, 56, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1309, 5, 6, 15, 51, 409)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1310, 5, 7, 15, 60, 408)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1311, 5, 1, 16, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1312, 5, 2, 16, 32, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1313, 5, 3, 16, 54, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1314, 5, 4, 16, 36, 307)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1315, 5, 5, 16, 44, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1316, 5, 6, 16, 44, 310)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1318, 5, 1, 17, 29, 111)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1319, 5, 2, 17, 27, 401)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1320, 5, 3, 17, 65, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1321, 5, 4, 17, 48, 109)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1322, 5, 5, 17, 55, 107)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1323, 5, 6, 17, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1324, 5, 7, 17, 33, 306)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1332, 5, 1, 19, 53, 410)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1333, 5, 2, 19, 60, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1334, 5, 3, 19, 19, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1335, 5, 4, 19, 35, 103)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1336, 5, 5, 19, 64, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1337, 5, 6, 19, 17, 412)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1338, 5, 7, 19, 62, 309)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1346, 5, 1, 21, 69, 403)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1347, 5, 2, 21, 20, 301)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1348, 5, 3, 21, 58, 402)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1349, 5, 4, 21, 60, 407)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1350, 5, 5, 21, 47, 311)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1351, 5, 6, 21, 66, 411)
INSERT [dbo].[Schedule] ([Id], [WeekId], [Num], [ClassID], [TeacherDisciplineID], [CabinetNum]) VALUES (1352, 5, 7, 21, 17, 412)
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
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ClassNum"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 119
               Right = 424
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
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Schedule"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "TeacherDiscipline"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 119
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Teacher"
            Begin Extent = 
               Top = 6
               Left = 480
               Bottom = 136
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Discipline"
            Begin Extent = 
               Top = 6
               Left = 692
               Bottom = 136
               Right = 866
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Class"
            Begin Extent = 
               Top = 6
               Left = 904
               Bottom = 119
               Right = 1078
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 780
         Width = 1215
         Width = 1215
         Width = 1125
         Width = 960
         Width = 1125
         Width = 1635
         Width = 1590
         Width = 1020
         Width = 570
         Width = 1020
         Width = 780
         Width = 1500
      End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 8250
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TeacherDiscipline"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 119
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Discipline"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 136
               Right = 636
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
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Schedule"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ClassNum"
            Begin Extent = 
               Top = 6
               Left = 480
               Bottom = 119
               Right = 654
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
