USE [dfc-coursedirectory]
GO
/****** Object:  StoredProcedure [dbo].[dfc_OnspdCountryUpdate]    Script Date: 14/03/2019 11:24:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[dfc_OnspdCountryUpdate] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    MERGE [ONSPD_Country] AS TARGET
	USING [ONSPD_Country_Temp] AS SOURCE
	ON (TARGET.[CTRY12CD] = SOURCE.[CTRY12CD])
	WHEN MATCHED AND TARGET.[CTRY12CDO] <> SOURCE.[CTRY12CDO] OR TARGET.[CTRY12NM] <> SOURCE.[CTRY12NM]
	OR TARGET.[CTRY12NMW] <> SOURCE.[CTRY12NMW] THEN
	UPDATE SET TARGET.[CTRY12CDO] = SOURCE.[CTRY12CDO], TARGET.[CTRY12NM] = SOURCE.[CTRY12NM],
	TARGET.[CTRY12NMW] = SOURCE.[CTRY12NMW]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (  [CTRY12CD],[CTRY12CDO],[CTRY12NM],[CTRY12NMW] )
	VALUES (SOURCE.[CTRY12CD], SOURCE.[CTRY12CDO], SOURCE.[CTRY12NM], SOURCE.[CTRY12NMW])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

END
