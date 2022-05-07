CREATE TABLE [dbo].[DeliveryQualityPointsTable] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [OrderKey]     NVARCHAR (50) NULL,
    [SS_Execelent] NVARCHAR (50) NULL,
    [SS_Average]   NVARCHAR (50) NULL,
    [SS_Poor]      NVARCHAR (50) NULL,
    [FQ_Execelent] NVARCHAR (50) NULL,
    [FQ_Average]   NVARCHAR (50) NULL,
    [FQ_Poor]      NVARCHAR (50) NULL,
    [CO_Yes]       NVARCHAR (50) NULL,
    [CO_No]        NVARCHAR (50) NULL,
    [OTD_Yes]      NVARCHAR (50) NULL,
    [OTD_No]       NVARCHAR (50) NULL
);

