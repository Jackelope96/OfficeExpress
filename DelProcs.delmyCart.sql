if exists (select * from dbo.sysobjects where id = object_id(N'DelProcs.delmyCart') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure DelProcs.delmyCart
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE DelProcs.delmyCart
(
  @OrderDetailsID int
)
AS

DELETE FROM  WHERE OrderDetailsID = @OrderDetailsID


RETURN