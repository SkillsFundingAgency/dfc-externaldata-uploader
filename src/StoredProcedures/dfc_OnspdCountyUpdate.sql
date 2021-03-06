USE [dfc-coursedirectory]
GO
/****** Object:  StoredProcedure [dbo].[dfc_OnspdCountyUpdate]    Script Date: 14/03/2019 11:26:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[dfc_OnspdCountyUpdate] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	MERGE [ONSPD_County] AS TARGET
	USING [ONSPD_County_Temp] AS SOURCE
	ON (TARGET.[CTY10CD] = SOURCE.[CTY10CD])
	WHEN MATCHED AND TARGET.[CTY10NM] <> SOURCE.[CTY10NM] THEN
	UPDATE SET TARGET.[CTY10NM] = SOURCE.[CTY10NM]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT ([CTY10CD] ,[CTY10NM])
	VALUES (SOURCE.[CTY10CD] ,SOURCE.[CTY10NM])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
END
