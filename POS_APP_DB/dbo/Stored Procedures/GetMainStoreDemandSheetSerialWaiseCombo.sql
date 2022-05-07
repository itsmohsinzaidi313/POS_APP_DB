Create Proc [dbo].[GetMainStoreDemandSheetSerialWaiseCombo]
as
Select DSCOId,DSNo as [D.O No] from DemandSheetMaster_Store order by DSNo


