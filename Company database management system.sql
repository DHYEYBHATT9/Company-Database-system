create database DhyeyBhatt99;

Use DhyeyBhatt99;


create table Customer(CustomerID numeric primary key, Customer_Name character(25),Address character(25),City character(25),Province character(25),Postal_Code character(25),Telephone numeric, Date_Of_Birth numeric, Primary_Language character(25));
insert into Customer values(1,"JOHN","308 REGINA","Waterloo","ON","N2J3B7",123454321,10982,"Punjabi");

-- Add a new customer named 'George' (INSERT RECORD-1)
insert into Customer values(2, 'George', '123 Main St', 'Cityville', 'ON', 'N1N1N1', 987654321, 19876, 'English');
select* from Customer;

-- -------------------------------------------------------------------------------------------------------------------

create table Accounts(AccountID numeric primary key, CustomerID numeric ,foreign key(CustomerID) references Customer(CustomerID), Payment_Date numeric,Payment_Amount numeric, Account_Type character(25));
insert into Accounts values(123,1,15712,200,"Premium");

-- Add at least 2 accounts related to the new customer in the Accounts table (INSERT RECORD-1)
insert into Accounts values(124, 2, 15713, 300, 'Basic');
insert into Accounts values(125, 2, 15714, 500, 'Gold');

-- -----------------------------------------------------------------------------------------------------------------------------
select* from Accounts;

create table Branch(BranchID numeric primary key,ManagerID numeric, Branch_Name character(25), Location character(25));

insert into Branch values(1,56789,"KWC","ON");
insert into Branch values(5, 56793,"Kitchener-Waterloo","ON");
-- Add a new branch with location (City) as 'New Market'
insert into Branch values(2, 56790, 'New Market', 'ON');

-- -------------------------------------------------------------------------------------------------------------------------------

-- Add few records in the Branch table
insert into Branch values(3, 56791, 'Some Branch', 'Some City');
insert into Branch values(4, 56792, 'Another Branch', 'Another City');

-- --------------------------------------------------------------------------------------------------------------------------------

select* from Branch;


create table Employee(EmployeeID numeric primary key, BranchID numeric, foreign key(BranchID) references Branch(BranchID),Employee_Name character(25),Address character(25),City character(25),Province character(25),Postal_Code character(25),Telephone numeric, Date_Of_Hire numeric,Number_Of_Employee numeric,Title character(25),Salary numeric,Age numeric);
insert into Employee values(123,1,"Raju","328 Regina","Waterloo","ON","N2j0b7",12345654,12304,40,"MANAGER",12000,26);
insert into Employee values(126,5,"Suresh","308 King street","Kitchener-Waterloo","ON","N2j0g4",12345656,12305,60,"Associate",8000,22);
insert into Employee values(127,3,"Sam","328 ERB STREET","Some Branch","ON","N2L6E5",11145654,12306,40,"MANAGER",20000,28);
insert into Employee values(128,4,"Zarah","12 WestMount Rd","Another Branch","ON","N2J2Z2",12345654,12307,45,"MANAGER",22000,29);

-- Add new employees with names 'Angelina' and 'Darren'
insert into Employee values(124, 2, 'Angelina', '456 Oak St', 'Cityville', 'ON', 'M1M1M1', 876543210, 20876, 35, 'Assistant Manager', 10000, 30);
insert into Employee values(125, 2, 'Darren', '789 Pine St', 'Cityville', 'ON', 'P1P1P1', 765432109, 20877, 28, 'Sales Associate', 8000, 28);

-- ----------------------------------------------------------------------------------------------------------------------------------------------

select* from Employee;


create table Dependent(DependentID numeric primary key, EmployeeID numeric, foreign key(EmployeeID) references Employee(EmployeeID),Dependent_Name character(25),Age numeric,Relationship character(25));  
insert into Dependent values(1234,123,"Rakesh",24,"brother");

-- Add at least a dependent for each of them in the dependent relation
insert into Dependent values(1235, 124, 'Aria', 5, 'Daughter');
insert into Dependent values(1236, 125, 'Daniel', 8, 'Son');

-- ---------------------------------------------------------------------------------------

select* from Dependent;


