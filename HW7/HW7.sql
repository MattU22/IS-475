--1) SQL Code
SELECT	CustomerID,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    UPPER(City)City,
	    UPPER(State)State,
	    CONVERT(VARCHAR, FirstBuyDate, 107) 'First Purchase Date'
FROM 	    tblCustomer
WHERE	    FirstBuyDate =
	        (SELECT MAX(FirstBuyDate)
	        FROM tblCustomer)

--2) SQL Code
SELECT	CustomerID,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    UPPER(City)City,
	    UPPER(State)State
FROM	    tblCustomer
WHERE	    CustomerID NOT IN
	        (SELECT CustomerID
	        FROM tblOrder)

--3) SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'OrderDate',
	    OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number'
FROM        TblOrder
INNER JOIN  tblCustomer
ON          tblOrder.CustomerID = tblCustomer.CustomerID
WHERE       MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())
ORDER BY    OrderDate desc;

--4) SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'OrderDate',
	    tblOrder.OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    itemID,
	    Quantity,
	    Price,
	    Quantity * Price ExtendedPrice
FROM        TblOrder
INNER JOIN  tblCustomer
ON          tblOrder.CustomerID = tblCustomer.CustomerID
INNER JOIN  TblOrderLine
ON          TblOrder.OrderID = TblOrderLine.OrderID
WHERE       MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())
ORDER BY    OrderDate desc;

--5) SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'OrderDate',
	    tblOrder.OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    tblorderline.ItemID,
	    Description,
	    Quantity,
	    Price,
	    Quantity * Price ExtendedPrice
FROM        TblOrder
INNER JOIN  tblCustomer
ON          tblOrder.CustomerID = tblCustomer.CustomerID
INNER JOIN  TblOrderLine
ON          TblOrder.OrderID = TblOrderLine.OrderID
INNER JOIN  TblItem
ON          TblOrderLine.ItemID = TblItem.ItemID
WHERE       MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())
ORDER BY    OrderDate desc;

--6) SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'OrderDate',
	    tblOrder.OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    tblorderline.ItemID,
	    Description,
	    CategoryDescription,
	    Quantity,
	    Price,
	    Quantity * Price ExtendedPrice
FROM        TblOrder
INNER JOIN  tblCustomer
ON          tblOrder.CustomerID = tblCustomer.CustomerID
INNER JOIN  TblOrderLine
ON          TblOrder.OrderID = TblOrderLine.OrderID
INNER JOIN  TblItem
ON          TblOrderLine.ItemID = TblItem.ItemID
INNER JOIN  TblItemType
ON          TblItemType.TypeID = TblItem.TypeID
WHERE       MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())
ORDER BY    OrderDate desc;

--7) SQL Code
SELECT	CONVERT(VARCHAR, OrderDate, 101) 'OrderDate',
	    tblOrder.OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    tblorderline.ItemID,
	    Description,
	    CategoryDescription,
	    Quantity,
	    Price,
	    Quantity * Price ExtendedPrice,
	    CASE
		    WHEN(TblReview.ReviewText) IS NOT NULL
			    THEN 'Yes'
		    ELSE 'No'
	    END 'ReviewExists?'
FROM            TblOrder
INNER JOIN      tblCustomer
ON              tblOrder.CustomerID = tblCustomer.CustomerID
INNER JOIN      TblOrderLine
ON              TblOrder.OrderID = TblOrderLine.OrderID
INNER JOIN      TblItem
ON              TblOrderLine.ItemID = TblItem.ItemID
INNER JOIN      TblItemType
ON              TblItemType.TypeID = TblItem.TypeID
LEFT OUTER JOIN tblReview
ON              TblOrderLine.OrderID = TblReview.OrderID AND TblOrderLine.ItemID = TblReview.ItemID
WHERE           MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())
ORDER BY        OrderDate desc;

--8) SQL Code
SELECT	tblorderline.ItemID,
	    Description ItemDescription,
	    SUM(quantity) TotalQtySold,
	    COUNT(TblOrderLine.ItemID)CountofOrderLines,
	    ListPrice,
	    MIN(Price)MinimumPrice,
	    MAX(Price)MaximumPrice,
	    AVG(Price)AveragePrice
FROM        TblOrderLine
INNER JOIN  TblItem
ON          TblOrderLine.ItemID = TblItem.ItemID
GROUP BY    tblorderline.ItemID, Description, ListPrice

