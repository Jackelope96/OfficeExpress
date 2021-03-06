USE [master]
GO
/****** Object:  Database [OfficeExpressTuckShop]    Script Date: 24/07/2019 07:46:30 ******/
CREATE DATABASE [OfficeExpressTuckShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Data', FILENAME = N'C:\Data\OfficeExpressTuckShop.mdf' , SIZE = 13312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240KB )
 LOG ON 
( NAME = N'Log', FILENAME = N'C:\Data\OfficeExpressTuckShop.ldf' , SIZE = 14912KB , MAXSIZE = 2048GB , FILEGROWTH = 10240KB )
GO
ALTER DATABASE [OfficeExpressTuckShop] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OfficeExpressTuckShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET RECOVERY FULL 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET  MULTI_USER 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OfficeExpressTuckShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OfficeExpressTuckShop] SET QUERY_STORE = OFF
GO
USE [OfficeExpressTuckShop]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [OfficeExpressTuckShop]
GO
/****** Object:  User [SINGULAR\jvanzyl]    Script Date: 24/07/2019 07:46:30 ******/
CREATE USER [SINGULAR\jvanzyl] FOR LOGIN [SINGULAR\jvanzyl] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Singular\Domain Users]    Script Date: 24/07/2019 07:46:30 ******/
CREATE USER [Singular\Domain Users] FOR LOGIN [SINGULAR\Domain Users] WITH DEFAULT_SCHEMA=[Singular\Domain Users]
GO
ALTER ROLE [db_owner] ADD MEMBER [SINGULAR\jvanzyl]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [SINGULAR\jvanzyl]
GO
/****** Object:  Schema [Checks]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [Checks]
GO
/****** Object:  Schema [CmdProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [CmdProcs]
GO
/****** Object:  Schema [DelProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [DelProcs]
GO
/****** Object:  Schema [Fn]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [Fn]
GO
/****** Object:  Schema [GetProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [GetProcs]
GO
/****** Object:  Schema [InsProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [InsProcs]
GO
/****** Object:  Schema [RptProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [RptProcs]
GO
/****** Object:  Schema [UpdProcs]    Script Date: 24/07/2019 07:46:30 ******/
CREATE SCHEMA [UpdProcs]
GO
/****** Object:  UserDefinedFunction [Fn].[DateMonthEnd]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Fn].[DateMonthEnd]
   (@dtDate DateTime)
RETURNS DateTime
AS
BEGIN
  DECLARE @dtReturnDate DateTime

	SET @dtReturnDate = DateAdd(d, -1, fn.DateMonthStart(DATEAdd(M,1,@dtDate)))
  RETURN @dtReturnDate
END
GO
/****** Object:  UserDefinedFunction [Fn].[DateMonthStart]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [Fn].[DateMonthStart]
   (@dtDate DateTime)
RETURNS DateTime
AS
BEGIN
  DECLARE @dtReturnDate DateTime
  SET @dtReturnDate = CONVERT(VARCHAR(11), DATEADD( DD, -1 * (SELECT DAY(@dtDate) -1), @dtDate),106)
  RETURN @dtReturnDate
END
GO
/****** Object:  UserDefinedFunction [Fn].[DateNoTime]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC fn.DateNoTime ('20081006 12:21')
*/

CREATE  FUNCTION [Fn].[DateNoTime]
	(
		@Date DateTime
	)
RETURNS DateTime
AS
BEGIN
	RETURN CONVERT(DateTime, CONVERT(VARCHAR(11), @Date, 111))
END
GO
/****** Object:  UserDefinedFunction [Fn].[FormatDate]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

	SELECT dbo.FormatDate('20050509 15:30', 'dd-MMM-yy HH:mm')

*/



CREATE FUNCTION [Fn].[FormatDate] 
(@date datetime, @format varchar(50))  
	RETURNS VARCHAR(50) AS  
BEGIN 

DECLARE @pos AS INTEGER
DECLARE @char AS VARCHAR(1)

-- Replace Year
	SET @pos = CHARINDEX('yyyy', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 4, DATENAME(yyyy, @date))
		SET @pos = CHARINDEX('yyyy', @format)
	END
	
	SET @pos = CHARINDEX('yy', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 2, RIGHT(DATENAME(yyyy, @date) ,2))
		--PRINT @format
		SET @pos = CHARINDEX('yy', @format)
	END

-- Replace Month
	SET @pos = CHARINDEX('MMMM', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 4, DATENAME(month, @date))
		SET @pos = CHARINDEX('MMMM', @format)
	END
	
	SET @pos = CHARINDEX('MMM', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 3, LEFT(DATENAME(month, @date), 3))
		SET @pos = CHARINDEX('MMM', @format)
	END

	SET @pos = CHARINDEX('MM', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 2, RIGHT(('0' + CAST(DATEPART(month, @date) AS VARCHAR(2))), 2))
		SET @pos = CHARINDEX('MM', @format)
	END
	
	SET @pos = CHARINDEX('M', @format)
	WHILE @pos > 0
	BEGIN
-- account for MArch and deceMBer
		SET @char = SUBSTRING(@format, @pos + 1, 1)
		IF (@char <> 'a') AND (@char <> 'b')
			BEGIN
				SET @format = STUFF(@format, @pos, 1, CAST(DATEPART(month, @date) AS VARCHAR(2)))
				SET @pos = CHARINDEX('M', @format)
			END
		ELSE
			BEGIN
				SET @pos = CHARINDEX('M', @format, @pos + 1)
			END
	END
-- Replace Day
	SET @pos = CHARINDEX('dddd', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 4, DATENAME(weekday, @date))
		SET @pos = CHARINDEX('dddd', @format)
	END
	
	SET @pos = CHARINDEX('ddd', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 3, LEFT(DATENAME(weekday, @date), 3))
		SET @pos = CHARINDEX('ddd', @format)
	END

	SET @pos = CHARINDEX('dd', @format)
	WHILE @pos > 0
	BEGIN
		SET @format = STUFF(@format, @pos, 2, RIGHT(('0' + DATENAME(day, @date)), 2))
		SET @pos = CHARINDEX('dd', @format)
	END

	SET @pos = CHARINDEX('d', @format)
	WHILE @pos > 0
	BEGIN
		-- account for DEcember, sunDAy --> saturDAy, weDNesday
		SET @char = SUBSTRING(@format, @pos + 1, 1)
		IF (@char <> 'e') AND (@char <> 'a') AND (@char <> 'n')
			BEGIN
				SET @format = STUFF(@format, @pos, 1, CAST(DATEPART(day, @date) AS VARCHAR(2)))
				SET @pos = CHARINDEX('d', @format)
			END
		ELSE
			BEGIN
				SET @pos = CHARINDEX('d', @format, @pos + 1)
			END
	END


IF @format = '--' OR @format = '  ' OR @format = '//' SET @format = 'No Date' 

RETURN @format

