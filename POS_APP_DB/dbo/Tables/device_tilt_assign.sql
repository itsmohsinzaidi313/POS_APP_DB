CREATE TABLE [dbo].[device_tilt_assign] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [tilt_id]   INT           NOT NULL,
    [device_no] NVARCHAR (50) NULL,
    [is_upload] INT           CONSTRAINT [DF_device_tilt_assign_is_upload] DEFAULT ((0)) NULL,
    [is_update] INT           CONSTRAINT [DF_device_tilt_assign_is_update] DEFAULT ((0)) NULL
);

