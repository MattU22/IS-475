Create Table tblCustomer
	(	
	CustomerID char(5) primary key,
	LastName varchar(30) NOT NULL,
	FirstName varchar(20),
	Address varchar(30) NOT NULL,
	City varchar(20) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(12) NOT NULL,
	Country varchar(15),
	FirstBuyDate datetime,
	Email varchar(60),
	Phone char(15) NOT NULL,
	CustomerType	char(1) check (CustomerType IN ('P','S')),
	PF
	);
	
Create Table TblShipAddress
	( 
	AddressID int NOT NULL primary key,
	ShipName varchar(30),
	ShipAddress varchar(30),
	ShipPostalCode varchar(20),
	ShipCountry varchar(30),
	ShipPhone char(15) 
	);
	
Create Table TblOrder
	( 
	OrderID char(6) NOT NULL Primary Key,
	OrderDate datetime NOT NULL,
	DiscountCode char(2) check (DiscountCode IN
    ('02','03','04','06','08','10','A1','B3')),
	CreditCode char(3),
	CustomerID char(5) NOT NULL foreign key references tblCustomer(CustomerID),
	AddressID int foreign key references TblShipAddress(AddressID),
	);
	
Create Table TblItemType
	( 
	TypeID int NOT NULL primary key,
	CategoryDescription varchar(50),
	);

Create Table TblItem
	(
	ItemID char(6) NOT NULL Primary Key,
	Description varchar(300),
	ListPrice money NOT NULL CHECK (ListPrice > 5),
	TypeID int NOT NULL FOREIGN KEY REFERENCES TblItemType(TypeID)
	);
	
Create Table TblItemCostHistory
	( 
	HistoryID int Primary Key IDENTITY(100,1),
	ItemID char(6) NOT NULL Foreign Key References TblItem(ItemID),
	LastCoseDate datetime NOT NULL,
	LastCost money NOT NULL,
	);
	
Create Table TblItemLocation 
	( 
	ItemID char(6) NOT NULL Foreign Key References TblItem (ItemID),
	LocationID char(2) NOT NULL,
	QtyOnHand int
	Primary Key (ItemID, LocationID)
	);
	
Create Table TblOrderLine
	( 
	OrderID char(6) foreign key references tblOrder(OrderID),
	ItemID char(6) foreign key references tblItem(ItemID),
	Quantity int Check (Quantity > 0) NOT NULL,
	Price money Check (Price > 0) NOT NULL,
	AddressID int foreign key references tblShipAddress(AddressID),
	Primary Key (OrderID, ItemID)
	);
	
Create Table TblReview
	( 
	ReviewID int Primary Key IDENTITY(1,1),
	ReviewDate datetime,
	Rating int,
	ReviewText varchar(500),
	OrderID char(6) NOT NULL,
	ItemID char(6) NOT NULL,
	Foreign Key(OrderID,ItemID) references tblOrderLine(OrderID,ItemId)
	);

Create Table TblShipLine
	( 
	ShipLineID int Primary Key IDENTITY(100,1),
	DateShipped datetime NOT NULL,
	OrderID char(6) NOT NULL,
	ItemID char(6) NOT NULL,
	LocationID char(2) NOT NULL,
	QtyShipped int NOT NULL,
	MethodShipped varchar(30) NOT NULL,
	Foreign Key(OrderID, ItemID) references TblOrderLine(OrderID,ItemID),
	Foreign Key(ItemID, LocationID) references tblItemLocation(ItemID,LocationID)
	);
