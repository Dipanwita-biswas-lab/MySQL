use assignment;

create table if not exists views
(article_id 	int ,
author_id 	int ,
viewer_id 	int ,
view_date 	date 
);

insert into views values (1, 	3, 	5, 	'2019-08-01' );
insert into views values (1, 	3, 	6, 	'2019-08-02');
insert into views values (2, 	7, 	7, 	'2019-08-01' );
insert into views values (2, 	7, 	6, 	'2019-08-02' );
insert into views values (4, 	7, 	1, 	'2019-07-22' );
insert into views values (3, 	4, 	4, 	'2019-07-21' );
insert into views values (3, 	4, 	4, 	'2019-07-21');

-- Write an SQL query to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.

select distinct author_id from views
where author_id=viewer_id
order by author_id;
 

-- 
create table delivery 
(
delivery_id 	int not null,
customer_id 	int ,
order_date 	date ,
customer_pref_delivery_date 	date ,
constraint PK_DID Primary Key (delivery_id)
)


insert into delivery values (1, 	1, 	'2019-08-01', 	'2019-08-02' );
insert into delivery values (2, 	5, 	'2019-08-02', 	'2019-08-02' );
insert into delivery values (3, 	1, 	'2019-08-11', 	'2019-08-11');
insert into delivery values (4, 	3, 	'2019-08-24', 	'2019-08-26' );
insert into delivery values (5, 	4, 	'2019-08-21', 	'2019-08-22');
insert into delivery values (6, 	2, 	'2019-08-11', 	'2019-08-13' );

-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places. 

select round(100*
			(select count(order_date)    from Delivery where order_date = customer_pref_delivery_date)
			/count(d1.delivery_id), 2) as immediate_percentage
from Delivery d1




-- -----------
create table Ads
(ad_id int not null,
user_id int  not null,
action enum ('Clicked', 'Viewed', 'Ignored'),
constraint PK_id Primary Key (ad_id, user_id));


insert into Ads values(1, 	1, 	'Clicked');
insert into Ads values(2, 	2, 	'Clicked' );
insert into Ads values(3, 	3, 	'Viewed' );
insert into Ads values(5, 	5, 	'Ignored' );
insert into Ads values(1, 	7, 	'Ignored' );
insert into Ads values(2, 	7, 	'Viewed' );
insert into Ads values(3, 	5, 	'Clicked' );
insert into Ads values(1, 	4, 	'Viewed' );
insert into Ads values(2, 	11, 	'Viewed' );
insert into Ads values(1, 	2, 	'Clicked'  );

-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points
 select ad_id ,
 round(case when SUM(Clicked)+SUM(Viewed)=0 then 0
 else (SUM(Clicked)/ (SUM(Clicked)+SUM(Viewed)))*100 end, 2) as ctr   from
 (select *,
 case when action ='clicked' then 1 else 0 end as Clicked,
  case when action ='Viewed' then 1 else 0 end as Viewed,
   case when action ='Ignored' then 1 else 0 end as Ignored
 from ads) temp
 group by ad_id;




create table employee
(
employee_id 	int not null,
team_id 	int ,
constraint pk_id primary key (employee_id)
);


insert into employee values (1, 	8 );
insert into employee values (2, 	8);
insert into employee values (3, 	8 );
insert into employee values (4, 	7 );
insert into employee values (5, 	9 );
insert into employee values (6, 	9 );

-- Write an SQL query to find the team size of each of the employees. Return result table in any order.
select employee_id, 
count(team_id) over(partition by team_id) as team_size from employee;



create table if not exists  countries
(country_id int not null, 
country_name varchar(50),
constraint pk_id primary key (country_id));


 create table if not exists weather 
 (country_id 	int  not null, 
weather_state 	int ,
day 	date ,
constraint pk_id primary key (country_id, day ));