END
GO
/****** Object:  UserDefinedFunction [Fn].[HasAccess]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Fn].[HasAccess]
(
	@UserID Int,
	@SectionName VarChar(100),
	@SecurityRole VarChar(100)
)
RETURNS Bit
BEGIN
		DECLARE @HasAccess Bit = 0

		SELECT @HasAccess = 1
		FROM SecurityRoles sr
		INNER JOIN SecurityGroupRoles sgr ON sr.SecurityRoleID = sgr.SecurityRoleID
		INNER JOIN SecurityGroupUsers sgu ON sgr.SecurityGroupID = sgu.SecurityGroupID
		WHERE UserID = @UserID
			AND sr.SectionName = @SectionName
			AND sr.SecurityRole = @SecurityRole
			
		RETURN @HasAccess
END
GO
/****** Object:  Table [dbo].[Order]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[RequiredDate] [date] NOT NULL,
	[ProcessStatusID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 24/07/2019 07:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[ProductPrice] [decimal](18, 2) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DeleteStatus] [bit] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductQuantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[OrderDetailsID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OrderDetails_1] PRIMARY KEY CLUSTERED 
(
	[OrderDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TuckshopSales]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TuckshopSales]
AS
SELECT        dbo.Product.ProductName, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.[Order].OrderDate, dbo.Category.CategoryName
FROM            dbo.OrderDetails INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID INNER JOIN
                         dbo.[Order] ON dbo.OrderDetails.OrderID = dbo.[Order].OrderID INNER JOIN
                         dbo.Category ON dbo.Product.CategoryID = dbo.Category.CategoryID AND dbo.Product.CategoryID = dbo.Category.CategoryID
WHERE        (dbo.[Order].ProcessStatusID = 2)
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[InventoryQuantity] [int] NULL,
	[CurrentInventoryQuantity] [int] NULL,
	[InventoryItemCost] [decimal](18, 0) NULL,
	[InventoryTypeID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Tuckshop_CurrentInventory]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tuckshop_CurrentInventory]
AS
SELECT top 1 with TIES ProductName,Inventory.InventoryQuantity,Inventory.CurrentInventoryQuantity,Inventory.InventoryTypeID,Inventory.InventoryItemCost,Inventory.ProductID,Inventory.InventoryID,Inventory.CreatedDate
FROM dbo.Inventory INNER JOIN
                         dbo.Product ON dbo.Inventory.ProductID = dbo.Product.ProductID 
						 where Product.DeleteStatus = 0 AND Product.CategoryID <> 13

order by (ROW_NUMBER() OVER (Partition BY Inventory.ProductID ORDER BY Inventory.CreatedDate DESC))
GO
/****** Object:  View [dbo].[Tuckshop_PurchasedStock]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Tuckshop_PurchasedStock]
as
 SELECT top 1 with TIES ProductName,Inventory.InventoryQuantity,Inventory.CurrentInventoryQuantity,Inventory.InventoryTypeID,Inventory.InventoryItemCost,Inventory.ProductID,Inventory.InventoryID, Inventory.CreatedDate FROM dbo.Inventory INNER JOIN
                         dbo.Product ON dbo.Inventory.ProductID = dbo.Product.ProductID 
						 where Product.DeleteStatus = 0 AND Product.CategoryID <> 13 AND InventoryTypeID = 1
order by (ROW_NUMBER() OVER (Partition BY Inventory.ProductID ORDER BY Inventory.CreatedDate DESC))
GO
/****** Object:  View [dbo].[v_myCart]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_myCart]
AS
SELECT        dbo.[Order].OrderID, dbo.[Order].UserID, dbo.OrderDetails.ProductID, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.OrderDetails.OrderDetailsID, dbo.Product.ProductName, dbo.[Order].OrderDate, 
                         dbo.[Order].ProcessStatusID
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderDetails ON dbo.[Order].OrderID = dbo.OrderDetails.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID
GO
/****** Object:  Table [dbo].[Users]    Script Date: 24/07/2019 07:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varbinary](500) NOT NULL,
	[Salt] [binary](16) NOT NULL,
	[RFID] [varchar](100) NULL,
	[PasswordChangeDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[FirstTimeLogin] [bit] NOT NULL,
	[EmailAddress] [varchar](100) NOT NULL,
	[DeductID] [int] NULL,
	[ResetState] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_UserOrderList]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_UserOrderList]
AS
SELECT        dbo.[Order].OrderID, dbo.Product.ProductName, dbo.Users.FirstName, dbo.Users.LastName, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.[Order].OrderDate, dbo.[Order].RequiredDate, 
                         dbo.[Order].ProcessStatusID, dbo.Product.ProductID
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderDetails ON dbo.[Order].OrderID = dbo.OrderDetails.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID INNER JOIN
                         dbo.Users ON dbo.[Order].UserID = dbo.Users.UserID
GO
/****** Object:  View [dbo].[v_EditIInventory]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_EditIInventory]
AS
SELECT        dbo.Product.ProductName, dbo.Inventory.InventoryQuantity, dbo.Inventory.CurrentInventoryQuantity, dbo.Inventory.InventoryType, dbo.Inventory.InventoryItemCost, dbo.Inventory.ProductID, dbo.Inventory.InventoryID
FROM            dbo.Product INNER JOIN
                         dbo.Inventory ON dbo.Product.ProductID = dbo.Inventory.ProductID
GO
/****** Object:  View [dbo].[v_Sales]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Sales]
AS
SELECT        dbo.Product.ProductName, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.[Order].OrderDate
FROM            dbo.OrderDetails INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID INNER JOIN
                         dbo.[Order] ON dbo.OrderDetails.OrderID = dbo.[Order].OrderID
GO
/****** Object:  View [dbo].[v_stockprofit]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_stockprofit]
AS
SELECT        dbo.Inventory.ProductID, dbo.Product.ProductPrice, dbo.Inventory.CurrentInventoryQuantity, dbo.Inventory.InventoryItemCost, dbo.Inventory.CreatedDate
FROM            dbo.Inventory INNER JOIN
                         dbo.Product ON dbo.Inventory.ProductID = dbo.Product.ProductID
GO
/****** Object:  Table [dbo].[DeductStatus]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeductStatus](
	[DeductID] [int] NOT NULL,
	[DeductStatus] [nchar](10) NULL,
 CONSTRAINT [PK_DeductStatus] PRIMARY KEY CLUSTERED 
(
	[DeductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documents](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [varchar](255) NOT NULL,
	[DocumentData] [varbinary](max) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[DocumentHash] [binary](32) NOT NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAttachments]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAttachments](
	[EmailAttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[EmailID] [int] NOT NULL,
	[AttachmentName] [varchar](255) NOT NULL,
	[AddressOfAttachment] [varchar](512) NOT NULL,
	[AttachmentData] [varbinary](max) NULL,
 CONSTRAINT [PK_EmailAttachments] PRIMARY KEY CLUSTERED 
(
	[EmailAttachmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Emails]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emails](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[ToEmailAddress] [varchar](1000) NOT NULL,
	[FromEmailAddress] [varchar](100) NOT NULL,
	[FriendlyFrom] [varchar](50) NOT NULL,
	[Subject] [varchar](255) NOT NULL,
	[Body] [varchar](max) NOT NULL,
	[CCEmailAddresses] [varchar](1000) NOT NULL,
	[CreatedBy] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DateToSend] [datetime] NULL,
	[SentDate] [datetime] NULL,
	[NotSentError] [varchar](1024) NOT NULL,
	[Ignore] [bit] NOT NULL,
	[BulkInd] [bit] NOT NULL,
 CONSTRAINT [PK_Emails] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryType]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryType](
	[InventoryTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeDescription] [nchar](10) NOT NULL,
 CONSTRAINT [PK_InventoryType] PRIMARY KEY CLUSTERED 
(
	[InventoryTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[InvoiceTotal] [decimal](18, 2) NULL,
	[Notes] [nchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageID] [int] NOT NULL,
	[Language] [varchar](30) NOT NULL,
	[CultureCode] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Languages] UNIQUE NONCLUSTERED 
(
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalisationKeys]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalisationKeys](
	[LocalisationKeyID] [int] IDENTITY(1,1) NOT NULL,
	[Key] [varchar](100) NOT NULL,
	[DefaultValue] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_LocalisationKeys] PRIMARY KEY CLUSTERED 
(
	[LocalisationKeyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalisationValues]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalisationValues](
	[LocalisationValueID] [int] IDENTITY(1,1) NOT NULL,
	[LocalisationKeyID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[Value] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_LocalisationValues] PRIMARY KEY CLUSTERED 
(
	[LocalisationValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginAudits]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginAudits](
	[LoginAuditID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[MachineName] [varchar](128) NOT NULL,
	[WindowsName] [varchar](128) NOT NULL,
	[LoginType] [int] NOT NULL,
	[RefreshedRolesInd] [bit] NOT NULL,
 CONSTRAINT [PK_LoginAudits] PRIMARY KEY CLUSTERED 
(
	[LoginAuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessStatus]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessStatus](
	[ProcessStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessStatusDescription] [nchar](10) NULL,
 CONSTRAINT [PK_ProcessStatus] PRIMARY KEY CLUSTERED 
(
	[ProcessStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityGroupRoles]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityGroupRoles](
	[SecurityGroupRoleID] [int] IDENTITY(1,1) NOT NULL,
	[SecurityGroupID] [int] NOT NULL,
	[SecurityRoleID] [int] NOT NULL,
 CONSTRAINT [PK_SecurityGroupRoles] PRIMARY KEY CLUSTERED 
(
	[SecurityGroupRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityGroups]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityGroups](
	[SecurityGroupID] [int] IDENTITY(1,1) NOT NULL,
	[SecurityGroup] [varchar](50) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_SecurityGroups] PRIMARY KEY CLUSTERED 
(
	[SecurityGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityGroupUsers]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityGroupUsers](
	[SecurityGroupUserID] [int] IDENTITY(1,1) NOT NULL,
	[SecurityGroupID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_SecurityGroupUsers] PRIMARY KEY CLUSTERED 
(
	[SecurityGroupUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityRoles]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityRoles](
	[SecurityRoleID] [int] IDENTITY(1,1) NOT NULL,
	[SectionName] [varchar](50) NOT NULL,
	[SecurityRole] [varchar](50) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[RowTimestamp] [timestamp] NOT NULL,
	[AutoGeneratedInd] [bit] NOT NULL,
 CONSTRAINT [PK_SecurityRoles] PRIMARY KEY CLUSTERED 
(
	[SecurityRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SecurityRolesUnique] UNIQUE NONCLUSTERED 
(
	[SectionName] ASC,
	[SecurityRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerProgramLock]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerProgramLock](
	[ServerProgramLockID] [int] NOT NULL,
	[LastRunTime] [datetime] NOT NULL,
	[InstanceName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ServerProgramLock] PRIMARY KEY CLUSTERED 
(
	[ServerProgramLockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerProgramLog]    Script Date: 24/07/2019 07:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerProgramLog](
	[ServerProgramLogID] [int] IDENTITY(1,1) NOT NULL,
	[ServerProgramID] [int] NOT NULL,
	[Message] [varchar](512) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ServerProgramProgress] PRIMARY KEY CLUSTERED 
(
	[ServerProgramLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerPrograms]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerPrograms](
	[ServerProgramID] [int] NOT NULL,
	[ServerProgram] [varchar](50) NOT NULL,
	[Info] [varbinary](max) NULL,
	[ActiveInd] [bit] NOT NULL,
 CONSTRAINT [PK_ServerProgramTypes] PRIMARY KEY CLUSTERED 
(
	[ServerProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[SystemSettingID] [int] IDENTITY(1,1) NOT NULL,
	[SystemSetting] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SystemSettings] PRIMARY KEY CLUSTERED 
(
	[SystemSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettingValues]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettingValues](
	[SystemSettingValueID] [int] IDENTITY(1,1) NOT NULL,
	[SystemSettingID] [int] NOT NULL,
	[PropertyName] [varchar](50) NOT NULL,
	[PropertyValue] [sql_variant] NULL,
	[PropertyBytes] [varbinary](max) NULL,
 CONSTRAINT [PK_SystemSettingValues] PRIMARY KEY CLUSTERED 
(
	[SystemSettingValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebErrors]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebErrors](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Page] [varchar](100) NOT NULL,
	[Browser] [varchar](100) NOT NULL,
	[StackTrace] [varchar](1024) NOT NULL,
	[Error] [varchar](1024) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[OtherData] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_WebErrors] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebGridInfo]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebGridInfo](
	[WebGridInfoID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueKey] [varchar](100) NOT NULL,
 CONSTRAINT [PK_WebGridInfo] PRIMARY KEY CLUSTERED 
(
	[WebGridInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebGridUserInfo]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebGridUserInfo](
	[WebGridUserInfoID] [int] IDENTITY(1,1) NOT NULL,
	[WebGridInfoID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[LayoutInfo] [varchar](max) NOT NULL,
	[LayoutName] [varchar](100) NOT NULL,
	[LayoutType] [int] NOT NULL,
	[ParentLayoutID] [int] NULL,
 CONSTRAINT [PK_WebGridUserInfo] PRIMARY KEY CLUSTERED 
(
	[WebGridUserInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_EmailAttachments_EmailID]    Script Date: 24/07/2019 07:46:33 ******/