--9) SQL Code
SELECT	tblitem.ItemID,
	    Description,
	    ISNULL(CONVERT(VARCHAR,LastCostDate,107), 'No Date Recorded') 'Last Cost Date',
	    ISNULL(LastCost, 0.00) 'Last Cost Paid'
FROM            TblItem
LEFT OUTER JOIN TblItemCostHistory
ON              tblitem.ItemID = TblItemCostHistory.ItemID
ORDER BY        TblItem.ItemID asc, LastCostDate desc

--10) SQL Code
SELECT	tblitem.ItemID,
	    Description,
	    ISNULL(CONVERT(VARCHAR,LastCostDate,107), 'No Date Recorded') 'Last Cost Date',
	    ISNULL(LastCost, 0.00) 'Last Cost Paid'
FROM            TblItem
LEFT OUTER JOIN TblItemCostHistory x
ON              tblitem.ItemID = x.ItemID
WHERE	        LastCostDate IN
		            (SELECT Max(lastCostDate)
		            FROM TblItemCostHistory y
		            WHERE x.ItemID = y.ItemID)
		        OR LastCostDate IS NULL
ORDER BY        TblItem.ItemID asc, LastCostDate desc

--11) SQL Code
SELECT	tblorder.OrderID OrderNumber,
	    LastName + ', ' + SUBSTRING(FirstName,1,1) + '.' 'Customer Name',
        '(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
	    ItemID,
	    ISNULL(x.shipaddress, ISNULL(y.shipaddress, tblCustomer.Address)) ShipAddress,
	    ISNULL(x.ShipPostalCode, ISNULL(y.ShipPostalCode, tblCustomer.Zip)) ShipCode,
	    ISNULL(x.ShipCountry, ISNULL(y.ShipCountry, tblCustomer.country)) ShipCountry,
	    Quantity
FROM            TblOrder
INNER JOIN      tblCustomer
ON              tblOrder.CustomerID = tblCustomer.CustomerID
INNER JOIN      TblOrderLine
ON              tblOrder.OrderID = TblOrderLine.OrderID
LEFT OUTER JOIN TblShipAddress x
ON              TblOrderLine.AddressID = x.AddressID
LEFT OUTER JOIN TblShipAddress y
ON              TblOrder.AddressID = y.AddressID
WHERE           MONTH(OrderDate)=2 and YEAR(OrderDate)=YEAR(GETDATE())

--12) SQL Code
SELECT	ol.OrderID,
	    ol.ItemID,
	    ol.Price,
	    ol.Quantity,
	    ISNULL((SUM(sl.QtyShipped)), 0) TotalQtyShipped,
	    ol.Quantity - ISNULL((SUM(sl.QtyShipped)), 0) LeftToShip
FROM	        tblOrderLine ol
LEFT OUTER JOIN	tblShipLine sl
ON	            ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
GROUP BY        ol.OrderID, ol.ItemID, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID
ORDER BY        ol.OrderID, ol.ItemID;

--13) SQL Code
Select	ol.OrderID,
	    ol.ItemID,
	    Description ItemDescription,
	    CategoryDescription,
	    ListPrice,
	    ol.Price,
	    ol.Quantity,
	    ISNULL((SUM(sl.QtyShipped)), 0) TotalQtyShipped,
	    ol.Quantity - ISNULL((SUM(sl.QtyShipped)), 0) LeftToShip
From	        tblOrderLine ol
LEFT OUTER JOIN tblShipLine sl
On              ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
INNER JOIN      TblItem I
ON              ol.ItemID = I.ItemID
INNER JOIN      TblItemType IT
ON              I.TypeID = IT.TypeID
Group By		ol.OrderID, ol.ItemID, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID, Description, CategoryDescription, ListPrice
Order By		ol.OrderID, ol.ItemID;

--14) SQL Code
SELECT	LastName + ', ' + FirstName 'Customer Name',
		tblorderLine.OrderID,
		tblorderline.ItemID,
		Description
FROM        tblCustomer
INNER JOIN  TblOrder
ON          tblCustomer.CustomerID = tblOrder.CustomerID
INNER JOIN  TblOrderLine
ON          tblOrder.OrderID = TblOrderLine.OrderID
INNER JOIN  TblItem
ON          TblOrderLine.ItemID = TblItem.ItemID
INNER JOIN  TblShipLine
ON          TblOrderLine.ItemID = TblShipLine.ItemID AND TblOrderLine.OrderID = TblShipLine.OrderID
WHERE       MethodShipped = 'fedex'
ORDER BY    LastName









