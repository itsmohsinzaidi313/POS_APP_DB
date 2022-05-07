CREATE proc [dbo].[uspApiGetUser]
@username varchar(50),
@password varchar(50),
@deviceId varchar(20)
as
begin try
	if(not exists(select id from Tilt where Serial = @deviceId))
	begin
		insert into Tilt(Serial, TilitName)
		select @deviceId, 'Tablet_' + cast((isnull((select max(id) from Tilt),0) + 1) as varchar(max))
	end

	if(exists(select z_report_number from Shift_Opening where status = 1))
	begin
		select id, username, (select id from Tilt where Serial = @deviceId) [tiltid] from tbl_user where username = @username and pwd = @password
	end
	else
	begin
		select 2
	end
end try
begin catch
	Print Error_message()
	Print Error_line()
	select -1
end catch