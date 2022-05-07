CREATE TABLE [dbo].[RiderCashFloat] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [ShiftNo]       NVARCHAR (50)  NULL,
    [Rider]         NVARCHAR (MAX) NULL,
    [CheackIn]      NVARCHAR (50)  NULL,
    [OpeningAmount] FLOAT (53)     NULL,
    [CheackOut]     NVARCHAR (50)  NULL,
    [ClosingAmount] FLOAT (53)     NULL,
    [Date]          DATETIME       NULL,
    [CheackInDate]  DATETIME       NULL,
    [CheackOutDate] DATETIME       NULL,
    [ChkInStatus]   BIT            CONSTRAINT [DF_RiderCashFloat_ChkInStatus] DEFAULT ((0)) NULL,
    [ChkOutStatus]  BIT            CONSTRAINT [DF_RiderCashFloat_ChkOutStatus] DEFAULT ((0)) NULL,
    [ReadingIn]     INT            DEFAULT ((0)) NOT NULL,
    [ReadingOut]    INT            DEFAULT ((0)) NOT NULL
);

