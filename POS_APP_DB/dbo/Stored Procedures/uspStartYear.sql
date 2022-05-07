create proc [dbo].[uspStartYear]

@From as datetime,
@COId as int

as

insert into AccountPeriod ([From],COId)
values 
(@From,@COId)
