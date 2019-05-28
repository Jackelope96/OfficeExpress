if exists (select * from dbo.sysobjects where id = object_id(N'DelProcs.delUserOrders') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure DelProcs.delUserOrders
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE DelProcs.delUserOrders
(
  @OrderID int
)
AS

DELETE FROM  WHERE OrderID = @OrderID


RETURN