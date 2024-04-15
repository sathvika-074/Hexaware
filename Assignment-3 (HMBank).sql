create table Customers(
customer_id int primary key,
first_name varchar(20),
last_name varchar(20),
DOB date,
email varchar(30),
phone_number varchar(30),
address varchar(50))

create table Accounts(
account_id int primary key,
customer_id int,
account_type varchar(20),
balance int,
foreign key (customer_id) references Customers(customer_id))

create table Transactions(
transaction_id int primary key,
account_id int,
transaction_type varchar(20),
amount int,
transaction_date date,
foreign key (account_id) references Accounts(account_id))

/*task-2*/

insert into customers (customer_id, first_name, last_name, dob, email, phone_number, address) values
(1, 'raj', 'kumar', '1986-02-15', 'raj.kumar@example.com', '1234567890', 'delhi'),
(2, 'sita', 'gupta', '1990-07-23', 'sita.gupta@example.com', '98765210', 'mumbai'),
(3, 'amit', 'shah', '1975-11-02', 'amit.shah@example.com', '45619', 'bangalore'),
(4, 'priya', 'reddy', '1993-03-12', 'priya.reddy@example.com', '98765', 'delhi'),
(5, 'anil', 'bajpai', '1988-08-19', 'anil.bajpai@example.com', '78438', 'pune'),
(6, 'deepa', 'nair', '1982-01-17', 'deepa.nair@example.com', '98593', 'delhi'),
(7, 'vinod', 'singh', '1995-04-30', 'vinod.singh@example.com', '23465', 'mumbai'),
(8, 'geeta', 'biswas', '1978-09-25', 'geeta.biswas@example.com', '37467', 'hyderabad'),
(9, 'sanjay', 'patel', '1984-12-16', 'sanjay.patel@example.com', '873847', 'pune'),
(10, 'nisha', 'jain', '1991-05-05', 'nisha.jain@example.com', '93859', 'pune');

insert into accounts (account_id, customer_id, account_type, balance) values
(1, 1, 'savings', 15000.00),
(2, 2, 'current', 25000.00),
(3, 3, 'cuurent', 1800.00),
(4, 4, 'savings', 20000.00),
(5, 5, 'savings', 30000.00),
(6, 6, 'current', 35000.00),
(7, 7, 'current', 2700.00),
(8, 8, 'savings', 15000.00),
(9, 9, 'current', 45000.00),
(10, 10, 'savings', 50000.00);

insert into transactions (transaction_id, account_id, transaction_type, amount, transaction_date) values
(1, 1, 'deposit', 2000.00, '2024-04-01'),
(2, 2, 'withdrawal', 1500.00, '2024-04-02'),
(3, 3, 'transfer', 1200.00, '2024-04-02'),
(4, 4, 'deposit', 3000.00, '2024-04-03'),
(5, 5, 'withdrawal', 4000.00, '2024-04-03'),
(6, 6, 'transfer', 6000.00, '2024-04-04'),
(7, 7, 'deposit', 2400.00, '2024-04-04'),
(8, 8, 'withdrawal', 1500.00, '2024-04-05'),
(9, 9, 'transfer', 2500.00, '2024-04-05'),
(10, 10, 'deposit', 5000.00, '2024-04-06');

/*1*/
select c.first_name,c.last_name,a.account_type,c.email 
from Customers c 
join Accounts a on c.Customer_id=a.Customer_id

/*2*/
select c.first_name,c.last_name,t.transaction_type,t.amount,t.transaction_date
from Customers c join Accounts a on c.Customer_id=a.Customer_id
join Transactions t on a.account_id=t.account_id

/*3*/
update Accounts 
set balance = balance+20000
where account_id=1

select *from Accounts

/*4*/
select concat(first_name,' ',last_name)as full_name from Customers

/*5*/
delete from accounts where balance=0 and account_type='savings'

/*6*/
select* from Customers where address='pune'

/*7*/
select balance from Accounts where account_id=4

/*8*/
select * from Accounts where account_type='current' and balance>1000

