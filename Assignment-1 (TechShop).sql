Create table Orders(
OrderID int Primary Key,
CustomerID int references Customers(CustomerID),
OrderDate date,
TotalAmount bigint)

drop table Orders

Create table OrderDetails(
OrderDetails int Primary Key,
OrderID int references Orders(OrderID),
ProductID int references Products(ProductID),
Quantity int)

Create table Inventory(
InventoryID int Primary Key,
ProductID int references Products(ProductID),
QuantityInStock int,
LastStockUpdate date)

/*task-2*/

/*1*/ select firstname,lastname,email from Customers

/*2*/select o.OrderID,o.OrderDate,c.Firstname,c.LastName
from Orders o
INNER JOIN Customers c on o.CustomerID=c.CustomerID 

/*3*/
insert into Customers values(111,'Ana','White','ana@email.com','45638','Pune')

/*4*/update Products set Price = Price*1.10

/*5*/ 
DECLARE @InputOrderID INT; 
SET @InputOrderID = 1;
delete from OrderDetails where OrderId= @InputOrderID
delete from Orders where OrderId= @InputOrderID

/*6*/
insert into Orders values(11,111,'2024-4-8',5000,'shipped')

/*7*/
declare @InputEmail varchar(30), @InputCustomerID int
set @InputEmail = 'jack123@email.com'
set @InputCustomerID=101
update Customers set Email=@InputEmail where CustomerID=@InputCustomerID
select * from Customers

/*8*/
update Orders SET totalamount=(
select sum(od.quantity*p.price) from OrderDetails od
INNER JOIN Products p on p.ProductID=od.ProductID
where orders.orderID=od.OrderID)


/*9*/ 
declare @InputCustomerID int
set @InputCustomerID=101
delete OrderDetails from OrderDetails
join Orders on OrderDetails.OrderID=Orders.OrderID
where Orders.CustomerID = @InputCustomerID;
delete from Orders where CustomerId= @InputCustomerID

/*10*/
insert into products values(211,'Earphones','High quality',800,3)

/*11*/
alter table orders add status varchar(10) 
DECLARE @InputOrderID INT; 
SET @InputOrderID = 1;
update orders set status='Shipped' where OrderId= @InputOrderID
select * from orders

/*12*/
select c.firstname, od.quantity
from Customers c
inner join Orders o on o.customerid=c.CustomerID
inner join OrderDetails od on od.OrderID=o.orderID

select * from orders


/* task-3 */

/*1*/
select o.OrderID,o.OrderDate,c.Firstname,c.LastName
from Orders o
INNER JOIN Customers c on o.CustomerID=c.CustomerID

/*2*/
select p.productname,sum(od.quantity*p.price) as totalrevenue
from orderdetails od
join products p on od.productid = p.productid
group by p.productid, p.productname

/*3*/
select c.firstname,c.phone 
from Customers c
join orders o on o.customerid=c.CustomerID
group by c.FirstName, c.Phone

/*4*/
select top 1 p.productname,sum(od.quantity) as totalquantity
from orderdetails od
join products p on od.productid = p.productid
group by p.productname
order by totalquantity desc

/*5*/
create table category(
categoryID int primary key,
categoryName varchar(30))

ALTER TABLE Products
ADD CategoryID INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Category
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID);

select p.productname,c.categoryname from Products p
join category c on c.categoryID=p.CategoryID

/*6*/
select c.firstname,avg(o.totalamount) as averageordervalue
from customers c
join orders o on c.customerid = o.customerid
group by c.firstname

/*7*/
select top 1 o.orderid,c.firstname,c.lastname,o.totalamount
from orders o
join customers c on o.customerid = c.customerid
order by o.totalamount desc

/*8*/
select p.productname,count(od.productid) from Products p
join OrderDetails od on od.ProductID=p.ProductID
group by p.productname

/*9*/
declare @InputProname varchar(20)
set @InputProname='Router'
select c.firstname from Customers c
join orders o on o.customerID=c.CustomerID
join OrderDetails od on od.OrderID=o.orderID
join Products p on p.ProductID=od.ProductID
where ProductName=@InputProname

/*10*/
declare @InputStartdate date, @InputEnddate date
set @InputStartdate='2022-4-20'
set @InputEnddate='2024-01-10'
select sum(o.totalamount) as totalrevenue
from orders o
where o.orderdate between @InputStartdate and @InputEnddate

/*task-4*/

/*1*/
select * from customers
where customerid not in(
select customerid from orders);

/*2*/
select count(productid) as available_products
from inventory
where quantityinstock > 0;

/*3*/
select sum(totalamount) as total_amount from orders;

/*4*/
declare @Inputcategoryname varchar(10);
set @Inputcategoryname='computers';
select avg(od.quantity) as averagequantity from orderdetails od
inner join products p on od.productid = p.productid
where p.categoryid=
(select c.categoryid from category c where c.categoryname=@Inputcategoryname)

/*5*/
declare @InputcustomerID int
set @InputcustomerID=104;
select sum(o.TotalAmount) as TotalAmount
from Orders o
where o.CustomerID=@InputcustomerID

/*6*/
select top 1 c.FirstName,o.noofOrders from Customers c
join (select CustomerID,count(OrderID) as noofOrders from Orders group by CustomerID) o
on o.customerid=c.CustomerID
order by noofOrders desc

/*7*/
select top 1 categoryname, totalquantity
from(select c.categoryname,sum(od.quantity) as totalquantity
from orderdetails od
join products p on od.productid = p.productid
join category c on p.categoryid = c.categoryid
group by c.categoryname) as categorytotals
order by totalquantity desc;

/*8*/
select top 1 c.firstname, maximum.totalspent
from customers c
join(select CustomerID, sum(totalamount) as totalspent from orders
group by customerid)maximum on c.customerid = maximum.customerid
order by maximum.totalspent desc

/*9*/
select c.firstname, all_orders.avg_order
from customers c
join(select customerid, sum(totalamount)/count(orderid) as avg_order
from orders
group by customerid) all_orders on c.customerid = all_orders.customerid;

/*10*/
select c.FirstName,o.noofOrders from Customers c
join (select CustomerID,count(OrderID) as noofOrders from Orders group by CustomerID) o
on o.customerid=c.CustomerID