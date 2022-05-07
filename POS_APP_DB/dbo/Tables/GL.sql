CREATE TABLE [dbo].[GL] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [Type]        VARCHAR (40)    NULL,
    [VN]          NVARCHAR (50)   NULL,
    [VoucherId]   INT             NULL,
    [Date]        DATETIME        NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [CAId]        INT             NULL,
    [VoucherType] VARCHAR (40)    NULL,
    [COId]        INT             NULL,
    [APId]        INT             CONSTRAINT [DF_GL_APId] DEFAULT ((0)) NULL,
    CONSTRAINT [ChartOfAccount_GL] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE,
    CONSTRAINT [FK_GL_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId])
);


GO
create TRIGGER [dbo].[InsertGLAPId] ON [dbo].[GL]
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @APId int;
select @APId = max(APId) from AccountPeriod where IsActive = 1

Declare @MaxGlId int;
Declare @VN nvarchar(50);

select @MaxGlId = max(id) from Gl 
select @VN = VN from Gl where id = @MaxGlId

update gl set APId = @APId where VN = @VN
--where id = @MaxGlId

End