CREATE PROCEDURE [dbo].[dfc_OnspdExecuteSsisPackage]
	-- Add the parameters for the stored procedure here
	@updated datetime,
	@output_execution_id bigint output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @execution_id bigint
   	declare @dt datetime
	set @dt = GETDATE()
	
	exec ssisdb.catalog.set_environment_variable_value 
			@folder_name = N'Onspd',
			@environment_name=N'OnspdEnvironment',
			@variable_name = N'UpdatedDateTime',
			@value = @dt
	
	exec ssisdb.catalog.create_execution 
			 @folder_name = 'Onspd'
			,@project_name = 'onspd-update'
			,@package_name = 'Package.dtsx'
			,@execution_id = @execution_id output

	exec SSISDB.catalog.set_execution_parameter_value
			@execution_id = @execution_id,
			@object_type = 30,					-- 20 = project parameter, 30 = package parameter
			@parameter_name = N'UpdatedDateTime',
			@parameter_value = @dt

	exec ssisdb.catalog.start_execution @execution_id

	set @output_execution_id = @execution_id

END
