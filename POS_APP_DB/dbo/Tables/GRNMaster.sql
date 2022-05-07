CREATE TABLE [dbo].[GRNMaster] (
    [GRNId]       INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [VId]         INT             NULL,
    [GRNo]        VARCHAR (50)    NULL,
    [SId]         INT             CONSTRAINT [DF_GRNMaster_SId] DEFAULT ((0)) NULL,
    [BRId]        INT             CONSTRAINT [DF_GRNMaster_BRId] DEFAULT ((0)) NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Discount]    DECIMAL (18, 2) NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [RefrenceNo]  NVARCHAR (50)   NULL,
    [TotalTax]    DECIMAL (18, 2) NULL,
    [Desc]        NVARCHAR (MAX)  NULL,
    [uid]         INT             DEFAULT ((0)) NULL,
    CONSTRAINT [PK__GRNMaster_Aylant__3449B6E4] PRIMARY KEY CLUSTERED ([GRNId] ASC),
    CONSTRAINT [FK_GRNMaster_Vendor] FOREIGN KEY ([VId]) REFERENCES [dbo].[Vendor] ([VId])
);

