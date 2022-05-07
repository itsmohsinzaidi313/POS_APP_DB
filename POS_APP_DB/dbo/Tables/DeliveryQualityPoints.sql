CREATE TABLE [dbo].[DeliveryQualityPoints] (
    [ServiceSatisfactory] NVARCHAR (50) NULL,
    [SS_Points]           DECIMAL (18)  CONSTRAINT [DF_DeliveryQualityPoints_SS_Points] DEFAULT ((0)) NOT NULL,
    [FoodQuality]         NVARCHAR (50) NULL,
    [FQ_Points]           DECIMAL (18)  CONSTRAINT [DF_DeliveryQualityPoints_FQ_Points] DEFAULT ((0)) NOT NULL,
    [CorrectOrder]        NVARCHAR (50) NULL,
    [CO_Points]           DECIMAL (18)  CONSTRAINT [DF_DeliveryQualityPoints_CO_Points] DEFAULT ((0)) NOT NULL,
    [OnTimeDelivery]      NVARCHAR (50) NULL,
    [OTD_Points]          DECIMAL (18)  CONSTRAINT [DF_DeliveryQualityPoints_OTD_Points] DEFAULT ((0)) NOT NULL
);

