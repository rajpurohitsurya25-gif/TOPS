


--                                           ASSESMENT




-- Section A:   Concept Application



 
/*1. What is the functional difference between SELECT * and specifying column 
names, and when is each preferred? 

--   select * will show all the data of table and selecting specific column will show the specific column what we want to show
	 select * we wil use in to show entire data and for quick use 
     select coulmn name will use when we need specific data and when we want multiple coloumn from another table also like join 
     and for getting clear and efficient result according to our need


2. Which keyword renames a column in the output, and does this alias change 
the actual table structure in the database? 


--   Alias is keyword which reaname the column name in output.
     but this alias is a name which we can show it in output only for better understanding .
     This Alias does not change in actual table structure in database.
     
     

3. Why does wrapping a numeric value in quotes (e.g., '5000') in a WHERE clause 
create a data type conflict in SQL? 


--   because in column there is only 5000. we enter 5000 not wrapped in quotes and when we write it in quotes then it give us data type conflict.
     so sql consider '5000' as a string data type and in table it is interger so this both has differnt data type.so it throghs a 
     data type conflict.



4. Contrast the results of ORDER BY Profit DESC versus ASC when the goal is to 
identify the top 10 most profitable orders. 


--   1) ORDER BY DESC :-    order by desc is giving us a value in order to hogh to low it means this organize a value end to start .
							this wil give us value in decending order.
                            and if our goal is to identify top 10 most profitable orders then we wil use this .
                            so this will give us highest profitable order and for top 10 we will use limit to top 10 highest.
                            here is querry for this 
                            select * from order
                            order by prfitable order desc
                            limit 10;
                            
                            
     2) order by asc : -    order by asc is giving us value in order to low to high or we can say start to end or 0 to nth
							this wil give us a value in ascending order.
						    this is not suitable tp find out top 10 top high profitable orders.
                            because it is use for lowest value first .





5. What is the T-SQL equivalent of the LIMIT clause in MS SQL Server, and why 
does syntax vary across SQL engines? 

--   In T-SQL, there is a top keyword which is equivalent of limit clause in mysql
     sql syntax varries across engine because sql is partitaly standardized .
     it defines its core feature but row-limiting syntax is not fully standardized.
     and each vendor adds proprietary extensions for performance, legacy support, and flexibility.




6. Explain the logical execution order of a query containing SELECT, WHERE, ORDER 
BY, and LIMIT clauses. 


--   SQL logical execution
     1)   FROM 
          first of all it decides the table in which it need to get the data.
          
     2)   WHERE
          after FROM and decinding the table it will filter out the rows based on condition in where clause.
          
     3)   SELECT
          then it will execute select, it decides which columns will show in output.
          
     4)   ORDER BY 
          this will organize a result based on column expression. 
          
	 5)   LIMIT
          this will restrict the raws after sorting or like limiting the number of raw.*/
          
     
     











-- Section B:       Practical Task 








CREATE DATABASE ORDER_PROFITABLITY;

use order_profitablity;

select * from orderss;



/*1. Execute a query to retrieve the first 20 records from the orders table to verify 
data ingestion. */

select * from orderss
limit 20;


/*2. Select Order ID, Order Date, Sales, and Profit, applying a column alias to 
display Sales as Total_Sales. */


select order_id,order_date,sales as Total_sales,profit from orderss;



/* 3. Filter the dataset to isolate all high-value transactions where the Sales figure 
exceeds 5000. */

select * from orderss
where sales > 5000;


/* 4. Generate a report of the top 10 most profitable orders by sorting the records 
by Profit in descending order.*/ 


select * from orderss
order by profit desc
limit 10;










-- Section C:   Mini Project 







-- 1. Title: Retail Profitability & Market Segment Analysis  


--                            Retail Profitability & Market Segment Analysis  




/* 2. Problem Statement: Identify underperforming product categories and regions 
by analyzing the relationship between discount rates and net profit margins. */

 
-- here are the categories and regions which are underperforming that has high discount and has loss in margine
with underperforming as
(select max(discount) as max_discount,min(profit) as min_profit from orderss)
select o.category,o.region,o.discount,o.profit from orderss  o
join underperforming u on o.discount = u.max_discount;


/* 3.  Dataset Recommendation: Sample Superstore Dataset 
(SampleSuperstore.csv) - 
https://www.kaggle.com/datasets/vivek468/superstore-dataset-final  */
  
  
-- Took  the data sample superstore from kaggle 

/*4. Required Deliverables: SQL script for database schema creation, 
multi-condition filtering queries, aggregated performance report by region, 
and a summary of loss-making transactions. */

-- 1)   schema creation

create table orderss ( 
Row_ID int unique,
Order_ID varchar(25) unique,
Order_Date date, 
Ship_Date date,
Ship_Mode varchar(25),
Customer_ID varchar(25) unique,
Customer_Name varchar(35), 
Segment varchar(20),
Country varchar(25),
City varchar(30),
State varchar(30),
Postal_code int, 
Region varchar(20), 
Product_ID varchar(50) unique,
Category varchar(40),
Sub_Category varchar(30),
Product_Name varchar(100),
Sales decimal,
Quantity int, 
Discount decimal,
Profit decimal);




-- 2)   multicondition filtering querries

select * from orderss;

SELECT Order_ID,Category, Region, discount,Profit
FROM orderss
WHERE Discount > 0 AND Profit < 0;

-- maximum quantity of product
select * from orderss
where quantity = (select max(quantity) as max_quantity from orderss);

with max_quantity as 
(select sub_category,max(quantity) as max_quantity from orderss
group by category)
select o.category,o.sub_category,max_quantity from orderss o
join max_quantity m on o.category = m.category;

 -- highest sale order
select category,sub_category,sales,discount,profit from orderss 
where sales = (select max(sales) from orderss);

--  highest profit making order
select category,sub_category,sales,discount,profit from orderss 
where sales = (select max(profit) from orderss);

--  all categories
select distinct(category) from orderss;

--  Total orderwise counr category wise
select category,count(order_id) from orderss
group by category;

-- Total sum of all thre  coliumn categorywise
select category,sum(sales),sum(discount),sum(profit)  from orderss
group by category;

--  total avg of all three column category wise
select category,avg(sales),avg(discount),avg(profit) from orderss
group by category;




-- 3)   aggregated performance report by region


select region,sum(profit) as total_profit,avg(discount) as avg_discount from orderss
group by region;

-- total sum of all three colounm
select region,sum(sales),sum(discount),sum(profit)  from orderss
group by region;

--  total avg of all three column category wise
select region,avg(sales),avg(discount),avg(profit) from orderss
group by region;




-- 4)  a summary of loss-making transactions. 


select category , sum(profit) as total_loss,count(profit) as loss_count from orderss
where profit < 0
group by category;

