CREATE proc [dbo].[uspApiInsertFeedback]
@data xml
as
begin try
begin transaction
	declare 
		@feedbackId int

	insert into feedback
		(order_key, customer_name, customer_contact, remarks)
	select
		c.value('OrderKey[1]','int'), c.value('Name[1]','varchar(200)'), c.value('Contact[1]','varchar(200)'), c.value('Remarks[1]','varchar(max)') 
		from @data.nodes('Feedback') t(c)

	set @feedbackId = @@IDENTITY

	insert into questions_feedback
		(feedback_id, question, answer)
	select
		@feedbackId, c.value('Question[1]','varchar(200)'), c.value('Answer[1]','varchar(200)') 
		from @data.nodes('Feedback/Questions/FeedbackQuestions') t(c) 

	insert into order_feedback
		(feedback_id, item_name, rating)
	select
		@feedbackId, c.value('ItemName[1]','varchar(200)'), c.value('Rating[1]','varchar(200)') 
		from @data.nodes('Feedback/Items/FeedbackItems') t(c) 
commit
select @feedbackId
end try
begin catch
rollback
print error_line()
print error_message()
select -1
end catch
