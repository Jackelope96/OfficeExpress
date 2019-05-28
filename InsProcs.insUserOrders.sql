if exists (select * from dbo.sysobjects where id = object_id(N'InsProcs.insUserOrders') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure InsProcs.insUserOrders
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE InsProcs.insUserOrders
(
  @OrderID  OUTPUT,
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

-- Insert statement
INSERT INTO 
(
  ProductName,
  FirstName,
  LastName,
  ProductQuantity,
  UnitPrice,
  OrderDate,
  RequiredDate,
  ProcessStatus
)
VALUES
(
  @ProductName,
  @FirstName,
  @LastName,
  @ProductQuantity,
  @UnitPrice,
  @OrderDate,
  @RequiredDate,
  @ProcessStatus
)
SET @OrderID = SCOPE_IDENTITY()


RETURN