CREATE TABLE [dbo].[Cashdrawer] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [ComPort]        NVARCHAR (50) NULL,
    [Tiltid]         INT           NULL,
    [GsmComPort]     NVARCHAR (50) NULL,
    [DisplayComPort] NVARCHAR (50) NULL
);

