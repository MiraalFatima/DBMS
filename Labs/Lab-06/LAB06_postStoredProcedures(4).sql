----------------Q4-------------------
------------POST LAB STORED PROCEDURE------------
CREATE PROCEDURE CalculateCustomerPoints
    @CustomerName varchar(30),
    @TotalPoints int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Initialize variable to hold total points
    DECLARE @PointsEarned int

    -- Calculate points earned based on purchases
    SELECT @PointsEarned = SUM((o.Total_Items_Ordered * i.Price) / 100)
    FROM dbo.[Order] o
    INNER JOIN dbo.OrderDetails od ON o.OrderNo = od.OrderNo
    INNER JOIN dbo.Items i ON od.ItemNo = i.ItemNo
    INNER JOIN dbo.Customers c ON o.CustomerNo = c.CustomerNo
    WHERE c.Name = @CustomerName

    -- Return total points earned
    SET @TotalPoints = @PointsEarned
END

----------Q4 EXECUTION STATEMENT-------------
DECLARE @CustomerPoints int
EXEC CalculateCustomerPoints @CustomerName = 'Customer Name', @TotalPoints = @CustomerPoints OUTPUT
SELECT @CustomerPoints AS TotalPoints
