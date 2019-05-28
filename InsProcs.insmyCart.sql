if exists (select * from dbo.sysobjects where id = object_id(N'InsProcs.insmyCart') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure InsProcs.insmyCart
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE InsProcs.insmyCart
(
  @OrderID ,
  @UserID ,
  @ProductID ,
  @ProductQuantity ,
  @UnitPrice ,
  @OrderDetailsID  OUTPUT
)
AS

-- Insert statement
INSERT INTO 
(
  OrderID,
  UserID,
  ProductID,
  ProductQuantity,
  UnitPrice
)
VALUES
(
  @OrderID,
  @UserID,
  @ProductID,
  @ProductQuantity,
  @UnitPrice
)
SET @OrderDetailsID = SCOPE_IDENTITY()


RETURN