insert into countries values (2, 'USA');
insert into countries values (3, 'Australia' );
insert into countries values (7, 'Peru');
insert into countries values (5, 'China' );
insert into countries values (8, 'Morocco');
insert into countries values (9, 'Spain');


insert into weather values (2, 15, '2019-11-01' );
insert into weather values (2, 12, '2019-10-28' );
insert into weather values (2, 12, '2019-10-27' );
insert into weather values (3, -2, '2019-11-10' );
insert into weather values (3, 0, '2019-11-11'  );
insert into weather values (3, 3, '2019-11-12' );
insert into weather values (5, 16, '2019-11-07' );
insert into weather values (5, 18, '2019-11-09' );
insert into weather values (5, 21, '2019-11-23' );
insert into weather values (7, 25, '2019-11-28');
insert into weather values (7, 22, '2019-12-01' );
insert into weather values (7, 20, '2019-12-02' );
insert into weather values (8, 25, '2019-11-05' );
insert into weather values (8, 27, '2019-11-15' );
insert into weather values (8, 31, '2019-11-25' );
insert into weather values (9, 7, '2019-10-23' );
insert into weather values (9, 3, '2019-12-23');


/*
Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
Return result table in any order.
*/
select  country_name , case when avg(weather_state) <=15 then 'cold'
 when avg(weather_state) >=25 then 'hot'
 else 'warm' end as weather_type
from weather w
inner join Countries c on c.country_id= w.country_id
and month(day)= 11 and year(day)=2019
group by country_name;



 create table if not exists  Prices (
 product_id 	int not null,
start_date 	date  not null,
end_date 	date  not null,
price 	int ,
constraint pk_id primary key (product_id, start_date, end_date)
);	


insert into Prices values (1, '2019-02-17', '2019-02-28', 5 );
insert into Prices values (1, '2019-03-01', '2019-03-22', 20 );
insert into Prices values (2, '2019-02-01', '2019-02-20', 15 );
insert into Prices values (2, '2019-02-21', '2019-03-31', 30 );


create table unitssold
(product_id 	int ,
purchase_date 	date ,
units 	int 
);

insert into UnitsSold values (1, '2019-02-25', 100 );
insert into UnitsSold values (1, '2019-03-01', 15 );
insert into UnitsSold values (2, '2019-02-10', 200 );
insert into UnitsSold values (2, '2019-03-22', 30 );



-- Q23 Q40 Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
select distinct u.product_id,
round((sum(price*units) over (partition by u.product_id)/ sum(units) over (partition by u.product_id)) ,2) as avg_selling
from prices p
inner join unitssold u
on u.product_id=p.product_id
and purchase_date between start_date and end_date ;


create table activity
(
player_id 	int not null,
device_id 	int not null,
event_date 	date ,
games_played 	int, 
constraint pk_id primary key (player_id, event_date)
)

insert into activity values (1, 2, '2016-03-01', 5 );
insert into activity values (1, 2, '2016-05-02', 6 );
insert into activity values (2, 3, '2017-06-25', 1 );
insert into activity values (3, 1, '2016-03-02', 0 );
insert into activity values (3, 4, '2018-07-03', 5 );


 -- 24  Write an SQL query to report the first login date for each player.
select distinct player_id, 
first_value(event_date) over (partition by player_id order by event_date)
from activity;

-- 25 Write an SQL query to report the first device  for each player.
select distinct player_id, 
first_value(device_id) over (partition by player_id order by event_date)
from activity;

-- Q43 Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

-- updateing the table to wrt question
update activity
set event_date ='2016-03-02'
where event_date='2016-05-02'
and player_id=1;

select round(count(player_id)/ (select Count(distinct player_id) from activity), 2) as fraction
 from 
(select * , 
lag(event_date) over (partition by player_id order by event_date) as prev_day
from activity)temp
where datediff(event_date, prev_day)=1




create table if not exists products
(product_id 	int not null Primary Key  ,
product_name 	varchar(50),
product_category 	varchar(30)
);

