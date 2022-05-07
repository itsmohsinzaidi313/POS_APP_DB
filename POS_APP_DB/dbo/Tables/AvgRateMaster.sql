CREATE TABLE [dbo].[AvgRateMaster] (
    [AMID]         INT           IDENTITY (1, 1) NOT NULL,
    [AvgRateMonth] NVARCHAR (50) NOT NULL,
    [CalcDate]     SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_AvgRateMaster] PRIMARY KEY CLUSTERED ([AvgRateMonth] ASC),
    CONSTRAINT [IX_AvgRateMaster] UNIQUE NONCLUSTERED ([AMID] ASC)
);

