CREATE PROCEDURE [dbo].[dfc_OnspdUpdate]
	-- Add the parameters for the stored procedure here
	@updated datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	MERGE [onspd] AS TARGET
	USING [ssis-onspd-temp] AS SOURCE
	ON (TARGET.pcd = SOURCE.pcd)
    WHEN MATCHED AND TARGET.pcd2 <> SOURCE.pcd2 OR TARGET.pcds <> SOURCE.pcds 
	OR TARGET.[dointr] <> SOURCE.[dointr]  OR TARGET.[doterm] <> SOURCE.[doterm]
      OR TARGET.[oscty]  <> SOURCE.[oscty] OR TARGET.[ced]  <> SOURCE.[ced]
      OR TARGET.[oslaua]  <> SOURCE.[oslaua] OR TARGET.[osward]  <> SOURCE.[osward]
      OR TARGET.[parish]  <> SOURCE.[parish] OR TARGET.[usertype]  <> SOURCE.[usertype]
      OR TARGET.[oseast1m]  <> SOURCE.[oseast1m] OR TARGET.[osnrth1m]  <> SOURCE.[osnrth1m]
      OR TARGET.[osgrdind]  <> SOURCE.[osgrdind]  OR TARGET.[oshlthau]  <> SOURCE.[oshlthau]
      OR TARGET.[nhser]  <> SOURCE.[nhser] OR TARGET.[ctry]  <> SOURCE.[ctry]
      OR TARGET.[rgn]  <> SOURCE.[rgn] OR TARGET.[streg]  <> SOURCE.[streg]
      OR TARGET.[pcon]  <> SOURCE.[pcon] OR TARGET.[eer]  <> SOURCE.[eer]
      OR TARGET.[teclec]  <> SOURCE.[teclec] OR TARGET.[ttwa]  <> SOURCE.[ttwa]
      OR TARGET.[pct]  <> SOURCE.[pct] OR TARGET.[nuts]  <> SOURCE.[nuts]
      OR TARGET.[statsward]  <> SOURCE.[statsward] OR TARGET.[oa01]  <> SOURCE.[oa01]
      OR TARGET.[casward]  <> SOURCE.[casward] OR TARGET.[park]  <> SOURCE.[park]
      OR TARGET.[lsoa01]  <> SOURCE.[lsoa01] OR TARGET.[msoa01]  <> SOURCE.[msoa01]
      OR TARGET.[ur01ind]  <> SOURCE.[ur01ind] OR TARGET.[oac01]  <> SOURCE.[oac01]
      OR TARGET.[oa11]  <> SOURCE.[oa11] OR TARGET.[lsoa11]  <> SOURCE.[lsoa11]
      OR TARGET.[msoa11]  <> SOURCE.[msoa11] OR TARGET.[wz11]  <> SOURCE.[wz11]
      OR TARGET.[ccg]  <> SOURCE.[ccg] OR TARGET.[bua11]  <> SOURCE.[bua11]
      OR TARGET.[buasd11]  <> SOURCE.[buasd11] OR TARGET.[ru11ind]  <> SOURCE.[ru11ind]
      OR TARGET.[oac11]  <> SOURCE.[oac11] OR TARGET.[lat]  <> SOURCE.[lat]
      OR TARGET.[long]  <> SOURCE.[long] OR TARGET.[lep1]  <> SOURCE.[lep1]
      OR TARGET.[lep2]  <> SOURCE.[lep2] OR TARGET.[pfa]  <> SOURCE.[pfa]
      OR TARGET.[imd]  <> SOURCE.[imd] OR TARGET.[calncv]  <> SOURCE.[calncv]
      OR TARGET.[stp]  <> SOURCE.[stp] THEN
	UPDATE SET TARGET.pcd2 = SOURCE.pcd2, TARGET.pcds = SOURCE.pcds,					-- add update fields here
	TARGET.[dointr] = SOURCE.[dointr],TARGET.[doterm] = SOURCE.[doterm],TARGET.[oscty] = SOURCE.[oscty],TARGET.[ced] = SOURCE.[ced]
      ,TARGET.[oslaua] = SOURCE.[oslaua],TARGET.[osward] = SOURCE.[osward],TARGET.[parish] = SOURCE.[parish],TARGET.[usertype] = SOURCE.[usertype]
      ,TARGET.[oseast1m] = SOURCE.[oseast1m],TARGET.[osnrth1m] = SOURCE.[osnrth1m],TARGET.[osgrdind] = SOURCE.[osgrdind],TARGET.[oshlthau] = SOURCE.[oshlthau]
      ,TARGET.[nhser] = SOURCE.[nhser],TARGET.[ctry] = SOURCE.[ctry],TARGET.[rgn] = SOURCE.[rgn],TARGET.[streg] = SOURCE.[streg],TARGET.[pcon] = SOURCE.[pcon]
      ,TARGET.[eer] = SOURCE.[eer],TARGET.[teclec] = SOURCE.[teclec],TARGET.[ttwa] = SOURCE.[ttwa],TARGET.[pct] = SOURCE.[pct] ,TARGET.[nuts] = SOURCE.[nuts]
      ,TARGET.[statsward] = SOURCE.[statsward],TARGET.[oa01] = SOURCE.[oa01],TARGET.[casward] = SOURCE.[casward],TARGET.[park] = SOURCE.[park]
      ,TARGET.[lsoa01] = SOURCE.[lsoa01],TARGET.[msoa01] = SOURCE.[msoa01],TARGET.[ur01ind] = SOURCE.[ur01ind],TARGET.[oac01] = SOURCE.[oac01]
      ,TARGET.[oa11] = SOURCE.[oa11],TARGET.[lsoa11] = SOURCE.[lsoa11],TARGET.[msoa11] = SOURCE.[msoa11] ,TARGET.[wz11] = SOURCE.[wz11]
      ,TARGET.[ccg] = SOURCE.[ccg],TARGET.[bua11] = SOURCE.[bua11],TARGET.[buasd11] = SOURCE.[buasd11],TARGET.[ru11ind] = SOURCE.[ru11ind]
      ,TARGET.[oac11] = SOURCE.[oac11],TARGET.[lat] = SOURCE.[lat],TARGET.[long] = SOURCE.[long],TARGET.[lep1] = SOURCE.[lep1]
      ,TARGET.[lep2] = SOURCE.[lep2],TARGET.[pfa] = SOURCE.[pfa],TARGET.[imd] = SOURCE.[imd],TARGET.[calncv] = SOURCE.[calncv]
	  ,TARGET.[stp] = SOURCE.[stp],TARGET.updated = @updated
	WHEN NOT MATCHED BY TARGET THEN 
	INSERT ([pcd], [pcd2],[pcds], [dointr],[doterm],[oscty],[ced],[oslaua],[osward],[parish],[usertype],[oseast1m],[osnrth1m],[osgrdind],[oshlthau],[nhser]
		,[ctry],[rgn],[streg],[pcon],[eer],[teclec],[ttwa],[pct],[nuts],[statsward],[oa01],[casward],[park],[lsoa01],[msoa01],[ur01ind],[oac01],[oa11],[lsoa11]
		,[msoa11],[wz11],[ccg],[bua11],[buasd11],[ru11ind],[oac11],[lat],[long],[lep1],[lep2],[pfa],[imd],[calncv],[stp], [updated])																-- add insert fields here
	VALUES(SOURCE.pcd, SOURCE.pcd2, SOURCE.pcds, SOURCE.[dointr],SOURCE.[doterm],SOURCE.[oscty],SOURCE.[ced],SOURCE.[oslaua],SOURCE.[osward],SOURCE.[parish],SOURCE.[usertype],SOURCE.[oseast1m],SOURCE.[osnrth1m],SOURCE.[osgrdind],SOURCE.[oshlthau],SOURCE.[nhser]
		,SOURCE.[ctry],SOURCE.[rgn],SOURCE.[streg],SOURCE.[pcon],SOURCE.[eer],SOURCE.[teclec],SOURCE.[ttwa],SOURCE.[pct],SOURCE.[nuts],SOURCE.[statsward],SOURCE.[oa01],SOURCE.[casward],SOURCE.[park],SOURCE.[lsoa01],SOURCE.[msoa01],SOURCE.[ur01ind],SOURCE.[oac01],SOURCE.[oa11],SOURCE.[lsoa11]
		,SOURCE.[msoa11],SOURCE.[wz11],SOURCE.[ccg],SOURCE.[bua11],SOURCE.[buasd11],SOURCE.[ru11ind],SOURCE.[oac11],SOURCE.[lat],SOURCE.[long],SOURCE.[lep1],SOURCE.[lep2],SOURCE.[pfa],SOURCE.[imd],SOURCE.[calncv],SOURCE.[stp], @updated)

	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	
END