CREATE NONCLUSTERED INDEX [IX_EmailAttachments_EmailID] ON [dbo].[EmailAttachments]
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [DF_Emails_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [DF_Emails_Ignore]  DEFAULT ((0)) FOR [Ignore]
GO
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [DF_Emails_BulkInd]  DEFAULT ((0)) FOR [BulkInd]
GO
ALTER TABLE [dbo].[LoginAudits] ADD  CONSTRAINT [DF_LoginAudits_RefreshedRolesInd]  DEFAULT ((0)) FOR [RefreshedRolesInd]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Products_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SecurityRoles] ADD  CONSTRAINT [DF_SecurityRoles_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_FirstTimeLogin]  DEFAULT ((1)) FOR [FirstTimeLogin]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_EmailAddress]  DEFAULT ('') FOR [EmailAddress]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Deduct]  DEFAULT ((0)) FOR [DeductID]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_ResetState]  DEFAULT ((1)) FOR [ResetState]
GO
ALTER TABLE [dbo].[WebErrors] ADD  CONSTRAINT [DF_WebErrors_OtherData]  DEFAULT ('') FOR [OtherData]
GO
ALTER TABLE [dbo].[WebGridUserInfo] ADD  CONSTRAINT [DF_WebGridUserInfo_LayoutType]  DEFAULT ((1)) FOR [LayoutType]
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [FK_Documents_Users]
GO
ALTER TABLE [dbo].[EmailAttachments]  WITH CHECK ADD  CONSTRAINT [FK_EmailAttachments_Emails] FOREIGN KEY([EmailID])
REFERENCES [dbo].[Emails] ([EmailID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailAttachments] CHECK CONSTRAINT [FK_EmailAttachments_Emails]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_InventoryType] FOREIGN KEY([InventoryTypeID])
REFERENCES [dbo].[InventoryType] ([InventoryTypeID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_InventoryType]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Order1] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Order1]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Users]
GO
ALTER TABLE [dbo].[LocalisationValues]  WITH CHECK ADD  CONSTRAINT [FK_LocalisationValues_Languages] FOREIGN KEY([LanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[LocalisationValues] CHECK CONSTRAINT [FK_LocalisationValues_Languages]
GO
ALTER TABLE [dbo].[LocalisationValues]  WITH CHECK ADD  CONSTRAINT [FK_LocalisationValues_LocalisationKeys] FOREIGN KEY([LocalisationKeyID])
REFERENCES [dbo].[LocalisationKeys] ([LocalisationKeyID])
GO
ALTER TABLE [dbo].[LocalisationValues] CHECK CONSTRAINT [FK_LocalisationValues_LocalisationKeys]
GO
ALTER TABLE [dbo].[LoginAudits]  WITH CHECK ADD  CONSTRAINT [FK_LoginAudits_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoginAudits] CHECK CONSTRAINT [FK_LoginAudits_Users]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ProcessStatus] FOREIGN KEY([ProcessStatusID])
REFERENCES [dbo].[ProcessStatus] ([ProcessStatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ProcessStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Users]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[SecurityGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK_SecurityGroupRoles_SecurityGroups] FOREIGN KEY([SecurityGroupID])
REFERENCES [dbo].[SecurityGroups] ([SecurityGroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SecurityGroupRoles] CHECK CONSTRAINT [FK_SecurityGroupRoles_SecurityGroups]
GO
ALTER TABLE [dbo].[SecurityGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK_SecurityGroupRoles_SecurityRoles] FOREIGN KEY([SecurityRoleID])
REFERENCES [dbo].[SecurityRoles] ([SecurityRoleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SecurityGroupRoles] CHECK CONSTRAINT [FK_SecurityGroupRoles_SecurityRoles]
GO
ALTER TABLE [dbo].[SecurityGroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_SecurityGroupUsers_SecurityGroups] FOREIGN KEY([SecurityGroupID])
REFERENCES [dbo].[SecurityGroups] ([SecurityGroupID])
GO
ALTER TABLE [dbo].[SecurityGroupUsers] CHECK CONSTRAINT [FK_SecurityGroupUsers_SecurityGroups]
GO
ALTER TABLE [dbo].[SecurityGroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_SecurityGroupUsers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SecurityGroupUsers] CHECK CONSTRAINT [FK_SecurityGroupUsers_Users]
GO
ALTER TABLE [dbo].[ServerProgramLog]  WITH CHECK ADD  CONSTRAINT [FK_ServerProgramLog_ServerPrograms] FOREIGN KEY([ServerProgramID])
REFERENCES [dbo].[ServerPrograms] ([ServerProgramID])
GO
ALTER TABLE [dbo].[ServerProgramLog] CHECK CONSTRAINT [FK_ServerProgramLog_ServerPrograms]
GO
ALTER TABLE [dbo].[SystemSettingValues]  WITH CHECK ADD  CONSTRAINT [FK_SystemSettingValues_SystemSettings] FOREIGN KEY([SystemSettingID])
REFERENCES [dbo].[SystemSettings] ([SystemSettingID])
GO
ALTER TABLE [dbo].[SystemSettingValues] CHECK CONSTRAINT [FK_SystemSettingValues_SystemSettings]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_DeductStatus] FOREIGN KEY([DeductID])
REFERENCES [dbo].[DeductStatus] ([DeductID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_DeductStatus]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Users]
GO
ALTER TABLE [dbo].[WebGridUserInfo]  WITH NOCHECK ADD  CONSTRAINT [FK_WebGridUserInfo_WebGridUserInfo] FOREIGN KEY([WebGridInfoID])
REFERENCES [dbo].[WebGridInfo] ([WebGridInfoID])
GO
ALTER TABLE [dbo].[WebGridUserInfo] CHECK CONSTRAINT [FK_WebGridUserInfo_WebGridUserInfo]
GO
ALTER TABLE [dbo].[WebGridUserInfo]  WITH NOCHECK ADD  CONSTRAINT [FK_WebGridUserInfo_WebGridUserInfo1] FOREIGN KEY([ParentLayoutID])
REFERENCES [dbo].[WebGridUserInfo] ([WebGridUserInfoID])
GO
ALTER TABLE [dbo].[WebGridUserInfo] CHECK CONSTRAINT [FK_WebGridUserInfo_WebGridUserInfo1]
GO
ALTER TABLE [dbo].[EmailAttachments]  WITH CHECK ADD  CONSTRAINT [CK_EmailAttachments] CHECK  ((len([AddressOfAttachment])>(0)))
GO
ALTER TABLE [dbo].[EmailAttachments] CHECK CONSTRAINT [CK_EmailAttachments]
GO
ALTER TABLE [dbo].[SecurityRoles]  WITH CHECK ADD  CONSTRAINT [CK_SecurityRoles] CHECK  ((len([SectionName])>(0)))
GO
ALTER TABLE [dbo].[SecurityRoles] CHECK CONSTRAINT [CK_SecurityRoles]
GO
ALTER TABLE [dbo].[SecurityRoles]  WITH CHECK ADD  CONSTRAINT [CK_SecurityRoles_1] CHECK  ((len([SecurityRole])>(0)))
GO
ALTER TABLE [dbo].[SecurityRoles] CHECK CONSTRAINT [CK_SecurityRoles_1]
GO
/****** Object:  StoredProcedure [CmdProcs].[cmdChangePassword]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	*** WARNING ***
	Access to this stored procedure should be restricted.
	Alternatively, the @CheckOldPassword parameter should be removed, 
	and the old password or an administrator user id and password must 
	be passed into updUser, which gets passed to this proc.
*/
CREATE PROCEDURE [CmdProcs].[cmdChangePassword]
(
	@UserID Int,
	@OldPassword VarChar(100),
	@NewPassword VarChar(100),
	@CheckOldPassword Bit = 1,
	@ResetState Int = 0
)
As

DECLARE @IsAuthenticated Bit

IF @CheckOldPassword = 1
BEGIN

	DECLARE @Salt Char(16), @UserPassword VarBinary(500)
	SELECT @Salt = Salt, @UserPassword = [Password]
	FROM Users 
	WHERE UserID = @UserID

	--Compare the calculated hash with the stored hash.
	SET @IsAuthenticated = CASE WHEN HASHBYTES ('SHA2_256', @OldPassword + @Salt) = @UserPassword THEN 1 ELSE 0 END
	
END
ELSE
BEGIN

	SET @IsAuthenticated = 1

END

IF @IsAuthenticated = 1
BEGIN
	--Generate a new salt, and hash the new password.
	DECLARE @NewSalt Binary(16) = CONVERT(Binary(16), NEWID())

	UPDATE Users
		SET Salt = @NewSalt,
				[Password] = HASHBYTES ('SHA2_256', @NewPassword + CONVERT(Char(16), @NewSalt)),
				PasswordChangeDate = GETDATE(),
				ResetState = @ResetState
	WHERE UserID = @UserID
	
	INSERT INTO LoginAudits (UserID, CreatedDate, MachineName, WindowsName, LoginType, RefreshedRolesInd)
	VALUES (@UserID, GetDate(), '', '', 3, 0)

END

IF @CheckOldPassword = 1
	SELECT @IsAuthenticated
GO
/****** Object:  StoredProcedure [CmdProcs].[cmdCheckServerProgramLock]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CmdProcs.cmdCheckServerProgramLock 'Prod1', 60
*/
CREATE PROCEDURE [CmdProcs].[cmdCheckServerProgramLock]
(
	@ServiceGroupID Int = 1,
	@InstanceName VarChar(100),
	@Interval Int
)
As

DECLARE @Result int,
				@LockName VarChar(50) = 'ServerProgramLock' + CONVERT(VarChar, @ServiceGroupID)

BEGIN TRANSACTION

	EXEC @result = sp_getapplock @Resource = @LockName, @LockMode = 'Exclusive'

	IF @Result = 0 
	BEGIN
		
		DECLARE @LastRunTime DateTime,
						@LastInstanceName VarChar(100)

		SELECT @LastRunTime = LastRunTime, @LastInstanceName = InstanceName
		FROM ServerProgramLock
		WHERE ServerProgramLockID = @ServiceGroupID

		IF @LastInstanceName = @InstanceName OR DATEDIFF(second, @LastRunTime, GetDate()) > @Interval
		BEGIN

			UPDATE ServerProgramLock 
				SET LastRunTime = GetDate(), InstanceName = @InstanceName
			WHERE ServerProgramLockID = @ServiceGroupID

			SELECT 1 As IsActive

		END
	

		EXEC @Result = sp_releaseapplock @Resource = @LockName
		
	END 

COMMIT



		


		
GO
/****** Object:  StoredProcedure [CmdProcs].[cmdCheckUserExists]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [CmdProcs].[cmdCheckUserExists]
(
	@UserID Int,
	@UserName VarChar(50)
)
As

SELECT UserID
FROM Users
WHERE UserName = @UserName
	AND UserID <> @UserID
GO
/****** Object:  StoredProcedure [CmdProcs].[cmdInsWebError]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [CmdProcs].[cmdInsWebError]
(
	@UserID Int = NULL,
	@Page VarChar(100),
	@Browser VarChar(100),
	@StackTrace VarChar(1024),
	@Error VarChar(1024),
	@OtherData VarChar(1024) = ''
)
AS

	INSERT INTO WebErrors (UserID, Page, Browser, StackTrace, Error, CreatedDate, OtherData)
	VALUES (@UserID, @Page, @Browser, @StackTrace, @Error, GETDATE(), @OtherData)
	
	SELECT SCOPE_IDENTITY()

RETURN



GO
/****** Object:  StoredProcedure [CmdProcs].[cmdResetPassword]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	*** WARNING ***
	Access to this stored procedure should be restricted to the website user account only.
*/
CREATE PROCEDURE [CmdProcs].[cmdResetPassword]
(
	@UserName VarChar(100),
	@RandomPassword VarChar(100)
)
As

DECLARE @UserID Int, @EmailAddress Varchar(200)

SELECT @UserID = UserID, @EmailAddress = EmailAddress
FROM Users
WHERE UserName = @UserName

IF @UserID IS NOT NULL
BEGIN

	EXEC CmdProcs.cmdChangePassword @UserID, '', @RandomPassword,0,1
	SELECT CONVERT(Bit, 1) As Success, @EmailAddress As EmailAddress
		
END
ELSE 
BEGIN

	SELECT CONVERT(Bit, 0) As Success, '' As EmailAddress

END

GO
/****** Object:  StoredProcedure [CmdProcs].[cmdServerProgramMessage]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [CmdProcs].[cmdServerProgramMessage]
(
	@MessageType Int,
	@Message VarChar(1024)
)
As

	DECLARE @c UniqueIdentifier;

  BEGIN DIALOG CONVERSATION @c
  FROM SERVICE ServiceUpdateService TO SERVICE 'ServiceUpdateService'
  WITH ENCRYPTION = OFF;

  SEND ON CONVERSATION @c(CONVERT(VarChar, @MessageType) + ',' + @Message)
GO
/****** Object:  StoredProcedure [CmdProcs].[WebLogin]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
[CmdProcs].[WebLogin] 0, 'superu', 'B76086D107948C259C07CEE2FA6946FD3FB6E1761CD6411C59CE4D4C3903219B'
*/
CREATE PROCEDURE [CmdProcs].[WebLogin]
(
	@RefreshingRoles Bit = 0,
	@UserName VarChar(50),
	@Password VarChar(500)
)
AS
--Check if the user name exists, and get the password info.
DECLARE @UserID Int, @Salt Char(16), @UserPassword VarBinary(500), @IsAuthenticated Int, @ResetState Int, @FailedCount Int = 0
SELECT @UserID = UserID, @Salt = Salt, @UserPassword = [Password], @ResetState = ResetState
FROM Users 
WHERE UserName = @UserName


--Compare the calculated hash with the stored hash.
SET @IsAuthenticated = CASE WHEN @RefreshingRoles = 1 OR HASHBYTES ('SHA2_256', @Password + @Salt) = @UserPassword THEN 1 ELSE 0 END

--If the user is authenticated, return the identity info
IF @UserID IS NOT NULL
BEGIN

	SELECT @FailedCount = SUM(CASE WHEN LoginType = 0 THEN 1 ELSE 0 END) 
	FROM (
		SELECT TOP 4 LoginType
		FROM LoginAudits 
		WHERE UserID = @UserID
		ORDER BY LoginAuditID DESC
	) x

	IF @FailedCount = 4 AND @IsAuthenticated = 0
	BEGIN
		SET @ResetState = 2
		UPDATE Users SET ResetState = @ResetState WHERE UserID = @UserID
		SET @IsAuthenticated = 2
	END

	IF @RefreshingRoles = 0
	BEGIN
		INSERT INTO LoginAudits (UserID, CreatedDate, MachineName, WindowsName, LoginType, RefreshedRolesInd)
		VALUES (@UserID, GetDate(), '', '', @IsAuthenticated, @RefreshingRoles)
	END

	IF @ResetState = 2
	BEGIN
		RAISERROR('CustomError: Account is locked, please reset password.', 11, 1)
		RETURN 
	END

END

--If the user is authenticated, return the identity info
IF @UserID IS NOT NULL AND @IsAuthenticated = 1
BEGIN

	IF Fn.HasAccess(@UserID, 'Web Application', 'Access') = 0
	BEGIN
		RAISERROR('CustomError: You do not have access to the web application', 11, 1)
		RETURN 
	END

	IF @ResetState = 1
	BEGIN
		--Make sure the user cant log in with this password again.
		UPDATE Users SET ResetState = 2 WHERE UserID = @UserID
	END

	SELECT	UserID, 
					UserName, 
					FirstName + ' ' + LastName As FullName, 
					CONVERT(Bit, CASE WHEN UserID = 1 THEN 1 ELSE 0 END) As Administrator,
					PasswordChangeDate, 
					EmailAddress,
					FirstTimeLogin,
					@ResetState 
	FROM Users
	WHERE UserID = @UserID


	SELECT sr.SectionName, sr.SecurityRole  
	FROM SecurityGroupRoles sgr 
	INNER JOIN SecurityGroupUsers sgu ON sgu.SecurityGroupID = sgr.SecurityGroupID
	INNER JOIN SecurityRoles sr ON sgr.SecurityRoleID = sr.SecurityRoleID  
	INNER JOIN Users u ON sgu.UserID = u.UserID
	WHERE u.UserID = @UserID

END





RETURN

GO
/****** Object:  StoredProcedure [DelProcs].[delCategory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delCategory]
(
  @CategoryID int
)
AS

DELETE FROM Category WHERE CategoryID = @CategoryID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delDocument]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delDocument]
(
  @DocumentID int
)
AS

DELETE FROM Documents WHERE DocumentID = @DocumentID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delEmail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delEmail]
(
  @EmailID int
)
AS

DELETE FROM Emails WHERE EmailID = @EmailID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delEmailAttachment]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delEmailAttachment]
(
  @EmailAttachmentID int
)
AS

DELETE FROM EmailAttachments WHERE EmailAttachmentID = @EmailAttachmentID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delInventory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delInventory]
(
  @InventoryID int
)
AS

DELETE FROM Inventory WHERE InventoryID = @InventoryID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delLocalisationKey]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delLocalisationKey]
(
  @LocalisationKeyID int
)
AS

DELETE FROM LocalisationKeys WHERE LocalisationKeyID = @LocalisationKeyID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delLocalisationValue]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delLocalisationValue]
(
  @LocalisationValueID int
)
AS

DELETE FROM LocalisationValues WHERE LocalisationValueID = @LocalisationValueID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delOrder]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [DelProcs].[delOrder]
(
  @OrderID int
)
AS

DELETE FROM [Order] WHERE OrderID = @OrderID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delOrderDetail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delOrderDetail]
(
  @OrderDetailsID int
)
AS

DELETE FROM OrderDetails WHERE OrderDetailsID = @OrderDetailsID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delProduct]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delProduct]
(
  @ProductID int
)
AS

DELETE FROM Product WHERE ProductID = @ProductID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delSale]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [DelProcs].[delSale]
(
  @SaleID int
)
AS

DELETE FROM Sale WHERE SaleID = @SaleID


RETURN
GO
/****** Object:  StoredProcedure [DelProcs].[delSecurityGroup]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delSecurityGroup]
(
	@SecurityGroupID Int
)
As

	DELETE FROM SecurityGroups WHERE SecurityGroupID = @SecurityGroupID

GO
/****** Object:  StoredProcedure [DelProcs].[delSecurityGroupUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DelProcs].[delSecurityGroupUser]
(
	@SecurityGroupUserID Int
)
As

	DELETE FROM SecurityGroupUsers WHERE SecurityGroupUserID = @SecurityGroupUserID

GO
/****** Object:  StoredProcedure [GetProcs].[getCategoryList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getCategoryList]
AS

SET NOCOUNT ON

SELECT CategoryID, CategoryName, CreatedDate
FROM Category



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getDocument]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC [GetProcs].[getDocument] null,'098376.jpg'


*/

CREATE PROCEDURE [GetProcs].[getDocument] 

As

	SELECT DocumentID, DocumentName, DocumentData, CreatedBy, CreatedDateTime, CreatedBy, CreatedDateTime
	FROM Documents

GO
/****** Object:  StoredProcedure [GetProcs].[getDocumentList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getDocumentList]
(
	@DocumentID Int = null,
	@DocumentName varchar(255) = null
)
AS

SET NOCOUNT ON

SELECT DocumentID, DocumentName, DocumentData, CreatedDateTime, CreatedBy, DocumentHash
FROM Documents
	WHERE 
	(@DocumentID IS NULL OR @DocumentID = DocumentID) AND
	(@DocumentName IS NULL OR @DocumentName LIKE '%' + DocumentName + '%')



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getEditInventoryList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getEditInventoryList]
AS

SET NOCOUNT ON

SELECT top 1 with TIES ProductName,Inventory.InventoryQuantity,Inventory.CurrentInventoryQuantity,Inventory.InventoryTypeID,Inventory.InventoryItemCost,Inventory.ProductID,Inventory.InventoryID FROM dbo.Inventory INNER JOIN
                         dbo.Product ON dbo.Inventory.ProductID = dbo.Product.ProductID 
						 where Product.DeleteStatus = 0 AND Product.CategoryID <> 13

order by (ROW_NUMBER() OVER (Partition BY Inventory.ProductID ORDER BY Inventory.CreatedDate DESC))





RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getEmailList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getEmailList]
(
	@EmailID Int = NULL,
	@SentInd Bit = 0,
	@StartDate Date = NULL,
	@EndDate Date = NULL
)
AS

--Filter
	SELECT TOP (CASE WHEN @SentInd = 1 THEN 1000 ELSE 50 END) EmailID, ToEmailAddress, FromEmailAddress, FriendlyFrom, Subject, 
			Body, CCEmailAddresses, CreatedBy, CreatedDate, DateToSend, SentDate, 
			NotSentError, Ignore
	INTO #Emails
	FROM Emails e
	WHERE (
						(@SentInd = 0 AND SentDate IS NULL AND NotSentError = '' AND Ignore = 0)
				 OR (@SentInd = 1 AND SentDate IS NOT NULL)
				 OR (@StartDate IS NOT NULL)
				)
		AND (@StartDate IS NULL OR CAST(e.CreatedDate AS date) >= @StartDate)
		AND (@EndDate IS NULL OR CAST(e.CreatedDate AS date) <= @EndDate)
		AND (@StartDate IS NOT NULL OR e.DateToSend IS NULL OR e.DateToSend <= GETDATE())
		AND (@EmailID IS NULL OR @EmailID = e.EmailID)
	ORDER BY BulkInd, CreatedDate
		 
	
	--Select
	SELECT EmailID, ToEmailAddress, FromEmailAddress, FriendlyFrom, Subject, 
			Body, CCEmailAddresses, CreatedBy, CreatedDate, DateToSend, SentDate, 
			NotSentError, Ignore
	FROM #Emails
	
	
	SELECT ea.EmailAttachmentID, ea.EmailID, ea.AttachmentName, ea.AddressOfAttachment, ea.AttachmentData
	FROM EmailAttachments ea
	INNER JOIN #Emails e ON ea.EmailID = e.EmailID
	
RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getGeneralUserList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getGeneralUserList]
@userid int = NULL
AS

SET NOCOUNT ON

SELECT UserID, FirstName, LastName, UserName, Password, 
		Salt, RFID, PasswordChangeDate, CreatedDate, CreatedBy, FirstTimeLogin, 
		EmailAddress, ResetState, DeductID
FROM Users
WHERE		@userid is null OR dbo.[Users].UserID = @userid


RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getInventoryList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getInventoryList]
AS

SET NOCOUNT ON

SELECT InventoryID, ProductID, InventoryQuantity, CurrentInventoryQuantity, InventoryItemCost, 
		InventoryTypeID, CreatedDate,OrderID
FROM Inventory



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getLanguageList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getLanguageList]
	AS

	SELECT LanguageID, [Language], CultureCode
	FROM Languages
	ORDER BY LanguageID

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getmyCartList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getmyCartList]
@userid int = NULL
AS

SET NOCOUNT ON
SELECT        dbo.[Order].OrderID, dbo.[Order].UserID, dbo.OrderDetails.ProductID, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.OrderDetails.OrderDetailsID, dbo.Product.ProductName, dbo.[Order].OrderDate, 
                         dbo.[Order].ProcessStatusID, dbo.Product.ProductPrice
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderDetails ON dbo.[Order].OrderID = dbo.OrderDetails.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID
						WHERE MONTH(OrderDate) = MONTH(GETDATE()) AND
						(@userid is null OR dbo.[Order].UserID = @userid) AND (dbo.[Order].ProcessStatusID <> 3)

ORDER BY OrderDate DESC

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getOrderDetailList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getOrderDetailList]
AS

SET NOCOUNT ON

SELECT orderID, ProductID, ProductQuantity, UnitPrice, OrderDetailsID
FROM OrderDetails



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getOrderList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getOrderList]
AS

SET NOCOUNT ON

SELECT OrderID, UserID, OrderDate, RequiredDate, ProcessStatusID
FROM [Order]



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getProductList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getProductList]
@CategoryID int = NULL

AS

SET NOCOUNT ON

SELECT ProductID, CategoryID, ProductName, ProductPrice, CreatedDate,DeleteStatus
FROM Product
where DeleteStatus = 0 AND (@CategoryID is null OR dbo.[Product].CategoryID = @CategoryID)




RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROCategoryList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getROCategoryList]
AS

SET NOCOUNT ON

SELECT CategoryID, CategoryName, CreatedDate
FROM Category



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROLocalisationKeyList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getROLocalisationKeyList]
AS

SELECT LocalisationKeyID, [Key], DefaultValue
FROM LocalisationKeys

SELECT LanguageID, CultureCode, [Language]
FROM Languages

EXEC GetProcs.getROLocalisationValueList

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROLocalisationValueList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getROLocalisationValueList]
AS

SELECT lv.LocalisationValueID, lv.LocalisationKeyID, lv.LanguageID, lv.Value
FROM LocalisationValues lv




RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROProductList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getROProductList]
AS

SET NOCOUNT ON

SELECT ProductID, CategoryID, ProductName, ProductPrice, CreatedDate
FROM Product



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROScheduleProgressList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getROScheduleProgressList]
(
	@ScheduleInfoID Int,
	@ToDate Date = NULL
)
As

	SELECT @ToDate = CASE WHEN @ToDate IS NULL THEN GetDate() ELSE @ToDate END

	SELECT ServerProgramLogID, ServerProgramID, Message, CreatedDate, '' As VersionNo
	FROM ServerProgramLog
	WHERE ServerProgramID = @ScheduleInfoID
	AND CreatedDate >= DateAdd(day, -7, @ToDate) AND CreatedDate < DATEADD(Day, 1, @ToDate)
GO
/****** Object:  StoredProcedure [GetProcs].[getROSecurityRoleList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getROSecurityRoleList]
	AS

	SELECT SectionName
	FROM SecurityRoles 
	GROUP BY SectionName

	SELECT SecurityRoleID, SectionName, SecurityRole, Description 
	FROM SecurityRoles 
	ORDER BY SectionName, SecurityRole
	

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROUserList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getROUserList]
AS

SET NOCOUNT ON

SELECT UserID, FirstName, LastName, UserName, Password, 
		Salt, RFID, PasswordChangeDate, CreatedDate, CreatedBy, FirstTimeLogin, 
		EmailAddress, ResetState, DeductID
FROM Users



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getROUserPagedList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
[GetProcs].[getROUserPagedList] 1, 20, 'UserName', 1, ''
*/
CREATE PROCEDURE [GetProcs].[getROUserPagedList]
(
	@PageNo Int = NULL,
	@PageSize Int = NULL,
	@SortColumn VarChar(100) = NULL,
	@SortAsc Bit = NULL,
	@UserName VarChar(100) = NULL,
	@CompanyID Int = NULL
)
As


SELECT u.UserID, UserName, FirstName, LastName
INTO #Users
FROM Users u
WHERE (@UserName = '' OR UserName Like '%' + @UserName + '%' OR FirstName + ' ' + LastName LIKE '%' + @UserName + '%')


DECLARE @TotalRecords Int
SELECT @TotalRecords = COUNT(*) 
FROM #Users

SELECT @TotalRecords

SELECT TOP (@PageSize) UserID, UserName, FirstName, LastName, RowNo, @TotalRecords + RowNo
FROM (
	SELECT	CASE WHEN @SortAsc = 1 THEN 1 ELSE -1 END * 
							ROW_NUMBER() OVER (ORDER BY CASE @SortColumn WHEN 'UserName' THEN UserName WHEN 'FirstName' THEN FirstName WHEN 'LastName' THEN LastName END) As RowNo,
					UserID, UserName, FirstName, LastName
	FROM #Users

) data
WHERE CASE WHEN @SortAsc = 1 THEN RowNo ELSE @TotalRecords + RowNo + 1 END > (@PageNo-1) * @PageSize 
ORDER BY RowNo

DROP TABLE #Users
GO
/****** Object:  StoredProcedure [GetProcs].[getROWebGridUserInfoList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getROWebGridUserInfoList]
(
	@UniqueName VarChar(100),
	@UserID Int = NULL
)
AS

SELECT wgui.WebGridUserInfoID, wgui.WebGridInfoID, wgui.UserID, wgui.LayoutInfo, wgui.LayoutName, wgui.ParentLayoutID
FROM WebGridUserInfo wgui
INNER JOIN WebGridInfo wgi ON wgui.WebGridInfoID = wgi.WebGridInfoID
WHERE wgi.UniqueKey = @UniqueName
	AND wgui.UserID = @UserID
	AND wgui.ParentLayoutID IS NULL
	
--First Child Level
SELECT wgui.WebGridUserInfoID, wgui.WebGridInfoID, wgui.UserID, wgui.LayoutInfo, wgui.LayoutName, wgui.ParentLayoutID
FROM WebGridUserInfo wgui
INNER JOIN WebGridInfo wgi ON wgui.WebGridInfoID = wgi.WebGridInfoID
WHERE wgi.UniqueKey = @UniqueName
	AND wgui.UserID = @UserID
	AND wgui.ParentLayoutID IS NOT NULL

RETURN

GO
/****** Object:  StoredProcedure [GetProcs].[getSaleList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getSaleList]
AS

SET NOCOUNT ON

SELECT SaleID, ProductID, CreatedDate, SaleAmount
FROM Sale



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getSecurityGroupList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getSecurityGroupList]
AS

SELECT SecurityGroupID, SecurityGroup, Description
FROM SecurityGroups


	EXEC GetProcs.getSecurityGroupRoleList

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getSecurityGroupRoleList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getSecurityGroupRoleList]
AS

SELECT SecurityGroupRoleID, SecurityGroupID, SecurityRoleID
FROM SecurityGroupRoles



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getServerProgramTypeList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getServerProgramTypeList]
(
	@ServiceProgramTypeID Int = NULL
)
AS

SELECT ServerProgramID, ServerProgram, Info, ActiveInd
FROM ServerPrograms
WHERE ServerProgramID = @ServiceProgramTypeID OR @ServiceProgramTypeID IS NULL



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getSystemSettingList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getSystemSettingList]
(
	@SystemSetting Varchar(50) = ''
)
AS

SELECT SystemSettingID, SystemSetting
FROM SystemSettings
WHERE (@SystemSetting = '' OR SystemSetting = @SystemSetting)


	EXEC GetProcs.getSystemSettingValueList @SystemSetting

RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getSystemSettingValueList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getSystemSettingValueList]
(
	@SystemSetting Varchar(50) = ''
)
AS

SELECT ssv.SystemSettingValueID, ssv.SystemSettingID, ssv.PropertyName, ssv.PropertyValue, ssv.PropertyBytes
FROM SystemSettingValues ssv 
INNER JOIN SystemSettings ss ON ss.SystemSettingID = ssv.SystemSettingID
WHERE (@SystemSetting = '' OR SystemSetting = @SystemSetting)



RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getTableReferenceList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [GetProcs].[getTableReferenceList]
(
	@TableToCheck VarChar(40), 
	@Key Int
)
As

DECLARE @References TABLE (
			TableSchema VarChar(150),
			TableName VarChar(150), 
			ColumnName VarChar(100), 
			ConstraintName VarChar(150), 
			ConstraintDescription VarChar(1024),
			NoOfReferences Int
)

INSERT INTO @References
SELECT 
		CONVERT(VarChar(150), FK.TABLE_SCHEMA) As TableSchema,
		CONVERT(VarChar(150), FK.TABLE_NAME) As TableName,
		CONVERT(VarChar(100), CU.COLUMN_NAME) As ColumnName,
		CONVERT(VarChar(150), C.CONSTRAINT_NAME) As ConstraintName,
		CONVERT(VarChar(1024), ex.Value) As ConstraintDescription,
		0 As NoOfRefereces
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
INNER JOIN	
(
		SELECT i1.TABLE_NAME, i2.COLUMN_NAME
		FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
	  INNER JOIN      INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2 ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
    WHERE i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
) PT ON PT.TABLE_NAME = PK.TABLE_NAME
INNER JOIN sys.objects so ON so.name = C.CONSTRAINT_NAME
LEFT JOIN sys.extended_properties ex ON so.object_id = ex.major_id
WHERE 		PK.TABLE_NAME = @TableToCheck 

DECLARE @TableSchema VarChar(100),
	@TableName VarChar(50), 
	@ColumnName VarChar(50), 
	@Select NVarChar(120), 
	@NoOfReferences Int

DECLARE @Rows TABLE (Num Int)

WHILE Exists(SELECT * FROM @References WHERE NoOfReferences = 0)
	BEGIN
		
		SELECT TOP 1 @TableName = TableName, @ColumnName = ColumnName, @TableSchema = TableSchema
		FROM @References
		WHERE NoOfReferences = 0

		-- BUILD UP THE SELECT STATEMENT
		SET @Select = 'SELECT Count(*) As Num FROM ' + @TableSchema + '.' + @TableName + 
					' WHERE ' + @ColumnName + ' = ' + CONVERT(VarChar, @Key)
	
		INSERT INTO @Rows 
		Exec sp_executesql @Select
	
		SELECT @NoOfReferences = Num FROM @Rows
	
		DELETE FROM @Rows
	
		IF @NoOfReferences > 0 
		BEGIN
			UPDATE @References
				SET NoOfReferences = @NoOfReferences
			WHERE TableName = @TableName
				AND ColumnName = @ColumnName
				AND NoOfReferences = 0
		END
		ELSE
		BEGIN
			DELETE FROM @References 
			WHERE TableName = @TableName
				AND ColumnName = @ColumnName
				AND NoOfReferences = 0
		END
	END

	SELECT TableName, ColumnName,	ConstraintName, ConstraintDescription, NoOfReferences FROM @References

	RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getUserList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [GetProcs].[getUserList]
(
@UserID int
)
AS


SELECT u.UserID, u.FirstName, u.LastName, u.UserName, '' As [Password], 
u.PasswordChangeDate, u.EmailAddress, uCreated.UserName, u.CreatedDate
FROM Users u
INNER JOIN Users uCreated ON u.CreatedBy = uCreated.UserID
WHERE u.UserID = @UserID

SELECT sgu.SecurityGroupUserID, sgu.SecurityGroupID, sgu.UserID
FROM SecurityGroupUsers sgu
WHERE sgu.UserID = @UserID


RETURN
GO
/****** Object:  StoredProcedure [GetProcs].[getUserOrdersList]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [GetProcs].[getUserOrdersList]
	@processStatusID int = 1
AS

SET NOCOUNT ON

SELECT        dbo.[Order].OrderID, dbo.Product.ProductName, dbo.Users.FirstName, dbo.Users.LastName, dbo.OrderDetails.ProductQuantity, dbo.OrderDetails.UnitPrice, dbo.[Order].OrderDate, dbo.[Order].RequiredDate, 
                         dbo.[Order].ProcessStatusID, dbo.Product.ProductID, dbo.[Order].UserID
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderDetails ON dbo.[Order].OrderID = dbo.OrderDetails.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderDetails.ProductID = dbo.Product.ProductID INNER JOIN
                         dbo.Users ON dbo.[Order].UserID = dbo.Users.UserID
						 where (@processStatusID is null OR dbo.[Order].ProcessStatusID = @processStatusID)


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insCategory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [InsProcs].[insCategory]
(
  @CategoryID int OUTPUT,
  @CategoryName varchar(255)
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Category
(
  CategoryName,
  CreatedDate
)
VALUES
(
  @CategoryName,
  @CreatedDate
)
SET @CategoryID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insDocument]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--************************************************
-- Author: James Smith
-- Modified Date: 2018/04/06
-- Description: Allow for different users to upload the same document, with individual Friendlynames
--				Reason for this was to allow inner join between a document and a user - in order to prevent foreign key manipulation in viewmodel
--				Thus multiple users could upload the same document, the user will see his own friendly name.
--************************************************
CREATE PROCEDURE [InsProcs].[insDocument]
(
	@DocumentID Int OUTPUT,
	@DocumentName VarChar(255) = NULL,
	@Document VarBinary(Max) = NULL,
	@DocumentHash Binary(32) = NULL,
	@ModifiedBy int = NULL
)
As

DECLARE @ModifiedDate DateTime

SET @ModifiedDate = GetDate()

SELECT @DocumentID = DocumentID
FROM Documents 
WHERE DocumentHash = @DocumentHash

IF @DocumentID IS NULL
BEGIN

	INSERT INTO Documents (DocumentName, DocumentData, DocumentHash, CreatedBy, CreatedDateTime)
	VALUES (@DocumentName, NULL, @DocumentHash, @ModifiedBy, @ModifiedDate)

	SET @DocumentID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	-- Otherise Update the Name
	UPDATE Documents SET DocumentName = @DocumentName
	WHERE DocumentID = @DocumentID

END

GO
/****** Object:  StoredProcedure [InsProcs].[insEmail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insEmail]
(
  @EmailID int OUTPUT,
  @ToEmailAddress varchar(1000),
  @FromEmailAddress varchar(100),
  @FriendlyFrom varchar(50),
  @Subject varchar(255),
  @Body varchar(MAX),
  @CCEmailAddresses varchar(1000),
  @CreatedBy varchar(255),
  @DateToSend datetime,
  @SentDate datetime,
  @NotSentError varchar(1024),
  @Ignore bit
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Emails
(
  ToEmailAddress,
  FromEmailAddress,
  FriendlyFrom,
  Subject,
  Body,
  CCEmailAddresses,
  CreatedBy,
  CreatedDate,
  DateToSend,
  SentDate,
  NotSentError,
  Ignore
)
VALUES
(
  @ToEmailAddress,
  @FromEmailAddress,
  @FriendlyFrom,
  @Subject,
  @Body,
  @CCEmailAddresses,
  @CreatedBy,
  @CreatedDate,
  @DateToSend,
  @SentDate,
  @NotSentError,
  @Ignore
)
SET @EmailID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insEmailAttachment]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insEmailAttachment]
(
  @EmailAttachmentID int OUTPUT,
  @EmailID int,
  @AttachmentName varchar(255),
  @AddressOfAttachment varchar(512),
  @AttachmentData varbinary(MAX)
)
AS

-- Insert statement
INSERT INTO EmailAttachments
(
  EmailID,
  AttachmentName,
  AddressOfAttachment,
  AttachmentData
)
VALUES
(
  @EmailID,
  @AttachmentName,
  @AddressOfAttachment,
  @AttachmentData
)
SET @EmailAttachmentID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insGeneralUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [InsProcs].[insGeneralUser]
(
  @UserID  int OUTPUT,
  @FirstName varchar(50),
  @LastName varchar(50),
  @UserName varchar(50),
  @Password varbinary(500),
  @Salt binary(16),
  @RFID varchar(100),
  @PasswordChangeDate datetime,
  @CreatedBy int,
  @FirstTimeLogin bit,
  @EmailAddress varchar(100),
  @DeductID int,
  @ResetState int
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Users
(
  FirstName,
  LastName,
  UserName,
  Password,
  Salt,
  RFID,
  PasswordChangeDate,
  CreatedDate,
  CreatedBy,
  FirstTimeLogin,
  EmailAddress,
  DeductID,
  ResetState
)
VALUES
(
  @FirstName,
  @LastName,
  @UserName,
  @Password,
  @Salt,
  @RFID,
  @PasswordChangeDate,
  @CreatedDate,
  @CreatedBy,
  @FirstTimeLogin,
  @EmailAddress,
  @DeductID,
  @ResetState
)
SET @UserID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insInventory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [InsProcs].[insInventory]
(
  @InventoryID int OUTPUT,
  @ProductID int,
  @InventoryQuantity int,
  @CurrentInventoryQuantity int,
  @InventoryItemCost decimal(18, 0),
  @InventoryTypeID int,
  @OrderID int
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Inventory
(
  ProductID,
  InventoryQuantity,
  CurrentInventoryQuantity,
  InventoryItemCost,
  InventoryTypeID,
  CreatedDate,
  OrderID
)
VALUES
(
  @ProductID,
  @InventoryQuantity,
  @CurrentInventoryQuantity,
  @InventoryItemCost,
  @InventoryTypeID,
  @CreatedDate,
  @OrderID
)
SET @InventoryID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insLocalisationKey]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insLocalisationKey]
(
  @LocalisationKeyID int OUTPUT,
  @Key varchar(100),
  @DefaultValue varchar(1024)
)
AS

-- Insert statement
INSERT INTO LocalisationKeys
(
  [Key],
  DefaultValue
)
VALUES
(
  @Key,
  @DefaultValue
)
SET @LocalisationKeyID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insLocalisationValue]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insLocalisationValue]
(
  @LocalisationValueID int OUTPUT,
  @LocalisationKeyID int,
  @LanguageID int,
  @Value varchar(1024)
)
AS

-- Insert statement
INSERT INTO LocalisationValues
(
  LocalisationKeyID,
  LanguageID,
  Value
)
VALUES
(
  @LocalisationKeyID,
  @LanguageID,
  @Value
)
SET @LocalisationValueID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insOrder]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [InsProcs].[insOrder]
(
  @OrderID int OUTPUT,
  @UserID int,
  @OrderDate datetime,
  @RequiredDate date,
  @ProcessStatusID int
)
AS

-- Insert statement
INSERT INTO [Order]
(
  UserID,
  OrderDate,
  RequiredDate,
  ProcessStatusID
)
VALUES
(
  @UserID,
  @OrderDate,
  @RequiredDate,
  @ProcessStatusID
)
SET @OrderID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insOrderDetail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [InsProcs].[insOrderDetail]
(
  @orderID int,
  @ProductID int,
  @ProductQuantity int,
  @UnitPrice decimal(18, 2),
  @OrderDetailsID int OUTPUT
)
AS

-- Insert statement
INSERT INTO OrderDetails
(
  orderID,
  ProductID,
  ProductQuantity,
  UnitPrice
)
VALUES
(
  @orderID,
  @ProductID,
  @ProductQuantity,
  @UnitPrice
)
SET @OrderDetailsID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insProduct]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [InsProcs].[insProduct]
(
  @ProductID int OUTPUT,
  @CategoryID int,
  @ProductName varchar(255),
  @ProductPrice decimal(18,2),
  @DeleteStatus bit
  
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Product
(
  CategoryID,
  ProductName,
  ProductPrice,
  CreatedDate,
  DeleteStatus
)
VALUES
(
  @CategoryID,
  @ProductName,
  @ProductPrice,
  @CreatedDate,
  @DeleteStatus
 
)
SET @ProductID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSale]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [InsProcs].[insSale]
(
  @SaleID int OUTPUT,
  @ProductID int,
  @SaleAmount decimal(18, 0)
)
AS

DECLARE @CreatedDate DateTime

SET @CreatedDate = GetDate()

-- Insert statement
INSERT INTO Sale
(
  ProductID,
  CreatedDate,
  SaleAmount
)
VALUES
(
  @ProductID,
  @CreatedDate,
  @SaleAmount
)
SET @SaleID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSecurityGroup]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insSecurityGroup]
(
  @SecurityGroupID int OUTPUT,
  @SecurityGroup varchar(50),
  @Description varchar(255)
)
AS

-- Insert statement
INSERT INTO SecurityGroups
(
  SecurityGroup,
  Description
)
VALUES
(
  @SecurityGroup,
  @Description
)
SET @SecurityGroupID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSecurityGroupRole]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insSecurityGroupRole]
(
  @SecurityGroupRoleID int OUTPUT,
  @SecurityGroupID int,
  @SecurityRoleID int,
  @SelectedInd Bit --The object will not call the save if this is false, so this can be ignored in the stored proc.
)
AS

-- Insert statement
INSERT INTO SecurityGroupRoles
(
  SecurityGroupID,
  SecurityRoleID
)
VALUES
(
  @SecurityGroupID,
  @SecurityRoleID
)
SET @SecurityGroupRoleID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSecurityGroupUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insSecurityGroupUser]
(
  @SecurityGroupUserID int OUTPUT,
  @SecurityGroupID int,
  @UserID int
)
AS

-- Insert statement
INSERT INTO SecurityGroupUsers
(
  SecurityGroupID,
  UserID
)
VALUES
(
  @SecurityGroupID,
  @UserID
)
SET @SecurityGroupUserID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insServerProgramProgress]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insServerProgramProgress]
(
	@ServerProgramProgressID Int OUTPUT,
	@ServerProgramTypeID Int,
	@Progress VarChar(512),
	@Version VarChar(10),
	@ProgressTypeID Int
)
As

	INSERT INTO ServerProgramLog (ServerProgramID, [Message], CreatedDate)
	VALUES (@ServerProgramTypeID, @Progress, GetDate())

	SET @ServerProgramProgressID = SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [InsProcs].[insServerProgramType]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insServerProgramType]
(
  @ServerProgramTypeID int OUTPUT,
  @ServerProgramType varchar(50),
  @Info varbinary(MAX),
  @ActiveInd bit
)
AS

-- Insert statement
INSERT INTO ServerPrograms
(
  ServerProgram,
  Info,
  ActiveInd
)
VALUES
(
  @ServerProgramType,
  @Info,
  @ActiveInd
)
SET @ServerProgramTypeID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSystemSetting]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insSystemSetting]
(
  @SystemSettingID int OUTPUT,
  @SystemSetting varchar(50)
)
AS

-- Insert statement
INSERT INTO SystemSettings
(
  SystemSetting
)
VALUES
(
  @SystemSetting
)
SET @SystemSettingID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insSystemSettingValue]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insSystemSettingValue]
(
  @SystemSettingValueID int OUTPUT,
  @SystemSettingID int,
  @PropertyName varchar(50),
  @PropertyValue sql_variant,
  @PropertyBytes varBinary(Max)
)
AS

-- Insert statement
INSERT INTO SystemSettingValues
(
  SystemSettingID,
  PropertyName,
  PropertyValue,
  PropertyBytes
)
VALUES
(
  @SystemSettingID,
  @PropertyName,
  @PropertyValue,
  @PropertyBytes
)
SET @SystemSettingValueID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[insUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [InsProcs].[insUser]
(
  @UserID int OUTPUT,
  @FirstName varchar(50),
  @LastName varchar(50),
  @UserName varchar(50),
  @Password varchar(200),
  @EmailAddress varchar(100),
  @CreatedBy Int
)
AS

DECLARE @NewSalt Binary(16) = CONVERT(Binary(16), NEWID())

-- Insert statement
INSERT INTO Users
(
  FirstName,
  LastName,
  UserName,
	Salt,
  Password,
  PasswordChangeDate,
  CreatedBy,
  CreatedDate,
  FirstTimeLogin,
  EmailAddress
)
VALUES
(
  @FirstName,
  @LastName,
  @UserName,
	@NewSalt,
  HASHBYTES ('SHA1', @Password + CONVERT(Char(16), @NewSalt)),
  GETDATE(),
  @CreatedBy,
  GETDATE(),
  1,
  @EmailAddress
)
SET @UserID = SCOPE_IDENTITY()


RETURN
GO
/****** Object:  StoredProcedure [InsProcs].[InsWebGridLayout]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [InsProcs].[InsWebGridLayout]
(
       @UserID Int,
       @UniqueKey VarChar(100),
       @LayoutInfo VarChar(Max),
       @LayoutName VarChar(100),
       @ParentLayout VarChar(100) = NULL,
       @AllUsers Bit
)
As

       DECLARE @WebGridInfoID Int,
                                  @WebGridUserInfoID Int
       SELECT @WebGridInfoID = WebGridInfoID FROM WebGridInfo WHERE UniqueKey = @UniqueKey

       IF @WebGridInfoID IS NULL
       BEGIN
       
              INSERT INTO WebGridInfo(UniqueKey)
              VALUES (@UniqueKey)
       
              SET @WebGridInfoID = SCOPE_IDENTITY()
              
       END
       
       DECLARE @ParentLayoutID Int
       SELECT @ParentLayoutID = WebGridUserInfoID
       FROM WebGridUserInfo 
       WHERE WebGridInfoID = @WebGridInfoID 
              AND UserID = @UserID
              AND LayoutName = @ParentLayout
              
       SELECT @WebGridUserInfoID = WebGridUserInfoID 
       FROM WebGridUserInfo 
       WHERE WebGridInfoID = @WebGridInfoID 
              AND UserID = @UserID 
              AND LayoutName = @LayoutName
              AND ISNULL(ParentLayoutID, 0) = ISNULL(@ParentLayoutID, 0)

       IF @LayoutInfo IS NOT NULL
       BEGIN
       
              IF @WebGridUserInfoID IS NULL
              BEGIN
              
                     INSERT INTO WebGridUserInfo (WebGridInfoID, UserID, LayoutName, LayoutInfo, ParentLayoutID)
                     VALUES (@WebGridInfoID, @UserID, @LayoutName, @LayoutInfo, @ParentLayoutID)
              
              END
              ELSE
              BEGIN
              
                     UPDATE WebGridUserInfo SET LayoutInfo = @LayoutInfo WHERE WebGridUserInfoID = @WebGridUserInfoID
              
              END
       
       END
       ELSE
       BEGIN
       
              DELETE FROM WebGridUserInfo WHERE ParentLayoutID = @WebGridUserInfoID
              DELETE FROM WebGridUserInfo WHERE WebGridUserInfoID = @WebGridUserInfoID
       
       END

GO
/****** Object:  StoredProcedure [UpdProcs].[updCategory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updCategory]
(
  @CategoryID int,
  @CategoryName varchar(255)
)
AS

-- Update statement
UPDATE Category
SET
  CategoryName = @CategoryName
WHERE CategoryID = @CategoryID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updDocument]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UpdProcs].[updDocument]
(
  @DocumentID int,
  @DocumentName varchar(255),
  @DocumentData varbinary,
  @CreatedBy int,
  @DocumentHash binary
)
AS

-- Update statement
UPDATE Documents
SET
  DocumentName = @DocumentName,
  DocumentData = @DocumentData,
  CreatedBy = @CreatedBy,
  DocumentHash = @DocumentHash
WHERE DocumentID = @DocumentID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updEmail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updEmail]
(
  @EmailID int,
  @ToEmailAddress varchar(1000),
  @FromEmailAddress varchar(100),
  @FriendlyFrom varchar(50),
  @Subject varchar(255),
  @Body varchar(MAX),
  @CCEmailAddresses varchar(1000),
  @CreatedBy varchar(255),
  @DateToSend datetime,
  @SentDate datetime,
  @NotSentError varchar(1024),
  @Ignore bit
)
AS

-- Update statement
UPDATE Emails
SET
  ToEmailAddress = @ToEmailAddress,
  FromEmailAddress = @FromEmailAddress,
  FriendlyFrom = @FriendlyFrom,
  Subject = @Subject,
  Body = @Body,
  CCEmailAddresses = @CCEmailAddresses,
  DateToSend = @DateToSend,
  SentDate = @SentDate,
  NotSentError = @NotSentError,
  Ignore = @Ignore
WHERE EmailID = @EmailID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updEmailAttachment]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updEmailAttachment]
(
  @EmailAttachmentID int,
  @EmailID int,
  @AttachmentName varchar(255),
  @AddressOfAttachment varchar(512),
  @AttachmentData varbinary(MAX)
)
AS

-- Update statement
UPDATE EmailAttachments
SET
  EmailID = @EmailID,
  AttachmentName = @AttachmentName,
  AddressOfAttachment = @AddressOfAttachment,
  AttachmentData = @AttachmentData
WHERE EmailAttachmentID = @EmailAttachmentID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updGeneralUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UpdProcs].[updGeneralUser]
(
  @UserID int,
  @FirstName  varchar(50),
  @LastName varchar(50),
  @UserName varchar(50),
  @Password varbinary(500),
  @Salt binary(16),
  @RFID varchar(100),
  @PasswordChangeDate datetime,
  @CreatedBy int,
  @FirstTimeLogin bit,
  @EmailAddress varchar(100),
  @DeductID int,
  @ResetState  int
)
AS

-- Update statement
UPDATE [Users]
SET
  FirstName = @FirstName,
  LastName = @LastName,
  UserName = @UserName,
  Password = @Password,
  Salt = @Salt,
  RFID = @RFID,
  PasswordChangeDate = @PasswordChangeDate,
  FirstTimeLogin = @FirstTimeLogin,
  EmailAddress = @EmailAddress,
  DeductID = @DeductID,
  ResetState = @ResetState
WHERE UserID = @UserID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updInventory]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updInventory]
(
  @InventoryID int,
  @ProductID int,
  @InventoryQuantity int,
  @CurrentInventoryQuantity int,
  @InventoryItemCost decimal(18, 0),
  @InventoryTypeID int
)
AS

-- Update statement
UPDATE Inventory
SET
  ProductID = @ProductID,
  InventoryQuantity = @InventoryQuantity,
  CurrentInventoryQuantity = @CurrentInventoryQuantity,
  InventoryItemCost = @InventoryItemCost,
  InventoryTypeID = @InventoryTypeID
WHERE InventoryID = @InventoryID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updLocalisationKey]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updLocalisationKey]
(
  @LocalisationKeyID int,
  @Key varchar(100),
  @DefaultValue varchar(1024)
)
AS

-- Update statement
UPDATE LocalisationKeys
SET
  [Key] = @Key,
  DefaultValue = @DefaultValue
WHERE LocalisationKeyID = @LocalisationKeyID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updLocalisationValue]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updLocalisationValue]
(
  @LocalisationValueID int,
  @LocalisationKeyID int,
  @LanguageID int,
  @Value varchar(1024)
)
AS

-- Update statement
UPDATE LocalisationValues
SET
  LocalisationKeyID = @LocalisationKeyID,
  LanguageID = @LanguageID,
  Value = @Value
WHERE LocalisationValueID = @LocalisationValueID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updmyCart]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UpdProcs].[updmyCart]
(
  @OrderID int ,
  @UserID int,
  @ProductID int,
  @ProductQuantity int,
  @UnitPrice decimal(18,2),
  @OrderDetailsID int
)
AS

-- Update statement



RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updOrder]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UpdProcs].[updOrder]
(
  @OrderID int,
  @UserID int,
  @OrderDate datetime,
  @RequiredDate date,
  @ProcessStatusID int
)
AS

-- Update statement
UPDATE [Order]
SET
 -- UserID = @UserID,
  OrderDate = @OrderDate,
  RequiredDate = @RequiredDate,
  ProcessStatusID = @ProcessStatusID
WHERE OrderID = @OrderID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updOrderDetail]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updOrderDetail]
(
  @orderID int,
  @ProductID int,
  @ProductQuantity int,
  @UnitPrice decimal(18, 2),
  @OrderDetailsID int
)
AS

-- Update statement
UPDATE OrderDetails
SET
  orderID = @orderID,
  ProductID = @ProductID,
  ProductQuantity = @ProductQuantity,
  UnitPrice = @UnitPrice
WHERE OrderDetailsID = @OrderDetailsID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updProduct]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updProduct]
(
  @ProductID int,
  @CategoryID int,
  @ProductName varchar(255),
  @ProductPrice smallint,
  @DeleteStatus bit
)
AS

-- Update statement
UPDATE Product
SET
  CategoryID = @CategoryID,
  ProductName = @ProductName,
  ProductPrice = @ProductPrice,
  DeleteStatus = @DeleteStatus 
WHERE ProductID = @ProductID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSale]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updSale]
(
  @SaleID int,
  @ProductID int,
  @SaleAmount decimal(18, 0)
)
AS

-- Update statement
UPDATE Sale
SET
  ProductID = @ProductID,
  SaleAmount = @SaleAmount
WHERE SaleID = @SaleID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSecurityGroup]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updSecurityGroup]
(
  @SecurityGroupID int,
  @SecurityGroup varchar(50),
  @Description varchar(255)
)
AS

-- Update statement
UPDATE SecurityGroups
SET
  SecurityGroup = @SecurityGroup,
  Description = @Description
WHERE SecurityGroupID = @SecurityGroupID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSecurityGroupRole]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updSecurityGroupRole]
(
  @SecurityGroupRoleID int,
  @SecurityGroupID int,
  @SecurityRoleID int,
  @SelectedInd Bit
)
AS

IF @SelectedInd = 0 
BEGIN

	DELETE FROM SecurityGroupRoles WHERE SecurityGroupRoleID = @SecurityGroupRoleID

END

---- Update statement
--UPDATE SecurityGroupRoles
--SET
--  SecurityGroupID = @SecurityGroupID,
--  SecurityRoleID = @SecurityRoleID
--WHERE SecurityGroupRoleID = @SecurityGroupRoleID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSecurityGroupUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UpdProcs].[updSecurityGroupUser]
(
  @SecurityGroupUserID int OUTPUT,
  @SecurityGroupID int,
  @UserID int
)
AS

-- Insert statement
UPDATE SecurityGroupUsers 
	SET SecurityGroupID = @SecurityGroupID 
WHERE SecurityGroupUserID = @SecurityGroupUserID 


RETURN

GO
/****** Object:  StoredProcedure [UpdProcs].[updServerProgramType]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updServerProgramType]
(
  @ServerProgramTypeID int,
  @ServerProgramType varchar(50),
  @Info varbinary(MAX),
  @ActiveInd bit
)
AS

-- Update statement
UPDATE ServerPrograms
SET
  ServerProgram = @ServerProgramType,
  Info = @Info,
  ActiveInd = @ActiveInd
WHERE ServerProgramID = @ServerProgramTypeID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSystemSetting]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updSystemSetting]
(
  @SystemSettingID int,
  @SystemSetting varchar(50)
)
AS

-- Update statement
UPDATE SystemSettings
SET
  SystemSetting = @SystemSetting
WHERE SystemSettingID = @SystemSettingID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updSystemSettingValue]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UpdProcs].[updSystemSettingValue]
(
  @SystemSettingValueID int,
  @SystemSettingID int,
  @PropertyName varchar(50),
  @PropertyValue sql_variant,
  @PropertyBytes varBinary(Max)
)
AS

-- Update statement
UPDATE SystemSettingValues
SET
  SystemSettingID = @SystemSettingID,
  PropertyName = @PropertyName,
  PropertyValue = @PropertyValue,
  PropertyBytes = @PropertyBytes
WHERE SystemSettingValueID = @SystemSettingValueID


RETURN
GO
/****** Object:  StoredProcedure [UpdProcs].[updUser]    Script Date: 24/07/2019 07:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UpdProcs].[updUser]
(
  @UserID int,
  @FirstName varchar(50),
  @LastName varchar(50),
  @Password varchar(200),
  @EmailAddress varchar(100),
  @CreatedBy int
)
AS

IF ISNULL(@Password, '') <> ''
BEGIN
--Password has changed
EXEC CmdProcs.cmdChangePassword @UserID, '', @Password, 0
END


-- Insert statement
UPDATE Users
SET 
  FirstName = @FirstName,
  LastName = @LastName,
  EmailAddress = @EmailAddress
WHERE UserID = @UserID


RETURN
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System generated unique ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailAttachments', @level2type=N'COLUMN',@level2name=N'EmailAttachmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email to which this attachment belongs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailAttachments', @level2type=N'COLUMN',@level2name=N'EmailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the Attachment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailAttachments', @level2type=N'COLUMN',@level2name=N'AttachmentName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Address of attachment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailAttachments', @level2type=N'COLUMN',@level2name=N'AddressOfAttachment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data of Attachment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailAttachments', @level2type=N'COLUMN',@level2name=N'AttachmentData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System generated unique ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'EmailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email Address to which email should be sent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'ToEmailAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email address of the sender' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'FromEmailAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Friendly name of sender' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'FriendlyFrom'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subject of Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'Subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Body of email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'Body'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Any other employees that email should be sent to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'CCEmailAddresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Person who initiated creation of this email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date on which email was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date to send the email (will be 5 minutes after this date)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'DateToSend'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date on which email was sent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'SentDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Any errors encountered during sending' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'NotSentError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tick indicates that this email will be ignored' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'Ignore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Normal (BulkInd = false) emails will always be sent before bulk emails. Set to true if sending out a large batch of emails.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Emails', @level2type=N'COLUMN',@level2name=N'BulkInd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique ID for language' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Languages', @level2type=N'COLUMN',@level2name=N'LanguageID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Language description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Languages', @level2type=N'COLUMN',@level2name=N'Language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The key used to reference this word / phrase.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LocalisationKeys', @level2type=N'COLUMN',@level2name=N'Key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Word / Phrase in the default language of the system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LocalisationKeys', @level2type=N'COLUMN',@level2name=N'DefaultValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System Generated unique ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LoginAudits', @level2type=N'COLUMN',@level2name=N'LoginAuditID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'USerID ex User table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LoginAudits', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Incorrect Password / User Name, 1 = Successfull, 2 = Locked Out' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LoginAudits', @level2type=N'COLUMN',@level2name=N'LoginType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Name of the Group.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityGroups', @level2type=N'COLUMN',@level2name=N'SecurityGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A Short Description of the Group.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityGroups', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique system generated security role ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'SecurityRoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the Section' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'SectionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Security Role ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'SecurityRole'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the security role' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time the row was inserted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'RowTimestamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicates that the security role was automatically generated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SecurityRoles', @level2type=N'COLUMN',@level2name=N'AutoGeneratedInd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The last time the active service reported it was running.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ServerProgramLock', @level2type=N'COLUMN',@level2name=N'LastRunTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The instance name of the active service. (e.g. the name of the machine the service is running on)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ServerProgramLock', @level2type=N'COLUMN',@level2name=N'InstanceName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System Generated Unique ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemSettings', @level2type=N'COLUMN',@level2name=N'SystemSettingID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Class name that holds the properties defined by the system setting values.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemSettings', @level2type=N'COLUMN',@level2name=N'SystemSetting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System generated unique ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemSettingValues', @level2type=N'COLUMN',@level2name=N'SystemSettingValueID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SHA2_256 hashed password.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Salt to be combined with plain text password. This is a guid that is changed whenever the user changes their password.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Salt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last time the password was changed / when the user was created.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'PasswordChangeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was created.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Who created the record.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True when the user is created, set to false the first time they log in.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'FirstTimeLogin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Password reset state. 0 = Normal, 1=Must change password on login, 2=Locked out until password reset again.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'ResetState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'JSON object of the grids layout / groupings and filters.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebGridUserInfo', @level2type=N'COLUMN',@level2name=N'LayoutInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Users description of the layout.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebGridUserInfo', @level2type=N'COLUMN',@level2name=N'LayoutName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Grid Layout, 2 = Graph' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebGridUserInfo', @level2type=N'COLUMN',@level2name=N'LayoutType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link to the parent layout required for this layout. (Graphs require a grid layout for the graph data)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebGridUserInfo', @level2type=N'COLUMN',@level2name=N'ParentLayoutID'
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
         Begin Table = "Inventory"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 220
               Right = 263
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tuckshop_CurrentInventory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tuckshop_CurrentInventory'
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
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 943
               Bottom = 179
               Right = 1120
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 515
               Bottom = 180
               Right = 685
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Category"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 119
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 210
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
         Width = 2505
         Width = 2850
         Width = 2370
         Width = 2595
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TuckshopSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TuckshopSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TuckshopSales'
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
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inventory"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 217
               Right = 471
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
         Width = 3195
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EditIInventory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EditIInventory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[19] 3) )"
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
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 204
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 136
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 1
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
         Column = 2835
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_myCart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_myCart'
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
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 216
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 149
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 136
               Right = 633
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
         Width = 1620
         Width = 1815
         Width = 4845
         Width = 1530
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Sales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Sales'
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
         Begin Table = "Inventory"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 170
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 169
               Right = 471
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
         Width = 1920
         Width = 2460
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_stockprofit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_stockprofit'
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
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 450
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2415
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
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UserOrderList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UserOrderList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UserOrderList'
GO
USE [master]
GO
ALTER DATABASE [OfficeExpressTuckShop] SET  READ_WRITE 
GO
