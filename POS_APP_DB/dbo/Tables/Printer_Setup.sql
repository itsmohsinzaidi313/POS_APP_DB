CREATE TABLE [dbo].[Printer_Setup] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [printer]    NVARCHAR (50) NULL,
    [department] NVARCHAR (50) NULL,
    [document]   NVARCHAR (50) NULL,
    [TiltId]     INT           NULL,
    [order_type] NVARCHAR (50) NULL
);

