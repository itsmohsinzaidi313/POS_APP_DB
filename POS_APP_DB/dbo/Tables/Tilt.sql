CREATE TABLE [dbo].[Tilt] (
    [id]                    INT            IDENTITY (1, 1) NOT NULL,
    [TilitName]             NVARCHAR (50)  NULL,
    [Serial]                NVARCHAR (MAX) NULL,
    [CounterWiseOrder]      BIT            CONSTRAINT [DF_Tilt_CounterWiseOrder] DEFAULT ((0)) NULL,
    [ConSolidatedKOT]       BIT            CONSTRAINT [DF_Tilt_ConSolidatedKOT] DEFAULT ((0)) NULL,
    [ItemLessKOT]           BIT            DEFAULT ((1)) NOT NULL,
    [is_upload]             BIT            DEFAULT ((0)) NOT NULL,
    [is_update]             BIT            DEFAULT ((0)) NOT NULL,
    [Is_Update_From_Server] BIT            DEFAULT ((0)) NOT NULL
);

