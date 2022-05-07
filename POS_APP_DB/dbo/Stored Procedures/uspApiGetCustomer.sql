
CREATE PROC [dbo].[uspApiGetCustomer]
@contact VARCHAR(100)
AS
SELECT id [id], Customer_name [name], Cell_No [contact], [address] FROM Customerpos WHERE Cell_No = @contact