/*9*/
select *from Transactions where account_id=7

/*10*/
select account_id,balance*0.7 as interest_accrued from accounts where account_type='savings'

/*11*/
select *from accounts where balance<3000

/*12*/
select *from Customers where address!='pune'

/*task-3*/

/*1*/
select avg(balance) as avg_balance from Accounts;
        
/*2*/
select top 10 * from Accounts
order by balance desc

/*3*/
select sum(amount)as total_deposits from Transactions 
where transaction_type='deposit' and transaction_date = '2024-04-04'

/*4*/
select min(DOB) as oldest_customer_dob,max(DOB) as newes_customer_dob from Customers

/*5*/
select t.*,a.account_type from Transactions t 
join Accounts a on t.account_id=a.account_id

/*6*/
select c.*,account_type,balance  from Customers c 
join Accounts a on c.Customer_id=a.Customer_id

/*7*/
select t.*,c.first_name,c.last_name,c.email from Transactions t
join Accounts a on t.account_id=a.account_id 
join Customers c on a.customer_id=c.customer_id
where a.account_id=2

/*8*/
select a.customer_id,c.first_name from accounts a
join Customers c on c.customer_id=a.customer_id
group by a.customer_id,c.first_name
having count(*)>1

/*9*/
select
sum(case when transaction_type = 'deposit' then amount else 0 end) -
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as difference
from Transactions

/*10 dont know for sure*/
select account_id, avg(balance) as avg_daily_bal
from Accounts
group by account_id;

/*11*/
select account_type, sum(balance) AS tot_bal
from Accounts
group by account_type;

/*12*/
select account_id, count(*) as transaction_count
from Transactions
group by account_id
order by transaction_count desc;

/*13*/
select c.customer_id,c.first_name,sum(a.balance) as Aggregate_bal,a.account_type
from Customers c
join Accounts a on a.customer_id=c.customer_id
group by c.customer_id,c.first_name,a.account_type

/*14*/
select account_id, transaction_type, amount, transaction_date, count(*) as count
from Transactions 
group by account_id, transaction_type, amount, transaction_date
having count(*) > 1
order by account_id, transaction_date

/*task-4*/

/*1*/
select c.customer_id,c.first_name
from customers c
join Accounts a on a.customer_id=c.customer_id
where a.balance=(select max(balance) from Accounts)

/*2*/
select customer_id,avg(tot_bal) as avg_bal
from(select customer_id,sum(balance) as tot_bal
from Accounts
group by customer_id
having COUNT(account_id)>1) as acc_bal
group by customer_id

/*3*/
select a.account_id, a.customer_id, a.balance
from accounts a
where exists (select 1 from transactions t
where t.account_id=a.account_id and 
t.amount>(select avg(amount) from transactions))

/*4*/
select c.customer_id, c.first_name
from customers c
where not exists (select 1 from transactions t
join accounts a on t.account_id=a.account_id
where a.customer_id=c.customer_id)

/*5*/
select sum(balance) as tot_bal
from accounts a
where not exists (select 1 from transactions t
where t.account_id=a.account_id)

/*6*/
select t.transaction_id, t.account_id, t.transaction_type, t.amount, t.transaction_date
from transactions t
join accounts a on t.account_id=a.account_id
where a.balance=(select min(balance) from accounts);

/*7*/
select c.customer_id, c.first_name
from customers c
join accounts a on c.customer_id=a.customer_id
group by c.customer_id,c.first_name
having count(a.account_type) > 1;

/*8*/
select account_type, count(*)*100.0/(select count(*) from accounts) as percentage
from accounts
group by account_type;

/*9*/
declare @InputCustomer_id int
set @InputCustomer_id=8
select t.transaction_id, t.account_id, t.transaction_type, t.amount, t.transaction_date
from transactions t
where t.account_id in(
select a.account_id from Accounts a
where a.customer_id=@InputCustomer_id)

/*10*/
select account_type, (select sum(balance) from Accounts a1 
where a1.account_type=a.account_type) as tot_bal
from Accounts a
group by account_type