insert into products values (1, 'Leetcode Solutions', 'Book' );
insert into products values (2, 'Jewels of Stringology', 'Book');
insert into products values (3, 'HP', 'Laptop');
insert into products values (4, 'Lenovo', 'Laptop');
insert into products values (5, 'Leetcode Kit', 'T-shirt');



create table if not exists Orders
(
product_id 	int ,
order_date 	date ,
unit 	int ,
constraint fk_id foreign key (product_id) references Products(product_id)
);

insert into Orders values (1, '2020-02-05', 60 );
insert into Orders values (1, '2020-02-10', 70 );
insert into Orders values (2, '2020-01-18', 30 );
insert into Orders values (2, '2020-02-11', 80 );
insert into Orders values (3, '2020-02-17', 2 );
insert into Orders values (3, '2020-02-24', 3 );
insert into Orders values (4, '2020-03-01', 20 );
insert into Orders values (4, '2020-03-04', 30 );
insert into Orders values (4, '2020-03-04', 60);
insert into Orders values (5, '2020-02-25', 50 );
insert into Orders values (5, '2020-02-27', 50);
insert into Orders values (5, '2020-03-01', 50 );

--  Q26. Q34 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.

select product_ID, sum(unit) as total_unit from orders
where month(order_date)=2 and year(order_date)= 2020
group by product_ID
having total_unit>=100;


create table Users 
(user_id 	int not null primary key, 
name 	varchar(50), 
mail 	varchar(50) 
);

insert into Users values (1, 'Winston', 'winston@leetcode.com');
insert into Users values (2, 'Jonathan', 'jonathanisgreat');
insert into Users values (3, 'Annabelle', 'bella-@leetcode.com');
insert into Users values (4, 'Sally', 'sally.come@leetcode.com');
insert into Users values (5, 'Marwan', 'quarz#2020@leetcode.com');
insert into Users values (6, 'David', 'david69@gmail.com');
insert into Users values (7, 'Shapiro', '.shapo@leetcode.com');


/* Q27.  Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where: 
●  The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. 
The prefix name must start with a letter. 
●  The domain is '@leetcode.com'.
Return the result table in any order.

*/

select * from Users
where mail  like '%@leetcode.com'
and mail rlike '^[a-zA-z]+[a-zA-z0-9-_.@]*$';


create table Customers
(
customer_id 	int not null Primary key,
name 	varchar(30), 
country 	varchar(30)
);

insert into Customers values (1, 'Winston','USA');
insert into Customers values (2, 'Jonathan','Peru' );
insert into Customers values (3, 'Moustafa','Egypt');



-- table already exists 
alter table sales
drop constraint FK_PID;

drop table product;

create table Product 
(
product_id int not null primary key , 
description varchar(50),
price int
);

insert into Product values (10, 'LC Phone', 300 );
insert into Product values (20, 'LC T-Shirt', 10 );
insert into Product values (30, 'LC Book', 45);
insert into Product values (40, 'LC Keychain', 2 );

-- table already exists
drop table orders;

create table Orders
(
order_id 	int not null Primary key,
customer_id 	int ,
product_id 	int ,
order_date 	date ,
quantity 	int 
)

insert into Orders values (1, 1, 10, '2020-06-10', 1 );
insert into Orders values (2, 1, 20, '2020-07-01', 1 );
insert into Orders values (3, 1, 30, '2020-07-08', 2 );
insert into Orders values (4, 2, 10, '2020-06-15', 2);
insert into Orders values (5, 2, 40, '2020-07-01', 10 );
insert into Orders values (6, 3, 20, '2020-06-24', 2 );
insert into Orders values (7, 3, 30, '2020-06-25', 2 );
insert into Orders values (9, 3, 30, '2020-05-08', 3 );


-- Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 
-- in each month of June and July 2020.
select name,month(order_date), sum(price*quantity) as spend from 
Orders o
left join Product p
on (p.product_id=o.product_id
and month(order_date) in (6,7) and year(order_date)=2020)
left join Customers c on c.customer_id=o.customer_id
group by name, month(order_date)
having spend>=100; 



