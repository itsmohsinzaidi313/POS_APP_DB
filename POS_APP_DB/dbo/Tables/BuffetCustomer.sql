CREATE TABLE [dbo].[BuffetCustomer] (
    [CustomerId] INT            IDENTITY (1, 1) NOT NULL,
    [Code]       NVARCHAR (50)  NULL,
    [Customer]   NVARCHAR (50)  NULL,
    [Address]    NVARCHAR (MAX) NULL,
    [PhoneNo]    NVARCHAR (50)  NULL,
    [MobileNo]   NVARCHAR (50)  NULL,
    [Email]      NVARCHAR (50)  NULL,
    [CNIC]       NVARCHAR (50)  NULL
);

