USE [OfficeExpressTuckShop]
GO
/****** Object:  StoredProcedure [UpdProcs].[updmyCart]    Script Date: 21/02/2019 14:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE UpdProcs.updmyCart
(
  @OrderID int ,
  @UserID int,
  @ProductID int,
  @ProductQuantity decimal,
  @UnitPrice decimal(18,2),
  @OrderDetailsID int
)
AS

-- Update statement



RETURN