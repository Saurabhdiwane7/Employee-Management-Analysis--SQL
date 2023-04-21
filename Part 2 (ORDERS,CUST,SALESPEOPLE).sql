
# Q1

create table Salespeople(
snum int,
sname varchar(50),
city varchar(50),
comm decimal(10,2));

insert into Salespeople values (1001, 'Peel','London',0.12),
(1002, 'Serres','San Jose',0.13),
(1003, 'Axelrod','New York',0.10),
(1004, 'Motika','London',0.11),
(1007, 'Rafkin','Barcelona',0.15);
select * from salespeople;


# Q2

create table cust (
cnum int,
cname varchar(50),
city varchar(50),
rating int,
snum int);

INSERT INTO CUST VALUES(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Peremira','Rome',100,1004);
INSERT INTO CUST VALUES(2008,'James','London',200,1007);

select * from cust;

# Q3

create table orders (
onum int,
amt decimal(10,2),
odate date,
cnum int,snum int);

insert into orders values (3001,18.69,"1994-10-03",2008,1007),
(3002,1900.10,"1994-10-03",2007,1004),
(3003,767.19,"1994-10-03",2001,1001),
(3005,5160.45,"1994-10-03",2003,1002),
(3006,1098.16,"1994-10-04",2008,1007),
(3007,75.75,"1994-10-05",2004,1002),
(3008,4723.00,"1994-10-05",2006,1001),
(3009,1713.23,"1994-10-04",2002,1003),
(3010,1309.95,"1994-10-06",2004,1002),
(3011,9891.88,"1994-10-06",2006,1001);

select * from orders;

# Q4  4.	Write a query to match the salespeople to the customers 
#according to the city they are living.

SELECT A.SNAME AS Salesperson,A.CITY,C.CNAME as Customer,C.CITY
FROM SALESPEOPLE A  JOIN CUST C ON (C.CITY=A.CITY);

#5.	Write a query to select the names of customers and the
# salespersons who are providing service to them.
select s.sname as salesperson,c.cname as customer from salespeople s 
join cust c on (s.snum=c.snum)
right join orders o on (s.snum=o.snum);

#6.	Write a query to find out all orders by customers not located in the same cities
# as that of their salespeople 

SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN salespeople s ON o.salesperson_id = s.id
WHERE c.city <> s.city;

select o.onum from orders o join cust c on (o.cnum=c.cnum) # (joined 3 tables and put where condition)
join salespeople s on (s.snum =o.snum)
where c.city<>s.city;

#7.	Write a query that lists each order number followed by name 
#of customer who made that order

select * from cust;
select o .onum ,c.cname from orders o join cust c on (o.cnum =c.cnum);  # connected both table with condition

#8.	Write a query that finds all pairs of customers having the same rating

select c.cname as customer1 ,s.cname as customer2 from cust c join cust s on (c.rating=s.rating)
and c.cnum<s.cnum;   #(self join with condition of rating and (c.cnum<s.cnum) # to skip and check records from s table)

#9 Write a query to find out all pairs of customers served by a single salesperson

SELECT DISTINCT o1.cnum as cust1, o2.cnum as cust2,s.sname AS salesperson_name
FROM cust o1
JOIN cust o2 ON o1.snum = o2.snum AND o1.cnum < o2.cnum
JOIN salespeople s ON o1.snum = s.snum;
 
 #explaination
 
 # select distinct of c1 cust and c2 cust vlaue and sname from salesperson table
 #self join with join condition  and 2nd condition to evaluate the pair or to check the record if twice
 #join salespeople table with condition.
 
 
 #10.Write a query that produces all pairs of salespeople who are living in same city
 
 select s1.sname,s2.sname,s1.city from salespeople s1 join
 salespeople s2 on (s1.city=s2.city) and (s1.snum<s2.snum);
 
 #explanation
 #self join with join condition and match condition for city
 
 #11.	Write a Query to find all orders credited to the same 
 #salesperson who services Customer 2008
 
 select c.cname,o.onum,s.sname from orders o join salespeople s on o.snum=s.snum 
 join cust c on c.snum =o.snum and c.cnum=2008;
 
 
 #12.	#q12 -Write a Query to find out all orders that are greater than the average for Oct 4th


SELECT *
FROM orders
WHERE odate = '1994-10-04'
AND amt > (
    SELECT AVG(amt)
    FROM orders
    WHERE odate = '1994-10-04'
);


#Q13 = Write a Query to find all orders attributed to salespeople in London.
select * from orders o join salespeople s on (o.snum=s.snum) where s.city='London';



#14.Write a query to find all the customers whose cnum is 1000 above 
#the snum of Serres. 

select * from cust where cnum > (select snum+1000 from salespeople where sname ='Serres');



#15.	Write a query to count customers with ratings above San Jose’s average rating.

select count(*) as total_customer_with_rating from cust where rating >
(select avg(rating) from cust where city ='San Jose'); 



#16.	Write a query to show each salesperson with multiple customers.

select s.sname, count(c.cname) from salespeople s 
join cust c on s.snum=c.snum
group by s.sname having count(c.cname)>1;



