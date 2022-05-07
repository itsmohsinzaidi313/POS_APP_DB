




CREATE Proc [dbo].[HeadOffice_GetDataForWebServer]--'HeadOffice_GetDataForWebServer','<doc><title id="0" /></doc>'
@Type as nvarchar(50),
@xml as xml
as
BEGIN TRY    
BEGIN TRANSACTION  

declare @count as int;
set @count = 0;
truncate table Table4 
if @Type = 'GetDataForInsertToServer'
begin
Select * from departmentpos where Is_upload = 0 or Is_Update = 1
Select * from categorypos where Is_upload = 0 or Is_Update = 1
Select * from itempos where Is_upload = 0 or Is_Update = 1
Select * from deals  where Is_upload = 0 or Is_Update = 1
select * from Fixed_Comments_Instructions where is_upload = 0
select * from tax where is_upload = 0 or Is_Update = 1
select * from reasons where is_upload = 0 or Is_Update = 1
select * from itemcomments where is_upload = 0 or Is_Update = 1

end
if @Type = 'GetDataForUpdateToServer'
begin
Select * from departmentpos where Is_upload = 1 and Is_Update = 1
Select * from categorypos where Is_upload = 1 and Is_Update = 1
Select * from itempos where Is_upload = 1 and Is_Update = 1
Select * from deals  where Is_upload = 1 and Is_Update = 1
select * from tax where is_upload = 0 and is_update = 1
select * from reasons where is_upload = 0 and is_update = 1
select * from itemcomments where is_upload = 0 or Is_Update = 1

end

if @Type = 'insert_update_Department'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update DepartmentPOs set is_upload = 1 from DepartmentPOs t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'insert_update_Category'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update CategoryPOs set is_upload = 1 from CategoryPOs t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'insert_update_tax'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update tax set is_upload = 1 from tax t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end


if @Type = 'insert_update_item_comments'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update itemcomments set is_upload = 1 from itemcomments t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end



if @Type = 'insert_update_reasons'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update reasons set is_upload = 1 from reasons t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end


if @Type = 'insert_update_fix_comment'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update Fixed_Comments_Instructions set is_upload = 1 from Fixed_Comments_Instructions t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'insert_update_Item'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update ItemPOS set is_upload = 1 from ItemPOS t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'insert_update_deal'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update Deals set is_upload = 1 from Deals t1 INNER JOIN Table4 t2 ON t1.id = t2.id 
select @count = count(id) from Table4 
select @count;
end
end




if @Type = 'update_update_Department'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update DepartmentPOs set is_Update = 0 from DepartmentPOs t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'update_update_Category'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update CategoryPOs set is_Update = 0 from CategoryPOs t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'update_update_Item'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update ItemPOS set is_Update = 0 from ItemPOS t1 INNER JOIN Table4 t2 ON t1.id = t2.id
select @count = count(id) from Table4 
select @count;
end
end

if @Type = 'update_update_deal'
begin
insert into Table4(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table4 
if @count > 0
begin 
Update Deals set is_Update = 0 from Deals t1 INNER JOIN Table4 t2 ON t1.id = t2.id 
select @count = count(id) from Table4 
select @count;
end
end
















COMMIT 
END 
TRY 
BEGIN CATCH  
IF @@TRANCOUNT > 0    
ROLLBACK   exec uspGetErrorInfo
END CATCH 





















