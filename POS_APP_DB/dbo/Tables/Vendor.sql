CREATE TABLE [dbo].[Vendor] (
    [VId]       INT             IDENTITY (1, 1) NOT NULL,
    [Vendor]    NVARCHAR (50)   NULL,
    [Address]   NVARCHAR (MAX)  NULL,
    [CellNo]    NVARCHAR (50)   NULL,
    [COId]      INT             NULL,
    [OpBalance] DECIMAL (18, 2) NULL,
    [Fax]       NVARCHAR (50)   NULL,
    [Email]     NVARCHAR (50)   NULL,
    [CAId]      INT             CONSTRAINT [DF_Vendor_CAId] DEFAULT ((0)) NULL,
    [PreOp]     DECIMAL (18, 2) CONSTRAINT [DF_Vendor_PreOp] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([VId] ASC),
    CONSTRAINT [FK_Vendor_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId])
);


GO
CREATE TRIGGER [dbo].[InsertAccountOpenBalanceVendor] ON [dbo].[Vendor]
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @APId int;
Declare @Op decimal(18,2);
Declare @CAId int;
Declare @COId int;
Declare @PreOp decimal(18,2);
Declare @VId int;
Declare @Date datetime;

set @COId = 0;
set @APId = 0;
set @Op = 0;
set @CAId = 0;
set @PreOp = 0;
set @VId = 0;

--select * from Vendor
--select * from SupplierLedger
select @Date = GetDate();
select @VId = VId from Vendor where VId = (select max(VId) from Vendor)
 

select 
 @Op = OpBalance,
 @CAId = CAId,
 @COId = COId

 from Vendor
where VId = @VId

select @APId = APId from AccountPeriod where COId = @COId and IsActive = 1

select @PreOp = Amount from AccountOpenBalance where APId = @APId and CAId = @CAId

execute [uspInsertSupplierLedger]@VId,0,@Op,'C','OPENING',@COId,@Date;

Update AccountOpenBalance set Amount = @Op + @PreOp where CAId = @CAId and APId = @APId

--insert into AccountOpenBalance 
--(
--Amount,
--CAId,
--APId
--)
--values 
--(
--@Op + @PreOp,
--@CAId,
--@APId
--)


End












GO

CREATE TRIGGER [dbo].[TR_Vendor_Update]
ON [dbo].[Vendor]
FOR UPDATE 
AS
BEGIN

Declare @COId int;
Declare @APId int;
Declare @VId as int;
Declare @CAId as int;
Declare @Op as decimal(18,2);
Declare @AcOp as decimal(18,2);
Declare @FinalOp as decimal(18,2);
Declare @PreOp as decimal(18,2);

set @COId = 0;
set @VId = 0;
set @CAId = 0;
set @Op = 0;
set @APId = 0;
set @AcOp = 0;
set @FinalOp = 0;
set @PreOp = 0;

select @VId = VId from Inserted
select @CAId = CAId , @Op = OpBalance, @PreOp = PreOp, @COId = COId from Vendor where VId = @VId
select @APId = APId from AccountPeriod where COId = @COId and IsActive = 1
select @AcOp = Amount from AccountOpenBalance where APId = @APId and CAId = @CAId

set @FinalOp = (@AcOp - @PreOp) + (@Op);

Update AccountOpenBalance set Amount = @FinalOp where CAId = @CAId and APId = @APId
Update SupplierLedger set Amount = @Op where VoucherType = 'OPENING' and VoucherId = 0 and VId = @VId

END

