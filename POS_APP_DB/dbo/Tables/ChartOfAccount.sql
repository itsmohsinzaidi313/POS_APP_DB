CREATE TABLE [dbo].[ChartOfAccount] (
    [CAId]      INT             IDENTITY (1, 1) NOT NULL,
    [AccNo]     INT             NULL,
    [AccName]   NVARCHAR (MAX)  NULL,
    [AccNature] NVARCHAR (MAX)  NULL,
    [Type]      NVARCHAR (40)   NULL,
    [Level]     INT             NULL,
    [ParentId]  INT             CONSTRAINT [DEF_ChartOfAccount_ParentId] DEFAULT ((0)) NULL,
    [Desc]      VARCHAR (40)    NULL,
    [COId]      INT             NULL,
    [Op]        DECIMAL (18, 2) CONSTRAINT [DF_ChartOfAccount_Op] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ChartOfAccount] PRIMARY KEY CLUSTERED ([CAId] ASC)
);


GO
create TRIGGER [dbo].[InsertAccountOpenBalance] ON [dbo].[ChartOfAccount]
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @APId int;
Declare @Op decimal(18,2);
Declare @CAId int;
Declare @Type nvarchar(50);
Declare @COId int;

set @COId = 0;
set @APId = 0;
set @Op = 0;
set @CAId = 0;
set @Type = '0';

select 
 @Op = Op,
 @CAId = CAId,
 @Type = [Type],
 @COId = COId

 from ChartOfAccount
where CAId = (select max(CAId) from ChartOfAccount)

if @Type = 'DETAIL'
Begin
select @APId = APId from AccountPeriod where COId = @COId and IsActive = 1

insert into AccountOpenBalance 
(
Amount,
CAId,
APId
)
values 
(
@Op,
@CAId,
@APId
)


End



End




