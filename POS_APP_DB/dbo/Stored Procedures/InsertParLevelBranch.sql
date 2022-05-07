


CREATE proc [dbo].[InsertParLevelBranch]
@XML as xml
as
insert into ItemParlevel
(
ItemId,
Parlevel,
BRId,
SId
)

Select

myXML.value('./@ItemId','int'),
myXML.value('./@Parlevel','decimal(18,2)'),
myXML.value('./@BRId','int'),
'0'

FROM @XML.nodes('/doc/title') As nodes(myXML);
SET NOCOUNT OFF;




--select * from ItemParlevel