create table TVProgram
(
program_date 	date not null, 
content_id 	int not null, 
channel 	varchar(20) ,
constraint pk_id primary key (program_date, content_id)

)

insert into tvprogram values ('2020-06-10 08:00', 1, 'LC-Channel');
insert into tvprogram values ('2020-05-11 12:00', 2, 'LC-Channel' );
insert into tvprogram values ('2020-05-12 12:00', 3, 'LC-Channel' );
insert into tvprogram values ('2020-05-13 14:00', 4, 'Disney Ch' );
insert into tvprogram values ('2020-06-18 14:00', 4, 'Disney Ch' );
insert into tvprogram values ('2020-07-15 16:00', 5, 'Disney Ch' );


create table Content
(
content_id 	varchar(30) not null Primary Key,
title 	varchar(30) ,
Kids_content 	enum ('Y', 'N'),
content_type 	varchar(30)
)

insert into  Content values (1, 'Leetcode Movie', 'N', 'Movies'); 
insert into  Content values (2, 'Alg. for Kids', 'Y', 'Series' ); 
insert into  Content values (3, 'Database Sols', 'N', 'Series' ); 
insert into  Content values (4, 'Aladdin', 'Y', 'Movies' ); 
insert into  Content values (5, 'Cinderella', 'Y', 'Movies' ); 


-- Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. 
-- Return the result table in any order.

select distinct title from TVProgram t
inner join Content  c on c.content_id= t.content_id 
and month(program_date)=6 and year(program_date)=2020
and Kids_content='Y'



create table NPV
(
id 	int not null,
year 	int  not null,
npv 	int ,
constraint PK_id primary key (id, year)
);

insert into NPV values (1, 2018, 100 );
insert into NPV values (7, 2020, 30);
insert into NPV values (13, 2019, 40 );
insert into NPV values (1, 2019, 113 );
insert into NPV values (2, 2008, 121 );
insert into NPV values (3, 2009, 12 );
insert into NPV values (11, 2020, 99 );
insert into NPV values (7, 2019, 0);


create table Queries
( id 	int not null,
year 	int not null,
constraint PK_id primary key (id, year)
);

insert into Queries values (1, 2019 );
insert into Queries values (2, 2008 );
insert into Queries values (3, 2009 );
insert into Queries values (7, 2018 );
insert into Queries values (7, 2019);
insert into Queries values (7, 2020 );
insert into Queries values (13, 2019);


-- Write an SQL query to find the npv of each query of the Queries table.
select q.id, q.year, ifnull(npv, 0  ) as  npv from queries q
left join NPV  n on 
n.id=q.id and q.year =n.year;



create table Employees
(id 	int not null Primary Key ,
name 	varchar(30)
);

insert into Employees values (1, 'Alice');
insert into Employees values (7, 'Bob' );
insert into Employees values (11, 'Meir');
insert into Employees values (90, 'Winston' );
insert into Employees values (3, 'Jonathan' );

create table EmployeeUNI
(
id 	int ,
unique_id 	int ,
constraint PK_key primary key (id, unique_id)
)


insert into EmployeeUNI values (3, 1 );
insert into EmployeeUNI values (11, 2  );
insert into EmployeeUNI values (90, 3 );


-- Q 32  Q 37 Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
select unique_id, name  from Employees e
left join EmployeeUNI u
on e.id= u.id;


-- table already exists
DROP TABLE IF EXISTS `Users`;

create table Users
(id 	int not null Primary key, 
name 	varchar(30)
);

insert into Users values (1, 'Alice');
insert into Users values (2, 'Bob' );
insert into Users values (3, 'Alex' );
insert into Users values (4, 'Donald' );
insert into Users values (7, 'Lee' );
insert into Users values (13, 'Jonathan' );
insert into Users values (19, 'Elvis' );


