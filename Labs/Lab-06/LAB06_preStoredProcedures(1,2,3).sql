
----------------Q1---------------
CREATE PROCEDURE InsertOrderDetail
    @OrderNo int,
    @ItemNo int,
    @Quantity int
AS
BEGIN
    DECLARE @QuantityInStore int

    -- Get the quantity of the item in store
    SELECT @QuantityInStore = [Quantity in Store] 
    FROM dbo.Items 
    WHERE ItemNo = @ItemNo

    -- Check if enough quantity is present in store
    IF @QuantityInStore < @Quantity
    BEGIN
        PRINT 'Only ' + CAST(@QuantityInStore AS varchar(10)) + ' is present, which is less than your required quantity.'
    END
    ELSE
    BEGIN
        -- Insert order detail into OrderDetails table
        INSERT INTO dbo.OrderDetails (OrderNo, ItemNo, Quantity)
        VALUES (@OrderNo, @ItemNo, @Quantity)

        -- Subtract ordered quantity from quantity in store
        UPDATE dbo.Items
        SET [Quantity in Store] = [Quantity in Store] - @Quantity
        WHERE ItemNo = @ItemNo
    END
END

----------Q1 EXECUTION STATEMENT-------------
EXEC InsertOrderDetail @OrderNo = 1, @ItemNo = 100, @Quantity = 50

----------------------Q2------------------
CREATE PROCEDURE CustomerSignUp
    @CustomerNo varchar(2),
    @Name varchar(30),
    @City varchar(3),
    @Phone varchar(11),
    @Flag int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Rule 1: Check if customer No is unique
    IF EXISTS (SELECT 1 FROM dbo.Customers WHERE CustomerNo = @CustomerNo)
    BEGIN
        SET @Flag = 1
        RETURN
    END

    -- Rule 2: Check if city is null
    IF @City IS NULL
    BEGIN
        SET @Flag = 2
        RETURN
    END

    -- Rule 3: Check if phone number length is not 6
    IF LEN(@Phone) <> 6
    BEGIN
        SET @Flag = 3
        RETURN
    END

    -- Insert customer if all rules are satisfied
    INSERT INTO dbo.Customers (CustomerNo, Name, City, Phone)
    VALUES (@CustomerNo, @Name, @City, @Phone)

    -- Set flag to 0 indicating successful insertion
    SET @Flag = 0
END
----------Q2 EXECUTION STATEMENT-------------
DECLARE @FlagResult int
EXEC CustomerSignUp @CustomerNo = 'C_7902', @Name = 'Miraal Fatima', @City = 'Lahore', @Phone = 'XXXX XXXXXXX', @Flag = @FlagResult OUTPUT
SELECT @FlagResult AS FlagResult


----------------Q3-------------------
CREATE PROCEDURE CancelOrder
    @CustomerNo varchar(2),
    @OrderNo int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerName varchar(30)

    -- Get customer name
    SELECT @CustomerName = Name FROM dbo.Customers WHERE CustomerNo = @CustomerNo

    -- Check if the order belongs to the customer
    IF EXISTS (SELECT 1 FROM dbo.[Order] WHERE OrderNo = @OrderNo AND CustomerNo = @CustomerNo)
    BEGIN
        -- Delete order details
        DELETE FROM dbo.OrderDetails WHERE OrderNo = @OrderNo

        -- Delete order
        DELETE FROM dbo.[Order] WHERE OrderNo = @OrderNo

        PRINT 'Order no ' + CAST(@OrderNo AS varchar(10)) + ' is cancelled for ' + @CustomerNo + ' ' + @CustomerName
    END
    ELSE
    BEGIN
        PRINT 'Order no ' + CAST(@OrderNo AS varchar(10)) + ' is not of ' + @CustomerNo + ' ' + @CustomerName
    END
END

----------Q3 EXECUTION STATEMENT-------------

EXEC CancelOrder @CustomerNo = 'C_7902', @OrderNo = 1


