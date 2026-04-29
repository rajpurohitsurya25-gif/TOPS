create database contact_managment;

use  contact_managment;

 
 -- 1)	Statement to create the Contact table 
 
create table company (
company_id int primary key,
company_name varchar (45),
street varchar (45),
city varchar (45),
state varchar (10),
zip varchar (10));


drop table company;



create table contact ( 
contact_id int primary key,
company_id int,
first_name varchar (40),
last_name varchar (40),
street varchar (45),
city varchar (45),
state varchar (10),
zip varchar (10),
ismain boolean,
email varchar (45),
phone varchar (15),
foreign key (company_id) references company(company_id));


-- 2)
create table employee (
employee_id int primary key,
first_name varchar(20),
last_name varchar(20),
salary decimal,
hire_date date,
job_title varchar(45),
email varchar (45),
phone varchar (15));


-- 3)
create table contact_employee (
contact_employee_id int primary key,
contact_id int,
employee_id int,
contact_date date,
description varchar (100),
foreign key (contact_id) references contact(contact_id),
foreign key (employee_id) references employee(employee_id));


drop table contact_employee;


insert into company values (1,'Toll Brothers','123 elm street','new york','NY','1001'),
(2,'Urban outfitters Inc.','789 pine avenue','los angeles','CA','90001'),
(3, 'Apple Inc.','1 Infinite loop','Cupertino','CA','95014');


insert into contact values 
(1,1,'dianne','conner','12 maple street','New York', 'NY','10002',TRUE,'dianne.connor&toll.com', '212-555-1111'),
(2,2,'lesley','blend','45 oak road','los angeles','CA','90002',FALSE,'lesley.bland@urban.com','213-555-2222'),
(3,3,'john','smith','56 cherry lane','cupertino','CA','95014',TRUE,'john.smith@apple.com','408-555-3333');


insert into employee values
( 1,'jack','Lee',65000.00,'2018-5-15','sales rep', 'jack.lee@marketco.com','215-555-4444'),
(2,'sarah','brown',72000.00,'2019-03-12','Manager','sarah.brown@marketco.com','215-555-5555'),
(3,'lesley','Bland',68000.00,'2020-01-20','Acount Executive', 'lesley.bland@marketco.com','215-555-6666');

insert into contact_employee values
(1,1,1,'2024-03-12','Meeting with dianne connor regarding toll brothers project'),
(2,2,2,'2024-05-25',' Discussion with lesley bland about urban outfitters'),
(3,3,3,'2024-06-10','follow-up meeting with Apple inc.cntact');



--  4)	In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800.


update employee
set phone = '215-555-8800' 
where first_name = 'lesley';

select * from employee;



-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters”.alter


update company 
set company_name = 'urban outfitters'
where company_name = 'urban outfitters inc.';


select * from company;


/*  6)  In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement). 
HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove. */


delete from contact_employee
where contact_employee_id = 1;


delete from contact_employee
where description = 'Meeting with dianne connor regarding toll brothers project';


select * from contact_employee;




/* 7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). 
Run the SQL SELECT query in MySQL Workbench. Copy the results below as well. */



insert into contact_employee values
(1,1,1,'2024-03-12','Meeting with dianne connor regarding toll brothers project');


select e.employee_id,e.first_name from employee e
join contact_employee ce on e.employee_id = ce.employee_id
where description like "%toll brother%";


select e.employee_id,e.first_name,ce.description from contact_employee ce
join employee e on ce.employee_id = e.employee_id
where description like "%toll brother%";



-- 8) What is the significance of “%” and “_” operators in the LIKE statement? 


/* Like operator is a statement which uses wildcards to match the pattern within the string data.
It has two wildcards % and _
“%” = this is use to get 1 0r multiple data in string
Eg. 
Like  ‘l%’ 
So it can be ‘l’ only,
It can be ‘lata’
Or it can be multiple like ‘lata mageskar’

“_”  =  this is use to get exactly one data in string
Like  ‘a_’
So it only cab be one letter like ‘at’ , ‘am’
If we want 2 or more letters than we will use 2 or more _(underscode)*/ 


-- 9) Explain normalization in the context of databases. 





-- 10) What does a join in MySQL mean?

/* A join in my sql do the work of joining the data of two or more tables 
we can say join is connecting one table to another table or multiple table via foreign key
foreign key is a key that is common in both table. */


-- 11) 19.What do you understand about DDL, DCL, and DML in MySQL? 

/* These are sql commands 

1). DDL 
this is data definition languague
this command we use for defining the structure of table 
or we use it to create table sturcture
 
 it has 4 types
 1 create - we use this to create the database and table. 
 2 alter - we use this to change the structure of existing table. 
 3 truncate - this is use to delete data from table while maintaining schema as it is. 
 4 drop - this is use to delete data and structure as well. 



2).DCL
this is data control language
it has2 types

1.grant - this grant access of data to user.
2.revoke - this take back the access of data from user.



3). DML
this is data manipulation language
it has 3 types

1. insert - this is inserting the data into the table.
2.update - this changes the existing data or value of the table.
3.delete - this is deleting the data from the table based on condition.*/





-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?

/* Mysql join is joining the tables via foreign key
this is helpful to get the data from multiple table 
join is joining the multiple table and give a data from that in a single querry 

it has main 5 types
1.left join - left join will give all the data from left table and common data of right table
2.right join - right join will give all the data from right table and common data from left table
3.inner join - inner join will give common data from both table
4. full join or union  - full join will give all the data from both table or we can use union as well
5.cross join - cross join will give all the combination of data from two table 
				it means each raw of table will connect with all the raw of another table*/ 