create table Rides
(
id 	int not null Primary key,
user_id 	int ,
distance 	int 
)

insert into Rides values (1, 1, 120);
insert into Rides values (2, 2, 317 );
insert into Rides values (3, 3, 222 );
insert into Rides values (4, 7, 100 );
insert into Rides values (5, 13, 312 );
insert into Rides values (6, 19, 50);
insert into Rides values (7, 7, 120 );
insert into Rides values (8, 19, 400 );
insert into Rides values (9, 7, 230 );


-- Q33  Q36 Write an SQL query to report the distance travelled by each user.
select name, ifnull(sum(distance), 0) as travelled_distance 
from Rides r
right join Users u
on r.user_id= u.id
group by name
order by ifnull(sum(distance), 0) desc, name;




create table Movies
(
movie_id 	int not null primary key ,
title 	varchar(30) 
);

insert into Movies values (1, 'Avengers' );
insert into Movies values (2, 'Frozen 2' );
insert into Movies values (3, 'Joker' );


DROP TABLE IF EXISTS `Users`;

create table Users
(id 	int not null Primary key, 
name 	varchar(30)
);

insert into Users values (1, 'Daniel' );
insert into Users values (2, 'Monica' );
insert into Users values (3, 'Maria' );
insert into Users values (4, 'James' );


create table MovieRating
(
movie_id 	int  not null,
user_id 	int not null,
rating 	int ,
created_at 	date,  
constraint PK_movie primary key (movie_id, user_id)
)

insert into MovieRating values (1, 1, 3, '2020-01-12' );
insert into MovieRating values (1, 2, 4, '2020-02-11' );
insert into MovieRating values (1, 3, 2, '2020-02-12');
insert into MovieRating values (1, 4, 1, '2020-01-01');
insert into MovieRating values (2, 1, 5, '2020-02-17');
insert into MovieRating values (2, 2, 2, '2020-02-01' );
insert into MovieRating values (2, 3, 2, '2020-03-01' );
insert into MovieRating values (3, 1, 3, '2020-02-22');
insert into MovieRating values (3, 2, 4, '2020-02-25' );




/* Q 35 Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.*/

with cte as(
select *, row_number() over (order by rating_count desc, name) as ranks 
from
(select distinct name , count(name) over (partition by name) as rating_count 
from MovieRating r
inner join Users u on r.user_id=u.id) temp
union
select *, row_number() over (order by avg_rating desc, title) as ranks 
from
(select distinct title, avg(rating) over (partition by title) as avg_rating from MovieRating r
inner join movies m on r.movie_id=m.movie_id
where month(created_at)=2 and year(created_at)=2020)temp
)
select name as results from cte where ranks=1



create table Departments
(
id 	int not null Primary Key,
name 	varchar(30)
)
insert into Departments values (1, 'Electrical Engineering' );
insert into Departments values (7, 'Computer Engineering');
insert into Departments values (13,' Business Administration');


create table Students
(
id 	int not null Primary Key,
name 	varchar(30),
department_id int 
)


insert into Students values (23, 'Alice', 1 );
insert into Students values (1, 'Bob', 7 );
insert into Students values (5, 'Jennifer', 13);
insert into Students values (2, 'John', 14 );
insert into Students values (4, 'Jasmine', 77 );
insert into Students values (3, 'Steve', 74 );
insert into Students values (6, 'Luis', 1 );
insert into Students values (8, 'Jonathan', 7 );
insert into Students values (7, 'Daiana', 33 );
insert into Students values (11, 'Madelynn', 1 );


-- Q38 Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.
select s.id, s.name from students s
left join departments d
on s.department_id=d.id
where d.name is null;


create table calls
(from_id 	int ,
to_id 	int ,
duration 	int 
);

