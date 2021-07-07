--1)SQL Code
SELECT  (FirstName + ' ' + LastName) CustomerName,
		Phone CustomerPhone,
		City,
		State,
		CustomerAffID AffiliatedCustomer,
		FirstBuyDate
FROM        tblCustomer
WHERE       State  = 'ca'
ORDER BY    LastName;

--2)SQL Code
SELECT  (LastName + ', ' + SUBSTRING(FirstName,1,1) + '.') 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    UPPER(City) City,
	    UPPER(State) State,
	    CustomerAffID AffiliatedCustomer,
	    CONVERT(VARCHAR, FirstBuyDate, 107) FirstBuyDate
FROM		tblCustomer
WHERE		State = 'ca'
ORDER BY	CONVERT(DATETIME, FirstBuyDate, 103) DESC;

--3)SQL Code
SELECT	(LastName + ', ' + SUBSTRING(FirstName,1,1) + '.') 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    UPPER(City) City,
	    UPPER(State) State,
	    CustomerAffID AffiliatedCustomer,
	    CONVERT(VARCHAR, FirstBuyDate, 107) FirstBuyDate
FROM		tblCustomer
WHERE		State = 'ca' AND CustomerAffID IS NULL
ORDER BY	CONVERT(DATETIME, FirstBuyDate, 103) DESC;

--4)SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'Date of Order',
	    OrderID 'Order Number',
	    CustomerID ' Customer Number',
	    CreditCode 'Credit Code',
	    ISNULL(CONVERT(VARCHAR, AddressID), 'Use Billing Address') 'Shipping AddressID'
FROM        TblOrder
WHERE       AddressID is NULL
ORDER BY    CONVERT(DATETIME, OrderDate, 103) ASC;

--5)SQL Code
SELECT	OrderID OrderNumber,
	    ItemID ItemNumber,
	    Quantity QuantityOrdered,
	    Price PricePaid,
	    (Price * Quantity) ExtendedPrice
FROM        TblOrderLine
WHERE       ItemID = 'B67466'
ORDER BY    OrderID;

--6)SQL Code
SELECT	OrderID OrderNumber,
		ItemID ItemNumber,
		Quantity QuantityOrdered,
		Price PricePaid,
		(Price * Quantity) ExtendedPrice
FROM        TblOrderLine
WHERE       (Price * Quantity) > 850
ORDER BY    OrderID, ItemID;

--7)SQL Code
SELECT	OrderID OrderNumber,
	    ItemID ItemNumber,
	    Quantity QuantityOrdered,
	    Price PricePaid,
	    (Price * Quantity) ExtendedPrice,
	    CASE
		    WHEN (Price * Quantity) >= 5000 
                THEN '***Closely Watch the Status***'
		    WHEN (Price * Quantity) >= 2000 and (Price * Quantity) < 5000 
                THEN 'Very Large Order - Watch Dates'
		    WHEN (Price * Quantity) >= 1500 and (Price * Quantity) < 2000 
                THEN 'Large Order - Monitor Shipping Date'
		    WHEN (Price * Quantity) >= 1000 and (Price * Quantity) < 1500 
                THEN 'Medium Order'
		    ELSE NULL
	    END OrderStatusMessage
FROM        TblOrderLine
WHERE       (Price * Quantity) > 850
ORDER BY    OrderID, ItemID;

--8)SQL Code
SELECT	OrderID,
	    ItemID,
	    CONVERT(VARCHAR,DateShipped,101) DateShipped,
	    QtyShipped,
	    UPPER(MethodShipped) MethodShipped
FROM        TblShipLine
WHERE       Month(DateShipped)=1 and YEAR(GETDATE())=YEAR(DateShipped)
ORDER BY    OrderID, ItemID;

--9)SQL Code
Select	ROUND(AVG(CAST(QtyShipped AS DECIMAL)),2) 'Average Quantity Shipped'
From        tblShipLine
Where       MethodShipped = 'fedex'

--10)SQL Code
SELECT  MAX(DateShipped)MostRecentShipDate,
	    MIN(DateShipped)EarliestShipDate,
	    COUNT(*)CountOfShipments,
	    SUM(QtyShipped)TotalQtyShipped,
	    AVG(QtyShipped) AverageQtyShipped
FROM        TblShipLine;

--11)SQL Code
SELECT	itemID,
	    COUNT(*)NumberOfRows,
	    SUM(Quantity)QuantitySold,
	    MIN(Price)MininumPrice,
	    MAX(Price)MaximumPrice,
	    AVG(Price)AveragePrice
FROM        TblOrderLine
GROUP BY    itemID;

--12)SQL Code
SELECT	itemID,
	    COUNT(*)NumberOfRows,
	    SUM(Quantity)QuantitySold,
	    MIN(Price)MininumPrice,
	    MAX(Price)MaximumPrice,
	    AVG(Price)AveragePrice,
	    CAST((MAX(Price)-MIN(Price))/MIN(Price) *100 AS varchar) + '%'  'Diff'
FROM        TblOrderLine
GROUP BY    itemID
HAVING      MAX(Price)>MIN(Price)*1.5;

--13)SQL Code
SELECT	OrderID,
	    ItemID,
	    Count(*) NumberOfShipments,
	    SUM(QtyShipped)TotalShipped
FROM        TblShipLine
GROUP BY    OrderID, ItemID
HAVING      COUNT(ItemID)>1
ORDER BY    OrderID;

--14)SQL Code
SELECT	OrderID 'Order Number',
	    CustomerID 'Customer Number',
	    Convert(Varchar, OrderDate, 107) 'Date Ordered',
	    Convert(Varchar,DATEADD(day,50,OrderDate), 107) '50 Days after Date Ordered',
	    DATEDIFF(day,OrderDate, getdate()) 'Number of Days Difference',
	    getdate() 'Current Date and Time'
FROM        TblOrder
WHERE       DATEDIFF(day,OrderDate, getdate())>50
