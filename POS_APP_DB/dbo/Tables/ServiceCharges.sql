CREATE TABLE [dbo].[ServiceCharges] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [Percent]         DECIMAL (18, 2) NULL,
    [IsApplicable]    BIT             CONSTRAINT [DF_ServiceCharges_Isapplicable] DEFAULT ((0)) NULL,
    [AppylOnCovers]   BIT             CONSTRAINT [DF_ServiceCharges_AppyOnCovers] DEFAULT ((0)) NULL,
    [OnCovers]        INT             CONSTRAINT [DF_ServiceCharges_OnCovers] DEFAULT ((0)) NULL,
    [ApplyOnAmount]   BIT             CONSTRAINT [DF_ServiceCharges_ApplyOnAmount] DEFAULT ((0)) NULL,
    [OnAmount]        FLOAT (53)      CONSTRAINT [DF_ServiceCharges_OnAmount] DEFAULT ((0)) NULL,
    [Company_Percent] DECIMAL (18, 2) DEFAULT ((0)) NULL,
    [Waiter_Percent]  DECIMAL (18, 2) DEFAULT ((0)) NULL
);