insert into calls values (1, 2, 59 );
insert into calls values (2, 1, 11 );
insert into calls values (1, 3, 20 );
insert into calls values (3, 4, 100 );
insert into calls values (3, 4, 200 );
insert into calls values (3, 4, 200);
insert into calls values (4, 3, 499 );

 
-- Q39 Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
select from_id, to_id, count(duration) as call_count, sum(duration) as total_duration
  from
(select *  from calls
union all
select to_id, from_id , duration from calls) temp
where from_id < to_id
group by from_id, to_id;



create table Warehouse
(name 	varchar(30), 
product_id 	int, 
units 	int,
constraint PK_key Primary key (name, product_id)
);

insert into Warehouse values ('LCHouse1', 1, 1 );
insert into Warehouse values ('LCHouse1', 2, 10 );
insert into Warehouse values ('LCHouse1', 3, 5 );
insert into Warehouse values ('LCHouse2', 1, 2 );
insert into Warehouse values ('LCHouse2', 2, 2 );
insert into Warehouse values ('LCHouse3', 4, 1 );



Drop table if exists Products;
create table Products
(
product_id 	int  not null Primary key ,
product_name 	varchar(30), 
Width 	int, 
Length 	int, 
Height 	int 
);
 
insert into Products values (1, 'LC-TV', 5, 50, 40 );
insert into Products values (2, 'LC-KeyChain', 5, 5, 5 );
insert into Products values (3, 'LC-Phone', 2, 10, 10 );
insert into Products values (4, 'LC-T-Shirt', 4, 10, 20 );


-- Q41 Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
select name,  sum(width*Length*Height*units) from  Products p
left join Warehouse w on p.product_id=w.product_id
group by name;



drop table if exists Sales;
create table Sales
(sale_date 	date ,
fruit 	enum ("apples",  "oranges" ),
sold_num 	int,  
constraint PK_key Primary key (sale_date, fruit)

);

 insert into Sales values ('2020-05-01', 'apples', 10 );
 insert into Sales values ('2020-05-01', 'oranges', 8 );
 insert into Sales values ('2020-05-02', 'apples', 15 );
 insert into Sales values ('2020-05-02', 'oranges', 15 );
 insert into Sales values ('2020-05-03', 'apples', 20 );
 insert into Sales values ('2020-05-03', 'oranges', 0 );
 insert into Sales values ('2020-05-04', 'apples', 15 );
 insert into Sales values ('2020-05-04', 'oranges', 16 );

 
-- Q42 Write an SQL query to report the difference between the number of apples and oranges sold each day. Return the result table ordered by sale_date.
select sale_date, apples_sold -oranges_sold
from
(select sale_date, 
sum(case when fruit ='apples' then sold_num end) as apples_sold,
sum(case when fruit ='oranges' then sold_num end) as oranges_sold
  from sales
  group by sale_date)temp


drop table if exists Employee;
create table Employee 
(id 	int primary key ,
name 	varchar(30) ,
department 	varchar(30) ,
managerId 	int 
);

insert into Employee values (101, 'John', 'A', NULL );
insert into Employee values (102, 'Dan', 'A', 101);
insert into Employee values (103, 'James', 'A', 101 );
insert into Employee values (104, 'Amy', 'A', 101 );
insert into Employee values (105, 'Anne', 'A', 101 );
insert into Employee values (106, 'Ron', 'B', 101 );


-- Q44 Write an SQL query to report the managers with at least five direct reports. Return the result table in any order.
select name from employee where
id in 
(select managerid from 
(select distinct managerId, count(managerId) over (partition by managerId) counts from Employee) temp
where counts>=5)




create table Department
(
dept_id 	int primary key,
dept_name 	varchar(30) 

);

insert into Department values (1, 'Engineering' );
insert into Department values (2, 'Science' );
insert into Department values (3, 'Law');


create table Student
(
student_id 	int primary key, 
student_name 	varchar(30),
gender 	varchar(2), 
dept_id 	int,
constraint FK_key foreign key (dept_id) references Department(dept_id)
);