create table Item(ItemID numeric primary key,Item_Description character(25),Color character(25),Size numeric,PatternID numeric,Item_Type character(25));
insert into Item values(1,"big oven","black",10,1234,"electric");
insert into Item values(2,"Light bulb","white",12,2356,"electric");
insert into Item values(3,"washing machine","blue",15,2386,"electric");

select* from Item;


create table Purchase_Order(OrderID numeric primary key, CustomerID numeric, foreign key(CustomerID) references Customer(CustomerID), Order_Date numeric,Credit_Authorization_Status character(25));
insert into Purchase_Order values(1,1,12306,"Pass");

-- Add a few orders associated with the new branch
insert into Purchase_Order values(2, 2, 12307, 'Pass');
insert into Purchase_Order values(3, 2, 12308, 'Pass');
insert into Purchase_Order values(4, 2, 12309, 'Pass');

-- ------------------------------------------------------------------------------------------------------------------------------

select* from Purchase_Order;

create table Order_Branch(primary key (OrderID , BranchID ),OrderID numeric , foreign key(OrderID) references Purchase_Order(OrderID),BranchID numeric, foreign key (BranchID) references  Branch(BranchID));  
 insert into Order_Branch values(1,1);
 insert into Order_Branch values(2,2);
 insert into Order_Branch values(3,3);
insert into Order_Branch values(4,4);
  
 
 select* from Order_Branch;
 
create table Customer_Branch(primary key (CustomerID , BranchID ),CustomerID numeric, foreign key(CustomerID) references Customer(CustomerID),BranchID numeric,foreign key (BranchID) references  Branch(BranchID));  
insert into Customer_Branch values (1,1);
insert into Customer_Branch values (2,2);
insert into Customer_Branch values (2,3);
insert into Customer_Branch values (2,4);



select* from Customer_Branch;

 
 create table Order_List(primary key (OrderID , ItemID ),OrderID numeric, foreign key(OrderID) references Purchase_Order(OrderID),ItemID numeric, foreign key (ItemID) references  Item(ItemID));
 insert into Order_List values (1,1);
 insert into Order_List values (2,2);
 insert into Order_List values (3,3);
 insert into Order_List values (4,3);
 
 
 
 select* from Order_List;
 create table Item_Branch(ItemID numeric,BranchID numeric,primary key (ItemID , BranchID ), foreign key(ItemID) references Item(ItemID),foreign key (BranchID) references  Branch(BranchID));
 insert into Item_Branch values(1,1);
 select* from Item_Branch;

-- -------------------------------------------------------QUERIES----------------------------------------------------------------------

-- --------------------------------------------------
-- List of the information of all accounts with the name of the customers holding those accounts
select a.*, c.Customer_Name
from Accounts a
inner join Customer c on a.CustomerID = c.CustomerID;

-- ----------------------------------------------------------------------------------

-- List of all the orders placed from a branch whose location (city) has space in its name.
select ob.*, b.Branch_Name
from Order_Branch ob
inner join Branch b on ob.OrderID = b.BranchID
where b.Branch_Name like '% %'; 
-- -------------------------------------------------------------------------------------

--  Prints the information of dependents with the employee names with whom 
-- they are associated for the employees whose name starts with character ‘A’ or ‘D’
select d.*, e.Employee_Name
from Dependent d
inner join Employee e on d.EmployeeID = e.EmployeeID
where e.Employee_Name like 'A%' or e.Employee_Name like 'D%';

-- ---------------------------------------------------------------------------------

-- List of all the orders with their order ids and all the items included 
-- in those orders in ascending order of order ids. 
-- here, Item names appear in every row with order ids.
select ol.OrderID, ol.ItemID, i.Item_Description
from Order_List ol
inner join Item i on ol.ItemID = i.ItemID
order by ol.OrderID;

-- --------------------------------------------------------------------------

-- List of the names of the employees working in a ‘Kitchener-Waterloo’ branch
-- with their branch location.
select e.Employee_Name, b.Branch_Name
from Employee e
inner join Branch b on e.BranchID = b.BranchID
where b.Branch_Name = 'Kitchener-Waterloo';

-- ----------------------------------------------------------------------------

-- List of all the branches that has no employees associated with it.
select b.*
from Branch b
left join Employee e on b.BranchID = e.BranchID
where e.EmployeeID is null;

-- ----------------------------------------------------------------------