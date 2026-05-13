
--CREATING A DATABASE

CREATE DATABASE MAY11;
USE MAY11;


--CREATING 3 TABLES

--1 CUSTOMER TABLE
CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(20)
);

--2 ORDER TABLE
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

--3 PAYMENT TABLE
CREATE TABLE Payment (
PaymentID INT PRIMARY KEY,
OrderID INT,
Amount INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


--INSERTING VALUES IN TABLES 

INSERT INTO Customer VALUES
(1, 'Ali'),
(2, 'Sara'),
(3, 'Usman');

INSERT INTO Orders VALUES
(101, 1, '2026-05-01'),
(102, 1, '2026-05-02'),
(103, 2, '2026-05-03');

INSERT INTO Payment VALUES
(1001, 101, 500),
(1002, 102, 1200),
(1003, 103, 700);

--SHOWING TABLES

SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Payment;

--Showing CustomerName, OrderID, OrderDate

SELECT Customer.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customer
INNER JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;



--Showing CustomerName, OrderID, PaymentAmount

SELECT Customer.CustomerName, Orders.OrderID, Payment.Amount
FROM Customer 
INNER JOIN Orders
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN Payment
ON Orders.OrderID = Payment.OrderID;


---Showing Customer Name and Total number of orders per customer

 SELECT Customer.CustomerName, COUNT(Orders.OrderID) AS PerOrder
 FROM Customer
 LEFT JOIN Orders
 ON Customer.CustomerID = Orders.CustomerID
 GROUP BY Customer.CustomerName;


 ---Showing CustomerName , Total Orders , BUT only customers who have MORE than 1 order
 
 SELECT Customer.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
 FROM Customer
 LEFT JOIN Orders
 ON Customer.CustomerID = Orders.CustomerID 
 GROUP BY Customer.CustomerID,Customer.CustomerName
 HAVING COUNT(Orders.OrderID) >1;

 ---Customers who NEVER placed an order

 SELECT Customer.CustomerName , COUNT(Orders.OrderID) AS PerOrders
 FROM Customer
 LEFT JOIN Orders
 ON Customer.CustomerID = Orders.CustomerID
 GROUP BY Customer.CustomerName
 HAVING COUNT(Orders.OrderID) = 0;

 ---OR 

 SELECT Customer.CustomerName
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

---Showing Customer Name and Total Amount they have spent

SELECT Customer.CustomerName, SUM(Payment.Amount) AS TotalSpent
FROM Customer 
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
LEFT JOIN Payment
ON Orders.OrderID = Payment.OrderID
GROUP BY Customer.CustomerName;

---Showing CustomerName ,Total Amount , BUT only customers who have spent more than 1000

SELECT Customer.CustomerName, SUM(Payment.Amount) AS TotalAmount
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
LEFT JOIN Payment 
ON Orders.OrderID = Payment.OrderID
GROUP BY Customer.CustomerName
HAVING SUM(Payment.Amount) >1000;


/*
Showing CustomerName, Number of Orders, Total Amount
BUT only include customers who have at least 1 order
AND total spending ≥ 1000
*/

SELECT Customer.CustomerName, COUNT(Orders.OrderID) AS PerOrder , SUM(Payment.Amount) AS TotalSpent
FROM Customer
INNER JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
INNER JOIN Payment
ON Orders.OrderID = Payment.OrderID 
GROUP BY Customer.CustomerName
HAVING COUNT(Orders.OrderID) >=1 AND SUM(Payment.Amount) > 1000;