INSERT INTO Student values (1, 'Jack', 'M', 1 );
INSERT INTO Student values (2, 'Jane', 'F', 1 );
INSERT INTO Student values (3, 'Mark', 'M', 2 );


-- Q 45 Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students). Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.
select dept_name, count(dept_name) as student_number from Department d
left join Student s
on d.dept_id= s.dept_id
group by dept_name;


create table Customer
(customer_id 	int ,
product_key 	int 
);

insert into Customer  values (1, 5 );
insert into Customer  values (2, 6 );
insert into Customer  values (3, 5 );
insert into Customer  values (3, 6 );
insert into Customer  values (1, 6 );

drop table if exists Product;

create table Product
(product_key int primary key);

insert into Product values (5), (6);

-- Q46 Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
select customer_id from
(select distinct customer_id,
count(product_key) over (partition by customer_id) as counts  from Customer) temp
where counts = (select count(*) from Product);





drop table if exists Employee;

create table Employee
(employee_id 	int primary key,
name 	varchar(30),
experience_years 	int 
);

insert into Employee values (1, 'Khaled', 3 );
insert into Employee values (2, 'Ali', 2 );
insert into Employee values (3, 'John', 3 );
insert into Employee values (4, 'Doe', 2 );


drop table if exists Project;
create table Project
(
project_id 	int ,
employee_id 	int ,
constraint pk_key primary key (project_id, employee_id),
constraint FK_Key_Project foreign key (employee_id) references Employee(employee_id)
) ;

insert into Project values (1, 1 );
insert into Project values (1, 2 );
insert into Project values (1, 3 );
insert into Project values (2, 1);
insert into Project values (2, 4 );



-- Q47 Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.
with cte as (
select project_ID, e.employee_id, rank() over ( order by experience_years desc ) as ranks from Project p
left join Employee  e
on p.employee_id=e.employee_id
order by project_id
)
select  project_ID, employee_id from cte where ranks=1;


create table Books 
(book_id 	int primary key, 
name 	varchar(30),  
available_from 	date
);

insert into  Books values (1, '"Kalila And Demna"', '2010-01-01' );
insert into  Books values (2, '"28 Letters"', '2012-05-12' );
insert into  Books values (3, '"The Hobbit"', '2019-06-10' );
insert into  Books values (4, '"13 Reasons Why"', '2019-06-01' );
insert into  Books values (5, '"The Hunger Games"', '2008-09-21' );


drop table if exists orders;
create table orders 
(order_id 	int primary key,
book_id 	int ,
quantity 	int ,
dispatch_date 	date ,
constraint fk_keys foreign key (book_id) references Books(book_id)
);




-- Q 48 Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.

-- question does not have data for orders





create table Enrollments
(student_id 	int  not null,
course_id 	int not null,
grade 	int ,
constraint pk_key primary key (student_id, course_id)

);


insert into Enrollments values (2, 2, 95 );
insert into Enrollments values (2, 3, 95 );
insert into Enrollments values (1, 1, 90 );
insert into Enrollments values (1, 2, 99 );
insert into Enrollments values (3, 1, 80 );
insert into Enrollments values (3, 2, 75 );
insert into Enrollments values (3, 3, 82 );

-- Q 49 Write a SQL query to find the highest grade with its corresponding course for each student.
-- In case of a tie, you should find the course with the smallest course_id.
-- Return the result table ordered by student_id in ascending order.
select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
(select student_id, max(grade)
from Enrollments
group by student_id)
group by student_id, grade
order by student_id;



create table Teams
(
team_id 	int Primary Key,
team_name 	varchar(30) 
);

15 	1 
25 	1 
30 	1 
45 	1 
10 	2 
35 	2 
50 	2 
20 	3 
40 	3 


create table matches
(match_id 	int primary key, 
host_team 	int, 
guest_team 	int, 
host_goals 	int, 
guest_goals 	int 
);



-- Q50 The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
-- Write an SQL query to find the winner in each group.
-- cannot understand question








