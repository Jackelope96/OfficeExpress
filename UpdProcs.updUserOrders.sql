if exists (select * from dbo.sysobjects where id = object_id(N'UpdProcs.updUserOrders') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure UpdProcs.updUserOrders
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE UpdProcs.updUserOrders
(
  @OrderID ,
  @ProductName ,
  @FirstName ,
  @LastName ,
  @ProductQuantity ,
  @UnitPrice ,
  @OrderDate ,
  @RequiredDate ,
  @ProcessStatus 
)
AS

-- Update statement
UPDATE 
SET
  ProductName = @ProductName,
  FirstName = @FirstName,
  LastName = @LastName,
  ProductQuantity = @ProductQuantity,
  UnitPrice = @UnitPrice,
  OrderDate = @OrderDate,
  RequiredDate = @RequiredDate,
  ProcessStatus = @ProcessStatus
WHERE OrderID = @OrderID


RETURN