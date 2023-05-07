-- Topic Chosen: Orders

CREATE TABLE User (
  Id int PRIMARY KEY,
  Username varchar(255) UNIQUE,
  Password varchar(255) NOT NULL,
  ConfirmPassword varchar(255) NOT NULL,
  Age int CHECK (12 <= Age <= 100), 
  Gender char(1) CHECK (Gender IN ('M', 'F')),
  CONSTRAINT same_password CHECK (Password = ConfirmPassword)
  );

CREATE TABLE Orders (
  OrderID int PRIMARY KEY,
  UserID int,
  FOREIGN KEY (UserID) REFERENCES User(Id) ON DELETE SET NULL
  );

CREATE TABLE OrderItems (
  ProductID int PRIMARY KEY,
  OrderID int,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON UPDATE CASCADE,
  ProductName varchar(255),
  Quantity int,
  Price decimal(10,2)
  );
  
  -- Populate User Table:
INSERT INTO User (Id, Username, Password, ConfirmPassword, Age, Gender)
VALUES (74681746, 'Bronya', '022Hu&@ChLdezo#ucre9', '022Hu&@ChLdezo#ucre9', 19, 'F');
INSERT INTO User (Id, Username, Password, ConfirmPassword, Age, Gender)
VALUES (73330602, 'Seele', '=5+_rOgUw1#b5a4AXinl', '=5+_rOgUw1#b5a4AXinl', 20, 'F');

-- Populate Orders Table:
INSERT INTO Orders (OrderID, UserID)
VALUES (12345, 74681746);

-- Populate OrderItems Table:
INSERT INTO OrderItems (ProductID, OrderID, ProductName, Quantity, Price)
VALUES (98765, 12345, 'Skirt', 1, 25.00);

-- OBSERVING ATTRIBUTE BASED CONSTRAINTS BY INSERTING INVALID DATA:
-- This insertion will fail because 'Username' must be unique and cannot be the same as another entry
INSERT INTO User (Id, Username, Password, ConfirmPassword, Age, Gender)
VALUES (21477425, 'Bronya', '@R5mibra?1lFrA=-sWi4', '@R5mibra?1lFrA=-sWi4', 40, 'F');

-- OBSERVING TUPLE BASED CONSTRAINTS BY INSERTING INVALID DATA:
-- This insertion will fail because Password and ConfirmPassword aren't the same
INSERT INTO User (Id, Username, Password, ConfirmPassword, Age, Gender)
VALUES (53661224, 'March', 'Fri99IT+w+ukac9i2rET', '6hewrlme6UstuSt=sWiZ', 18, 'F');

-- VERIFYING REFERENTIAL CONSTRAINTS:

-- Deleting Id value from "User" Table
DELETE FROM User WHERE Id = 74681746;
SELECT * FROM Orders WHERE UserId = 74681746;
-- This will return no rows of the table

-- Updating Id value from "User" table
UPDATE User SET Id = 11784924 WHERE Id = 73330602;
SELECT * FROM Orders WHERE UserID = 11784924;
-- This will return the row of the "Orders" table with updated UserID

-- Updating OrderID value from "Orders" table
UPDATE Orders SET OrderID = 6789 WHERE OrderID = 12345;
SELECT * FROM OrderItems WHERE OrderID = 6789;
-- This will return the row of the "OrderItems" table with updated OrderID
