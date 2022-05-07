CREATE TABLE [dbo].[AvgRateDetail] (
    [Id]           INT             IDENTITY (1, 1) NOT NULL,
    [ItemId]       INT             NOT NULL,
    [AvgRateMonth] NVARCHAR (50)   NOT NULL,
    [AvgRate]      DECIMAL (18, 2) NULL,
    [DateFrom]     SMALLDATETIME   NULL,
    [DateTo]       SMALLDATETIME   NULL,
    [AmId]         INT             NULL
);

