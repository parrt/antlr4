USE msdb;
EXECUTE sp_add_job @job_name = 'TestJob';
BEGIN
	    WAITFOR TIME '22:20';
	    EXECUTE sp_update_job @job_name = 'TestJob',
	        @new_name = 'UpdatedJob';
	END;
	GO
